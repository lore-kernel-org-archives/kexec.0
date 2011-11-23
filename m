Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RT1Q4-000848-ST
 for kexec@lists.infradead.org; Wed, 23 Nov 2011 01:14:37 +0000
Received: by iapp10 with SMTP id p10so1085878iap.36
 for <kexec@lists.infradead.org>; Tue, 22 Nov 2011 17:14:34 -0800 (PST)
Date: Tue, 22 Nov 2011 17:14:31 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: [patch v2 for-3.2] block: initialize request_queue's numa node during
 allocation
In-Reply-To: <20111122220218.GA17543@redhat.com>
Message-ID: <alpine.DEB.2.00.1111221703590.18644@chino.kir.corp.google.com>
References: <4ECB5C80.8080609@redhat.com>
 <alpine.DEB.2.00.1111220140470.4306@chino.kir.corp.google.com>
 <20111122152739.GA5663@redhat.com> <20111122211954.GA17120@redhat.com>
 <alpine.DEB.2.00.1111221342320.2621@chino.kir.corp.google.com>
 <20111122220218.GA17543@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

From: Mike Snitzer <snitzer@redhat.com>

struct request_queue is allocated with __GFP_ZERO so its "node" field is 
zero before initialization.  This causes an oops if node 0 is offline in 
the page allocator because its zonelists are not initialized.  From Dave 
Young's dmesg:

	SRAT: Node 1 PXM 2 0-d0000000
	SRAT: Node 1 PXM 2 100000000-330000000
	SRAT: Node 0 PXM 1 330000000-630000000
	Initmem setup node 1 0000000000000000-000000000affb000
	...
	Built 1 zonelists in Node order, mobility grouping on.
	...
	BUG: unable to handle kernel paging request at 0000000000001c08
	IP: [<ffffffff8111c355>] __alloc_pages_nodemask+0xb5/0x870

and __alloc_pages_nodemask+0xb5 translates to a NULL pointer on 
zonelist->_zonerefs.

The fix is to initialize q->node at the time of allocation so the correct 
node is passed to the slab allocator later.

Since blk_init_allocated_queue_node() is no longer needed, merge it with 
blk_init_allocated_queue().

[rientjes@google.com: changelog, initializing q->node]
Cc: stable@vger.kernel.org [2.6.37+]
Reported-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 block/blk-core.c       |   14 +++-----------
 include/linux/blkdev.h |    3 ---
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -467,6 +467,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id)
 	q->backing_dev_info.state = 0;
 	q->backing_dev_info.capabilities = BDI_CAP_MAP_COPY;
 	q->backing_dev_info.name = "block";
+	q->node = node_id;
 
 	err = bdi_init(&q->backing_dev_info);
 	if (err) {
@@ -551,7 +552,7 @@ blk_init_queue_node(request_fn_proc *rfn, spinlock_t *lock, int node_id)
 	if (!uninit_q)
 		return NULL;
 
-	q = blk_init_allocated_queue_node(uninit_q, rfn, lock, node_id);
+	q = blk_init_allocated_queue(uninit_q, rfn, lock);
 	if (!q)
 		blk_cleanup_queue(uninit_q);
 
@@ -563,18 +564,9 @@ struct request_queue *
 blk_init_allocated_queue(struct request_queue *q, request_fn_proc *rfn,
 			 spinlock_t *lock)
 {
-	return blk_init_allocated_queue_node(q, rfn, lock, -1);
-}
-EXPORT_SYMBOL(blk_init_allocated_queue);
-
-struct request_queue *
-blk_init_allocated_queue_node(struct request_queue *q, request_fn_proc *rfn,
-			      spinlock_t *lock, int node_id)
-{
 	if (!q)
 		return NULL;
 
-	q->node = node_id;
 	if (blk_init_free_list(q))
 		return NULL;
 
@@ -604,7 +596,7 @@ blk_init_allocated_queue_node(struct request_queue *q, request_fn_proc *rfn,
 
 	return NULL;
 }
-EXPORT_SYMBOL(blk_init_allocated_queue_node);
+EXPORT_SYMBOL(blk_init_allocated_queue);
 
 int blk_get_queue(struct request_queue *q)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -805,9 +805,6 @@ extern void blk_unprep_request(struct request *);
  */
 extern struct request_queue *blk_init_queue_node(request_fn_proc *rfn,
 					spinlock_t *lock, int node_id);
-extern struct request_queue *blk_init_allocated_queue_node(struct request_queue *,
-							   request_fn_proc *,
-							   spinlock_t *, int node_id);
 extern struct request_queue *blk_init_queue(request_fn_proc *, spinlock_t *);
 extern struct request_queue *blk_init_allocated_queue(struct request_queue *,
 						      request_fn_proc *, spinlock_t *);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
