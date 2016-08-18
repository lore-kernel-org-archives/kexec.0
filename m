Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1471542334.20164.8.camel@infradead.org>
Subject: Re: [PATCH V2] arm64:kexec: Memstart should not be before the
 kernel start address
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 18 Aug 2016 10:45:34 -0700
In-Reply-To: <1470965069-20121-1-git-send-email-sgoel@codeaurora.org>
References: <1470965069-20121-1-git-send-email-sgoel@codeaurora.org>
Mime-Version: 1.0
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
To: Sameer Goel <sgoel@codeaurora.org>
Cc: panand@redhat.com, takahiro.akashi@linaro.org, timur@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org

SGkgU2FtZWVyLAoKT24gVGh1LCAyMDE2LTA4LTExIGF0IDE5OjI0IC0wNjAwLCBTYW1lZXIgR29l
bCB3cm90ZToKPiBTdGFydGluZyA0LjYgdGhlIGtlcm5lbCBtZW1ibG9jayBzdGFydCBpcyByb3Vu
ZGVkIGRvd24gdG8gYSBkZXNpcmFibGUKPiBhbGlnbm1lbnQuwqAKClBsZWFzZSBtZW50aW9uIGhl
cmUgdGhlIGtlcm5lbCBjb21taXQgdGhhdCBtYWRlIHRoaXMgY2hhbmdlLCBtYXliZQona2VybmVs
IGNvbW1pdCBhN2Y4ZGUxNjhhY2UgKCJhcm02NDogYWxsb3cga2VybmVsIEltYWdlIHRvIGJlIGxv
YWRlZAphbnl3aGVyZSBpbiBwaHlzaWNhbCBtZW1vcnkiKSc/Cgo+IFNvLCB0aGUga2VybmVsIGNh
biBzZWUgcmVzZXJ2ZWQgbWVvcnkgcmVnaW9ucyBiZWZvcmUgdGhlIGtlcm5lbAo+IHN0YXJ0IGFk
ZHJlc3MgaW4gdGhlIGlvbWVtIHF1ZXJ5Lgo+IE5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHJp
Z2h0IGtlcm5lbCBzdGFydCBhZGRyZXNzIGlzIHBpY2tlZCBmcm9tIHRoZSBpb21lbQo+IHF1ZXJ5
LgoKUGxlYXNlIHJ1biBrZXhlYyB3aXRoIHRoZcKgLS1kZWJ1ZyBvcHRpb24gYW5kIHBvc3QgdGhl
IGdldF9tZW1vcnlfcmFuZ2VzCm91dHB1dCB0byB0aGUgTUwgb3Igc2VuZCBtZSBkaXJlY3RseSBp
ZiB5b3UgY29uc2lkZXIgaXQgc2Vuc2l0aXZlLgrCoAotR2VvZmYKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==
