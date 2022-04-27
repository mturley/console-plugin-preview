import React from 'react';
import ReactDOM from 'react-dom';
import App from '@app/index';

import { worker } from './mocks/browser';
import { PluginStore } from 'console/frontend/packages/console-plugin-sdk/src/store';
import { loadPluginFromURL } from 'console/frontend/packages/console-dynamic-plugin-sdk/src/runtime/plugin-loader';

worker.start();

const pluginStore = new PluginStore();

const loadAndEnableMockPlugin = async () => {
  try {
    const pluginID = await loadPluginFromURL('http://localhost:9001/');
    pluginStore.setDynamicPluginEnabled(pluginID, true);
    console.log({
      allowedDynamicPluginNames: pluginStore.getAllowedDynamicPluginNames(),
      extensionsInUse: pluginStore.getExtensionsInUse(),
      stateForTestPurposes: pluginStore.getStateForTestPurposes(),
      dynamicPluginInfo: pluginStore.getDynamicPluginInfo(),
    });
  } catch (e) {
    console.error('Error while loading plugin', e);
  }
};

loadAndEnableMockPlugin();

if (process.env.NODE_ENV !== 'production') {
  const config = {
    rules: [
      {
        id: 'color-contrast',
        enabled: false,
      },
    ],
  };
  // eslint-disable-next-line @typescript-eslint/no-var-requires, no-undef
  const axe = require('react-axe');
  axe(React, ReactDOM, 1000, config);
}

ReactDOM.render(<App />, document.getElementById('root') as HTMLElement);
