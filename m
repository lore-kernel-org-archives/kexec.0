Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRVlN-005so2-9n
 for kexec@lists.infradead.org; Wed, 31 Mar 2021 07:59:43 +0000
From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
In-Reply-To: <20210330153512.1182-3-john.ogness@linutronix.de>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-3-john.ogness@linutronix.de>
Date: Wed, 31 Mar 2021 09:59:39 +0200
Message-ID: <875z17vjmc.fsf@jogness.linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org

T24gMjAyMS0wMy0zMCwgSm9obiBPZ25lc3MgPGpvaG4ub2duZXNzQGxpbnV0cm9uaXguZGU+IHdy
b3RlOgo+IGRpZmYgLS1naXQgYS9rZXJuZWwvcHJpbnRrL3ByaW50ay5jIGIva2VybmVsL3ByaW50
ay9wcmludGsuYwo+IGluZGV4IGU5NzFjMGE5ZWM5ZS4uZjA5MGQ2YTFiMzllIDEwMDY0NAo+IC0t
LSBhL2tlcm5lbC9wcmludGsvcHJpbnRrLmMKPiArKysgYi9rZXJuZWwvcHJpbnRrL3ByaW50ay5j
Cj4gQEAgLTE3NzIsMTYgKzE3NTksMjEgQEAgc3RhdGljIHN0cnVjdCB0YXNrX3N0cnVjdCAqY29u
c29sZV9vd25lcjsKPiAgc3RhdGljIGJvb2wgY29uc29sZV93YWl0ZXI7Cj4gIAo+ICAvKioKPiAt
ICogY29uc29sZV9sb2NrX3NwaW5uaW5nX2VuYWJsZSAtIG1hcmsgYmVnaW5uaW5nIG9mIGNvZGUg
d2hlcmUgYW5vdGhlcgo+ICsgKiBjb25zb2xlX2xvY2tfc3Bpbm5pbmdfZW5hYmxlX2lycXNhdmUg
LSBtYXJrIGJlZ2lubmluZyBvZiBjb2RlIHdoZXJlIGFub3RoZXIKPiAgICoJdGhyZWFkIG1pZ2h0
IHNhZmVseSBidXN5IHdhaXQKPiAgICoKPiAgICogVGhpcyBiYXNpY2FsbHkgY29udmVydHMgY29u
c29sZV9sb2NrIGludG8gYSBzcGlubG9jay4gVGhpcyBtYXJrcwo+ICAgKiB0aGUgc2VjdGlvbiB3
aGVyZSB0aGUgY29uc29sZV9sb2NrIG93bmVyIGNhbiBub3Qgc2xlZXAsIGJlY2F1c2UKPiAgICog
dGhlcmUgbWF5IGJlIGEgd2FpdGVyIHNwaW5uaW5nIChsaWtlIGEgc3BpbmxvY2spLiBBbHNvIGl0
IG11c3QgYmUKPiAgICogcmVhZHkgdG8gaGFuZCBvdmVyIHRoZSBsb2NrIGF0IHRoZSBlbmQgb2Yg
dGhlIHNlY3Rpb24uCj4gKyAqCj4gKyAqIFRoaXMgZGlzYWJsZXMgaW50ZXJydXB0cyBiZWNhdXNl
IHRoZSBoYW5kIG92ZXIgdG8gYSB3YWl0ZXIgbXVzdCBub3QgYmUKPiArICogaW50ZXJydXB0ZWQg
dW50aWwgdGhlIGhhbmQgb3ZlciBpcyBjb21wbGV0ZWQgKEBjb25zb2xlX3dhaXRlciBpcyBjbGVh
cmVkKS4KPiAgICovCj4gLXN0YXRpYyB2b2lkIGNvbnNvbGVfbG9ja19zcGlubmluZ19lbmFibGUo
dm9pZCkKPiArc3RhdGljIHZvaWQgY29uc29sZV9sb2NrX3NwaW5uaW5nX2VuYWJsZV9pcnFzYXZl
KHVuc2lnbmVkIGxvbmcgKmZsYWdzKQoKSSBtaXNzZWQgdGhlIHByb3RvdHlwZSBjaGFuZ2UgZm9y
IHRoZSAhQ09ORklHX1BSSU5USyBjYXNlLCByZXN1bHRpbmcgaW46CgpsaW51eC9rZXJuZWwvcHJp
bnRrL3ByaW50ay5jOjI3MDc6MzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0
aW9uIOKAmGNvbnNvbGVfbG9ja19zcGlubmluZ19lbmFibGVfaXJxc2F2ZeKAmTsgZGlkIHlvdSBt
ZWFuIOKAmGNvbnNvbGVfbG9ja19zcGlubmluZ19lbmFibGXigJk/IFstV2Vycm9yPWltcGxpY2l0
LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICBjb25zb2xlX2xvY2tfc3Bpbm5pbmdfZW5hYmxlX2ly
cXNhdmUoJmZsYWdzKTsKICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAg
IGNvbnNvbGVfbG9ja19zcGlubmluZ19lbmFibGUKCldpbGwgYmUgZml4ZWQgZm9yIHYzLgoKKEkg
aGF2ZSBub3cgb2ZmaWNpYWxseSBhZGRlZCAhQ09ORklHX1BSSU5USyB0byBteSBDSSB0ZXN0cy4p
CgpKb2huIE9nbmVzcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
