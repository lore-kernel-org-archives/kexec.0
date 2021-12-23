Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0KfL-00CQDE-R1
 for kexec@lists.infradead.org; Thu, 23 Dec 2021 09:45:41 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 3/3] mm/page_alloc.c: do not warn allocation failure on
 zone DMA if no managed pages
Date: Thu, 23 Dec 2021 17:44:35 +0800
Message-Id: <20211223094435.248523-4-bhe@redhat.com>
In-Reply-To: <20211223094435.248523-1-bhe@redhat.com>
References: <20211223094435.248523-1-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de, cl@linux.com, John.p.donnelly@oracle.com, kexec@lists.infradead.org, bhe@redhat.com, 42.hyeyoo@gmail.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, David.Laight@ACULAB.COM, david@redhat.com, x86@kernel.org, bp@alien8.de

In kdump kernel of x86_64, page allocation failure is observed:

 kworker/u2:2: page allocation failure: order:0, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
 CPU: 0 PID: 55 Comm: kworker/u2:2 Not tainted 5.16.0-rc4+ #5
 Hardware name: AMD Dinar/Dinar, BIOS RDN1505B 06/05/2013
 Workqueue: events_unbound async_run_entry_fn
 Call Trace:
  <TASK>
  dump_stack_lvl+0x48/0x5e
  warn_alloc.cold+0x72/0xd6
  __alloc_pages_slowpath.constprop.0+0xc69/0xcd0
  __alloc_pages+0x1df/0x210
  new_slab+0x389/0x4d0
  ___slab_alloc+0x58f/0x770
  __slab_alloc.constprop.0+0x4a/0x80
  kmem_cache_alloc_trace+0x24b/0x2c0
  sr_probe+0x1db/0x620
  ......
  device_add+0x405/0x920
  ......
  __scsi_add_device+0xe5/0x100
  ata_scsi_scan_host+0x97/0x1d0
  async_run_entry_fn+0x30/0x130
  process_one_work+0x1e8/0x3c0
  worker_thread+0x50/0x3b0
  ? rescuer_thread+0x350/0x350
  kthread+0x16b/0x190
  ? set_kthread_struct+0x40/0x40
  ret_from_fork+0x22/0x30
  </TASK>
 Mem-Info:
 ......

The above failure happened when calling kmalloc() to allocate buffer with
GFP_DMA. It requests to allocate slab page from DMA zone while no managed
pages at all in there.
 sr_probe()
 --> get_capabilities()
     --> buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);

Because in the current kernel, dma-kmalloc will be created as long as
CONFIG_ZONE_DMA is enabled. However, kdump kernel of x86_64 doesn't have
managed pages on DMA zone since commit 6f599d84231f ("x86/kdump: Always
reserve the low 1M when the crashkernel option is specified"). The failure
can be always reproduced.

For now, let's mute the warning of allocation failure if requesting pages
from DMA zone while no managed pages.

Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
Cc: stable@vger.kernel.org
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7c7a0b5de2ff..843bc8e5550a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4204,7 +4204,8 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	va_list args;
 	static DEFINE_RATELIMIT_STATE(nopage_rs, 10*HZ, 1);
 
-	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs))
+	if ((gfp_mask & __GFP_NOWARN) || !__ratelimit(&nopage_rs) ||
+		(gfp_mask & __GFP_DMA) && !has_managed_dma())
 		return;
 
 	va_start(args, fmt);
-- 
2.26.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
