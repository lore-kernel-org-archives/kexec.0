Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khVlm-0002PX-Nx
 for kexec@lists.infradead.org; Tue, 24 Nov 2020 10:41:59 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: RE: [PATCH] makedumpfile: printk: add support for lockless ringbuffer
In-Reply-To: <OSBPR01MB199155FE684812D139FBD7F7DDFF0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1991BDA9AB4100A661E53CF6DDE00@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <87sg94zsva.fsf@jogness.linutronix.de>
 <OSBPR01MB199155FE684812D139FBD7F7DDFF0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
Date: Tue, 24 Nov 2020 11:47:55 +0106
Message-ID: <87lfer82a4.fsf@jogness.linutronix.de>
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
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

SGkgS2F6dSwKCk9uIDIwMjAtMTEtMjAsIEhBR0lPIEtBWlVISVRPKOiQqeWwvuOAgOS4gOS7gSkJ
PGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6Cj4gVGhhbmsgeW91IGZvciBjb25maXJtaW5nIGFu
ZCB0ZXN0aW5nLgo+IEkgd2lsbCBtZXJnZSB0aGlzIGFmdGVyIGEgZmV3IHNsaWdodCBmaXhlcyBh
bmQgbW9yZSB0ZXN0cy4KCkFmdGVyIGxvb2tpbmcgbW9yZSBjbG9zZWx5LCBJIHNlZSB0aGF0IHlv
dXIgcGF0Y2ggaXMgc3RpbGwgdXNpbmcgdGhlIG9sZApzdGF0ZSBmbGFncy4gV2l0aCB0aGUgY3Vy
cmVudCB2ZXJzaW9uLCB0aGVyZSBpcyBub3cgYSB2YWx1ZS1iYXNlZCBzdGF0ZQpmaWVsZC4gQm90
aCBzdGF0ZSB2YWx1ZXMgMSAoY29tbWl0dGVkKSBhbmQgMiAoZmluYWxpemVkKSBhcmUgdmFsaWQg
Zm9yCnByaW50aW5nLiBTaG91bGQgSSBzdWJtaXQgYSBmb2xsb3ctdXAgcGF0Y2g/IE9yIGFyZSB0
aGVzZSB0aGUgInNsaWdodApmaXhlcyIgeW91IGFyZSByZWZlcnJpbmcgdG8/CgpKb2huIE9nbmVz
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
