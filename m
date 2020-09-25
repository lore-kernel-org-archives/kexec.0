Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLwh0-0004rl-Vb
 for kexec@lists.infradead.org; Fri, 25 Sep 2020 22:59:55 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH printk v5 6/6] printk: reimplement log_cont using record
 extension
In-Reply-To: <f1651593-3579-5820-6863-5f4973d2bfdc@samsung.com>
References: <20200914123354.832-1-john.ogness@linutronix.de>
 <20200914123354.832-7-john.ogness@linutronix.de>
 <CGME20200925190829eucas1p2f35866317389cd5e842e99b465632902@eucas1p2.samsung.com>
 <f1651593-3579-5820-6863-5f4973d2bfdc@samsung.com>
Date: Sat, 26 Sep 2020 01:05:51 +0206
Message-ID: <87v9g1bgyg.fsf@jogness.linutronix.de>
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
To: Marek Szyprowski <m.szyprowski@samsung.com>, Petr Mladek <pmladek@suse.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

T24gMjAyMC0wOS0yNSwgTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29t
PiB3cm90ZToKPiBUaGlzIHBhdGNoIGxhbmRlZCByZWNlbnRseSBpbiBsaW51eC1uZXh0IGFzIGNv
bW1pdCBmNWYwMjJlNTNiODcgCj4gKCJwcmludGs6IHJlaW1wbGVtZW50IGxvZ19jb250IHVzaW5n
IHJlY29yZCBleHRlbnNpb24iKS4gSSd2ZSBub3RpY2VkIAo+IHRoYXQgaXQgY2F1c2VzIGEgcmVn
cmVzc2lvbiBvbiBteSB0ZXN0IHN5c3RlbSAoQVJNIDMyYml0IFNhbXN1bmcgRXh5bm9zIAo+IDQ0
MTItYmFzZWQgVHJhdHMyIGJvYXJkKS4gVGhlIG1lc3NhZ2VzIGFyZSBwcmludGVkIGNvcnJlY3Rs
eSBvbiB0aGUgCj4gc2VyaWFsIGNvbnNvbGUgZHVyaW5nIGJvb3QsIGJ1dCB0aGVuIHdoZW4gSSBy
dW4gJ2RtZXNnJyBjb21tYW5kLCB0aGUgbG9nIAo+IGlzIHRydW5jYXRlZC4KPgo+IEhlcmUgaXMg
YXJlIHRoZSBsYXN0IGxpbmVzIG9mIHRoZSBkbWVzZyBsb2cgYWZ0ZXIgdGhpcyBwYXRjaDoKPgo+
IFvCoMKgwqAgNi42NDkwMThdIFdhaXRpbmcgMiBzZWMgYmVmb3JlIG1vdW50aW5nIHJvb3QgZGV2
aWNlLi4uCj4gW8KgwqDCoCA2Ljc2NjQyM10gZHdjMiAxMjQ4MDAwMC5oc290ZzogbmV3IGRldmlj
ZSBpcyBoaWdoLXNwZWVkCj4gW8KgwqDCoCA2Ljg0NTI5MF0gZHdjMiAxMjQ4MDAwMC5oc290Zzog
bmV3IGRldmljZSBpcyBoaWdoLXNwZWVkCj4gW8KgwqDCoCA2LjkxNDIxN10gZHdjMiAxMjQ4MDAw
MC5oc290ZzogbmV3IGFkZHJlc3MgNTEKPiBbwqDCoMKgIDguNzEwMzUxXSBSQU1ESVNLOiBzcXVh
c2hmcyBmaWxlc3lzdGVtIGZvdW5kIGF0IGJsb2NrIDAKPgo+IFRoZSBjb3JyZXNwb25kaW5nIGRt
ZXNnIGxpbmVzIGJlZm9yZSBhcHBseWluZyB0aGlzIHBhdGNoOgo+Cj4gW8KgwqDCoCA4Ljg2NDMy
MF0gUkFNRElTSzogc3F1YXNoZnMgZmlsZXN5c3RlbSBmb3VuZCBhdCBibG9jayAwCj4gW8KgwqDC
oCA4Ljg2ODQxMF0gUkFNRElTSzogTG9hZGluZyAzNzY5MktpQiBbMSBkaXNrXSBpbnRvIHJhbSBk
aXNrLi4uIC8KPiBbwqDCoMKgIDkuMDcxNjcwXSAvCj4gW8KgwqDCoCA5LjI2MjQ5OF0gLwo+IFvC
oMKgwqAgOS41NDA3MTFdIC8KPiBbwqDCoMKgIDkuODE4MDMxXSBkb25lLgoKQWguIE9uZSBvZiB0
aGUgbW9yZSBjcmVhdGl2ZSBwcmludGsgdXNlcnMuLi4KaW5pdC9kb19tb3VudHNfcmQuYzpyZF9s
b2FkX2ltYWdlKCkuIFRoaXMgaXMgYSBzZXQgb2YgTE9HX0NPTlQgbWVzc2FnZXMKdGhhdCB0cnkg
dG8gZGlzcGxheSBhIHJvdGF0aW5nIGxpbmUsIGNvbXBsZXRlIHdpdGggJ1xiJyBjb250cm9sCmNo
YXJhY3RlcnMuIFRoZSBjb2RlIGlzIHRvdGFsbHkgYnJva2VuLCBidXQgdGhhdCBpcyBubyBleGN1
c2UgZm9yIHByaW50awp0byBicmVhay4gSXQgc2hvdWxkIGJlIGVhc3kgdG8gcmVwcm9kdWNlIG9u
IGFueSBhcmNoaXRlY3R1cmUuIEkgd2lsbAppbnZlc3RpZ2F0ZSBpdCBmdXJ0aGVyLiBUaGFua3Mg
Zm9yIHJlcG9ydGluZy4KCkpvaG4gT2duZXNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==
