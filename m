Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lgemrelse1q.lge.com ([156.147.1.111])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFfFR-0004di-ES
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 06:33:14 +0000
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 3/8] mm, vmalloc: protect va->vm by vmap_area_lock
Date: Wed, 13 Mar 2013 15:32:55 +0900
Message-Id: <1363156381-2881-4-git-send-email-iamjoonsoo.kim@lge.com>
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

Inserting and removing an entry to vmlist is linear time complexity, so
it is inefficient. Following patches will try to remove vmlist entirely.
This patch is preparing step for it.

For removing vmlist, iterating vmlist codes should be changed to iterating
a vmap_area_list. Before implementing that, we should make sure that
when we iterate a vmap_area_list, accessing to va->vm doesn't cause a race
condition. This patch ensure that when iterating a vmap_area_list,
there is no race condition for accessing to vm_struct.

Signed-off-by: Joonsoo Kim <js1304@gmail.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1d9878b..1bf94ad 100644
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
@@ -1447,6 +1449,11 @@ struct vm_struct *remove_vm_area(const void *addr)
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
