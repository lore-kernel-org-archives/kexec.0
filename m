Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rlb5T-0005jo-Uu
 for kexec@lists.infradead.org; Fri, 13 Jan 2012 06:58:09 +0000
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Fri, 13 Jan 2012 12:27:56 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0D6vpDM3428352
 for <kexec@lists.infradead.org>; Fri, 13 Jan 2012 12:27:51 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0D6voht018868
 for <kexec@lists.infradead.org>; Fri, 13 Jan 2012 17:57:50 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH][makedumpfile] Fix compilation error in sadump_info.h
Date: Fri, 13 Jan 2012 12:27:50 +0530
Message-ID: <20120113065726.13214.80477.stgit@suzukikp.in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
Cc: kexec-ml <kexec@lists.infradead.org>

V2hpbGUgY29tcGlsaW5nIHRoZSBtYWtlZHVtcGZpbGUtMS40LjEgSSBnb3QgdGhlIGZvbGxvd2lu
ZyBlcnJvciA6CgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gbWFrZWR1bXBmaWxlLmM6MjE6CnNhZHVt
cF9pbmZvLmg6ODY6IGVycm9yOiBleHBlY3RlZCBpZGVudGlmaWVyIG9yIOKAmCjigJkgYmVmb3Jl
IOKAmHvigJkgdG9rZW4KCgpUaGlzIHBhdGNoIGZpeGVzIHRoZSBjb21waWxhdGlvbiBlcnJvciBp
biBzYWR1bXBfaW5mby5oCgpTaWduZWQtb2ZmLWJ5OiBTdXp1a2kgSy4gUG91bG9zZSA8c3V6dWtp
QGluLmlibS5jb20+Ci0tLQoKIHNhZHVtcF9pbmZvLmggfCAgICAyICstCiAxIGZpbGVzIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zYWR1bXBf
aW5mby5oIGIvc2FkdW1wX2luZm8uaAppbmRleCAxZjc0ZWU1Li5jNDgyNGJlIDEwMDY0NAotLS0g
YS9zYWR1bXBfaW5mby5oCisrKyBiL3NhZHVtcF9pbmZvLmgKQEAgLTgyLDcgKzgyLDcgQEAgc3Rh
dGljIGlubGluZSBpbnQgc2FkdW1wX2luaXRpYWxpemVfYml0bWFwX21lbW9yeSh2b2lkKQogCXJl
dHVybiBGQUxTRTsKIH0KIAotc3RhdGljIGlubGluZSBpbnQgc2FkdW1wX251bV9vbmxpbmVfY3B1
cyh2b2lkKTsKK3N0YXRpYyBpbmxpbmUgaW50IHNhZHVtcF9udW1fb25saW5lX2NwdXModm9pZCkK
IHsKIAlyZXR1cm4gMDsKIH0KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
