Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-Id: <06fe76674ef56e9ea89d499f13b9fb742bdd0e0e.1380746425.git.geoff@infradead.org>
In-Reply-To: <cover.1380746425.git.geoff@infradead.org>
References: <cover.1380746425.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 4/6] kexec: Fix uninitialized build warning
MIME-Version: 1.0
Date: Wed, 02 Oct 2013 20:49:46 +0000
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

SW5pdGlhbGl6ZSBhIGxvY2FsIHZhcmlhYmxlIHRvIHplcm8uCgpGaXhlcyBidWlsZCB3YXJuaW5n
cyBsaWtlIHRoZXNlOgoKICBrZXhlYy9rZXhlYy1lbGYtcmVsLmM6IHdhcm5pbmc6IOKAmHJlbC5y
X29mZnNldOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24KClNp
Z25lZC1vZmYtYnk6IEdlb2ZmIExldmFuZCA8Z2VvZmZAaW5mcmFkZWFkLm9yZz4gZm9yIEh1YXdl
aSwgTGluYXJvCi0tLQoga2V4ZWMva2V4ZWMtZWxmLXJlbC5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEva2V4ZWMva2V4
ZWMtZWxmLXJlbC5jIGIva2V4ZWMva2V4ZWMtZWxmLXJlbC5jCmluZGV4IGY1OTE0MGYuLjAyMGNh
YjAgMTAwNjQ0Ci0tLSBhL2tleGVjL2tleGVjLWVsZi1yZWwuYworKysgYi9rZXhlYy9rZXhlYy1l
bGYtcmVsLmMKQEAgLTMzNiw3ICszMzYsNyBAQCBpbnQgZWxmX3JlbF9sb2FkKHN0cnVjdCBtZW1f
ZWhkciAqZWhkciwgc3RydWN0IGtleGVjX2luZm8gKmluZm8sCiAJCX0KIAkJcmVsX2VuZCA9IHNo
ZHItPnNoX2RhdGEgKyBzaGRyLT5zaF9zaXplOwogCQlmb3IocHRyID0gc2hkci0+c2hfZGF0YTsg
cHRyIDwgcmVsX2VuZDsgcHRyICs9IHJlbF9zaXplKSB7Ci0JCQlzdHJ1Y3QgbWVtX3JlbGEgcmVs
OworCQkJc3RydWN0IG1lbV9yZWxhIHJlbCA9IHswfTsKIAkJCXN0cnVjdCBtZW1fc3ltIHN5bTsK
IAkJCWNvbnN0IHZvaWQgKmxvY2F0aW9uOwogCQkJY29uc3QgdW5zaWduZWQgY2hhciAqbmFtZTsK
LS0gCjEuOC4xLjIKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
