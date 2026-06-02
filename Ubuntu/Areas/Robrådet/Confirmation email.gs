/***** CONFIG *****/
const SPREADSHEET_ID = '1JEEvMgfmV3qipgRYhBQG4k1rJMYZPoSXk6oMzC3lEiE'; // INSERT SHEET ID HERE
const SHEET_ID = 765643494; // INSERT GID OF THE TAB HERE
const COL = { // MAKE SURE THIS IS 1:1 CORRECT
  TIME: 'Tidsstempel',
  NAME: 'Full name:',
  USER: 'Student username',
  EMAIL: 'Non outlook email:',
  PAID: 'Paid ?',
  SENT: 'Email Sent At'
};
const FORM_ID = "15pYzCb0_coIzy5CWBL65JOIOy18IKsf6J5ffXsnYE7E" // INSERT FORMS ID HERE
const LIMIT = 40 // INSERT CAPACITY LIMIT HERE


/***** EMAIL *****/
// Email Subject // UPDATE THIS
const SUBJECT = "EMOJI Robrådet XX registration confirmation";

// Email Body // UPDATE THIS
function renderBody_(name) {
  return `Hi ${name},

Your registration to the Robrådet XX event and YY DKK payment has been confirmed.

<strong>Event details:</strong>
📅 <strong>Date:</strong> dd mm
🕕 <strong>Time:</strong> tt:tt - TT:TT
📍 <strong>Location:</strong> Location
EMOJI <strong>What to bring:</strong> Student ID.

Bla bla bla

If you have any questions or can no longer attend, please contact us at 👉 robraadet@sdu.dk

See you there,
Robrådet - Robotics Student Council`;
}



/*****************************************************************************************/
/*************************************** MAIN CODE ***************************************/
/*****************************************************************************************/


/***** UTIL *****/
function getTargetSheet_() {
  const ss = SpreadsheetApp.openById(SPREADSHEET_ID); // open by spreadsheet ID
  const sh = ss.getSheets().find(s => s.getSheetId() === SHEET_ID);
  if (!sh) throw new Error('Tab with given SHEET_ID (gid) not found in this spreadsheet.');
  return sh;
}

function ensureSentColumn_(sh) {
  const header = sh.getRange(1, 1, 1, sh.getLastColumn()).getValues()[0];
  if (header.indexOf(COL.SENT) === -1) {
    sh.getRange(1, header.length + 1).setValue(COL.SENT);
  }
}

function getHeaderIndexMap_(sh) {
  const header = sh.getRange(1, 1, 1, sh.getLastColumn()).getValues()[0];
  const idx = (n) => header.indexOf(n);
  return {
    name: idx(COL.NAME),
    email: idx(COL.EMAIL),
    paid: idx(COL.PAID),
    sent: idx(COL.SENT),
    header
  };
}

function isYes_(v) {
  return String(v).trim().toLowerCase() === 'yes';
}



/***** TRIGGER: fires on edit in the bound sheet *****/
function onEdit(e) {
  Logger.log("Running onEdit()")
  updateCapacity();
  Logger.log("Capacity updated.")

  if (!e || !e.range) return;
  console.log('onEdit row:', e.range.getRow(), 'col:', e.range.getColumn(), 'value:', e.value);
  Logger.log("Cell was updated.")

  const sh = e.range.getSheet();
  if (sh.getSheetId() !== SHEET_ID) {
  Logger.log("Could not resolve SHEET_ID")
  return;
    }
  
  if (e.range.getRow() === 1) return;

  ensureSentColumn_(sh);
  const map = getHeaderIndexMap_(sh);
  if ([map.name, map.email, map.paid, map.sent].some(i => i === -1)){ 
    Logger.log("Not all information was given.")
    return
    }
  Logger.log("All information was given. Proceeding.")

  if (e.range.getColumn() !== map.paid + 1) { 
    Logger.log("Wont send email before the Paid column has been marked with yes")
    return
    }
  Logger.log("Entry was payed.")

  const row = e.range.getRow();
  const paidVal = sh.getRange(row, map.paid + 1).getValue();
  console.log('Paid cell value:', paidVal);
  if (!isYes_(paidVal)) return;

  const sentVal = sh.getRange(row, map.sent + 1).getValue();
  if (sentVal) return;

  const name = sh.getRange(row, map.name + 1).getValue();
  const email = sh.getRange(row, map.email + 1).getValue();

  if (!email) { 
    Logger.log("Email has not been provided")
    return
    };
  

  MailApp.sendEmail({
    to: email,
    replyTo: "robraadet@sdu.dk",
    subject: SUBJECT,
    body: renderBody_(name),
    htmlBody: renderBody_(name).replace(/\n/g, '<br>')
  });
  Logger.log("Successfully send email onEdit()");

  const sentCell = sh.getRange(row, map.sent + 1);
  sentCell.setValue(new Date());
  sentCell.setNumberFormat("yyyy-mm-dd HH:mm:ss");
  Logger.log("Email send timestamp updated.")
  
}


function updateCapacity() {
  const form = FormApp.openById(FORM_ID);
  const sh = getTargetSheet_();

  // find "Email Sent At" column
  const header = sh.getRange(1, 1, 1, sh.getLastColumn()).getValues()[0];
  const sentIdx = header.indexOf(COL.PAID);
  if (sentIdx === -1) throw new Error('"Email Sent At" column not found.');

  // count non-empty entries below header
  const sentRange = sh.getRange(2, sentIdx + 1, sh.getLastRow() - 1, 1).getValues();
  const submitted = sentRange.filter(r => r[0]).length;
  Logger.log("Info",submitted)
  const left = Math.max(0, LIMIT - submitted);

  //form.setTitle('Robrådet Christmas dinner');
  //form.setDescription(
 //   `Join the first Robrådet christmas dinner friday the 21. of November! Dinner, soda and snacks will all be provided you should only bring your good mood, favorite christmas sweater and alcohol for the night if you are into that. There are ONLY ${LIMIT} tickets available (${left} left) so make sure to be quick before the tickets run out.
//Remember your student card!!`
//  );
  form.setConfirmationMessage(
    left > 0
      ? `Thanks for your submission. Your spot at the event is confirmed once you recieve your confirmation email. If you encounter any problems please shoot us an email at robraadet@sdu.dk.`
      : `Event reached capacity. You may be waitlisted. If you already payed please contact us through robraadet@sdu.dk so we can refund you.`
  );

  if (left <= 0 && form.isAcceptingResponses()) {
    //form.setAcceptingResponses(false)
        //.setCustomClosedFormMessage('Fully booked. The form is now closed.');
  } else if (left > 0 && !form.isAcceptingResponses()) {
    form.setAcceptingResponses(true);
  }
}
