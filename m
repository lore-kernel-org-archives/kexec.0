Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8asg-0002BR-4r
 for kexec@lists.infradead.org; Tue, 26 Mar 2019 01:28:04 +0000
Subject: Re: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when
 SEV is active
References: <20190315103203.13128-1-lijiang@redhat.com>
 <20190315103203.13128-2-lijiang@redhat.com> <20190324150034.GH23289@zn.tnic>
 <7b115829-40d9-e55e-dee3-ec8e4766971f@redhat.com>
 <20190325063742.GA12016@zn.tnic>
 <652b9166-f06e-c210-3c3f-c9e80a97db18@amd.com>
 <20190325173239.GO12016@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <a15e03a2-c2da-aa2f-d0b7-c18d23f49ea8@redhat.com>
Date: Tue, 26 Mar 2019 09:27:38 +0800
MIME-Version: 1.0
In-Reply-To: <20190325173239.GO12016@zn.tnic>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>, "Singh, Brijesh" <brijesh.singh@amd.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

5ZyoIDIwMTnlubQwM+aciDI25pelIDAxOjMyLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IE1vbiwgTWFyIDI1LCAyMDE5IGF0IDA1OjE3OjU1UE0gKzAwMDAsIFNpbmdoLCBCcmlqZXNoIHdy
b3RlOgo+PiBCeSBkZWZhdWx0IGFsbCB0aGUgbWVtb3J5IHJlZ2lvbnMgYXJlIG1hcHBlZCBlbmNy
eXB0ZWQuIFRoZQo+PiBzZXRfbWVtb3J5X3tlbmNyeXB0LGRlY3J5cHR9KCkgaXMgYSBnZW5lcmlj
IGZ1bmN0aW9uIHdoaWNoIGNhbiBiZQo+PiBjYWxsZWQgZXhwbGljaXRseSB0byBjbGVhci9zZXQg
dGhlIGVuY3J5cHRpb24gbWFzayBmcm9tIHRoZSBleGlzdGluZwo+PiBtZW1vcnkgbWFwcGluZy4g
VGhlIG1lbV9lbmNyeXB0X2FjdGl2ZSgpIHJldHVybnMgdHJ1ZSBpZiBlaXRoZXIgU0VWIG9yIAo+
PiBTTUUgaXMgYWN0aXZlLiBTbyB0aGUgX19zZXRfbWVtb3J5X2VuY19kZWMoKSB1c2VzIHRoZQo+
PiBtZW1vcnlfZW5jcnlwdF9hY3RpdmUoKSBjaGVjayB0byBlbnN1cmUgdGhhdCB0aGUgZnVuY3Rp
b24gaXMgbm8tb3Agd2hlbgo+PiBTTUUvU0VWIGFyZSBub3QgYWN0aXZlLgo+Pgo+PiBDdXJyZW50
bHksIHRoZSBhcmNoX2tleGVjX3Bvc3RfYWxsb2NfcGFnZXMoKSB1bmNvbmRpdGlvbmFsbHkgY2xl
YXIgdGhlCj4+IGVuY3J5cHRpb24gbWFzayBmcm9tIHRoZSBrZXhlYyBhcmVhLiBJbiBjYXNlIG9m
IFNFViwgd2Ugc2hvdWxkIG5vdCBjbGVhcgo+PiB0aGUgZW5jcnlwdGlvbiBtYXNrLgo+IAo+IEJy
aWplc2gsIEkga25vdyBhbGwgdGhhdC4KPiAKPiBQbGVhc2UgcmVhZCB3aGF0IEkgc2FpZCBoZXJl
IGF0IHRoZSBlbmQ6Cj4gCj4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5MDMyNDE1MDAz
NC5HSDIzMjg5QHpuLnRuaWMKPiAKPiBXaXRoIHRoaXMgY2hhbmdlLCB0aGUgY29kZSBsb29rcyBs
aWtlIHRoaXM6Cj4gCj4gKyAgICAgICBpZiAoc21lX2FjdGl2ZSgpKQo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gc2V0X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2lnbmVkIGxvbmcpdmFkZHIsIHBhZ2Vz
KTsKPiAKPiBub3cgaW4gX19zZXRfbWVtb3J5X2VuY19kZWMgdmlhIHNldF9tZW1vcnlfZGVjcnlw
dGVkKCk6Cj4gCj4gICAgICAgICAvKiBOb3RoaW5nIHRvIGRvIGlmIG1lbW9yeSBlbmNyeXB0aW9u
IGlzIG5vdCBhY3RpdmUgKi8KPiAgICAgICAgIGlmICghbWVtX2VuY3J5cHRfYWN0aXZlKCkpCj4g
ICAgICAgICAgICAgICAgIHJldHVybiAwOwo+IAo+IAo+IHNvIHlvdSBoYXZlOgo+IAo+IAlpZiAo
c21lX2FjdGl2ZSgpKQo+IAo+IAkJLi4uCj4gCj4gCQlpZiAoIW1lbV9lbmNyeXB0X2FjdGl2ZSgp
KQo+IAo+IAo+IG5vdyBtYXliZSB0aGlzIGlzIGFsbCBjbGVhciB0byB5b3UgYW5kIFRvbSBidXQg
SSBiZXRjaGEgb3RoZXJzIHdpbGwgZ2V0Cj4gY29uZnVzZWQuIFByb2JhYmx5IHNvbWV0aGluZyBs
aWtlICJ3ZWxsLCB3aGF0IHNob3VsZCBiZSBhY3RpdmUgbm93LCBTTUUsCj4gU0VWIG9yIG1lbW9y
eSBlbmNyeXB0aW9uIGluIGdlbmVyYWwiPwo+IAo+IEkgaG9wZSB5b3UncmUgY2F0Y2hpbmcgbXkg
ZHJpZnQuCj4gCj4gU28gaWYgeW91IHdhbnQgdG8gKm5vdCogZGVjcnlwdCBtZW1vcnkgaW4gdGhl
IFNFViBjYXNlLCB0aGVuIGRvaW5nIHNvbWV0aGluZwo+IGxpa2UgdGhpcyBzaG91bGQgbWFrZSBp
dCBhIGJpdCBtb3JlIGNsZWFyOgo+IAo+IAo+IAlpZiAoc2V2X2FjdGl2ZSgpKQo+IAkJcmV0dXJu
Owo+IAo+IAlyZXR1cm4gc2V0X21lbW9yeV9kZWNyeXB0ZWQoKHVuc2lnbmVkIGxvbmcpdmFkZHIs
IHBhZ2VzKTsKPiAKPiBhbG9uZyB3aXRoIGEgY29tbWVudCAqd2h5KiB3ZSdyZSBjaGVja2luZyBo
ZXJlLgpJdCBsb29rcyBnb29kIHRvIG1lLiBJIHdpbGwgaW1wcm92ZSB0aGVtIG5leHQgcG9zdC4K
ClRoYW5rIHlvdSwgZXZlcnlvbmUuCgpMaWFuYm8KCj4gCj4gQnV0IGFjdHVhbGx5LCBJJ2QgcHJl
ZmVyIGlmIHlvdSBoYWQgc2VwYXJhdGUgd3JhcHBlcnMgd2hpY2ggYXJlIGNhbGxlZAo+IGZvciBT
TUUgYW5kIGZvciBTRVYuCj4gCj4gSSdsbCBsZXQgVG9tIGNoaW1lIGluIHRvby4KPiAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
