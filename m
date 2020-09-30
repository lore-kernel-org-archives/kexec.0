Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNh0h-0003t1-9w
 for kexec@lists.infradead.org; Wed, 30 Sep 2020 18:39:32 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200930183925euoutp02a25cb8ff68b9bf8df2870906a5ce549e~5o7rb9GAy0433404334euoutp02C
 for <kexec@lists.infradead.org>; Wed, 30 Sep 2020 18:39:25 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 3/4] arm: Add kexec_image_info
Date: Wed, 30 Sep 2020 20:34:12 +0200
Message-Id: <20200930183413.17023-4-l.stelmach@samsung.com>
In-Reply-To: <20200930183413.17023-1-l.stelmach@samsung.com>
MIME-Version: 1.0
References: <20200601142754.26139-1-l.stelmach@samsung.com>
 <20200930183413.17023-1-l.stelmach@samsung.com>
 <CGME20200930183924eucas1p1eba72052e1723ce75e00cbadbe03b6fa@eucas1p1.samsung.com>
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

QWRkIGtleGVjX2ltYWdlX2luZm8gdG8gcHJpbnQgZGV0YWlsZWQgaW5mb3JtYXRpb24gYWJvdXQg
YSBrZXhlYyBpbWFnZS4KClNpZ25lZC1vZmYtYnk6IMWBdWthc3ogU3RlbG1hY2ggPGwuc3RlbG1h
Y2hAc2Ftc3VuZy5jb20+Ci0tLQogYXJjaC9hcm0va2VybmVsL21hY2hpbmVfa2V4ZWMuYyB8IDI4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0va2VybmVsL21hY2hpbmVfa2V4ZWMuYyBiL2Fy
Y2gvYXJtL2tlcm5lbC9tYWNoaW5lX2tleGVjLmMKaW5kZXggNWQ4NGFkMzMzZjA1Li5hMGMyMjll
ZWMwYjIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2tlcm5lbC9tYWNoaW5lX2tleGVjLmMKKysrIGIv
YXJjaC9hcm0va2VybmVsL21hY2hpbmVfa2V4ZWMuYwpAQCAtMjksNiArMjksMzIgQEAgZXh0ZXJu
IHVuc2lnbmVkIGxvbmcga2V4ZWNfYm9vdF9hdGFnczsKIAogc3RhdGljIGF0b21pY190IHdhaXRp
bmdfZm9yX2NyYXNoX2lwaTsKIAorLyoqCisgKiBrZXhlY19pbWFnZV9pbmZvIC0gRm9yIGRlYnVn
Z2luZyBvdXRwdXQuCisgKi8KKyNkZWZpbmUga2V4ZWNfaW1hZ2VfaW5mbyhfaSkgX2tleGVjX2lt
YWdlX2luZm8oX19mdW5jX18sIF9fTElORV9fLCBfaSkKK3N0YXRpYyB2b2lkIF9rZXhlY19pbWFn
ZV9pbmZvKGNvbnN0IGNoYXIgKmZ1bmMsIGludCBsaW5lLAorCWNvbnN0IHN0cnVjdCBraW1hZ2Ug
KmtpbWFnZSkKK3sKKwl1bnNpZ25lZCBsb25nIGk7CisKKwlwcl9kZWJ1ZygiJXM6JWQ6XG4iLCBm
dW5jLCBsaW5lKTsKKwlwcl9kZWJ1ZygiICBrZXhlYyBraW1hZ2UgaW5mbzpcbiIpOworCXByX2Rl
YnVnKCIgICAgdHlwZTogICAgICAgICVkXG4iLCBraW1hZ2UtPnR5cGUpOworCXByX2RlYnVnKCIg
ICAgc3RhcnQ6ICAgICAgICVseFxuIiwga2ltYWdlLT5zdGFydCk7CisJcHJfZGVidWcoIiAgICBo
ZWFkOiAgICAgICAgJWx4XG4iLCBraW1hZ2UtPmhlYWQpOworCXByX2RlYnVnKCIgICAgbnJfc2Vn
bWVudHM6ICVsdVxuIiwga2ltYWdlLT5ucl9zZWdtZW50cyk7CisKKwlmb3IgKGkgPSAwOyBpIDwg
a2ltYWdlLT5ucl9zZWdtZW50czsgaSsrKSB7CisJCXByX2RlYnVnKCIgICAgICBzZWdtZW50WyVs
dV06ICUwOGx4IC0gJTA4bHgsIDB4JXggYnl0ZXMsICVsdSBwYWdlc1xuIiwKKwkJCWksCisJCQlr
aW1hZ2UtPnNlZ21lbnRbaV0ubWVtLAorCQkJa2ltYWdlLT5zZWdtZW50W2ldLm1lbSArIGtpbWFn
ZS0+c2VnbWVudFtpXS5tZW1zeiwKKwkJCWtpbWFnZS0+c2VnbWVudFtpXS5tZW1zeiwKKwkJCWtp
bWFnZS0+c2VnbWVudFtpXS5tZW1zeiAvICBQQUdFX1NJWkUpOworCX0KK30KKwogLyoKICAqIFBy
b3ZpZGUgYSBkdW1teSBjcmFzaF9ub3RlcyBkZWZpbml0aW9uIHdoaWxlIGNyYXNoIGR1bXAgYXJy
aXZlcyB0byBhcm0uCiAgKiBUaGlzIHByZXZlbnRzIGJyZWFrYWdlIG9mIGNyYXNoX25vdGVzIGF0
dHJpYnV0ZSBpbiBrZXJuZWwva3N5c2ZzLmMuCkBAIC00MCw2ICs2Niw4IEBAIGludCBtYWNoaW5l
X2tleGVjX3ByZXBhcmUoc3RydWN0IGtpbWFnZSAqaW1hZ2UpCiAJX19iZTMyIGhlYWRlcjsKIAlp
bnQgaSwgZXJyOwogCisJa2V4ZWNfaW1hZ2VfaW5mbyhpbWFnZSk7CisKIAlpbWFnZS0+YXJjaC5r
ZXJuZWxfcjIgPSBpbWFnZS0+c3RhcnQgLSBLRVhFQ19BUk1fWklNQUdFX09GRlNFVAogCQkJCSAg
ICAgKyBLRVhFQ19BUk1fQVRBR1NfT0ZGU0VUOwogCi0tIAoyLjI2LjIKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==
