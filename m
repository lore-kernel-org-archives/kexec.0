Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UgPIa-0007tA-9k
 for kexec@lists.infradead.org; Sun, 26 May 2013 00:59:01 +0000
Received: by mail-pd0-f179.google.com with SMTP id q11so5406752pdj.10
 for <kexec@lists.infradead.org>; Sat, 25 May 2013 17:58:38 -0700 (PDT)
Message-ID: <51A15E2F.7010308@gmail.com>
Date: Sun, 26 May 2013 08:58:23 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] Documentation/devices.txt: Remove /dev/oldmem
 description
References: <51A02E50.5020507@gmail.com> <51A02F59.8000103@gmail.com>
 <87vc668x4w.fsf@xmission.com>
In-Reply-To: <87vc668x4w.fsf@xmission.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, davej@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

5LqOIDIwMTPlubQwNeaciDI25pelIDA3OjIwLCBFcmljIFcuIEJpZWRlcm1hbiDlhpnpgZM6Cj4g
WmhhbmcgWWFuZmVpIDx6aGFuZ3lhbmZlaS55ZXNAZ21haWwuY29tPiB3cml0ZXM6Cj4gCj4+IEZy
b206IFpoYW5nIFlhbmZlaSA8emhhbmd5YW5mZWlAY24uZnVqaXRzdS5jb20+Cj4gCj4gV29uJ3Qg
d2Ugd2FudCB0byBrZWVwIHRoaXMgcmVzZXJ2YXRpb24gYXJvdW5kIHRvIHNvIHRoYXQgdGhpcyBu
dW1iZXIKPiBkb2Vzbid0IGdldCByZXVzZWQsIGFuZCBjYXVzZSBwZW9wbGUgY29uZnVzaW9uIHdo
ZW4KPiB1cGdyYWRpbmcvZG93bmdyYWRpbmcga2VybmVscz8KCkFoLCB5ZXMuIEkgd2lsbCBqdXN0
IGtlZXAgdGhpcyBhbmQgYWRkIGEgbm90ZSB0byBtYWtlIHBlb3BsZSBrbm93IHRoYXQKaXQgaXMg
cmVtb3ZlZCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKVGhhbmtzClpoYW5nCgo+IAo+PiBTaWduZWQt
b2ZmLWJ5OiBaaGFuZyBZYW5mZWkgPHpoYW5neWFuZmVpQGNuLmZ1aml0c3UuY29tPgo+PiBDYzog
RGF2ZSBKb25lcyA8ZGF2ZWpAcmVkaGF0LmNvbT4KPj4gLS0tCj4+ICBEb2N1bWVudGF0aW9uL2Rl
dmljZXMudHh0IHwgICAgMiAtLQo+PiAgMSBmaWxlcyBjaGFuZ2VkLCAwIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXMu
dHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2VzLnR4dAo+PiBpbmRleCAwOGYwMWU3Li40Zjg1NzM5
IDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXMudHh0Cj4+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNlcy50eHQKPj4gQEAgLTEwMCw4ICsxMDAsNiBAQCBZb3VyIGNvb3BlcmF0
aW9uIGlzIGFwcHJlY2lhdGVkLgo+PiAgCQkgMTAgPSAvZGV2L2FpbwkJQXN5bmNocm9ub3VzIEkv
TyBub3RpZmljYXRpb24gaW50ZXJmYWNlCj4+ICAJCSAxMSA9IC9kZXYva21zZwkJV3JpdGVzIHRv
IHRoaXMgY29tZSBvdXQgYXMgcHJpbnRrJ3MsIHJlYWRzCj4+ICAJCQkJCWV4cG9ydCB0aGUgYnVm
ZmVyZWQgcHJpbnRrIHJlY29yZHMuCj4+IC0JCSAxMiA9IC9kZXYvb2xkbWVtCVVzZWQgYnkgY3Jh
c2hkdW1wIGtlcm5lbHMgdG8gYWNjZXNzCj4+IC0JCQkJCXRoZSBtZW1vcnkgb2YgdGhlIGtlcm5l
bCB0aGF0IGNyYXNoZWQuCj4+ICAKPj4gICAgMSBibG9jawlSQU0gZGlzawo+PiAgCQkgIDAgPSAv
ZGV2L3JhbTAJCUZpcnN0IFJBTSBkaXNrCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
