Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjKas-0003az-0T
 for kexec@lists.infradead.org; Thu, 11 Jun 2020 10:37:59 +0000
Date: Thu, 11 Jun 2020 18:37:37 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/5] kexec_file_load() for arm
Message-ID: <20200611103737.GA5079@dhcp-128-65.nay.redhat.com>
References: <CGME20200601142806eucas1p2680c5625411e7a695d8469760a926520@eucas1p2.samsung.com>
 <20200601142754.26139-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200601142754.26139-1-l.stelmach@samsung.com>
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
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc: Kees Cook <keescook@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kexec@lists.infradead.org, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Thomas Gleixner <tglx@linutronix.de>, Enrico Weigelt <info@metux.net>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>

Q2Mga2V4ZWMgbGlzdCBpbiBjYXNlIHBlb3BsZSBtYXkgbWlzc2VkIHRoZSBwaWVjZXMuCk9uIDA2
LzAxLzIwIGF0IDA0OjI3cG0sIMWBdWthc3ogU3RlbG1hY2ggd3JvdGU6Cj4gVGhlIGZvbGxvd2lu
ZyBzZXJpZXMgb2YgcGF0Y2hlcyBwcm92aWRlcyBpbXBsZW1lbnRhdGlvbiBvZiB0aGUKPiBrZXhl
Y19maWxlX2xvYWQoKSBzeXN0ZW0gY2FsbCBmb3JtIHRoZSBhcm0gYXJjaGl0ZWN0dXJlLiB6SW1h
Z2UgYW5kIHVJbWFnZQo+IChsZWdhY3kgZm9ybWF0KSBmaWxlcyBhcmUgc3VwcG9ydGVkLiBMaWtl
IG9uIGFybTY0LCB0aGVyZSBpcyBubwo+IHBvc3NpYmlsaXR5IG9mIGxvYWRpbmcgYSBuZXcgRFRC
IGFuZCB0aGUgY3VycmVudGx5IGxvYWRlZCBpcyByZXVzZWQuCj4gCj4gxYF1a2FzeiBTdGVsbWFj
aCAoNSk6Cj4gICBhcm06IGRlY29tcHJlc3Nvcjogc2V0IG1hbGxvYyBwb29sIHNpemUgZm9yIHRo
ZSBkZWNvbXByZXNzb3IKPiAgIGFybTogYWRkIGltYWdlIGhlYWRlciBkZWZpbml0aW9ucwo+ICAg
YXJtOiBkZWNvbXByZXNzb3I6IGRlZmluZSBhIG5ldyB6SW1hZ2UgdGFnCj4gICBhcm06IEFkZCBr
ZXhlY19pbWFnZV9pbmZvCj4gICBhcm06IGtleGVjX2ZpbGU6IGxvYWQgekltYWdlIG9yIHVJbWFn
ZSwgaW5pdHJkIGFuZCBkdGIKPiAKPiAgYXJjaC9hcm0vS2NvbmZpZyAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTUgKysKPiAgYXJjaC9hcm0vYm9vdC9jb21wcmVzc2VkL01ha2VmaWxlICAgICAg
fCAgIDIgKwo+ICBhcmNoL2FybS9ib290L2NvbXByZXNzZWQvaGVhZC5TICAgICAgICB8ICAgOSAr
LQo+ICBhcmNoL2FybS9ib290L2NvbXByZXNzZWQvdm1saW51eC5sZHMuUyB8ICAyMiArLS0KPiAg
YXJjaC9hcm0vaW5jbHVkZS9hc20vaW1hZ2UuaCAgICAgICAgICAgfCAgODcgKysrKysrKysrKwo+
ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9rZXhlYy5oICAgICAgICAgICB8ICAxNCArKwo+ICBhcmNo
L2FybS9rZXJuZWwvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgNSArLQo+ICBhcmNoL2FybS9r
ZXJuZWwva2V4ZWNfdWltYWdlLmMgICAgICAgICB8ICA4MCArKysrKysrKysrCj4gIGFyY2gvYXJt
L2tlcm5lbC9rZXhlY196aW1hZ2UuYyAgICAgICAgIHwgMTk5ICsrKysrKysrKysrKysrKysrKysr
KysrCj4gIGFyY2gvYXJtL2tlcm5lbC9tYWNoaW5lX2tleGVjLmMgICAgICAgIHwgIDM5ICsrKyst
Cj4gIGFyY2gvYXJtL2tlcm5lbC9tYWNoaW5lX2tleGVjX2ZpbGUuYyAgIHwgMjA5ICsrKysrKysr
KysrKysrKysrKysrKysrKysKPiAgMTEgZmlsZXMgY2hhbmdlZCwgNjYyIGluc2VydGlvbnMoKyks
IDE5IGRlbGV0aW9ucygtKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vaW5jbHVkZS9h
c20vaW1hZ2UuaAo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0va2VybmVsL2tleGVjX3Vp
bWFnZS5jCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9rZXJuZWwva2V4ZWNfemltYWdl
LmMKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2tlcm5lbC9tYWNoaW5lX2tleGVjX2Zp
bGUuYwo+IAo+IC0tIAo+IDIuMjYuMgo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
