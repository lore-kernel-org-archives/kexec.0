Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt6HG-007hmC-WB
 for kexec@lists.infradead.org; Tue, 15 Jun 2021 10:26:48 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AEA01850612
 for <kexec@lists.infradead.org>; Tue, 15 Jun 2021 10:26:40 +0000 (UTC)
From: Coiby Xu <coxu@redhat.com>
Subject: [MAKEDUMPFILE PATCH] makedumpfile: elf_info: check for invalid
 physical address when finding max_paddr
Date: Tue, 15 Jun 2021 18:26:31 +0800
Message-Id: <20210615102631.63775-1-coxu@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Xiaoying Yan <yiyan@redhat.com>

Kernel commit 464920104bf7adac12722035bfefb3d772eb04d8
"/proc/kcore: update physical address for kcore ram and text" sets an
invalid paddr (-1=0xffffffffffffffff) for PT_LOAD segments of not direct
mapped regions,
    $ readelf -l /proc/kcore

    Elf file type is CORE (Core file)
    Entry point 0x0
    There are 4 program headers, starting at offset 64

    Program Headers:
      Type           Offset             VirtAddr           PhysAddr
                     FileSiz            MemSiz              Flags  Align
      NOTE           0x0000000000000120 0x0000000000000000 0x0000000000000000
                     0x0000000000002320 0x0000000000000000         0x0
      LOAD           0x1000000000010000 0xd000000000000000 0xffffffffffffffff
                                                           ^^^^^^^^^^^^^^^^^^
                     0x0001f80000000000 0x0001f80000000000  RWE    0x10000
      LOAD           0x0000000000010000 0xc000000000000000 0x0000000000000000
                     0x00000003f0000000 0x00000003f0000000  RWE    0x10000
      LOAD           0x3000000000010000 0xf000000000000000 0xffffffffffffffff
                                                           ^^^^^^^^^^^^^^^^^^
                     0x0000000000fc0000 0x0000000000fc0000  RWE    0x10000

makedumple uses max_paddr to calculate the number of sections for sparse
memory model thus wrong number is obtained based on max_paddr=-1. This
error could lead to the failure of copying /proc/kcore for RHEL-8.5 on
ppc64le machine [1],
    $ uname -r
    4.18.0-312.el8.ppc64le
    $ makedumpfile /proc/kcore vmcore1
    get_mem_section: Could not validate mem_section.
    get_mm_sparsemem: Can't get the address of mem_section.

    makedumpfile Failed.

Let's check if the phys_start of the segment is a valid physical address
to fix this problem.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1965267

Reported-by: Xiaoying Yan <yiyan@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 elf_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/elf_info.c b/elf_info.c
index e8affb7..9444847 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -628,7 +628,7 @@ get_max_paddr(void)
 
 	for (i = 0; i < num_pt_loads; i++) {
 		pls = &pt_loads[i];
-		if (max_paddr < pls->phys_end)
+		if (pls->phys_start != NOT_PADDR  && max_paddr < pls->phys_end)
 			max_paddr = pls->phys_end;
 	}
 	return max_paddr;
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
