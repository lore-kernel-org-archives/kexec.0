Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lgemrelse1q.lge.com ([156.147.1.111])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFfFT-0004di-To
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 06:33:19 +0000
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 6/8] mm, vmalloc: iterate vmap_area_list, instead of vmlist,
 in vmallocinfo()
Date: Wed, 13 Mar 2013 15:32:58 +0900
Message-Id: <1363156381-2881-7-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1363156381-2881-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1363156381-2881-1-git-send-email-iamjoonsoo.kim@lge.com>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bob Liu <lliubbo@gmail.com>, Joonsoo Kim <js1304@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Dave Anderson <anderson@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vivek Goyal <vgoyal@redhat.com>

From: Joonsoo Kim <js1304@gmail.com>

This patch is preparing step for removing vmlist entirely.
For above purpose, we change iterating a vmap_list codes to iterating a
vmap_area_list. It is somewhat trivial change, but just one thing
should be noticed.

Using vmap_area_list in vmallocinfo() introduce ordering problem in SMP
system. In s_show(), we retrieve some values from vm_struct. vm_struct's
values is not fully setup when va->vm is assigned. Full setup is notified
by removing VM_UNLIST flag without holding a lock. When we see that
VM_UNLIST is removed, it is not ensured that vm_struct has proper values
in view of other CPUs. So we need smp_[rw]mb for ensuring that proper
values is assigned when we see that VM_UNLIST is removed.

Therefore, this patch not only change a iteration list, but also add a
appropriate smp_[rw]mb to right places.

Signed-off-by: Joonsoo Kim <js1304@gmail.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index aee1f61..bda6cef 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1304,7 +1304,14 @@ static void insert_vmalloc_vmlist(struct vm_struct *vm)
 {
 	struct vm_struct *tmp, **p;
 
+	/*
+	 * Before removing VM_UNLIST,
+	 * we should make sure that vm has proper values.
+	 * Pair with smp_rmb() in show_numa_info().
+	 */
+	smp_wmb();
 	vm->flags &= ~VM_UNLIST;
+
 	write_lock(&vmlist_lock);
 	for (p = &vmlist; (tmp = *p) != NULL; p = &tmp->next) {
 		if (tmp->addr >= vm->addr)
@@ -2542,19 +2549,19 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
-	__acquires(&vmlist_lock)
+	__acquires(&vmap_area_lock)
 {
 	loff_t n = *pos;
-	struct vm_struct *v;
+	struct vmap_area *va;
 
-	read_lock(&vmlist_lock);
-	v = vmlist;
-	while (n > 0 && v) {
+	spin_lock(&vmap_area_lock);
+	va = list_entry((&vmap_area_list)->next, typeof(*va), list);
+	while (n > 0 && &va->list != &vmap_area_list) {
 		n--;
-		v = v->next;
+		va = list_entry(va->list.next, typeof(*va), list);
 	}
-	if (!n)
-		return v;
+	if (!n && &va->list != &vmap_area_list)
+		return va;
 
 	return NULL;
 
@@ -2562,16 +2569,20 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 
 static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	struct vm_struct *v = p;
+	struct vmap_area *va = p, *next;
 
 	++*pos;
-	return v->next;
+	next = list_entry(va->list.next, typeof(*va), list);
+	if (&next->list != &vmap_area_list)
+		return next;
+
+	return NULL;
 }
 
 static void s_stop(struct seq_file *m, void *p)
-	__releases(&vmlist_lock)
+	__releases(&vmap_area_lock)
 {
-	read_unlock(&vmlist_lock);
+	spin_unlock(&vmap_area_lock);
 }
 
 static void show_numa_info(struct seq_file *m, struct vm_struct *v)
@@ -2582,6 +2593,11 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v)
 		if (!counters)
 			return;
 
+		/* Pair with smp_wmb() in insert_vmalloc_vmlist() */
+		smp_rmb();
+		if (v->flags & VM_UNLIST)
+			return;
+
 		memset(counters, 0, nr_node_ids * sizeof(unsigned int));
 
 		for (nr = 0; nr < v->nr_pages; nr++)
@@ -2595,7 +2611,20 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v)
 
 static int s_show(struct seq_file *m, void *p)
 {
-	struct vm_struct *v = p;
+	struct vmap_area *va = p;
+	struct vm_struct *v;
+
+	if (va->flags & (VM_LAZY_FREE | VM_LAZY_FREEING))
+		return 0;
+
+	if (!(va->flags & VM_VM_AREA)) {
+		seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ram\n",
+			(void *)va->va_start, (void *)va->va_end,
+					va->va_end - va->va_start);
+		return 0;
+	}
+
+	v = va->vm;
 
 	seq_printf(m, "0x%pK-0x%pK %7ld",
 		v->addr, v->addr + v->size, v->size);
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
