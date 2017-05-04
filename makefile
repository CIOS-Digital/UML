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

UC_ADDWAYPOINT_UML = src/uc_add_waypoint.uml
UC_ADDWAYPOINT_IMG = out/uc_add_waypoint.png

all: $(APPIMG) use_cases

$(PLANTUML):
	wget https://cedrickc.net/res/plantuml.jar

out:
	mkdir out

use_cases: $(UC_ADDWAYPOINT_IMG)

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

$(UC_ADDWAYPOINT_IMG): $(UC_ADDWAYPOINT_UML) | $(PLANTUML) out
	$(JAVA) $(JAVA_ARGS) $(PLANTUML) $(PLANTUML_ARGS) $<

clean:
	-rm -f ./out/*.png

.PHONY: all clean use_cases
