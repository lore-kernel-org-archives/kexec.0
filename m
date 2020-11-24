Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400055.outbound.protection.outlook.com
 ([40.107.140.55] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khi68-0007iS-KC
 for kexec@lists.infradead.org; Tue, 24 Nov 2020 23:51:50 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH] makedumpfile: printk: add support for lockless ringbuffer
Date: Tue, 24 Nov 2020 23:51:33 +0000
Message-ID: <OSBPR01MB1991B98F9B72C74C33BAA950DDFB0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1991BDA9AB4100A661E53CF6DDE00@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <87sg94zsva.fsf@jogness.linutronix.de>
 <OSBPR01MB199155FE684812D139FBD7F7DDFF0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <87lfer82a4.fsf@jogness.linutronix.de>
In-Reply-To: <87lfer82a4.fsf@jogness.linutronix.de>
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

SGkgSm9obiwNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gSGkgS2F6dSwNCj4gDQo+
IE9uIDIwMjAtMTEtMjAsIEhBR0lPIEtBWlVISVRPKOiQqeWwvuOAgOS4gOS7gSkJPGstaGFnaW8t
YWJAbmVjLmNvbT4gd3JvdGU6DQo+ID4gVGhhbmsgeW91IGZvciBjb25maXJtaW5nIGFuZCB0ZXN0
aW5nLg0KPiA+IEkgd2lsbCBtZXJnZSB0aGlzIGFmdGVyIGEgZmV3IHNsaWdodCBmaXhlcyBhbmQg
bW9yZSB0ZXN0cy4NCj4gDQo+IEFmdGVyIGxvb2tpbmcgbW9yZSBjbG9zZWx5LCBJIHNlZSB0aGF0
IHlvdXIgcGF0Y2ggaXMgc3RpbGwgdXNpbmcgdGhlIG9sZA0KPiBzdGF0ZSBmbGFncy4gV2l0aCB0
aGUgY3VycmVudCB2ZXJzaW9uLCB0aGVyZSBpcyBub3cgYSB2YWx1ZS1iYXNlZCBzdGF0ZQ0KPiBm
aWVsZC4gQm90aCBzdGF0ZSB2YWx1ZXMgMSAoY29tbWl0dGVkKSBhbmQgMiAoZmluYWxpemVkKSBh
cmUgdmFsaWQgZm9yDQo+IHByaW50aW5nLiBTaG91bGQgSSBzdWJtaXQgYSBmb2xsb3ctdXAgcGF0
Y2g/IE9yIGFyZSB0aGVzZSB0aGUgInNsaWdodA0KPiBmaXhlcyIgeW91IGFyZSByZWZlcnJpbmcg
dG8/DQoNClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgaXQgb3V0ISAgQ291bGQgeW91IHN1Ym1pdCBh
IGZvbGxvdy11cCBwYXRjaD8NCkl0IHdvdWxkIGJlIHZlcnkgaGVscGZ1bC4NCg0KVGhhbmtzLA0K
S2F6dQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
