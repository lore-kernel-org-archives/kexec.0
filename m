Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WgwCb-0001rw-Va
 for kexec@lists.infradead.org; Sun, 04 May 2014 13:11:35 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH] zImage-arm: init modified_cmdline with zero
Date: Sun, 4 May 2014 21:03:53 +0800
Message-ID: <1399208633-62071-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

VGhpcyBwYXRjaCBtZW1zZXQgbW9kaWZpZWRfY21kbGluZSBhZnRlciBpdCBhbGxvY2VkLgoKV2l0
aG91dCB0aGlzIHBhdGNoLCB0aGUgaGVhZGVyIG9mIGNvbW1hbmQgbGluZSBhbHdheXMgY29udGFp
bnMgcmFuZG9tCnZhbHVlIGxpa2UgZm9sbG93aW5nIGV4YW1wbGU6CgprZXJuZWw6IDB4NzY1ZmQw
MDgga2VybmVsX3NpemU6IDB4MjNiNjEwCm1lbW9yeSByYW5nZTogWzB4NjAwMDAwMDAgLSAweDZm
ZmZmZmZmXSAoMjU2TSkKbWVtb3J5IHJhbmdlOiBbMHg3ODAwMDAwMCAtIDB4OWZmZmZmZmZdICg2
NDBNKQouLi4Ka2VybmVsIGNvbW1hbmQgbGluZTogIsKwwqXmsKXkkLYjIGVsZmNvcmVoZHI9MHg3
N2YwMDAwMCBtZW09MTMwMDQ4SyIKClNpZ25lZC1vZmYtYnk6IFdhbmcgTmFuIDx3YW5nbmFuMEBo
dWF3ZWkuY29tPgpDYzogR2VuZyBIdWkgPGh1aS5nZW5nQGh1YXdlaS5jb20+CgotLS0KIGtleGVj
L2FyY2gvYXJtL2tleGVjLXpJbWFnZS1hcm0uYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9rZXhlYy9hcmNoL2FybS9rZXhlYy16SW1hZ2UtYXJt
LmMgYi9rZXhlYy9hcmNoL2FybS9rZXhlYy16SW1hZ2UtYXJtLmMKaW5kZXggMjIwODI2ZS4uNGI1
ZDNmNCAxMDA2NDQKLS0tIGEva2V4ZWMvYXJjaC9hcm0va2V4ZWMtekltYWdlLWFybS5jCisrKyBi
L2tleGVjL2FyY2gvYXJtL2tleGVjLXpJbWFnZS1hcm0uYwpAQCAtMzc4LDYgKzM3OCw4IEBAIGlu
dCB6SW1hZ2VfYXJtX2xvYWQoaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpidWYs
IG9mZl90IGxlbiwKIAkJaWYgKCFtb2RpZmllZF9jbWRsaW5lKQogCQkJcmV0dXJuIC0xOwogCisJ
CW1lbXNldChtb2RpZmllZF9jbWRsaW5lLCAnXDAnLCBDT01NQU5EX0xJTkVfU0laRSk7CisKIAkJ
aWYgKGNvbW1hbmRfbGluZSkgewogCQkJKHZvaWQpIHN0cm5jcHkobW9kaWZpZWRfY21kbGluZSwg
Y29tbWFuZF9saW5lLAogCQkJCSAgICAgICBDT01NQU5EX0xJTkVfU0laRSk7Ci0tIAoxLjguNAoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
