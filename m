Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQ3Nm-000174-8f
 for kexec@lists.infradead.org; Wed, 07 Oct 2020 06:57:03 +0000
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 2/3] Cleanup: Remove unused elf_info.c functions
Date: Wed,  7 Oct 2020 08:56:51 +0200
Message-Id: <20201007065652.28160-3-ptesarik@suse.com>
In-Reply-To: <20201007065652.28160-1-ptesarik@suse.com>
References: <20201007065652.28160-1-ptesarik@suse.com>
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
To: Kazuhito Hagio <k-hagio-ab@nec.com>, kexec-ml <kexec@lists.infradead.org>
Cc: Petr Tesarik <ptesarik@suse.com>

These functions are unused and can be removed:

- page_head_to_phys_start
- page_head_to_phys_end
- offset_to_pt_load_start
- get_offset_pt_load_memory

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 elf_info.c | 66 ------------------------------------------------------
 elf_info.h |  4 ----
 2 files changed, 70 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index 7d72742..5ed65fc 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -502,66 +502,6 @@ paddr_to_offset2(unsigned long long paddr, off_t hint)
 	return offset;
 }
 
-unsigned long long
-page_head_to_phys_start(unsigned long long head_paddr)
-{
-	int i;
-	struct pt_load_segment *pls;
-
-	for (i = 0; i < num_pt_loads; i++) {
-		pls = &pt_loads[i];
-		if ((pls->phys_start <= head_paddr + info->page_size)
-		    && (head_paddr < pls->phys_end)) {
-			return (pls->phys_start > head_paddr) ?
-				pls->phys_start : head_paddr;
-		}
-	}
-
-	return 0;
-}
-
-unsigned long long
-page_head_to_phys_end(unsigned long long head_paddr)
-{
-	int i;
-	struct pt_load_segment *pls;
-
-	for (i = 0; i < num_pt_loads; i++) {
-		pls = &pt_loads[i];
-		if ((pls->phys_start <= head_paddr + info->page_size)
-		    && (head_paddr < pls->phys_end)) {
-			return (pls->phys_end < head_paddr + info->page_size) ?
-				pls->phys_end : head_paddr + info->page_size;
-		}
-	}
-
-	return 0;
-}
-
-/*
- *  Calculate a start File Offset of PT_LOAD from a File Offset
- *  of a page. If this function returns 0x0, the input page is
- *  not in the memory image.
- */
-off_t
-offset_to_pt_load_start(off_t offset)
-{
-	int i;
-	off_t pt_load_start;
-	struct pt_load_segment *pls;
-
-	for (i = pt_load_start = 0; i < num_pt_loads; i++) {
-		pls = &pt_loads[i];
-		if ((offset >= pls->file_offset)
-		    && (offset < pls->file_offset +
-			(pls->phys_end - pls->phys_start))) {
-			pt_load_start = pls->file_offset;
-			break;
-		}
-	}
-	return pt_load_start;
-}
-
 /*
  *  Calculate a end File Offset of PT_LOAD from a File Offset
  *  of a page. If this function returns 0x0, the input page is
@@ -1120,12 +1060,6 @@ get_phdr_memory(int index, Elf64_Phdr *phdr)
 	return TRUE;
 }
 
-off_t
-get_offset_pt_load_memory(void)
-{
-	return offset_pt_load_memory;
-}
-
 int
 get_pt_load(int idx,
 	unsigned long long *phys_start,
diff --git a/elf_info.h b/elf_info.h
index 934b608..d9b5d05 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -32,9 +32,6 @@ int get_elf32_phdr(int fd, char *filename, int index, Elf32_Phdr *phdr);
 
 off_t paddr_to_offset(unsigned long long paddr);
 off_t paddr_to_offset2(unsigned long long paddr, off_t hint);
-unsigned long long page_head_to_phys_start(unsigned long long head_paddr);
-unsigned long long page_head_to_phys_end(unsigned long long head_paddr);
-off_t offset_to_pt_load_start(off_t offset);
 off_t offset_to_pt_load_end(off_t offset);
 unsigned long long vaddr_to_paddr_general(unsigned long long vaddr);
 off_t vaddr_to_offset_slow(int fd, char *filename, unsigned long long vaddr);
@@ -57,7 +54,6 @@ int is_xen_memory(void);
 int get_elf64_phnum(int fd, char *filename, Elf64_Ehdr *ehdr, int *phnum);
 int get_phnum_memory(void);
 int get_phdr_memory(int index, Elf64_Phdr *phdr);
-off_t get_offset_pt_load_memory(void);
 int get_pt_load(int idx,
 	unsigned long long *phys_start,
 	unsigned long long *phys_end,
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
