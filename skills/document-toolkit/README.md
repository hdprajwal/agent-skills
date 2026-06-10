# document-toolkit

Read, extract, fill, and generate PDF / DOCX / XLSX documents from Python.

Pick the right library per file type — `pdfplumber`/`pypdf` for PDF (extract text & tables, merge/split, forms, OCR), `python-docx` for Word (read/build headings, paragraphs, tables, images), `openpyxl` (or pandas) for Excel (read values, write sheets/formulas/styles). Library over brittle shell parsing; work on a copy; verify the output.

## Install

```bash
npx skills add https://github.com/hdprajwal/agent-skills --skill document-toolkit -g
```

## Requires

`pip install pypdf pdfplumber python-docx openpyxl` (and `ocrmypdf` for scanned PDFs).
