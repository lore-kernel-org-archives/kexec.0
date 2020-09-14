Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410080.outbound.protection.outlook.com
 ([40.107.141.80] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHjeV-0008Qb-Af
 for kexec@lists.infradead.org; Mon, 14 Sep 2020 08:15:56 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: makedumpfile: a feature question about filtering
Date: Mon, 14 Sep 2020 08:15:39 +0000
Message-ID: <OSBPR01MB19915EEEDE74943D073908D4DD230@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <9da0d585-4170-5758-e27d-814fcb97d575@redhat.com>
 <OSBPR01MB1991C082928AD18ED5574DDBDD240@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <0b99591e-7117-7661-e728-684ece22787e@redhat.com>
In-Reply-To: <0b99591e-7117-7661-e728-684ece22787e@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: piliu <piliu@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gT24gMDkvMTEvMjAyMCAwNDo1MyBQTSwgSEFH
SU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKSB3cm90ZToNCj4gPiBIaSBQaW5nZmFuLA0KPiA+
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gSGVsbG8sDQo+ID4+DQo+ID4+
IFRoZXJlIGlzIGFuIGFwcGVhbCB3aGljaCBvbmx5IHdhbnRzIHRvIHNhdmUgc29tZSB1c2VyIHBh
Z2UgaW5jbHVkaW5nIGVudg0KPiA+PiBhbmQgYXJncyBwYWdlcywgYW5kIGRpc2NhcmRzIHRoZSBv
dGhlciB1c2VyIHNwYWNlIHBhZ2VzLg0KPiA+DQo+ID4gSSB1bmRlcnN0YW5kIHRoYXQgaXQncyBo
ZWxwZnVsIHRvIGdldCB0aGVtIGV2ZW4gd2l0aCAtZCAzMSBmb3IgY3Jhc2gncw0KPiA+ICJwcyAt
YSIgb3B0aW9uLi4NCj4gPg0KPiA+Pg0KPiA+PiBUbyBhY2hpZXZlIHRoaXMgZmVhdHVyZSwgbW1f
c3RydWN0J3MgbWVtYmVycyAiYXJnX3N0YXJ0LCBhcmdfZW5kLA0KPiA+PiBlbnZfc3RhcnQsIGVu
dl9lbmQ7IiBzaG91bGQgYmUgYWNjZXNzZWQuIFNvIHdlIG5lZWQgdG8gZXhwb3J0IG1tX3N0cnVj
dA0KPiA+PiBhbmQgaW5pdF9tbSB0aHJvdWdoIHZtY29yZS4NCj4gPg0KPiA+IEhvdyBtYW55IG9m
ZnNldHMvc2l6ZXMgd2lsbCBiZSByZXF1aXJlZCB0byB3YWxrIGFsbCB0YXNrcz8NCj4gQXQgcHJl
c2VudCwgSSB0aGluayBvbmx5IHRoZSBpbmZvICJhcmdfc3RhcnQsIGFyZ19lbmQsIGVudl9zdGFy
dCwNCj4gZW52X2VuZCIgaW4gbW1fc3RydWN0IGFyZSByZXF1aXJlZC4NCg0KYWggd2hhdCBJIHdh
bnRlZCB0byBhc2sgbWFpbmx5IHdhcyB0aGUgbnVtYmVyIG9mIHRoZSBvZmZzZXRzL3NpemVzIHVz
ZWQgdG8NCndhbGsgdGhyb3VnaCBhbGwgKHVzZXIpIHRhc2tzIGluIGEgc3lzdGVtLCBiZWNhdXNl
IG1ha2VkdW1wZmlsZSBjYW5ub3QgZ2V0DQp0byBhIHRhc2sncyBhcmdfc3RhcnQgb25seSB3aXRo
IE9GRlNFVChtbV9zdHJ1Y3QuYXJnX3N0YXJ0KS4gIElzIGl0IGVhc3kNCmVub3VnaCB0byBkbyBp
dCBvbmx5IHdpdGggc2V2ZXJhbCB2bWNvcmVpbmZvIGVudHJpZXM/DQoNClRoYW5rcywNCkthenUN
Cg0KPiA+IElmIGtlcm5lbCBtYWludGFpbmVycyBhY2NlcHQgaXQsIEkgd2lsbCBub3Qgb3Bwb3Nl
IHRoYXQgZmVhdHVyZS4uDQo+IE9LLCBJIHdpbGwgc3RhcnQgd2l0aCBrZXJuZWwgc2lkZSBhcyB0
aGUgZmlyc3Qgc3RlcC4NCj4gPg0KPiA+IChvciBpdCB3b3VsZCBiZSBzaW1wbGVyIHRvIG1hcmsg
dGhlIHBhZ2VzIHNvbWV0aGluZyBzcGVjaWFsIHdoZW4gYWxsb2NhdGluZywNCj4gPiBidXQgSSBk
b24ndCBmZWVsIGxpa2UgaXQncyBlYXN5IHRvIGNoYW5nZSBrZXJuZWwgdG8gZG8gc28uKQ0KPiBZ
ZXMsIEkgYWdyZWUuIEZyb20ga2VybmVsIHNpZGUsIHRoZSBwYWdlIGlzIGEgbm9ybWFsIHVzZXIg
c3BhY2UgcGFnZSwNCj4gdGhlcmUgc2hvdWxkIG5vdCBiZSBleGNlcHRpb24uDQo+IA0KPiBUaGFu
a3MsDQo+IFBpbmdmYW4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
