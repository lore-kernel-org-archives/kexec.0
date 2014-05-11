Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WjPFs-00026V-1J
 for kexec@lists.infradead.org; Sun, 11 May 2014 08:37:08 +0000
Date: Sun, 11 May 2014 09:22:52 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] zImage-arm: init modified_cmdline with zero
Message-ID: <20140511002252.GR31760@verge.net.au>
References: <1399208633-62071-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399208633-62071-1-git-send-email-wangnan0@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Geng Hui <hui.geng@huawei.com>

T24gU3VuLCBNYXkgMDQsIDIwMTQgYXQgMDk6MDM6NTNQTSArMDgwMCwgV2FuZyBOYW4gd3JvdGU6
Cj4gVGhpcyBwYXRjaCBtZW1zZXQgbW9kaWZpZWRfY21kbGluZSBhZnRlciBpdCBhbGxvY2VkLgo+
IAo+IFdpdGhvdXQgdGhpcyBwYXRjaCwgdGhlIGhlYWRlciBvZiBjb21tYW5kIGxpbmUgYWx3YXlz
IGNvbnRhaW5zIHJhbmRvbQo+IHZhbHVlIGxpa2UgZm9sbG93aW5nIGV4YW1wbGU6Cj4gCj4ga2Vy
bmVsOiAweDc2NWZkMDA4IGtlcm5lbF9zaXplOiAweDIzYjYxMAo+IG1lbW9yeSByYW5nZTogWzB4
NjAwMDAwMDAgLSAweDZmZmZmZmZmXSAoMjU2TSkKPiBtZW1vcnkgcmFuZ2U6IFsweDc4MDAwMDAw
IC0gMHg5ZmZmZmZmZl0gKDY0ME0pCj4gLi4uCj4ga2VybmVsIGNvbW1hbmQgbGluZTogIsKwwqXm
sKXkkLYjIGVsZmNvcmVoZHI9MHg3N2YwMDAwMCBtZW09MTMwMDQ4SyIKPiAKPiBTaWduZWQtb2Zm
LWJ5OiBXYW5nIE5hbiA8d2FuZ25hbjBAaHVhd2VpLmNvbT4KPiBDYzogR2VuZyBIdWkgPGh1aS5n
ZW5nQGh1YXdlaS5jb20+CgpUaGFua3MsIGFwcGxpZWQuCgo+IAo+IC0tLQo+ICBrZXhlYy9hcmNo
L2FybS9rZXhlYy16SW1hZ2UtYXJtLmMgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEva2V4ZWMvYXJjaC9hcm0va2V4ZWMtekltYWdlLWFy
bS5jIGIva2V4ZWMvYXJjaC9hcm0va2V4ZWMtekltYWdlLWFybS5jCj4gaW5kZXggMjIwODI2ZS4u
NGI1ZDNmNCAxMDA2NDQKPiAtLS0gYS9rZXhlYy9hcmNoL2FybS9rZXhlYy16SW1hZ2UtYXJtLmMK
PiArKysgYi9rZXhlYy9hcmNoL2FybS9rZXhlYy16SW1hZ2UtYXJtLmMKPiBAQCAtMzc4LDYgKzM3
OCw4IEBAIGludCB6SW1hZ2VfYXJtX2xvYWQoaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjb25zdCBj
aGFyICpidWYsIG9mZl90IGxlbiwKPiAgCQlpZiAoIW1vZGlmaWVkX2NtZGxpbmUpCj4gIAkJCXJl
dHVybiAtMTsKPiAgCj4gKwkJbWVtc2V0KG1vZGlmaWVkX2NtZGxpbmUsICdcMCcsIENPTU1BTkRf
TElORV9TSVpFKTsKPiArCj4gIAkJaWYgKGNvbW1hbmRfbGluZSkgewo+ICAJCQkodm9pZCkgc3Ry
bmNweShtb2RpZmllZF9jbWRsaW5lLCBjb21tYW5kX2xpbmUsCj4gIAkJCQkgICAgICAgQ09NTUFO
RF9MSU5FX1NJWkUpOwo+IC0tIAo+IDEuOC40Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==
