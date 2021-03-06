echo ' * Initializing Angular Client Build..'
ng new client
echo ' * Navigating into Project>Client Folder..'
cd client
echo ' * Creating MODEL1 service'
ng g s $3
echo ' * Creating MODEL2 service'
ng g s $5
echo ' * Navigating into Project>Client>Src Folder..'
cd src
echo ' * Navigating into Project>Client>Src>App Folder..'
cd app
echo ' * Writing Project>Client>Src>App> * app.component.html File..'
cat >| app.component.html << EOL
<!--The content below is only a placeholder and can be replaced.-->
<div style="text-align:center">
  <h1>
    Welcome to {{ title }}!
  </h1>
  <fieldset>
    <legend>Add a new $2</legend>
    <form (submit)="make$2()">
      <input type="text" name="new$2.name" [(ngModel)]="new$2.name" placeholder="name" />
      <input type="submit" value="Create" />
    </form>
  </fieldset>
</div>
<!--<app-$3 *ngFor="let $3 of $3s" [$3]="$3" ($3Event)="andGet$2s()"></app-$3>-->
EOL
echo ' * Writing Project>Client>Src>App> * app.component.ts File..'
cat >| app.component.ts << EOL
import { Component } from '@angular/core';
import { $2Service } from './$3.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'MEAN';
  $3s = [];
  new$2 = {
    "name": ""
  }

  constructor(private _$3Service:$2Service){}

  ngOnInit(){
    this.andGet$2s();
  }

  andGet$2s(){
    let observable = this._$3Service.get$2s();
    observable.subscribe( (data) => {
      console.log(data);
      this.$3s = data['$3s'];
    });
  }

  destroy$2($3_id){
    let observable = this._$3Service.remove$2($3_id);
    observable.subscribe( (data) => {
      console.log(data);
      this.andGet$2s();
    });
  }

  make$2(){
    let observable = this._$3Service.create$2(this.new$2);
    observable.subscribe( data => {
      console.log(data);
      this.andGet$2s();
      this.new$2 = {
        "name": ""
      };
    });
  }
}
EOL
echo ' * Writing Project>Client>Src>App> * app.module.ts File..'
cat >| app.module.ts << EOL
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { $2Service } from './$3.service';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [$2Service],
  bootstrap: [AppComponent]
})
export class AppModule { }
EOL
echo ' * Writing Project>Client>Src>App> * MODELNAME.service.ts File..'
cat >| $3.service.ts << EOL
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class $2Service {

  constructor(private _http: HttpClient) { }

  get$2s(){
    return this._http.get(\`/$3s\`);
  }

  remove$2($3_id){
    return this._http.delete(\`/$3s/\${$3_id}\`);
  }

  create$2(new$2){
    return this._http.post(\`/$3s\`, new$2);
  }
}
EOL
echo ' * Navigating into Project>Client>Src from Project>Client>Src>App Folder..'
cd ..
echo ' * Navigating into Project>Client from Project>Client>Src Folder..'
cd ..
echo ' * Calling ../../meanpackage/mean-components.sh..'
. ../../meanpackage/mean-components.sh
