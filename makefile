JAVA      = java
JAVA_ARGS = -jar

PLANTUML      = plantuml.jar
PLANTUML_ARGS = -o ../out

APPUML = src/application.uml
APPIMG = out/application.png

COORDUML = src/coordinate.uml
COORDIMG = out/coordinate.png

FPLANUML = src/flightplan.uml
FPLANIMG = out/flightplan.png

MCONTUML = src/mapcontrol.uml
MCONTIMG = out/mapcontrol.png

MDBUML = src/mapdb.uml
MDBIMG = out/mapdb.png

all: $(APPIMG)

$(PLANTUML):
	wget https://cedrickc.net/res/plantuml.jar

out:
	mkdir out

$(APPIMG): $(APPUML) $(COORDIMG) $(FPLANIMG) $(MCONTIMG) | $(PLANTUML) out
	$(JAVA) $(JAVA_ARGS) $(PLANTUML) $(PLANTUML_ARGS) $<

$(COORDIMG): $(COORDUML) | $(PLANTUML) out
	$(JAVA) $(JAVA_ARGS) $(PLANTUML) $(PLANTUML_ARGS) $<

$(FPLANIMG): $(FPLANUML) $(COORDIMG) | $(PLANTUML) out
	$(JAVA) $(JAVA_ARGS) $(PLANTUML) $(PLANTUML_ARGS) $<

$(MCONTIMG): $(MCONTUML) $(COORDIMG) $(FPLANIMG) $(MDBIMG) | $(PLANTUML) out
	$(JAVA) $(JAVA_ARGS) $(PLANTUML) $(PLANTUML_ARGS) $<

$(MDBIMG): $(MDBUML) $(COORDIMG) | $(PLANTUML) out
	$(JAVA) $(JAVA_ARGS) $(PLANTUML) $(PLANTUML_ARGS) $<

clean:
	-rm -f ./out/*.png

.PHONY: all clean
