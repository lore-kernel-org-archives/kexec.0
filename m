Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tge3O-0004XB-QP
 for kexec@lists.infradead.org; Thu, 06 Dec 2012 16:12:04 +0000
Received: by mail-pb0-f49.google.com with SMTP id un15so4075612pbc.36
 for <kexec@lists.infradead.org>; Thu, 06 Dec 2012 08:12:02 -0800 (PST)
From: Joonsoo Kim <js1304@gmail.com>
Subject: [RFC PATCH 3/8] mm, vmalloc: protect va->vm by vmap_area_lock
Date: Fri,  7 Dec 2012 01:09:30 +0900
Message-Id: <1354810175-4338-4-git-send-email-js1304@gmail.com>
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

Inserting and removing an entry to vmlist is linear time complexity, so
it is inefficient. Following patches will try to remove vmlist entirely.
This patch is preparing step for it.

For removing vmlist, iterating vmlist codes should be changed to iterating
a vmap_area_list. Before implementing that, we should make sure that
when we iterate a vmap_area_list, accessing to va->vm doesn't cause a race
condition. This patch ensure that when iterating a vmap_area_list,
there is no race condition for accessing to vm_struct.

Signed-off-by: Joonsoo Kim <js1304@gmail.com>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 16147bc..a0b85a6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1290,12 +1290,14 @@ struct vm_struct *vmlist;
 static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
 			      unsigned long flags, const void *caller)
 {
+	spin_lock(&vmap_area_lock);
 	vm->flags = flags;
 	vm->addr = (void *)va->va_start;
 	vm->size = va->va_end - va->va_start;
 	vm->caller = caller;
 	va->vm = vm;
 	va->flags |= VM_VM_AREA;
+	spin_unlock(&vmap_area_lock);
 }
 
 static void insert_vmalloc_vmlist(struct vm_struct *vm)
@@ -1446,6 +1448,11 @@ struct vm_struct *remove_vm_area(const void *addr)
 	if (va && va->flags & VM_VM_AREA) {
 		struct vm_struct *vm = va->vm;
 
+		spin_lock(&vmap_area_lock);
+		va->vm = NULL;
+		va->flags &= ~VM_VM_AREA;
+		spin_unlock(&vmap_area_lock);
+
 		if (!(vm->flags & VM_UNLIST)) {
 			struct vm_struct *tmp, **p;
 			/*
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
