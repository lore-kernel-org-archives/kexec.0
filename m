Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tge3R-0004Wc-VE
 for kexec@lists.infradead.org; Thu, 06 Dec 2012 16:12:07 +0000
Received: by mail-pa0-f49.google.com with SMTP id bi1so4037897pad.36
 for <kexec@lists.infradead.org>; Thu, 06 Dec 2012 08:12:05 -0800 (PST)
From: Joonsoo Kim <js1304@gmail.com>
Subject: [RFC PATCH 4/8] mm, vmalloc: iterate vmap_area_list,
 instead of vmlist in vread/vwrite()
Date: Fri,  7 Dec 2012 01:09:31 +0900
Message-Id: <1354810175-4338-5-git-send-email-js1304@gmail.com>
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

Now, when we hold a vmap_area_lock, va->vm can't be discarded. So we can
safely access to va->vm when iterating a vmap_area_list with holding a
vmap_area_lock. With this property, change iterating vmlist codes in
vread/vwrite() to iterating vmap_area_list.

There is a little difference relate to lock, because vmlist_lock is mutex,
but, vmap_area_lock is spin_lock. It may introduce a spinning overhead
during vread/vwrite() is executing. But, these are debug-oriented
functions, so this overhead is not real problem for common case.

Signed-off-by: Joonsoo Kim <js1304@gmail.com>

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a0b85a6..d21167f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2009,7 +2009,8 @@ static int aligned_vwrite(char *buf, char *addr, unsigned long count)
 
 long vread(char *buf, char *addr, unsigned long count)
 {
-	struct vm_struct *tmp;
+	struct vmap_area *va;
+	struct vm_struct *vm;
 	char *vaddr, *buf_start = buf;
 	unsigned long buflen = count;
 	unsigned long n;
@@ -2018,10 +2019,17 @@ long vread(char *buf, char *addr, unsigned long count)
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;
 
-	read_lock(&vmlist_lock);
-	for (tmp = vmlist; count && tmp; tmp = tmp->next) {
-		vaddr = (char *) tmp->addr;
-		if (addr >= vaddr + tmp->size - PAGE_SIZE)
+	spin_lock(&vmap_area_lock);
+	list_for_each_entry(va, &vmap_area_list, list) {
+		if (!count)
+			break;
+
+		if (!(va->flags & VM_VM_AREA))
+			continue;
+
+		vm = va->vm;
+		vaddr = (char *) vm->addr;
+		if (addr >= vaddr + vm->size - PAGE_SIZE)
 			continue;
 		while (addr < vaddr) {
 			if (count == 0)
@@ -2031,10 +2039,10 @@ long vread(char *buf, char *addr, unsigned long count)
 			addr++;
 			count--;
 		}
-		n = vaddr + tmp->size - PAGE_SIZE - addr;
+		n = vaddr + vm->size - PAGE_SIZE - addr;
 		if (n > count)
 			n = count;
-		if (!(tmp->flags & VM_IOREMAP))
+		if (!(vm->flags & VM_IOREMAP))
 			aligned_vread(buf, addr, n);
 		else /* IOREMAP area is treated as memory hole */
 			memset(buf, 0, n);
@@ -2043,7 +2051,7 @@ long vread(char *buf, char *addr, unsigned long count)
 		count -= n;
 	}
 finished:
-	read_unlock(&vmlist_lock);
+	spin_unlock(&vmap_area_lock);
 
 	if (buf == buf_start)
 		return 0;
@@ -2082,7 +2090,8 @@ finished:
 
 long vwrite(char *buf, char *addr, unsigned long count)
 {
-	struct vm_struct *tmp;
+	struct vmap_area *va;
+	struct vm_struct *vm;
 	char *vaddr;
 	unsigned long n, buflen;
 	int copied = 0;
@@ -2092,10 +2101,17 @@ long vwrite(char *buf, char *addr, unsigned long count)
 		count = -(unsigned long) addr;
 	buflen = count;
 
-	read_lock(&vmlist_lock);
-	for (tmp = vmlist; count && tmp; tmp = tmp->next) {
-		vaddr = (char *) tmp->addr;
-		if (addr >= vaddr + tmp->size - PAGE_SIZE)
+	spin_lock(&vmap_area_lock);
+	list_for_each_entry(va, &vmap_area_list, list) {
+		if (!count)
+			break;
+
+		if (!(va->flags & VM_VM_AREA))
+			continue;
+
+		vm = va->vm;
+		vaddr = (char *) vm->addr;
+		if (addr >= vaddr + vm->size - PAGE_SIZE)
 			continue;
 		while (addr < vaddr) {
 			if (count == 0)
@@ -2104,10 +2120,10 @@ long vwrite(char *buf, char *addr, unsigned long count)
 			addr++;
 			count--;
 		}
-		n = vaddr + tmp->size - PAGE_SIZE - addr;
+		n = vaddr + vm->size - PAGE_SIZE - addr;
 		if (n > count)
 			n = count;
-		if (!(tmp->flags & VM_IOREMAP)) {
+		if (!(vm->flags & VM_IOREMAP)) {
 			aligned_vwrite(buf, addr, n);
 			copied++;
 		}
@@ -2116,7 +2132,7 @@ long vwrite(char *buf, char *addr, unsigned long count)
 		count -= n;
 	}
 finished:
-	read_unlock(&vmlist_lock);
+	spin_unlock(&vmap_area_lock);
 	if (!copied)
 		return 0;
 	return buflen;
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
