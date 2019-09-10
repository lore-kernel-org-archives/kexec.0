Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7mLb-0007rc-Bb
 for kexec@lists.infradead.org; Tue, 10 Sep 2019 20:02:44 +0000
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5035C007351
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 20:02:39 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id m8so3107593ljb.3
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 13:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190910102150.7229-1-bhsharma@redhat.com>
 <20190910102150.7229-2-bhsharma@redhat.com>
 <50726111-29ef-6054-edd3-f9c9214442e8@redhat.com>
In-Reply-To: <50726111-29ef-6054-edd3-f9c9214442e8@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 11 Sep 2019 01:32:25 +0530
Message-ID: <CACi5LpOOdxr1c95k69QXp60RwE2CWGC97dqG0mUaVKgNenGgKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmcore-dmesg/vmcore-dmesg.c: Fix shifting error
 reported by cppcheck
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
To: lijiang <lijiang@redhat.com>
Cc: Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>

T24gVHVlLCBTZXAgMTAsIDIwMTkgYXQgNzoyNSBQTSBsaWppYW5nIDxsaWppYW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4g5ZyoIDIwMTnlubQwOeaciDEw5pelIDE4OjIxLCBCaHVwZXNoIFNoYXJt
YSDlhpnpgZM6Cj4gPiBSdW5uaW5nICdjcHBjaGVjaycgc3RhdGljIGNvZGUgYW5hbHl6ZXIgKHNl
ZSBjcHBjaGVjaygxKSkKPiA+ICBvbiAndm1jb3JlLWRtZXNnL3ZtY29yZS1kbWVzZy5jJyBzaG93
cyB0aGUgZm9sbG93aW5nCj4gPiBzaGlmdGluZyBlcnJvcjoKPiA+Cj4gPiAkIGNwcGNoZWNrICAt
LWVuYWJsZT1hbGwgIHZtY29yZS1kbWVzZy92bWNvcmUtZG1lc2cuYwo+ID4gQ2hlY2tpbmcgdm1j
b3JlLWRtZXNnL3ZtY29yZS1kbWVzZy5jIC4uLgo+ID4gW3ZtY29yZS1kbWVzZy92bWNvcmUtZG1l
c2cuYzoxN106IChlcnJvcikgU2hpZnRpbmcgc2lnbmVkIDMyLWJpdCB2YWx1ZSBieSAzMSBiaXRz
IGlzIHVuZGVmaW5lZCBiZWhhdmlvdXIKPiA+Cj4gPiBGaXggdGhlIHNhbWUgdmlhIHRoaXMgcGF0
Y2guCj4gPgo+ID4gQ2M6IExpYW5ibyBKaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPgo+ID4gQ2M6
IFNpbW9uIEhvcm1hbiA8aG9ybXNAdmVyZ2UubmV0LmF1Pgo+ID4gU2lnbmVkLW9mZi1ieTogQmh1
cGVzaCBTaGFybWEgPGJoc2hhcm1hQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICB2bWNvcmUtZG1l
c2cvdm1jb3JlLWRtZXNnLmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL3ZtY29yZS1kbWVzZy92bWNv
cmUtZG1lc2cuYyBiL3ZtY29yZS1kbWVzZy92bWNvcmUtZG1lc2cuYwo+ID4gaW5kZXggODFjMmE1
OC4uMTIyZTUzNiAxMDA2NDQKPiA+IC0tLSBhL3ZtY29yZS1kbWVzZy92bWNvcmUtZG1lc2cuYwo+
ID4gKysrIGIvdm1jb3JlLWRtZXNnL3ZtY29yZS1kbWVzZy5jCj4gPiBAQCAtNiw3ICs2LDcgQEAg
dHlwZWRlZiBFbGYzMl9OaGRyIEVsZl9OaGRyOwo+ID4gIGV4dGVybiBjb25zdCBjaGFyICpmbmFt
ZTsKPiA+Cj4gPiAgLyogc3RvbGUgdGhpcyBtYWNybyBmcm9tIGtlcm5lbCBwcmludGsuYyAqLwo+
ID4gLSNkZWZpbmUgTE9HX0JVRl9MRU5fTUFYICh1aW50MzJfdCkoMSA8PCAzMSkKPiA+ICsjZGVm
aW5lIExPR19CVUZfTEVOX01BWCAodWludDMyX3QpKDFVIDw8IDMxKQo+ID4KPgo+IFRoaXMgbG9v
a3MgYmV0dGVyLiBUaGFuayB5b3UsIEJodXBlc2guCgpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBM
aWFuYm8uCgpSZWdhcmRzLApCaHVwZXNoCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
