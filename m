Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwkQt-009TpO-Bf
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 12:27:56 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/5] dma-pool: allow user to disable atomic pool
Date: Mon, 13 Dec 2021 20:27:09 +0800
Message-Id: <20211213122712.23805-3-bhe@redhat.com>
In-Reply-To: <20211213122712.23805-1-bhe@redhat.com>
References: <20211213122712.23805-1-bhe@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, bhe@redhat.com

In the current code, three atomic memory pools are always created,
atomic_pool_kernel|dma|dma32, even though 'coherent_pool=0' is
specified in kernel command line. In fact, atomic pool is only
necessary when CONFIG_DMA_DIRECT_REMAP=y or mem_encrypt_active=y
which are needed on few ARCHes.

So change code to allow user to disable atomic pool by specifying
'coherent_pool=0'.

Meanwhile, update the relevant document in kernel-parameter.txt.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 kernel/dma/pool.c                               | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ec4d25e854a8..d7015309614b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -664,7 +664,8 @@
 
 	coherent_pool=nn[KMG]	[ARM,KNL]
 			Sets the size of memory pool for coherent, atomic dma
-			allocations. Otherwise the default size will be scaled
+			allocations. A value of 0 disables the three atomic
+			memory pool. Otherwise the default size will be scaled
 			with memory capacity, while clamped between 128K and
 			1 << (PAGE_SHIFT + MAX_ORDER-1).
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 5f84e6cdb78e..5a85804b5beb 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -21,7 +21,7 @@ static struct gen_pool *atomic_pool_kernel __ro_after_init;
 static unsigned long pool_size_kernel;
 
 /* Size can be defined by the coherent_pool command line */
-static size_t atomic_pool_size;
+static unsigned long atomic_pool_size = -1;
 
 /* Dynamic background expansion when the atomic pool is near capacity */
 static struct work_struct atomic_pool_work;
@@ -188,11 +188,14 @@ static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
 
+	if (!atomic_pool_size)
+		return 0;
+
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
 	 */
-	if (!atomic_pool_size) {
+	if (atomic_pool_size == -1) {
 		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
 		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
 		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
-- 
2.17.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
