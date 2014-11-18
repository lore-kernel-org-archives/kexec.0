Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XqhIi-0002eX-V5
 for kexec@lists.infradead.org; Tue, 18 Nov 2014 11:50:30 +0000
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NF800ASKH01FO70@mailout4.w1.samsung.com> for
 kexec@lists.infradead.org; Tue, 18 Nov 2014 11:52:49 +0000 (GMT)
Subject: [PATCH 1/2 v2] scripts/coccinelle: catch freeing cryptographic
 structures via kfree
From: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
Date: Tue, 18 Nov 2014 14:50:03 +0400
Message-id: <20141118114920.13498.73584.stgit@buzz>
In-reply-to: <20141117151420.10739.16342.stgit@buzz>
References: <20141117151420.10739.16342.stgit@buzz>
MIME-version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Cc: Michal Marek <mmarek@suse.cz>, Herbert Xu <herbert@gondor.apana.org.au>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Structures allocated by crypto_alloc_* must be freed using crypto_free_*.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
---
 scripts/coccinelle/free/crypto_free.cocci |   64 +++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 scripts/coccinelle/free/crypto_free.cocci

diff --git a/scripts/coccinelle/free/crypto_free.cocci b/scripts/coccinelle/free/crypto_free.cocci
new file mode 100644
index 0000000..a717070
--- /dev/null
+++ b/scripts/coccinelle/free/crypto_free.cocci
@@ -0,0 +1,64 @@
+///
+/// Structures allocated by crypto_alloc_* must be freed using crypto_free_*.
+/// This finds freeing them by kfree.
+///
+// Confidence: Moderate
+// Copyright: (C) 2014 Konstantin Khlebnikov,  GPLv2.
+// Comments: There are false positives in crypto/ where they are actually freed.
+// Keywords: crypto, kfree
+// Options: --no-includes --include-headers
+
+virtual org
+virtual report
+virtual context
+
+@r depends on context || org || report@
+expression x;
+@@
+
+(
+ x = crypto_alloc_base(...)
+|
+ x = crypto_alloc_cipher(...)
+|
+ x = crypto_alloc_ablkcipher(...)
+|
+ x = crypto_alloc_aead(...)
+|
+ x = crypto_alloc_instance(...)
+|
+ x = crypto_alloc_instance2(...)
+|
+ x = crypto_alloc_comp(...)
+|
+ x = crypto_alloc_pcomp(...)
+|
+ x = crypto_alloc_hash(...)
+|
+ x = crypto_alloc_ahash(...)
+|
+ x = crypto_alloc_shash(...)
+|
+ x = crypto_alloc_rng(...)
+)
+
+@pb@
+expression r.x;
+position p;
+@@
+
+* kfree@p(x)
+
+@script:python depends on org@
+p << pb.p;
+@@
+
+msg="WARNING: invalid free of crypto_alloc_* allocated data"
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on report@
+p << pb.p;
+@@
+
+msg="WARNING: invalid free of crypto_alloc_* allocated data"
+coccilib.report.print_report(p[0], msg)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
