Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tge3U-0004Wc-Pd
 for kexec@lists.infradead.org; Thu, 06 Dec 2012 16:12:09 +0000
Received: by mail-pa0-f49.google.com with SMTP id bi1so4037897pad.36
 for <kexec@lists.infradead.org>; Thu, 06 Dec 2012 08:12:08 -0800 (PST)
From: Joonsoo Kim <js1304@gmail.com>
Subject: [RFC PATCH 5/8] mm,
 vmalloc: iterate vmap_area_list in get_vmalloc_info()
Date: Fri,  7 Dec 2012 01:09:32 +0900
Message-Id: <1354810175-4338-6-git-send-email-js1304@gmail.com>
In-Reply-To: <1354810175-4338-1-git-send-email-js1304@gmail.com>
References: <1354810175-4338-1-git-send-email-js1304@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Joonsoo Kim <js1304@gmail.com>, linux-mm@kvack.org

This patch is preparing step for removing vmlist entirely.
For above purpose, we change iterating a vmap_list codes to iterating a
vmap_area_list. It is somewhat trivial change, but just one thing
should be noticed.

vmlist is lack of information about some areas in vmalloc address space.
For example, vm_map_ram() allocate area in vmalloc address space,
but it doesn't make a link with vmlist. To provide full information about
vmalloc address space is better idea, so we don't use va->vm and use
vmap_area directly.
This makes get_vmalloc_info() more precise.

Signed-off-by: Joonsoo Kim <js1304@gmail.com>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d21167f..f7f4a35 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2668,46 +2668,47 @@ module_init(proc_vmalloc_init);
 
 void get_vmalloc_info(struct vmalloc_info *vmi)
 {
-	struct vm_struct *vma;
+	struct vmap_area *va;
 	unsigned long free_area_size;
 	unsigned long prev_end;
 
 	vmi->used = 0;
+	vmi->largest_chunk = 0;
 
-	if (!vmlist) {
-		vmi->largest_chunk = VMALLOC_TOTAL;
-	} else {
-		vmi->largest_chunk = 0;
+	prev_end = VMALLOC_START;
 
-		prev_end = VMALLOC_START;
+	spin_lock(&vmap_area_lock);
 
-		read_lock(&vmlist_lock);
+	if (list_empty(&vmap_area_list)) {
+		vmi->largest_chunk = VMALLOC_TOTAL;
+		goto out;
+	}
 
-		for (vma = vmlist; vma; vma = vma->next) {
-			unsigned long addr = (unsigned long) vma->addr;
+	list_for_each_entry(va, &vmap_area_list, list) {
+		unsigned long addr = va->va_start;
 
-			/*
-			 * Some archs keep another range for modules in vmlist
-			 */
-			if (addr < VMALLOC_START)
-				continue;
-			if (addr >= VMALLOC_END)
-				break;
+		/*
+		 * Some archs keep another range for modules in vmalloc space
+		 */
+		if (addr < VMALLOC_START)
+			continue;
+		if (addr >= VMALLOC_END)
+			break;
 
-			vmi->used += vma->size;
+		vmi->used += (va->va_end - va->va_start);
 
-			free_area_size = addr - prev_end;
-			if (vmi->largest_chunk < free_area_size)
-				vmi->largest_chunk = free_area_size;
+		free_area_size = addr - prev_end;
+		if (vmi->largest_chunk < free_area_size)
+			vmi->largest_chunk = free_area_size;
 
-			prev_end = vma->size + addr;
-		}
+		prev_end = va->va_end;
+	}
 
-		if (VMALLOC_END - prev_end > vmi->largest_chunk)
-			vmi->largest_chunk = VMALLOC_END - prev_end;
+	if (VMALLOC_END - prev_end > vmi->largest_chunk)
+		vmi->largest_chunk = VMALLOC_END - prev_end;
 
-		read_unlock(&vmlist_lock);
-	}
+out:
+	spin_unlock(&vmap_area_lock);
 }
 #endif
 
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
