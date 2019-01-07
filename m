Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggRR6-0004xI-Pn
 for kexec@lists.infradead.org; Mon, 07 Jan 2019 09:43:10 +0000
Subject: Re: [PATCH 2/2 v5] kdump, vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
References: <20190107014734.9730-1-lijiang@redhat.com>
 <20190107014734.9730-3-lijiang@redhat.com>
 <20190107022925.GF30750@MiWiFi-R3L-srv>
From: lijiang <lijiang@redhat.com>
Message-ID: <4a922a68-8513-51ab-b887-e367f627f688@redhat.com>
Date: Mon, 7 Jan 2019 17:42:55 +0800
MIME-Version: 1.0
In-Reply-To: <20190107022925.GF30750@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: k-hagio@ab.jp.nec.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, anderson@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTnlubQwMeaciDA35pelIDEwOjI5LCBCYW9xdWFuIEhlIOWGmemBkzoKPiBPbiAwMS8w
Ny8xOSBhdCAwOTo0N2FtLCBMaWFuYm8gSmlhbmcgd3JvdGU6Cj4+IEZvciBBTUQgbWFjaGluZSB3
aXRoIFNNRSBmZWF0dXJlLCBtYWtlZHVtcGZpbGUgdG9vbHMgbmVlZCB0byBrbm93Cj4+IHdoZXRo
ZXIgdGhlIGNyYXNoIGtlcm5lbCB3YXMgZW5jcnlwdGVkIG9yIG5vdC4gSWYgU01FIGlzIGVuYWJs
ZWQKPiAgICAgICAgICAgICAgIF4gY3Jhc2hlZAo+PiBpbiB0aGUgZmlyc3Qga2VybmVsLCB0aGUg
Y3Jhc2gga2VybmVsJ3MgcGFnZSB0YWJsZShwZ2QvcHVkL3BtZC9wdGUpCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXiBjcmFzaGVkCj4+IGNvbnRhaW5zIHRoZSBtZW1vcnkgZW5jcnlwdGlv
biBtYXNrLCBzbyBuZWVkIHRvIHJlbW92ZSB0aGUgc21lIG1hc2sKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIm1ha2VkdW1wZmlsZSBuZWVkcyIgb3IKPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbiBtYWtlZHVtcGZpbGUgbmVlZCB0byBy
ZW1vdmUuLi4KClRoYW5rcyBmb3IgeW91ciBjb21tZW50LgoKVGhpcyB3aWxsIGJlIG1vZGlmaWVk
IGluIG5leHQgcG9zdC4KClJlZ2FyZHMsCkxpYW5ibwoKPj4gdG8gb2J0YWluIHRoZSB0cnVlIHBo
eXNpY2FsIGFkZHJlc3MuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IExpYW5ibyBKaWFuZyA8bGlqaWFu
Z0ByZWRoYXQuY29tPgo+PiAtLS0KPj4gIGFyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0
LmMgfCAzICsrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYyBiL2FyY2gveDg2L2tl
cm5lbC9tYWNoaW5lX2tleGVjXzY0LmMKPj4gaW5kZXggNGM4YWNkZmRjNWE3Li5iYzQxMDgwOTZi
MTggMTAwNjQ0Cj4+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMKPj4g
KysrIGIvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYwo+PiBAQCAtMzUyLDEwICsz
NTIsMTMgQEAgdm9pZCBtYWNoaW5lX2tleGVjKHN0cnVjdCBraW1hZ2UgKmltYWdlKQo+PiAgCj4+
ICB2b2lkIGFyY2hfY3Jhc2hfc2F2ZV92bWNvcmVpbmZvKHZvaWQpCj4+ICB7Cj4+ICsJdTY0IHNt
ZV9tYXNrID0gc21lX21lX21hc2s7Cj4+ICsKPj4gIAlWTUNPUkVJTkZPX05VTUJFUihwaHlzX2Jh
c2UpOwo+PiAgCVZNQ09SRUlORk9fU1lNQk9MKGluaXRfdG9wX3BndCk7Cj4+ICAJdm1jb3JlaW5m
b19hcHBlbmRfc3RyKCJOVU1CRVIocGd0YWJsZV9sNV9lbmFibGVkKT0lZFxuIiwKPj4gIAkJCXBn
dGFibGVfbDVfZW5hYmxlZCgpKTsKPj4gKwlWTUNPUkVJTkZPX05VTUJFUihzbWVfbWFzayk7Cj4+
ICAKPj4gICNpZmRlZiBDT05GSUdfTlVNQQo+PiAgCVZNQ09SRUlORk9fU1lNQk9MKG5vZGVfZGF0
YSk7Cj4+IC0tIAo+PiAyLjE3LjEKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
