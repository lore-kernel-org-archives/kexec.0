Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1acqv6-0008DC-MD
 for kexec@lists.infradead.org; Mon, 07 Mar 2016 08:53:41 +0000
From: Minoru Usui <min-usui@ti.jp.nec.com>
Subject: RE: [PATCH v3] Improve the performance of --num-threads -d 31
Date: Mon, 7 Mar 2016 08:52:05 +0000
Message-ID: <BE691E4CBA06214BB0FA8EEFC7C61A4D0181E6B9@BPXM02GP.gisp.nec.co.jp>
References: <1457080544-16469-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160307070458.GA6016@dhcp-128-25.nay.redhat.com>
 <BE691E4CBA06214BB0FA8EEFC7C61A4D0181E2B9@BPXM02GP.gisp.nec.co.jp>
 <56DD3A3E.1000402@cn.fujitsu.com> <56DD3F27.4030105@cn.fujitsu.com>
In-Reply-To: <56DD3F27.4030105@cn.fujitsu.com>
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
To: =?utf-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?= <zhouwj-fnst@cn.fujitsu.com>
Cc: Minfei Huang <mhuang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

SGksIFpob3UNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBrZXhlYyBb
bWFpbHRvOmtleGVjLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9yZ10gT24gQmVoYWxmIE9mICJa
aG91LCBXZW5qaWFuL+WRqOaWhz8iDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMDcsIDIwMTYgNTo0
MyBQTQ0KPiBUbzogVXN1aSBNaW5vcnUo56KT5LqVIOaIkCkgPG1pbi11c3VpQHRpLmpwLm5lYy5j
b20+DQo+IENjOiBNaW5mZWkgSHVhbmcgPG1odWFuZ0ByZWRoYXQuY29tPjsga2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBJbXByb3ZlIHRoZSBwZXJm
b3JtYW5jZSBvZiAtLW51bS10aHJlYWRzIC1kIDMxDQo+IA0KPiBIaSBNaW5vcnUsDQo+IA0KPiBJ
IGdvdCB0d28gZXJyb3IgZHVtcGZpbGVzIGJ5IHJ1bm5pbmcgaXQgbGVzcyB0aGFuIDEwMCB0aW1l
cy4NCg0KT2gsIEknbSBzb3JyeS4NClRoYW5rIHlvdSBmb3IgeW91ciB0ZXN0Lg0KDQpJJ20gd2Fp
dGluZyBmb3IgeW91ciB2NCBwYXRjaC4NCg0KVGhhbmtzDQpNaW5vcnUgVXN1aQ0KDQoNCg0KPiAt
LQ0KPiBUaGFua3MNCj4gWmhvdQ0KPiANCj4gT24gMDMvMDcvMjAxNiAwNDoyMiBQTSwgIlpob3Us
IFdlbmppYW4v5ZGo5paHPyIgd3JvdGU6DQo+ID4gSGkgTWlub3J1LA0KPiA+DQo+ID4gSSBoYXZl
IHRlc3QgeW91ciBwYXRjaCBzaW5jZSB5b3UgcG9zdC4NCj4gPiBJIGNhbiBnZXQgYSBmYWlsdXJl
IGVhc2lseS4NCj4gPiBJZiB5b3UgcnVuIGl0IHNldmVyYWwgdGltZXMsIHRoZSBkdW1wZmlsZSBp
dCBwcm9kdWNlcyBtYXkgYmUgZGlmZmVyZW50IGZyb20gdGhlIGNvcnJlY3Qgb25lLg0KPiA+DQo+
ID4gKwkJCWluZm8tPmN1cnJlbnRfcGZuID0gcGZuICsgMTsNCj4gPiArCQkJcHRocmVhZF9tdXRl
eF91bmxvY2soJmluZm8tPmN1cnJlbnRfcGZuX211dGV4KTsNCj4gPiArCQkJcGFnZV9mbGFnX2J1
Zi0+cGZuID0gcGZuOw0KPiA+ICsJCQlwYWdlX2ZsYWdfYnVmLT5yZWFkeSA9IEZMQUdfRklMTElO
RzsNCj4gPiBUaGUgYWJvdmUgY29kZSBzaG91bGQgYmUgY2hhbmdlZCB0byB0aGUgZm9sbG93aW5n
Og0KPiA+DQo+ID4gKwkJCWluZm8tPmN1cnJlbnRfcGZuID0gcGZuICsgMTsNCj4gPiArCQkJcGFn
ZV9mbGFnX2J1Zi0+cGZuID0gcGZuOw0KPiA+ICsJCQlwYWdlX2ZsYWdfYnVmLT5yZWFkeSA9IEZM
QUdfRklMTElORzsNCj4gPiArCQkJcHRocmVhZF9tdXRleF91bmxvY2soJmluZm8tPmN1cnJlbnRf
cGZuX211dGV4KTsNCj4gPg0KPiA+IEkgaGF2ZW4ndCBydW4geW91ciBjb2RlIHdpdGggdGhlIGJ1
ZyBmaXhlZC4NCj4gPiBJJ2xsIHRyeSBub3cuDQo+ID4NCj4gPiBCeSB0aGUgd2F5LCB3aXRoIG15
IHBhdGNoIHYzLCBJIGNhbid0IGdldCBhbiBlcnJvciBkdW1wZmlsZSB1bnRpbCBydW4gaXQgYnkg
NTAwMCB0aW1lcy4NCj4gDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4ga2V4ZWMgbWFpbGluZyBsaXN0DQo+IGtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
