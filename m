Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <aa9a3104cda82608321e94ab9acdfe1ecb75923b.1523465700.git.geoff@infradead.org>
In-Reply-To: <cover.1523465700.git.geoff@infradead.org>
References: <cover.1523465700.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/4] kexec: Fix printf warning
MIME-Version: 1.0
Date: Wed, 11 Apr 2018 17:03:11 +0000
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Petitboot@lists.ozlabs.org

Rml4ZXMgd2FybmluZ3MgbGlrZSB0aGVzZSB3aGVuIGJ1aWxkaW5nIGtleGVjIGZvciBwb3dlcnBj
ICgzMiBiaXQpOgoKICBrZXhlYy5jOiB3YXJuaW5nOiBmb3JtYXQg4oCYJWx14oCZIGV4cGVjdHMg
YXJndW1lbnQgb2YgdHlwZSDigJhsb25nIHVuc2lnbmVkIGludOKAmSwgYnV0IGFyZ3VtZW50IDIg
aGFzIHR5cGUg4oCYdWludDY0X3QKClNpZ25lZC1vZmYtYnk6IEdlb2ZmIExldmFuZCA8Z2VvZmZA
aW5mcmFkZWFkLm9yZz4KLS0tCiBrZXhlYy9rZXhlYy5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9rZXhlYy9rZXhl
Yy5jIGIva2V4ZWMva2V4ZWMuYwppbmRleCAzMTNkOWZlLi4yOWZhNWZhIDEwMDY0NAotLS0gYS9r
ZXhlYy9rZXhlYy5jCisrKyBiL2tleGVjL2tleGVjLmMKQEAgLTIwLDYgKzIwLDcgQEAKICAqLwog
CiAjZGVmaW5lIF9HTlVfU09VUkNFCisjaW5jbHVkZSA8aW50dHlwZXMuaD4KICNpbmNsdWRlIDxz
dGRpby5oPgogI2luY2x1ZGUgPHN0ZGFyZy5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgpAQCAtMTIz
NSw3ICsxMjM2LDcgQEAgc3RhdGljIHZvaWQgcHJpbnRfY3Jhc2hrZXJuZWxfcmVnaW9uX3NpemUo
dm9pZCkKIAkJcmV0dXJuOwogCX0KIAotCXByaW50ZigiJWx1XG4iLCAoc3RhcnQgIT0gZW5kKSA/
IChlbmQgLSBzdGFydCArIDEpIDogMFVMKTsKKwlwcmludGYoIiUiIFBSSXU2NCAiXG4iLCAoc3Rh
cnQgIT0gZW5kKSA/IChlbmQgLSBzdGFydCArIDEpIDogMFVMKTsKIH0KIAogaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKLS0gCjIuMTQuMQoKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==
