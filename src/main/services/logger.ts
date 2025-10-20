import log from 'electron-log/main';

log.initialize();
log.transports.console.level = 'info';
log.transports.file.level = 'info';

export { log };
