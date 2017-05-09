Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d8ESV-0000xf-2C
 for kexec@lists.infradead.org; Tue, 09 May 2017 23:22:24 +0000
Received: by mail-it0-x22d.google.com with SMTP id e65so11057572ita.1
 for <kexec@lists.infradead.org>; Tue, 09 May 2017 16:22:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494371625.7678.3.camel@gmail.com>
References: <20170509230639.GA132135@beast> <1494371625.7678.3.camel@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 9 May 2017 16:22:01 -0700
Message-ID: <CAGXu5jJxmgRKXBs_h-wO6H1jubvQuBM6GdHriEr97P2+Aau4Mg@mail.gmail.com>
Subject: Re: [PATCH] kexec_file: Adjust type of kexec_purgatory
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
To: Daniel Micay <danielmicay@gmail.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>

T24gVHVlLCBNYXkgOSwgMjAxNyBhdCA0OjEzIFBNLCBEYW5pZWwgTWljYXkgPGRhbmllbG1pY2F5
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gT24gVHVlLCAyMDE3LTA1LTA5IGF0IDE2OjA2IC0wNzAwLCBL
ZWVzIENvb2sgd3JvdGU6Cj4+IERlZmluaW5nIGtleGVjX3B1cmdhdG9yeSBhcyBhIHplcm8tbGVu
Z3RoIGNoYXIgYXJyYXkgdXBzZXRzIGNvbXBpbGUKPj4gdGltZSBzaXplIGNoZWNraW5nLiBTaW5j
ZSB0aGlzIGlzIGVudGlyZWx5IHJ1bnRpbWUgc2l6ZWQsIHN3aXRjaAo+PiB0aGlzIHRvIHZvaWQg
Ki4gVGhpcyBzaWxlbmNlcyB0aGUgd2FybmluZyBnZW5lcmF0ZWQgYnkgdGhlIGZ1dHVyZQo+PiBD
T05GSUdfRk9SVElGWV9TT1VSQ0UsIHdoaWNoIGRpZCBub3QgbGlrZSB0aGUgbWVtY21wKCkgb2Yg
YSAiMCBieXRlIgo+PiBhcnJheS4KPj4KPj4gQ2M6IERhbmllbCBNaWNheSA8ZGFuaWVsbWljYXlA
Z21haWwuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVt
Lm9yZz4KPj4gLS0tCj4+ICBrZXJuZWwva2V4ZWNfZmlsZS5jIHwgMiArLQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9r
ZXJuZWwva2V4ZWNfZmlsZS5jIGIva2VybmVsL2tleGVjX2ZpbGUuYwo+PiBpbmRleCBiMTE4NzM1
ZmVhOWQuLmJjODZmODVmMTMyOSAxMDA2NDQKPj4gLS0tIGEva2VybmVsL2tleGVjX2ZpbGUuYwo+
PiArKysgYi9rZXJuZWwva2V4ZWNfZmlsZS5jCj4+IEBAIC0zMCw3ICszMCw3IEBACj4+ICAgKiBE
ZWNsYXJlIHRoZXNlIHN5bWJvbHMgd2VhayBzbyB0aGF0IGlmIGFyY2hpdGVjdHVyZSBwcm92aWRl
cyBhCj4+IHB1cmdhdG9yeSwKPj4gICAqIHRoZXNlIHdpbGwgYmUgb3ZlcnJpZGRlbi4KPj4gICAq
Lwo+PiAtY2hhciBfX3dlYWsga2V4ZWNfcHVyZ2F0b3J5WzBdOwo+PiArdm9pZCAqIF9fd2VhayBr
ZXhlY19wdXJnYXRvcnk7Cj4+ICBzaXplX3QgX193ZWFrIGtleGVjX3B1cmdhdG9yeV9zaXplID0g
MDsKPj4KPj4gIHN0YXRpYyBpbnQga2V4ZWNfY2FsY3VsYXRlX3N0b3JlX2RpZ2VzdHMoc3RydWN0
IGtpbWFnZSAqaW1hZ2UpOwo+PiAtLQo+PiAyLjcuNAo+Cj4gSXQgc2VlbXMgbW9yZSBjb3JyZWN0
IHRvIHVzZSBjaGFyIGBjaGFyIF9fd2VhayBrZXhlY19wdXJnYXRvcnlbXWAsCj4gb3RoZXJ3aXNl
IGlzbid0IF9fYnVpbHRpbl9vYmplY3Rfc2l6ZSBlbmRpbmcgdXAgYXMgOCwgd2hpY2ggaXMgc3Rp
bGwKPiB3cm9uZz8KCkkgdHJpZWQgW10sIHRoYXQgd2FzIG15IGluc3RpbmN0LCB0b28sIGJ1dCBz
aW5jZSB0aGlzIGlzIGEgX193ZWFrIGFuZApub3QgYW4gZXh0ZXJuLCB0aGF0IGRvZXNuJ3Qgd29y
azoKCmtlcm5lbC9rZXhlY19maWxlLmM6MzM6MTM6IHdhcm5pbmc6IGFycmF5IOKAmGtleGVjX3B1
cmdhdG9yeeKAmSBhc3N1bWVkIHRvCmhhdmUgb25lIGVsZW1lbnQKIGNoYXIgX193ZWFrIGtleGVj
X3B1cmdhdG9yeVtdOwogICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+CgotS2VlcwoKLS0gCktl
ZXMgQ29vawpQaXhlbCBTZWN1cml0eQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
