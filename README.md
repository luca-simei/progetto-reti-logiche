# <div align="center"> Progetto di Reti Logiche </div> <div align="center"> Prova Finale, AA. 2022-2023 </div>
## <div align="center"> Luca Simei, Alessio Spineto </div>

Questa è la prova finale per il corso di Reti Logiche @ Politecnico di Milano
Il progetto consiste nella progettazione e realizzazione di un modulo in linguaggio VHDL a partire da una specifica in linguaggio naturale del suo funzionamento.
Questo progetto ha ricevuto la valutazione massima di **30L**.

### Descrizione del Problema

Ad elevato livello di astrazione, il sistema riceve indicazioni circa una locazione di memoria, il cui contenuto deve essere indirizzato verso un canale di uscita fra i quattro disponibili.  Considerando informazioni più dettagliate riguardo le interfacce e il funzionamento del modulo [(specifica completa)](https://github.com/luca-simei/progetto-reti-logiche/blob/main/Specifica/PFRL_Specifica_22_23.pdf), l'implementazione del componente è stata realizzata interfacciandosi a una memoria contenente tutte le informazioni relative al problema e utilizzando appositi segnali.

### Implementazione

L'[implementazione](https://github.com/luca-simei/progetto-reti-logiche/blob/main/10714016_10739526.vhdl) del componente consiste principalmente nella realizzazione di una macchina a stati finiti che regola il funzionamento del circuito. La transizione da uno stato all'altro dipende dallo stato corrente della macchina e, in alcuni casi, dal valore del segnale di START. Tale macchina a stati finiti presenta 5 stati, rappresentati secondo una codifica a minor numero di bit.

### Test Bench

Nel contesto dello sviluppo del circuito descritto, è stato utilizzato il set di test bench di esempio fornito per la simulazione. Ciò ha permesso di ricevere un feedback sui cambiamenti apportati al codice. Successivamente, è stato sviluppato un insieme personalizzato di test, focalizzato sull'identificazione dei casi che potrebbero condurre l'esecuzione alle condizioni critiche, al fine di verificare la completa correttezza del sistema.

I test sviluppati per sforzare il componente in situazioni particolari sono i seguenti:
- **Reset Test**: risposta corretta al segnale di RESET
- **Overwrite and Extension Test**: verifica di proprietà necessarie per rispettare le specifiche del progetto
- **Min and Max Values of START Test**: condizioni limite del segnale di START derivate dalle specifiche di progetto


### Sviluppatori
[Luca Simei](https://github.com/luca-simei)

[Alessio Spineto](https://github.com/Comodaino)
