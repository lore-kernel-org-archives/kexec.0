Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XpAqH-0000mK-Sh
 for kexec@lists.infradead.org; Fri, 14 Nov 2014 06:58:50 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAE6w8Tu015880
 for <kexec@lists.infradead.org>; Fri, 14 Nov 2014 14:58:08 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] makedumpfile: Add description of elf dump file
Date: Fri, 14 Nov 2014 14:55:00 +0800
Message-ID: <1415948101-25843-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

Add description of elf dump file in IMPLEMENTATION.

Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 IMPLEMENTATION |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/IMPLEMENTATION b/IMPLEMENTATION
index 2f4cfd6..0e5ad1f 100644
--- a/IMPLEMENTATION
+++ b/IMPLEMENTATION
@@ -112,3 +112,91 @@
         unsigned long long      page_flags;     /* page flags */
     } page_desc_t;
 
+
+* The ELF format
+  There are two different ELF format(ELF32, ELF64) for K-bit architectures (K=32,64).
+  Since they almost have the same behaviour in this situation, the following will use
+  ELF32 as a example.
+
+  - The file structure
+
+    +---------------------------------+
+    |  elf_header (struct elf32_hdr)  |
+    |---------------------------------+
+    |  PT_NOTE    (struct elf32_phdr) |
+    |---------------------------------+
+    |  PT_LOAD(1) (struct elf32_phdr) |
+    |  PT_LOAD(2) (struct elf32_phdr) |
+    |             :                   |
+    |  PT_LOAD(Z) (struct elf32_phdr) |
+    |---------------------------------+
+    |  NOTE                           |
+    |---------------------------------+
+    |  segment(1)                     |
+    |  segment(2)                     |
+    |          :                      |
+    |  segment(Z)                     |
+    +---------------------------------+
+
+  - elf_header
+    This header is almost the same as a normal elf_header. The difference is that the
+    e_flags is used for indicating whether the dump file is complete or not.
+    0x0 : complete,
+    0x1 : incomplete
+
+	typedef struct elf32_hdr{
+		unsigned char e_ident[EI_NIDENT];
+		Elf32_Half    e_type;
+		Elf32_Half    e_machine;
+		Elf32_Word    e_version;
+		Elf32_Addr    e_entry;
+		Elf32_Off     e_phoff;
+		Elf32_Off     e_shoff;
+		Elf32_Word    e_flags;
+		Elf32_Half    e_ehsize;
+		Elf32_Half    e_phentsize;
+		Elf32_Half    e_phnum;
+		Elf32_Half    e_shentsize;
+		Elf32_Half    e_shnum;
+		Elf32_Half    e_shstrndx;
+	} Elf32_Ehdr;
+
+  - PT_NOTE and PT_LOAD
+    PT_NOTE corresponds to NOTE and PT_LOAD to segment.
+    They present the corresponding NOTE and segments information.
+
+
+	typedef struct elf32_phdr{
+		Elf32_Word    p_type;
+		Elf32_Off     p_offset;
+		Elf32_Addr    p_vaddr;
+		Elf32_Addr    p_paddr;
+		Elf32_Word    p_filesz;
+		Elf32_Word    p_memsz;
+		Elf32_Word    p_flags;
+		Elf32_Word    p_align;
+	} Elf32_Phdr;
+
+  - note
+    The note structure
+
+    +------------------------------------+
+    |  note header 1 (struct elf32_note) |
+    |  note header 2 (struct elf32_note) |
+    |               :                    |
+    |  note header N (struct elf32_note) |
+    |------------------------------------+
+    |  note data 1                       |
+    |  note data 2                       |
+    |          :                         |
+    |  note data N                       |
+    +------------------------------------+
+   
+	typedef struct elf32_note {
+		Elf32_Word    n_namesz;       /* Name size */
+		Elf32_Word    n_descsz;       /* Content size */
+		Elf32_Word    n_type;         /* Content type */
+	} Elf32_Nhdr;
+    
+  - segments
+    The data dumped are all stored in segments and notes.
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
