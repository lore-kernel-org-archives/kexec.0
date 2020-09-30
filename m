Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNh0g-0003t5-PG
 for kexec@lists.infradead.org; Wed, 30 Sep 2020 18:39:30 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200930183925euoutp01b7b7f24370102e96553ad70eecc6eeb2~5o7rxCESp2538725387euoutp014
 for <kexec@lists.infradead.org>; Wed, 30 Sep 2020 18:39:25 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 2/4] arm: decompressor: define a new zImage tag
Date: Wed, 30 Sep 2020 20:34:11 +0200
Message-Id: <20200930183413.17023-3-l.stelmach@samsung.com>
In-Reply-To: <20200930183413.17023-1-l.stelmach@samsung.com>
MIME-Version: 1.0
References: <20200601142754.26139-1-l.stelmach@samsung.com>
 <20200930183413.17023-1-l.stelmach@samsung.com>
 <CGME20200930183924eucas1p2869520cc28e705073cb08c37c1e2fc6d@eucas1p2.samsung.com>
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
To: Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Thomas Gleixner <tglx@linutronix.de>, Enrico Weigelt <info@metux.net>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

QWRkIERDU1ogdGFnIHdoaWNoIGhvbGRzIGR5bmFtaWMgbWVtb3J5IChzdGFjaywgYnNzLCBtYWxs
b2MgcG9vbCkKcmVxdWlyZW1lbnRzIG9mIHRoZSBkZWNvbXByZXNzb3IgY29kZS4KClNpZ25lZC1v
ZmYtYnk6IMWBdWthc3ogU3RlbG1hY2ggPGwuc3RlbG1hY2hAc2Ftc3VuZy5jb20+Ci0tLQogYXJj
aC9hcm0vYm9vdC9jb21wcmVzc2VkL3ZtbGludXgubGRzLlMgfCA5ICsrKysrKysrLQogYXJjaC9h
cm0vaW5jbHVkZS9hc20vaW1hZ2UuaCAgICAgICAgICAgfCAzICsrKwogMiBmaWxlcyBjaGFuZ2Vk
LCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9jb21wcmVzc2VkL3ZtbGludXgubGRzLlMgYi9hcmNoL2FybS9ib290L2NvbXByZXNzZWQv
dm1saW51eC5sZHMuUwppbmRleCBhNmIxNTExMTJhYzUuLjNlNzQ0M2I1MmY1YiAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vYm9vdC9jb21wcmVzc2VkL3ZtbGludXgubGRzLlMKKysrIGIvYXJjaC9hcm0v
Ym9vdC9jb21wcmVzc2VkL3ZtbGludXgubGRzLlMKQEAgLTQzLDYgKzQzLDExIEBAIFNFQ1RJT05T
CiAgICAgTE9ORyhaSU1BR0VfTUFHSUMoX2tlcm5lbF9ic3Nfc2l6ZSkpCiAgICAgTE9ORyhaSU1B
R0VfTUFHSUMoVEVYVF9PRkZTRVQpKQogICAgIExPTkcoWklNQUdFX01BR0lDKE1BTExPQ19TSVpF
KSkKKyAgICBMT05HKFpJTUFHRV9NQUdJQygzKSkKKyAgICBMT05HKEFSTV9aSU1BR0VfTUFHSUM0
KQorICAgIExPTkcoWklNQUdFX01BR0lDKChfZW5kIC0gX19ic3Nfc3RhcnQpICsKKyAgICAgICAg
ICAgICAgICAgICAgICAoX3N0YWNrX2VuZCAtIF9zdGFja19zdGFydCkgKworICAgICAgICAgICAg
ICAgICAgICAgIE1BTExPQ19TSVpFKSkKICAgICBMT05HKDApCiAgICAgX3RhYmxlX2VuZCA9IC47
CiAgIH0KQEAgLTExNywxMCArMTIyLDEyIEBAIFNFQ1RJT05TCiAgIC4gPSBCU1NfU1RBUlQ7CiAg
IF9fYnNzX3N0YXJ0ID0gLjsKICAgLmJzcwkJCTogeyAqKC5ic3MpIH0KKyAgLiA9IEFMSUdOKDgp
OwkJLyogdGhlIHN0YWNrIG11c3QgYmUgNjQtYml0IGFsaWduZWQgYW5kIGFkam9pbiBic3MgKi8K
ICAgX2VuZCA9IC47CiAKLSAgLiA9IEFMSUdOKDgpOwkJLyogdGhlIHN0YWNrIG11c3QgYmUgNjQt
Yml0IGFsaWduZWQgKi8KKyAgX3N0YWNrX3N0YXJ0ID0gLjsKICAgLnN0YWNrCQk6IHsgKiguc3Rh
Y2spIH0KKyAgX3N0YWNrX2VuZCA9IC47CiAKICAgUFJPVklERShfX3BlY29mZl9kYXRhX3NpemUg
PSBBTElHTig1MTIpIC0gQUREUiguZGF0YSkpOwogICBQUk9WSURFKF9fcGVjb2ZmX2VuZCA9IEFM
SUdOKDUxMikpOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vaW1hZ2UuaCBiL2Fy
Y2gvYXJtL2luY2x1ZGUvYXNtL2ltYWdlLmgKaW5kZXggODE1MGI5NDkwZTg2Li44YmU2ZGJjNjlm
YmIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2ltYWdlLmgKKysrIGIvYXJjaC9h
cm0vaW5jbHVkZS9hc20vaW1hZ2UuaApAQCAtMTUsNiArMTUsNyBAQAogI2RlZmluZSBBUk1fWklN
QUdFX01BR0lDMSBaSU1BR0VfTUFHSUMoMHgwMTZmMjgxOCkKICNkZWZpbmUgQVJNX1pJTUFHRV9N
QUdJQzIgKDB4NDU0NTQ1NDUpCiAjZGVmaW5lIEFSTV9aSU1BR0VfTUFHSUMzIFpJTUFHRV9NQUdJ
QygweDVhNTM0YzRiKQorI2RlZmluZSBBUk1fWklNQUdFX01BR0lDNCBaSU1BR0VfTUFHSUMoMHg1
YTUzNDM0NCkKIAogI2lmbmRlZiBfX0FTU0VNQkxZX18KIApAQCAtNDIsNiArNDMsOCBAQCBzdHJ1
Y3QgYXJtX3ppbWFnZV90YWcgewogCQkJX19sZTMyIHRleHRfb2Zmc2V0OwogCQkJX19sZTMyIG1h
bGxvY19zaXplOwogCQl9IGtybmxfc2l6ZTsKKyNkZWZpbmUgWklNQUdFX1RBR19aSU1BR0VfTUVN
IEFSTV9aSU1BR0VfTUFHSUM0CisJCV9fbGUzMiB6aW1hZ2VfbWVtOwogCX0gdTsKIH07CiAKLS0g
CjIuMjYuMgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
