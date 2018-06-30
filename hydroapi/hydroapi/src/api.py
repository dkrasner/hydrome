"""API Handler."""


class Api(object):

    """API Handler main class."""

    def __init__(self):
        # TODO: currently this is all hardcoded but should be loaded
        # dynamically from the wrfhydropy modules
        self.models = {
            "WrfHydroModel": {
                "args": [
                    {"name": "source_dir", "type": "str",
                     "default": "/wrf_hydro_nwm_public/trunk/NDHMS/"
                     },
                    {"name": "model_config", "type": "List[str]",
                     "options": ["NWM"], "default": "NWM"}
                ],
                "compile_args": [
                    {"name": "compiler", "type": "List[str]",
                     "default": "gfort", "options": ["gfort"]},
                    {"name": "compile_dir", "type": "str", "default": "/tmp"},
                    {"name": "overwrite", "type": "bool", "default": "False"},
                ]
            }
        }
        self.domains = {
            "WrfHydroDomain": {
                "args": [
                    {"name": "domain_top_dir", "type": "str",
                     "default": "/domain/croton_NY"
                     },
                    {"name": "model_version", "type": "str"},
                    {"name": "domain_config", "type": "List[str]",
                     "options": ["NWM"], "default": "NWM"}
                ]
            }
        }

    def model_info(self, name=None):
            """
            Return argument and related data about either all or specific chosen
            model.

            Parameters :
            ----------
            name : str
                model name; if None return info for all models

            Returns:
            --------
            dict
            """
            if name is None:
                return self.models
            return {name: self.models[name]}

    def model_compile(self, model_args, compile_args):
        """
        Handler for the model compilation process

        """
        # TODO: This needs to communicate with hydro models, deal with errors
        return True

    def domain_info(self, name=None):
            """
            Return argument and related data about either all or specific chosen
            domain.

            Parameters :
            ----------
            name : str
                domain name; if None return info for all domains

            Returns:
            --------
            dict
            """
            if name is None:
                return self.domains
            return {name: self.domains[name]}

    def setup(self, model, domain):
        """
        Setup Handler.

        TODO: this needs to interface with Hydro modal and domain classes. TBD
        """
        return True

    def run(self, **args):
        """
        Run Handler.

        TODO: all!
        """
        return True

    def scheduler(self, **args):
        """
        Job Scheduler Handler.

        TODO: all!
        """
        return True
