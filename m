Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7gby-0002Ye-Sc
 for kexec@lists.infradead.org; Tue, 10 Sep 2019 13:55:16 +0000
Subject: Re: [PATCH 1/2] vmcore-dmesg/vmcore-dmesg.c: Fix shifting error
 reported by cppcheck
References: <20190910102150.7229-1-bhsharma@redhat.com>
 <20190910102150.7229-2-bhsharma@redhat.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <50726111-29ef-6054-edd3-f9c9214442e8@redhat.com>
Date: Tue, 10 Sep 2019 21:55:07 +0800
MIME-Version: 1.0
In-Reply-To: <20190910102150.7229-2-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org
Cc: bhupesh.linux@gmail.com, horms@verge.net.au

5ZyoIDIwMTnlubQwOeaciDEw5pelIDE4OjIxLCBCaHVwZXNoIFNoYXJtYSDlhpnpgZM6Cj4gUnVu
bmluZyAnY3BwY2hlY2snIHN0YXRpYyBjb2RlIGFuYWx5emVyIChzZWUgY3BwY2hlY2soMSkpCj4g
IG9uICd2bWNvcmUtZG1lc2cvdm1jb3JlLWRtZXNnLmMnIHNob3dzIHRoZSBmb2xsb3dpbmcKPiBz
aGlmdGluZyBlcnJvcjoKPiAKPiAkIGNwcGNoZWNrICAtLWVuYWJsZT1hbGwgIHZtY29yZS1kbWVz
Zy92bWNvcmUtZG1lc2cuYwo+IENoZWNraW5nIHZtY29yZS1kbWVzZy92bWNvcmUtZG1lc2cuYyAu
Li4KPiBbdm1jb3JlLWRtZXNnL3ZtY29yZS1kbWVzZy5jOjE3XTogKGVycm9yKSBTaGlmdGluZyBz
aWduZWQgMzItYml0IHZhbHVlIGJ5IDMxIGJpdHMgaXMgdW5kZWZpbmVkIGJlaGF2aW91cgo+IAo+
IEZpeCB0aGUgc2FtZSB2aWEgdGhpcyBwYXRjaC4KPiAKPiBDYzogTGlhbmJvIEppYW5nIDxsaWpp
YW5nQHJlZGhhdC5jb20+Cj4gQ2M6IFNpbW9uIEhvcm1hbiA8aG9ybXNAdmVyZ2UubmV0LmF1Pgo+
IFNpZ25lZC1vZmYtYnk6IEJodXBlc2ggU2hhcm1hIDxiaHNoYXJtYUByZWRoYXQuY29tPgo+IC0t
LQo+ICB2bWNvcmUtZG1lc2cvdm1jb3JlLWRtZXNnLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS92bWNvcmUt
ZG1lc2cvdm1jb3JlLWRtZXNnLmMgYi92bWNvcmUtZG1lc2cvdm1jb3JlLWRtZXNnLmMKPiBpbmRl
eCA4MWMyYTU4Li4xMjJlNTM2IDEwMDY0NAo+IC0tLSBhL3ZtY29yZS1kbWVzZy92bWNvcmUtZG1l
c2cuYwo+ICsrKyBiL3ZtY29yZS1kbWVzZy92bWNvcmUtZG1lc2cuYwo+IEBAIC02LDcgKzYsNyBA
QCB0eXBlZGVmIEVsZjMyX05oZHIgRWxmX05oZHI7Cj4gIGV4dGVybiBjb25zdCBjaGFyICpmbmFt
ZTsKPiAgCj4gIC8qIHN0b2xlIHRoaXMgbWFjcm8gZnJvbSBrZXJuZWwgcHJpbnRrLmMgKi8KPiAt
I2RlZmluZSBMT0dfQlVGX0xFTl9NQVggKHVpbnQzMl90KSgxIDw8IDMxKQo+ICsjZGVmaW5lIExP
R19CVUZfTEVOX01BWCAodWludDMyX3QpKDFVIDw8IDMxKQo+IAoKVGhpcyBsb29rcyBiZXR0ZXIu
IFRoYW5rIHlvdSwgQmh1cGVzaC4KCj4gIHN0YXRpYyB2b2lkIHdyaXRlX3RvX3N0ZG91dChjaGFy
ICpidWYsIHVuc2lnbmVkIGludCBucikKPiAgewo+IAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
