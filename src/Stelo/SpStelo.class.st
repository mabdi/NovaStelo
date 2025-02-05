Class {
	#name : #SpStelo,
	#superclass : #SpScratchApp,
	#instVars : [
		'sworld',
		'events',
		'lastMSec',
		'lastTicks',
		'sworldMode',
		'recorder',
		'process',
		'updateInfoCount'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #accessing }
SpStelo class >> appFolderName [
	^ 'stelo'
]

{ #category : #accessing }
SpStelo class >> appName [
	^ 'NovaStelo'
]

{ #category : #accessing }
SpStelo class >> extension [
	^ 'sl'
]

{ #category : #'class initialization' }
SpStelo class >> initialize [
	"self initialize"
	ScratchTheme
		themesURL: self themesURL;
		setupThemeNamed: self appFolderName
]

{ #category : #'world menu' }
SpStelo class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #NovaStelo)
		order: 0.5;
		target: self;
		action: [self new open]; 
		icon: self icon
]

{ #category : #private }
SpStelo class >> recodingExtent [
	^ 400 @ 400
]

{ #category : #private }
SpStelo class >> screenshotExtent [
	^ 400 @ 400
]

{ #category : #accessing }
SpStelo class >> themesURL [
	^ 'https://github.com/EiichiroIto/NovaStelo/raw/master/misc/Themes.zip'
]

{ #category : #private }
SpStelo >> aboutAppString [
	^ self appName
		,
			'
Copyright © 2019 Eiichiro Ito (ghc02331@nifty.com)
All rights reserved.

Based on Scratch from the MIT Media Lab, v' , self basedVersion
		,
			'
Copyright © 2009 Massachusetts Institute of Technology.
All rights reserved.
'
]

{ #category : #variables }
SpStelo >> addList: aString var: vno breed: bno [
	sworld addList: aString var: vno breed: bno
]

{ #category : #'button actions' }
SpStelo >> addTurtles [
	| script |
	script := project addNewTurtleScript.
	sworld addBreed: script breed.
	^ script
]

{ #category : #variables }
SpStelo >> addVariable: aString var: vno breed: bno [
	sworld addVariable: aString var: vno breed: bno
]

{ #category : #private }
SpStelo >> backupProject [
	sworld backupBreeds: project breeds
]

{ #category : #private }
SpStelo >> changeMicroWorld [
	sworldMode = #SMicroWorld
		ifTrue: [ ^ self ].
	sworldMode := #SMicroWorld.
	self sworld: self newWorld
]

{ #category : #private }
SpStelo >> changePluginWorld [
	sworldMode = #SPluginWorld
		ifTrue: [ ^ self ].
	sworldMode := #SPluginWorld.
	self sworld: self newWorld
]

{ #category : #'button actions' }
SpStelo >> clearPatches [
	sworld clearBreed: project patches breedNo.
	presenter updateDisplay
]

{ #category : #'button actions' }
SpStelo >> clearTurtles [
	project turtleBreeds do: [ :each | sworld clearBreed: each breedNo ].
	presenter updateDisplay
]

{ #category : #'menu actions' }
SpStelo >> copyListToPlots [
	| listNames plots ret list vno |
	listNames := project observer userDefinedListNames.
	listNames isEmpty
		ifTrue: [ ^ self ].
	plots := (1 to: self plotter numChannels + 1) asArray.
	ret := SpSteloConvDialog listNames: listNames plots: plots.
	ret ifNil: [ ^ self ].
	vno := project observer varNoFor: ret first.
	list := sworld var: vno breed: SBreedId observerBreedNo list: 1.
	self plotter plot: ret second list: list
]

{ #category : #'menu actions' }
SpStelo >> copyPlotsToList [
	| listNames plots ret list vno |
	listNames := project observer userDefinedListNames.
	listNames isEmpty
		ifTrue: [ ^ self ].
	plots := (1 to: self plotter numChannels) asArray.
	ret := SpSteloConvDialog plots: plots listNames: listNames.
	ret ifNil: [ ^ self ].
	list := self plotter listOf: ret first.
	vno := project observer varNoFor: ret second.
	sworld
		var: vno
		breed: SBreedId observerBreedNo
		list: 1
		set: list
]

{ #category : #private }
SpStelo >> createProject [
	^ SteloProject new
]

{ #category : #private }
SpStelo >> defaultSWorldMode [
	^ #SMicroWorld
]

{ #category : #'button actions' }
SpStelo >> deleteTurtles: anInteger [
	| script |
	script := project scriptOf: anInteger.
	project deleteScript: script.
	sworld deleteBreed: script breed.
	presenter updateDisplay
]

{ #category : #accessing }
SpStelo >> eventIdFor: aSymbol [
	^ events at: aSymbol
]

{ #category : #'menu actions' }
SpStelo >> exportPlots [
	self export: SteloPlotsExporter new extension: self plotsExtension
]

{ #category : #'menu actions' }
SpStelo >> exportSexpCode [
	self export: (ScratchSexpExporter appName: self appName) extension: self sexpExtension
]

{ #category : #private }
SpStelo >> imageExtension [
	^ 'png'
]

{ #category : #'menu actions' }
SpStelo >> importPlots [
	self import: SteloPlotsImporter new extension: self plotsExtension
]

{ #category : #'menu actions' }
SpStelo >> importSexpCode [
	self import: (ScratchSexpImporter appName: self appName) extension: self sexpExtension.
	presenter updateTurtles
]

{ #category : #initialization }
SpStelo >> initialize [
	super initialize.
	lastMSec := nil.
	lastTicks := 0.
	sworldMode := self defaultSWorldMode.
	presenter sworldMode: sworldMode.
	updateInfoCount := 0
]

{ #category : #private }
SpStelo >> installNewProject: aProject [
	self stopAllProcesses.
	self sworld: self newWorld.
	project := aProject.
	project application: self.
	project setupScripts.
	project fixVars.
	project modified: false.
	self restoreProject.
	self setupView.
	presenter updateTurtles.
	Smalltalk garbageCollect
]

{ #category : #processes }
SpStelo >> isProcessRunning [
	^ process notNil and: [ process isRunning ]
]

{ #category : #testing }
SpStelo >> isRecording [
	^ recorder notNil
]

{ #category : #processes }
SpStelo >> maxUpdateInfoCount [
	^ 50
]

{ #category : #processes }
SpStelo >> newCode [
	^ SteloCode new
		generator: SteloBytecodeGenerator new;
		yourself
]

{ #category : #private }
SpStelo >> newObserver [
	^ SObserver new
]

{ #category : #private }
SpStelo >> newPatches [
	^ SPatches new
]

{ #category : #private }
SpStelo >> newPresenter [
	^ SpSteloFrame basicNew
		application: self;
		initialize;
		whenStepsDo: [ self stepProcesses ]
]

{ #category : #processes }
SpStelo >> newProgram [
	^ SProgram new
]

{ #category : #private }
SpStelo >> newTurtles [
	^ sworld newBreed
]

{ #category : #private }
SpStelo >> newWorld [
	^ (Smalltalk at: sworldMode) new
]

{ #category : #accessing }
SpStelo >> observerScript [
	^ project scriptOf: SBreedId observerBreedNo
]

{ #category : #accessing }
SpStelo >> patchesScript [
	^ project scriptOf: SBreedId patchBreedNo
]

{ #category : #private }
SpStelo >> plotsExtension [
	^ 'csv'
]

{ #category : #accessing }
SpStelo >> plotter [
	^ presenter plotter
]

{ #category : #private }
SpStelo >> restoreProject [
	sworld restoreBreeds: project breeds
]

{ #category : #processes }
SpStelo >> runLoop [
	| program |
	self setupEvents.
	program := project programOf: events.
	process := sworld newProcess program: program.
	process loop.
	^ process
]

{ #category : #processes }
SpStelo >> runSetup [
	| program |
	self setupEvents.
	program := project programOf: events.
	process := sworld newProcess program: program.
	process startup.
	^ process
]

{ #category : #'menu actions' }
SpStelo >> saveStageAsImage [
	| file saveForm |
	saveForm := presenter stageShotExtent: self class screenshotExtent.
	saveForm ifNil: [ ^ self ].
	file := UIManager default
		chooseForSaveFileReference: 'Save Stage' localized
		extensions: {self imageExtension}
		path: self projectPath.
	file ifNil: [ ^ self ].
	saveForm writePNGFileNamed: file pathString
]

{ #category : #accessing }
SpStelo >> scriptOf: anInteger [
	^ project scriptOf: anInteger
]

{ #category : #processes }
SpStelo >> setupEvents [
	| result eventId |
	eventId := EventId new.
	result := Dictionary new.
	result at: #startup put: EventId startupEventNo.
	result at: #setup put: EventId setupEventNo.
	result at: #loop put: EventId loopEventNo.
	result at: #single put: EventId singleEventNo.
	project allEventNames do: [ :each | result at: each asSymbol put: eventId newNo ].
	events := result.
	^ events
]

{ #category : #private }
SpStelo >> sexpExtension [
	^ 'sts'
]

{ #category : #'button actions' }
SpStelo >> startEvent [
	| program menu eno |
	self stopAllProcesses.
	presenter stepTime: 0.
	self setupEvents.
	eno := 0.
	menu := presenter
		eventMenuFrom: events
		whenSelected: [ :v | eno := v ].
	menu ifNil: [ ^ self ].
	menu openWithSpecAt: ActiveWorld cursorPoint.
	eno = 0 ifTrue: [ ^ self ].
	program := project programOf: events.
	process := sworld newProcess program: program.
	process event: eno.
	^ process
]

{ #category : #'button actions' }
SpStelo >> startLoop [
	self stopAllProcesses.
	presenter stepTime: 0.
	self runLoop
]

{ #category : #'button actions' }
SpStelo >> startLoopSlow [
	self stopAllProcesses.
	presenter stepTime: 500.
	self runLoop
]

{ #category : #processes }
SpStelo >> startProcessFor: topBlock [
	| code program |
	self stopAllProcesses.
	self setupEvents.
	code := self newCode parse: topBlock target: presenter target.
	program := self newProgram.
	program
		addCode: code;
		addEntryPoint: 1
			eventNo: EventId singleEventNo
			breedNo: topBlock receiver breedNo.
	process := sworld newProcess program: program.
	process single.
	^ process
]

{ #category : #'button actions' }
SpStelo >> startSetup [
	self stopAllProcesses.
	presenter stepTime: 0.
	self runSetup
]

{ #category : #'menu actions' }
SpStelo >> startStageRecording [
	| file |
	file := UIManager default
		chooseForSaveFileReference: 'Start Stage Recording' localized
		extensions: {'gif'}
		path: self projectPath.
	file ifNil: [ ^ self ].
	recorder := ScratchRecorder new
		openFileNamed: file;
		model: presenter;
		extent: self class recodingExtent.
	self updateStatus
]

{ #category : #'button actions' }
SpStelo >> stepLoop [
	self stopAllProcesses.
	presenter stepTime: 0.
	self runLoop.
	self stepProcesses.
	self stopAllProcesses
]

{ #category : #processes }
SpStelo >> stepProcesses [
	| list |
	process ifNotNil: [ process step ].
	updateInfoCount := updateInfoCount + 1.
	updateInfoCount > self maxUpdateInfoCount
		ifTrue: [ updateInfoCount := 0.
			self updateInfo ].
	presenter updateDisplay.
	recorder ifNotNil: [ recorder writeForced: false ].
	list := sworld plotList.
	list isEmpty
		ifTrue: [ ^ self ].
	presenter addPlots: list
]

{ #category : #'button actions' }
SpStelo >> stopAll [
	presenter stepTime: 1000.
	self stopAllProcesses
]

{ #category : #processes }
SpStelo >> stopAllProcesses [
	process ifNil: [ ^ self ].
	process stop.
	process := nil
]

{ #category : #'menu actions' }
SpStelo >> stopStageRecording [
	recorder ifNil: [ ^ self ].
	recorder close.
	recorder := nil.
	self updateStatus
]

{ #category : #accessing }
SpStelo >> sworld [
	^ sworld
]

{ #category : #accessing }
SpStelo >> sworld: aWorld [
	sworld ifNotNil: [ self backupProject ].
	sworld := aWorld.
	project ifNotNil: [ self restoreProject ].
	presenter sworld: aWorld.
	self updateStatus
]

{ #category : #'menu actions' }
SpStelo >> toggleSWorld [
	sworldMode = #SMicroWorld
		ifTrue: [ self changePluginWorld ]
		ifFalse: [ self changeMicroWorld ].
	presenter sworldMode: sworldMode.
	self updateStatus
]

{ #category : #'menu actions' }
SpStelo >> toggleStageRecording [
	self isRecording
		ifTrue: [ self stopStageRecording ]
		ifFalse: [ self startStageRecording ]
]

{ #category : #accessing }
SpStelo >> turtlesScript: bno [
	^ project scriptOf: bno
]

{ #category : #accessing }
SpStelo >> turtlesScripts [
	^ project scriptsForMenu
]

{ #category : #processes }
SpStelo >> updateInfo [
	| msec ticks fps info |
	self updateStatus.
	msec := Time millisecondClockValue.
	ticks := sworld ticks.
	lastMSec
		ifNotNil: [ fps := ((ticks - lastTicks) * 1000 / (msec - lastMSec)) truncated.
			info := String new writeStream
				in: [ :stream | 
					stream
						nextPutAll: 'ticks=';
						nextPutAll: ticks truncated asString;
						nextPutAll: ' (';
						nextPutAll: fps asString;
						nextPutAll: 'fps)';
						nextPutAll: ', ';
						nextPutAll: (sworld countAliveOf: SBreedId turtleBreedNo) asString;
						nextPutAll: ' turtles'.
					stream contents ].
			presenter info: info ].
	lastMSec := msec.
	lastTicks := ticks
]

{ #category : #private }
SpStelo >> updateStatus [
	| str |
	str := ' (', sworld worldName, ')'.
	self isRecording
		ifTrue: [ str := str, ' (Recording)' ].
	presenter status: str
]
