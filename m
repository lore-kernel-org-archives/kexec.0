Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OvLtx-0002PD-0x
	for kexec@lists.infradead.org; Tue, 14 Sep 2010 03:09:46 +0000
Date: Mon, 13 Sep 2010 23:09:39 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <149379123.860951284433779554.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: kvm kdump regression
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
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: graff.yang@gmail.com, Marcelo Tosatti <mtosatti@redhat.com>, kexec <kexec@lists.infradead.org>, dhowells@redhat.com, sonic.adi@gmail.com, Avi Kivity <avi@redhat.com>, tj@kernel.org

This commit introduced a regression that an empty vmcore was generated on a kvm guest.
ioremap: invalid physical address db74000000000000
------------[ cut here ]------------
WARNING: at arch/x86/mm/ioremap.c:83 __ioremap_caller+0x307/0x380()
Hardware name: KVM
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.36-rc2-mm1+ #2
Call Trace:
 [<ffffffff8105f48f>] warn_slowpath_common+0x7f/0xc0
 [<ffffffff8103052e>] ? copy_oldmem_page+0x4e/0xc0
 [<ffffffff8105f4ea>] warn_slowpath_null+0x1a/0x20
 [<ffffffff8103f0a7>] __ioremap_caller+0x307/0x380
 [<ffffffff8103f1f7>] ioremap_nocache+0x17/0x20
 [<ffffffff8103052e>] copy_oldmem_page+0x4e/0xc0
 [<ffffffff811af4ca>] read_from_oldmem+0x7a/0xb0
 [<ffffffff81c4f70b>] merge_note_headers_elf64.clone.1+0x6c/0x21f
 [<ffffffff8103056e>] ? copy_oldmem_page+0x8e/0xc0
 [<ffffffff811af4ca>] ? read_from_oldmem+0x7a/0xb0
 [<ffffffff81c4fa5b>] vmcore_init+0x19d/0x396
 [<ffffffff81c4f8be>] ? vmcore_init+0x0/0x396
 [<ffffffff81002053>] do_one_initcall+0x43/0x190
 [<ffffffff81c278ab>] kernel_init+0x2a0/0x330
 [<ffffffff8100be84>] kernel_thread_helper+0x4/0x10
 [<ffffffff81c2760b>] ? kernel_init+0x0/0x330
 [<ffffffff8100be80>] ? kernel_thread_helper+0x0/0x10
---[ end trace 93d72a36b9146f22 ]---
Kdump: vmcore not initialized

commit 020ec6537aa65c18e9084c568d7b94727f2026fd
Author: Tejun Heo <tj@kernel.org>
Date:   Fri Apr 9 18:57:00 2010 +0900

    percpu: factor out pcpu_addr_in_first/reserved_chunk() and update per_cpu_ptr_to_phys()
    
    Factor out pcpu_addr_in_first/reserved_chunk() from
    pcpu_chunk_addr_search() and use it to update per_cpu_ptr_to_phys()
    such that it handles first chunk differently from the rest.
    
    This patch doesn't cause any functional change and is to prepare for
    percpu nommu support.
    
    Signed-off-by: Tejun Heo <tj@kernel.org>
    Reviewed-by: David Howells <dhowells@redhat.com>
    Cc: Graff Yang <graff.yang@gmail.com>
    Cc: Sonic Zhang <sonic.adi@gmail.com>

diff --git a/mm/percpu.c b/mm/percpu.c
index 6e09741..1aeb081 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -177,6 +177,21 @@ static struct list_head *pcpu_slot __read_mostly; /* chunk list slots */
 static void pcpu_reclaim(struct work_struct *work);
 static DECLARE_WORK(pcpu_reclaim_work, pcpu_reclaim);
 
+static bool pcpu_addr_in_first_chunk(void *addr)
+{
+	void *first_start = pcpu_first_chunk->base_addr;
+
+	return addr >= first_start && addr < first_start + pcpu_unit_size;
+}
+
+static bool pcpu_addr_in_reserved_chunk(void *addr)
+{
+	void *first_start = pcpu_first_chunk->base_addr;
+
+	return addr >= first_start &&
+		addr < first_start + pcpu_reserved_chunk_limit;
+}
+
 static int __pcpu_size_to_slot(int size)
 {
 	int highbit = fls(size);	/* size is in bytes */
@@ -334,12 +349,10 @@ static void pcpu_chunk_relocate(struct pcpu_chunk *chunk, int oslot)
  */
 static struct pcpu_chunk *pcpu_chunk_addr_search(void *addr)
 {
-	void *first_start = pcpu_first_chunk->base_addr;
-
 	/* is it in the first chunk? */
-	if (addr >= first_start && addr < first_start + pcpu_unit_size) {
+	if (pcpu_addr_in_first_chunk(addr)) {
 		/* is it in the reserved area? */
-		if (addr < first_start + pcpu_reserved_chunk_limit)
+		if (pcpu_addr_in_reserved_chunk(addr))
 			return pcpu_reserved_chunk;
 		return pcpu_first_chunk;
 	}
@@ -1343,10 +1356,13 @@ bool is_kernel_percpu_address(unsigned long addr)
  */
 phys_addr_t per_cpu_ptr_to_phys(void *addr)
 {
-	if ((unsigned long)addr < VMALLOC_START ||
-			(unsigned long)addr >= VMALLOC_END)
-		return __pa(addr);
-	else
+	if (pcpu_addr_in_first_chunk(addr)) {
+		if ((unsigned long)addr < VMALLOC_START ||
+		    (unsigned long)addr >= VMALLOC_END)
+			return __pa(addr);
+		else
+			return page_to_phys(vmalloc_to_page(addr));
+	} else
 		return page_to_phys(vmalloc_to_page(addr));
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
