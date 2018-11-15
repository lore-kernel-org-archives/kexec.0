Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gNAZw-0005Xe-M6
 for kexec@lists.infradead.org; Thu, 15 Nov 2018 05:52:38 +0000
Received: by mail-yb1-xb41.google.com with SMTP id u103-v6so7919104ybi.5
 for <kexec@lists.infradead.org>; Wed, 14 Nov 2018 21:52:35 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v16 05/16] kexec_file: kexec_walk_memblock() only walks a
 dedicated region at kdump
Date: Thu, 15 Nov 2018 14:52:44 +0900
Message-Id: <20181115055254.2812-6-takahiro.akashi@linaro.org>
In-Reply-To: <20181115055254.2812-1-takahiro.akashi@linaro.org>
References: <20181115055254.2812-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
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
To: catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com, arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: ard.biesheuvel@linaro.org, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, prudo@linux.ibm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

In kdump case, there exists only one dedicated memblock region as usable
memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
callback function on this region.

Cosmetic change: 0 to MEMBLOCK_NONE at for_each_free_mem_range*()

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d03195a8cb6e..f1d0e00a3971 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -515,8 +515,11 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
 	if (kbuf->top_down) {
-		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
+		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, MEMBLOCK_NONE,
 						&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
@@ -530,8 +533,8 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 				break;
 		}
 	} else {
-		for_each_free_mem_range(i, NUMA_NO_NODE, 0, &mstart, &mend,
-					NULL) {
+		for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
+					&mstart, &mend, NULL) {
 			/*
 			 * In memblock, end points to the first byte after the
 			 * range while in kexec, end points to the last byte
-- 
2.19.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
