Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdmY3-0001wL-9p
 for kexec@lists.infradead.org; Wed, 27 May 2020 03:16:08 +0000
Subject: Re: [PATCH] kexec: Do not verify the signature without the lockdown
 or mandatory signature
References: <20200525052351.24134-1-lijiang@redhat.com>
 <20200526135935.ffkfulsjf7xrep63@dwarf.suse.cz>
From: lijiang <lijiang@redhat.com>
Message-ID: <07a65a70-3764-f62f-705c-049b8d409316@redhat.com>
Date: Wed, 27 May 2020 11:15:49 +0800
MIME-Version: 1.0
In-Reply-To: <20200526135935.ffkfulsjf7xrep63@dwarf.suse.cz>
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
To: Jiri Bohac <jbohac@suse.cz>
Cc: bhe@redhat.com, kexec@lists.infradead.org, jmorris@namei.org, mjg59@google.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, dyoung@redhat.com

5ZyoIDIwMjDlubQwNeaciDI25pelIDIxOjU5LCBKaXJpIEJvaGFjIOWGmemBkzoKPiBPbiBNb24s
IE1heSAyNSwgMjAyMCBhdCAwMToyMzo1MVBNICswODAwLCBMaWFuYm8gSmlhbmcgd3JvdGU6Cj4+
IFNvLCBoZXJlLCBsZXQncyBzaW1wbGlmeSB0aGUgbG9naWMgdG8gaW1wcm92ZSBjb2RlIHJlYWRh
YmlsaXR5LiBJZiB0aGUKPj4gS0VYRUNfU0lHX0ZPUkNFIGVuYWJsZWQgb3Iga2V4ZWMgbG9ja2Rv
d24gZW5hYmxlZCwgc2lnbmF0dXJlIHZlcmlmaWNhdGlvbgo+PiBpcyBtYW5kYXRlZC4gT3RoZXJ3
aXNlLCB3ZSBsaWZ0IHRoZSBiYXIgZm9yIGFueSBrZXJuZWwgaW1hZ2UuCj4gCj4gSSBhZ3JlZSBj
b21wbGV0ZWx5OyBpbiBmYWN0IHRoYXQgd2FzIG15IGludGVudGlvbiB3aGVuCj4gaW50cm9kdWNp
bmcgdGhlIGNvZGUsIGJ1dCBJIGdvdCBvdmVycnVsZWQgYWJvdXQgdGhlIHJldHVybiBjb2RlczoK
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgwMTE5MTI1NDI1Lmw3Mm1leXljMnF0
cnJpd2VAZHdhcmYuc3VzZS5jei8KPiAKPiBJIGxpa2UgdGhpcyBzaW1wbGlmaWNhdGlvbiB2ZXJ5
IG11Y2gsIGV4Y2VwdCB0aGlzIHBhcnQ6Cj4gCj4+ICsJaWYgKHJldCkgewo+PiArCQlwcl9kZWJ1
Zygia2VybmVsIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gZmFpbGVkICglZCkuXG4iLCByZXQpOwo+
IAo+IC4uLgo+IAo+PiAtCQlwcl9ub3RpY2UoImtlcm5lbCBzaWduYXR1cmUgdmVyaWZpY2F0aW9u
IGZhaWxlZCAoJWQpLlxuIiwgcmV0KTsKPiAKPiBJIHRoaW5rIHRoZSBsb2cgbGV2ZWwgc2hvdWxk
IHN0YXkgYXQgbW9zdCBQUl9OT1RJQ0Ugd2hlbiB0aGUKPiB2ZXJpZmljYXRpb24gZmFpbHVyZSBy
ZXN1bHRzIGluIHJlamVjdGluZyB0aGUga2VybmVsLiBQZXJoYXBzCj4gZXZlbiBsb3dlci4KPiAK
ClRoYW5rIHlvdSBmb3IgdGhlIGNvbW1lbnQsIEppcmkgQm9oYWMuCgpJIGxpa2UgdGhlIGlkZWEg
b2Ygc3RheWluZyBhdCBtb3N0IFBSX05PVElDRSwgYnV0IHRoZSBwcl9ub3RpY2UoKSB3aWxsIG91
dHB1dApzb21lIG1lc3NhZ2VzIHRoYXQga2VybmVsIGNvdWxkIHdhbnQgdG8gaWdub3JlLCBzdWNo
IGFzIHRoZSBjYXNlIHlvdSBtZW50aW9uZWQKYmVsb3cuCgo+IEluIGNhc2UgdmVyaWZpY2F0aW9u
IGlzIG5vdCBlbmZvcmNlZCBhbmQgdGhlIGZhaWx1cmUgaXMKPiBpZ25vcmVkLCBLRVJOX0RFQlVH
IHNlZW1zIHJlYXNvbmFibGUuCj4gCgpZZXMsIGdvb2QgdW5kZXJzdGFuZGluZy4gSXQgc2VlbXMg
dGhhdCB0aGUgcHJfZGVidWcoKSBpcyBzdGlsbCBhIGdvb2Qgb3B0aW9uIGhlcmU/CkFueSBvdGhl
ciB0aG91Z2h0cz8KClRoYW5rcy4KTGlhbmJvCgoKPiBSZWdhcmRzLAo+IAoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK
