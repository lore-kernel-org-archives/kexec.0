Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1400081.outbound.protection.outlook.com
 ([40.107.140.81] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiRBR-0007MI-3v
 for kexec@lists.infradead.org; Fri, 27 Nov 2020 00:00:18 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH] makedumpfile: printk: add support for lockless ringbuffer
Date: Fri, 27 Nov 2020 00:00:10 +0000
Message-ID: <OSBPR01MB1991CC69C6331CD8FBAA4C23DDF80@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1991BDA9AB4100A661E53CF6DDE00@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <87sg94zsva.fsf@jogness.linutronix.de>
 <OSBPR01MB199155FE684812D139FBD7F7DDFF0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <87lfer82a4.fsf@jogness.linutronix.de>
 <OSBPR01MB1991B98F9B72C74C33BAA950DDFB0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <87k0u94xfv.fsf@jogness.linutronix.de>
 <OSBPR01MB1991C22FD4870CACD0039ECADDF90@OSBPR01MB1991.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB1991C22FD4870CACD0039ECADDF90@OSBPR01MB1991.jpnprd01.prod.outlook.com>
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

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiBPbiAyMDIwLTExLTI0LCBIQUdJTyBLQVpVSElUTyjokKnlsL7jgIDkuIDku4EpCTxrLWhh
Z2lvLWFiQG5lYy5jb20+IHdyb3RlOg0KPiA+ID4+IEFmdGVyIGxvb2tpbmcgbW9yZSBjbG9zZWx5
LCBJIHNlZSB0aGF0IHlvdXIgcGF0Y2ggaXMgc3RpbGwgdXNpbmcgdGhlDQo+ID4gPj4gb2xkIHN0
YXRlIGZsYWdzLiBXaXRoIHRoZSBjdXJyZW50IHZlcnNpb24sIHRoZXJlIGlzIG5vdyBhIHZhbHVl
LWJhc2VkDQo+ID4gPj4gc3RhdGUgZmllbGQuDQo+ID4gPg0KPiA+ID4gVGhhbmsgeW91IGZvciBw
b2ludGluZyBpdCBvdXQhICBDb3VsZCB5b3Ugc3VibWl0IGEgZm9sbG93LXVwIHBhdGNoPw0KPiA+
DQo+ID4gSSBoYXZlIGF0dGFjaGVkIGEgZm9sbG93LXVwIHBhdGNoLiBJdCBpcyBwcmV0dHkgbXVj
aCB0aGUgZXhhY3Qgc2FtZQ0KPiA+IHBhdGNoIGFzIHRoZSBvbmUgSSBzZW50IGZvciAiY3Jhc2gi
Lg0KDQpNZXJnZWQgdGhvc2UgcGF0Y2hlcy4NCmh0dHBzOi8vZ2l0aHViLmNvbS9tYWtlZHVtcGZp
bGUvbWFrZWR1bXBmaWxlL2NvbXBhcmUvMDE4OGVhOS4uLjQ0YjA3M2INCg0KVGhhbmtzLA0KS2F6
dQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
