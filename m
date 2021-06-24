Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwHmv-00CmbR-I6
 for kexec@lists.infradead.org; Thu, 24 Jun 2021 05:20:30 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] dma-pool: allow user to disable atomic pool
Date: Thu, 24 Jun 2021 13:20:10 +0800
Message-Id: <20210624052010.5676-3-bhe@redhat.com>
In-Reply-To: <20210624052010.5676-1-bhe@redhat.com>
References: <20210624052010.5676-1-bhe@redhat.com>
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
Cc: linux-mm@kvack.org, x86@kernel.org, rientjes@google.com, rppt@linux.ibm.com, thomas.lendacky@amd.com, brijesh.singh@amd.com, kexec@lists.infradead.org, bhe@redhat.com

In the current code, three atomic memory pools are provided,
atomic_pool_kernel, atomic_pool_dma, atomic_pool_dma32, initialized
with flag GFP_KERNEL, GFP_KERNEL|GFP_DMA, GFP_KERNEL|GFP_DMA32.
And they are always enabled, even though 'coherent_pool=0' is
specified in kernel command line.

In some cases, atomic pool may not be needed. And worse, it even will
cause problem. E.g in kdump kernel of x86_64, it will cause OOM for
atomic_pool_dma initialization. Because there isn't available memory
for buddy allocatory in DMA zone of kdump kernel since commit
f1d4d47c5851 ("x86/setup: Always reserve the first 1M of RAM"). 
The OOM will cause panic if panic_on_oom is added into kdump kernel.

So change code to adjust the existing coherent_pool to allow user
to disable atomic pool by specifying 'coherent_pool=0'.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/dma/pool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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
