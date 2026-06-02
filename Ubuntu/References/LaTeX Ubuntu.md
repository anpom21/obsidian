

### Download MikTeX
##### a. Register GPG key

```
curl -fsSL https://miktex.org/download/key | sudo gpg --dearmor -o /usr/share/keyrings/miktex.gpg
```

##### b. Register installation source

###### Ubuntu 24.04 LTS (Noble Numbat):

```
echo "deb [signed-by=/usr/share/keyrings/miktex.gpg] https://miktex.org/download/ubuntu noble universe" | sudo tee /etc/apt/sources.list.d/miktex.list
```
##### c. Install MiKTeX
```
sudo apt-get update
sudo apt-get install miktex
```


## Download LaTeX utilities

```
sudo apt install latexmk texlive-latex-extra texlive-fonts-recommended texlive-bibtex-extra biber
sudo apt install texlive-science
```

## Using LaTeX in vscode
Compile with the compile button in the top or `Ctrl + Alt + B`.
Compile from scratch with:
```
latexmk -c && latexmk -pdf -interaction=nonstopmode main.tex
```

## Build folder
To make the LaTeX environment more structured it is recommended to have a `.vscode/settings.json` files which tells the compiler how to compile the .pdf and where to place its auxiliary files.
Make the file `.vscode/settings.json` ([also linked here](file:///home/ap/Documents/speciale/LaTeX/Kandidat_kontrakt/.vscode/settings.json)):

```json
{
	"latex-workshop.latex.outDir": "./build",
	"latex-workshop.latex.tools": [
	{
	"name": "latexmk",
	"command": "latexmk",
	"args": [
		"-synctex=1",
		"-interaction=nonstopmode",
		"-file-line-error",
		"-pdf",
		"-outdir=build",
		"%DOC%"
	]
	},
	{
	"name": "pdflatex",
	"command": "pdflatex",
	"args": [
		"-synctex=1",
		"-interaction=nonstopmode",
		"-file-line-error",
		"-output-directory=build",
		"%DOC%"
	]
	}
],
"latex-workshop.latex.recipes": [
{
"name": "latexmk 🔃",
"tools": ["latexmk"]
},
{
"name": "pdflatex ➞ bibtex ➞ pdflatex × 2",
"tools": ["pdflatex", "bibtex", "pdflatex", "pdflatex"]
}
],
"latex-workshop.latex.clean.fileTypes": [
"*.aux",
"*.bbl",
"*.blg",
"*.idx",
"*.ind",
"*.lof",
"*.lot",
"*.out",
"*.toc",
"*.acn",
"*.acr",
"*.alg",
"*.glg",
"*.glo",
"*.gls",
"*.ist",
"*.fls",
"*.log",
"*.fdb_latexmk",
"*.snm",
"*.nav",
"*.vrb",
"*.bcf",
"*.run.xml",
"*.synctex.gz"
],
"latex-workshop.latex.clean.subfolder.enabled": true,
"latex-workshop.view.pdf.viewer": "tab"
}
```

### Move pdf to root folder
To move the pdf from the build folder to the root folder make the following file in your root project folder `.latexmkrc` ([also linked here](file:///home/ap/Documents/speciale/LaTeX/Kandidat_kontrakt/.latexmkrc)) with the following contents:
```
# LaTeX build configuration
# Output directory for auxiliary files
$out_dir = 'build';

# Copy PDF to root directory after successful compilation
$success_cmd = 'cp build/%B.pdf ./%B.pdf';

# Ensure output directory exists
system('mkdir -p build');
```
