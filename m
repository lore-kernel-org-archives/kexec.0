Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400070.outbound.protection.outlook.com
 ([40.107.140.70] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfziX-00022r-Mu
 for kexec@lists.infradead.org; Fri, 20 Nov 2020 06:16:23 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH] makedumpfile: printk: add support for lockless ringbuffer
Date: Fri, 20 Nov 2020 06:16:13 +0000
Message-ID: <OSBPR01MB199155FE684812D139FBD7F7DDFF0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1991BDA9AB4100A661E53CF6DDE00@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <87sg94zsva.fsf@jogness.linutronix.de>
In-Reply-To: <87sg94zsva.fsf@jogness.linutronix.de>
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
To: John Ogness <john.ogness@linutronix.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBPbiAyMDIwLTExLTE5LCBIQUdJTyBLQVpV
SElUTyjokKnlsL7jgIDkuIDku4EpCTxrLWhhZ2lvLWFiQG5lYy5jb20+IHdyb3RlOg0KPiA+IEZy
b206IEpvaG4gT2duZXNzIDxqb2huLm9nbmVzc0BsaW51dHJvbml4LmRlPg0KPiA+DQo+ID4gTGlu
dXggNS4xMCBpbnRyb2R1Y2VzIGEgbmV3IGxvY2tsZXNzIHJpbmdidWZmZXIuICBUaGUgbmV3IHJp
bmdidWZmZXINCj4gPiBpcyBzdHJ1Y3R1cmVkIGNvbXBsZXRlbHkgZGlmZmVyZW50IHRvIHRoZSBw
cmV2aW91cyBpdGVyYXRpb25zLg0KPiA+IEFkZCBzdXBwb3J0IGZvciByZXRyaWV2aW5nIHRoZSBy
aW5nYnVmZmVyIGZyb20gZGVidWcgaW5mb3JtYXRpb24NCj4gPiBhbmQvb3IgdXNpbmcgdm1jb3Jl
aW5mby4gIFRoZSBuZXcgcmluZ2J1ZmZlciBpcyBkZXRlY3RlZCBiYXNlZCBvbg0KPiA+IHRoZSBh
dmFpbGFiaWxpdHkgb2YgdGhlICJwcmIiIHN5bWJvbC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEpvaG4gT2duZXNzIDxqb2huLm9nbmVzc0BsaW51dHJvbml4LmRlPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEthenVoaXRvIEhhZ2lvIDxrLWhhZ2lvLWFiQG5lYy5jb20+DQo+ID4gLS0tDQo+ID4gSSd2
ZSB1cGRhdGVkIEpvaG4ncyBSRkMgbWFrZWR1bXBmaWxlIHBhdGNoIHRvIG1hdGNoIDUuMTAtcmM0
IGtlcm5lbC4NCj4gPiBDaGFuZ2VzIGZyb20gdGhlIFJGQyBwYXRjaDoNCj4gPiAtIGZvbGxvd2Vk
IHRoZSBmb2xsb3dpbmcga2VybmVsIGNvbW1pdA0KPiA+ICAgICBjZmUyNzkwYjE2M2EgKCJwcmlu
dGs6IG1vdmUgcHJpbnRrX2luZm8gaW50byBzZXBhcmF0ZSBhcnJheSIpDQo+ID4gLSBkaXZpZGVk
IG1lbWJlcnMgb2Ygc3RydWN0IHByaW50a19sb2cgaW4gb2Zmc2V0X3RhYmxlIGludG8gZWFjaCBz
dHJ1Y3R1cmUNCj4gPiAgIGZvciByZWFkYWJpbGl0eQ0KPiA+IC0gYWRkZWQgc29tZSBlcnJvciBo
YW5kbGluZ3MNCj4gPiAtIGFsc28gZHVtcCBoZWFkIHJlY29yZCB0aGF0IHdhcyBtaXNzZWQNCj4g
DQo+IEkgY29uZmlybSB0aGF0IHRoZXNlIGNoYW5nZXMgYXJlIGNvcnJlY3QuIFRoYW5rcyBmb3Ig
dXBkYXRpbmcgdGhpcywNCj4gYWRkaW5nIHRoZSBuZWVkZWQgZXJyb3IgaGFuZGxpbmcsIGFuZCBj
YXRjaGluZyB0aGF0IHRoZSBoZWFkIHJlY29yZCB3YXMNCj4gbWlzc2VkIQ0KDQpIaSBKb2huLA0K
DQpUaGFuayB5b3UgZm9yIGNvbmZpcm1pbmcgYW5kIHRlc3RpbmcuDQpJIHdpbGwgbWVyZ2UgdGhp
cyBhZnRlciBhIGZldyBzbGlnaHQgZml4ZXMgYW5kIG1vcmUgdGVzdHMuDQoNCkkndmUgdXBkYXRl
ZCB5b3VyIGNyYXNoIHBhdGNoIFsxXSBhcyB3ZWxsLCBpdCB3b3VsZCBiZSBoZWxwZnVsIGlmIHlv
dQ0Kd291bGQgY2hlY2sgaXQuDQpbMV0gaHR0cHM6Ly93d3cucmVkaGF0LmNvbS9hcmNoaXZlcy9j
cmFzaC11dGlsaXR5LzIwMjAtTm92ZW1iZXIvbXNnMDAwNjUuaHRtbA0KDQpUaGFua3MsDQpLYXp1
DQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
