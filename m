Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <a3c8c1d9fa406ff68484225fd9356ac82f8090b9.1523465700.git.geoff@infradead.org>
In-Reply-To: <cover.1523465700.git.geoff@infradead.org>
References: <cover.1523465700.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 4/4] purgatory/ppc64: Fix uninitialized warning
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
ICgzMiBiaXQpOgoKICBjb25zb2xlLXBwYzY0LmM6IHdhcm5pbmc6IOKAmCooKHZvaWQgKikmYnVm
Zis4KeKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkCgpTaWduZWQtb2ZmLWJ5OiBHZW9mZiBM
ZXZhbmQgPGdlb2ZmQGluZnJhZGVhZC5vcmc+Ci0tLQogcHVyZ2F0b3J5L2FyY2gvcHBjNjQvY29u
c29sZS1wcGM2NC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvcHVyZ2F0b3J5L2FyY2gvcHBjNjQvY29uc29sZS1wcGM2
NC5jIGIvcHVyZ2F0b3J5L2FyY2gvcHBjNjQvY29uc29sZS1wcGM2NC5jCmluZGV4IGI4MDE4M2Mu
LjI0MDMzMTIgMTAwNjQ0Ci0tLSBhL3B1cmdhdG9yeS9hcmNoL3BwYzY0L2NvbnNvbGUtcHBjNjQu
YworKysgYi9wdXJnYXRvcnkvYXJjaC9wcGM2NC9jb25zb2xlLXBwYzY0LmMKQEAgLTI5LDcgKzI5
LDcgQEAgZXh0ZXJuIGludCBkZWJ1ZzsKIAogdm9pZCBwdXRjaGFyKGludCBjKQogewotCWNoYXIg
YnVmZlsxNl07CisJY2hhciBidWZmWzE2XSA9ICIiOwogCXVuc2lnbmVkIGxvbmcgKmxidWYgPSAo
dW5zaWduZWQgbG9uZyAqKWJ1ZmY7CiAKIAlpZiAoIWRlYnVnKSAvKiBydW5uaW5nIG9uIG5vbiBw
c2VyaWVzICovCi0tIAoyLjE0LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
