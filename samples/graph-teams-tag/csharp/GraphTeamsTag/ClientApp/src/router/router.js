import * as React from "react";
import {
    BrowserRouter,
    Route,
    Routes
} from 'react-router-dom';
import Configure from "../components/configure";
import * as microsoftTeams from "@microsoft/teams-js";
import Dashboard from "../components/dashboard";

export const AppRoute = () => {
    // React.useEffect(() => {
    //     microsoftTeams.app
    //         .initialize()
    //         .then(() => {
    //         console.log("App.js: initializing client SDK initialized");
    //         microsoftTeams.app.notifyAppLoaded();
    //         microsoftTeams.app.notifySuccess();
    //         })
    //         .catch((error) => console.error(error));
    //   }, []);

    return (
        <React.Fragment>
            <BrowserRouter>
                <Routes>
                    <Route path="/configure" element={<Configure />}/>
                    <Route path="/dashboard" element={<Dashboard />}/>
                </Routes>
            </BrowserRouter>
        </React.Fragment>
    );
};