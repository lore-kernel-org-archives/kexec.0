Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XqO0t-0003Lq-M0
 for kexec@lists.infradead.org; Mon, 17 Nov 2014 15:14:48 +0000
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NF600JDRVSQTG20@mailout2.w1.samsung.com> for
 kexec@lists.infradead.org; Mon, 17 Nov 2014 15:17:14 +0000 (GMT)
Subject: [PATCH 2/2] kernel/kexec: free crypto_shash using crypto_free_shash
From: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
Date: Mon, 17 Nov 2014 18:14:26 +0400
Message-id: <20141117151426.10739.86414.stgit@buzz>
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

These objects have special freeing functions which cares about
proper destruction and reference counting.

Signed-off-by: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
---
 kernel/kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 2abf9f6..5a62311 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -2286,7 +2286,7 @@ out_free_sha_regions:
 out_free_desc:
 	kfree(desc);
 out_free_tfm:
-	kfree(tfm);
+	crypto_free_shash(tfm);
 out:
 	return ret;
 }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
