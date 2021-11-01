Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20211030031832.165457-1-liaochang1@huawei.com>
 <20211030031832.165457-3-liaochang1@huawei.com>
 <87ee83goju.fsf@disp2133>
 <CAJ+HfNjaBQrBtOuMvTccbb2K-Ua=T1eZk0+70hp0_aOAc83A-Q@mail.gmail.com>
Date: Mon, 01 Nov 2021 16:15:42 -0500
In-Reply-To: <CAJ+HfNjaBQrBtOuMvTccbb2K-Ua=T1eZk0+70hp0_aOAc83A-Q@mail.gmail.com>
 (=?utf-8?Q?=22Bj=C3=B6rn_T=C3=B6pel=22's?= message of "Sun, 31 Oct 2021
 12:14:33 +0100")
Message-ID: <87a6inbmrl.fsf@disp2133>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] RISC-V: use memcpy for kexec_file mode
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
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc: Liao Chang <liaochang1@huawei.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nick Kossifidis <mick@ics.forth.gr>, jszhang@kernel.org, guoren@linux.alibaba.com, Pekka Enberg <penberg@kernel.org>, sunnanyong@huawei.com, wangkefeng.wang@huawei.com, changbin.du@intel.com, Alex Ghiti <alex@ghiti.fr>, linux-riscv <linux-riscv@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org

QmrDtnJuIFTDtnBlbCA8Ympvcm4udG9wZWxAZ21haWwuY29tPiB3cml0ZXM6Cgo+IE9uIFNhdCwg
MzAgT2N0IDIwMjEgYXQgMDU6NTEsIEVyaWMgVy4gQmllZGVybWFuIDxlYmllZGVybUB4bWlzc2lv
bi5jb20+IHdyb3RlOgo+Pgo+PiBMaWFvIENoYW5nIDxsaWFvY2hhbmcxQGh1YXdlaS5jb20+IHdy
aXRlczoKPj4KPj4gPiBUaGUgcG9pbnRlciB0byBidWZmZXIgbG9hZGluZyBrZXJuZWwgYmluYXJp
ZXMgaXMgaW4ga2VybmVsIHNwYWNlIGZvcgo+PiA+IGtleGVjX2ZpbCBtb2RlLCBXaGVuIGNvcHlf
ZnJvbV91c2VyIGNvcGllcyBkYXRhIGZyb20gcG9pbnRlciB0byBhIGJsb2NrCj4+ID4gb2YgbWVt
b3J5LCBpdCBjaGVja2VzIHRoYXQgdGhlIHBvaW50ZXIgaXMgaW4gdGhlIHVzZXIgc3BhY2UgcmFu
Z2UsIG9uCj4+ID4gUklTQ1YtViB0aGF0IGlzOgo+PiA+Cj4+ID4gc3RhdGljIGlubGluZSBib29s
IF9fYWNjZXNzX29rKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBzaXplKQo+PiA+
IHsKPj4gPiAgICAgICByZXR1cm4gc2l6ZSA8PSBUQVNLX1NJWkUgJiYgYWRkciA8PSBUQVNLX1NJ
WkUgLSBzaXplOwo+PiA+IH0KPj4gPgo+PiA+IGFuZCBUQVNLX1NJWkUgaXMgMHg0MDAwMDAwMDAw
IGZvciA2NC1iaXRzLCB3aGljaCBub3cgY2F1c2VzCj4+ID4gY29weV9mcm9tX3VzZXIgdG8gcmVq
ZWN0IHRoZSBhY2Nlc3Mgb2YgdGhlIGZpZWxkICdidWYnIG9mIHN0cnVjdAo+PiA+IGtleGVjX3Nl
Z21lbnQgdGhhdCBpcyBpbiByYW5nZSBbQ09ORklHX1BBR0VfT0ZGU0VUIC0gVk1BTExPQ19TSVpF
LAo+PiA+IENPTkZJR19QQUdFX09GRlNFVCksIGlzIGludmFsaWQgdXNlciBzcGFjZSBwb2ludGVy
Lgo+PiA+Cj4+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGlzIGlzc3VlIGJ5IHNraXBwaW5nIGFjY2Vz
c19vaygpLCB1c2UgbWVtcGN5KCkgaW5zdGVhZC4KPj4KPj4gSSBhbSBhIGJpdCBjb25mdXNlZC4K
Pj4KPj4gV2h5IGlzIG1hY2hpbmVfa2V4ZWMgZXZlciBjYWxsaW5nIGNvcHlfZnJvbV91c2VyPyAg
VGhhdCBzZWVtcyB3cm9uZyBpbgo+PiBhbGwgY2FzZXMuCj4+Cj4KPiBJdCdzIG5vdCBtYWNoaW5l
X2tleGVjIC0tIGl0J3MgbWFjaGluZV9rZXhlY19wcmVwYXJlLCB3aGljaCBwdWxscyBvdXQKPiB0
aGUgRkRUIGZyb20gdGhlIGltYWdlLiBJdCBsb29rcyBsaWtlIE1JUFMgZG9lcyBpdCBzaW1pbGFy
bHkuCj4KPiAoQ2F2ZWF0OiBJIG1pZ2h0IGJlIGNvbmZ1c2VkIGFzIHdlbGwhIDstKSkKClRydWUg
aXQgaXMgbWFjaGluZV9rZXhlY19wcmVwYXJlLiAgQnV0IHN0aWxsLiAgY29weV9mcm9tX3VzZXIg
ZG9lcyBub3QKYmVsb25nIGluIHRoZXJlLiAgSXQgaXMgbm90IHBhc3NlZCBhIHVzZXJzcGFjZSBw
b2ludGVyLgoKVGhpcyBsb29rcyBtb3JlIGxpa2UgYSBjYXNlIGZvciBrbWFwIHRvIHJlYWQgYSB0
YWJsZSBmcm9tIHRoZSBmaXJtd2FyZS4KCkV2ZW4gaWYgaXQgc29tZW9uZSBtYWRlIHNlbnNlIGl0
IGRlZmluaXRlbHkgZG9lcyBub3QgbWFrZSBzZW5zZSB0bwptYWtlIGl0IGEgY29uZGl0aW9uYWwg
Y29weV9mcm9tX3VzZXIuICBUaGF0IHdheSBsaWVzIG1hZG5lc3MuCgpUaGUgZW50aXJlIGNoYW5n
ZSBpcyBhIHNtZWxsIHRoYXQgdGhlcmUgaXMgc29tZSBhYnN0cmFjdGlvbiB0aGF0IGlzCmdvaW5n
IHdyb25nLCBhbmQgdGhhdCBhYnN0cmFjdGlvbiBuZWVkcyB0byBnZXQgZml4ZWQuCgpFcmljCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFp
bGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
