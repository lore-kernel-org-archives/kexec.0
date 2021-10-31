Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <20211030031832.165457-1-liaochang1@huawei.com>
 <20211030031832.165457-3-liaochang1@huawei.com> <87ee83goju.fsf@disp2133>
In-Reply-To: <87ee83goju.fsf@disp2133>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date: Sun, 31 Oct 2021 12:14:33 +0100
Message-ID: <CAJ+HfNjaBQrBtOuMvTccbb2K-Ua=T1eZk0+70hp0_aOAc83A-Q@mail.gmail.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Liao Chang <liaochang1@huawei.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nick Kossifidis <mick@ics.forth.gr>, jszhang@kernel.org, guoren@linux.alibaba.com, Pekka Enberg <penberg@kernel.org>, sunnanyong@huawei.com, wangkefeng.wang@huawei.com, changbin.du@intel.com, Alex Ghiti <alex@ghiti.fr>, linux-riscv <linux-riscv@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org

T24gU2F0LCAzMCBPY3QgMjAyMSBhdCAwNTo1MSwgRXJpYyBXLiBCaWVkZXJtYW4gPGViaWVkZXJt
QHhtaXNzaW9uLmNvbT4gd3JvdGU6Cj4KPiBMaWFvIENoYW5nIDxsaWFvY2hhbmcxQGh1YXdlaS5j
b20+IHdyaXRlczoKPgo+ID4gVGhlIHBvaW50ZXIgdG8gYnVmZmVyIGxvYWRpbmcga2VybmVsIGJp
bmFyaWVzIGlzIGluIGtlcm5lbCBzcGFjZSBmb3IKPiA+IGtleGVjX2ZpbCBtb2RlLCBXaGVuIGNv
cHlfZnJvbV91c2VyIGNvcGllcyBkYXRhIGZyb20gcG9pbnRlciB0byBhIGJsb2NrCj4gPiBvZiBt
ZW1vcnksIGl0IGNoZWNrZXMgdGhhdCB0aGUgcG9pbnRlciBpcyBpbiB0aGUgdXNlciBzcGFjZSBy
YW5nZSwgb24KPiA+IFJJU0NWLVYgdGhhdCBpczoKPiA+Cj4gPiBzdGF0aWMgaW5saW5lIGJvb2wg
X19hY2Nlc3Nfb2sodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIHNpemUpCj4gPiB7
Cj4gPiAgICAgICByZXR1cm4gc2l6ZSA8PSBUQVNLX1NJWkUgJiYgYWRkciA8PSBUQVNLX1NJWkUg
LSBzaXplOwo+ID4gfQo+ID4KPiA+IGFuZCBUQVNLX1NJWkUgaXMgMHg0MDAwMDAwMDAwIGZvciA2
NC1iaXRzLCB3aGljaCBub3cgY2F1c2VzCj4gPiBjb3B5X2Zyb21fdXNlciB0byByZWplY3QgdGhl
IGFjY2VzcyBvZiB0aGUgZmllbGQgJ2J1Zicgb2Ygc3RydWN0Cj4gPiBrZXhlY19zZWdtZW50IHRo
YXQgaXMgaW4gcmFuZ2UgW0NPTkZJR19QQUdFX09GRlNFVCAtIFZNQUxMT0NfU0laRSwKPiA+IENP
TkZJR19QQUdFX09GRlNFVCksIGlzIGludmFsaWQgdXNlciBzcGFjZSBwb2ludGVyLgo+ID4KPiA+
IFRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBpc3N1ZSBieSBza2lwcGluZyBhY2Nlc3Nfb2soKSwgdXNl
IG1lbXBjeSgpIGluc3RlYWQuCj4KPiBJIGFtIGEgYml0IGNvbmZ1c2VkLgo+Cj4gV2h5IGlzIG1h
Y2hpbmVfa2V4ZWMgZXZlciBjYWxsaW5nIGNvcHlfZnJvbV91c2VyPyAgVGhhdCBzZWVtcyB3cm9u
ZyBpbgo+IGFsbCBjYXNlcy4KPgoKSXQncyBub3QgbWFjaGluZV9rZXhlYyAtLSBpdCdzIG1hY2hp
bmVfa2V4ZWNfcHJlcGFyZSwgd2hpY2ggcHVsbHMgb3V0CnRoZSBGRFQgZnJvbSB0aGUgaW1hZ2Uu
IEl0IGxvb2tzIGxpa2UgTUlQUyBkb2VzIGl0IHNpbWlsYXJseS4KCihDYXZlYXQ6IEkgbWlnaHQg
YmUgY29uZnVzZWQgYXMgd2VsbCEgOy0pKQoKCkJqw7ZybgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=
