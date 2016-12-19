Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cInO4-0003dq-Qq
 for kexec@lists.infradead.org; Mon, 19 Dec 2016 02:09:14 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCHv2 2/2] [fs] proc/vmcore: check the dummy place holder for
 offline cpu to avoid warning
Date: Mon, 19 Dec 2016 10:08:47 +0800
Message-Id: <1482113327-19103-2-git-send-email-piliu@redhat.com>
In-Reply-To: <1482113327-19103-1-git-send-email-piliu@redhat.com>
References: <1482113327-19103-1-git-send-email-piliu@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Xunlei Pang <xpang@redhat.com>, Dave Young <dyoung@redhat.com>, kernelfans@gmail.com, Baoquan He <bhe@redhat.com>

kexec-tools always allocates program headers for present cpus. But
when crashing, offline cpus have dummy headers. We do not copy these
dummy notes into ELF file, also have no need of warning on them.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 fs/proc/vmcore.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 8ab782d..fc6e352 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -526,9 +526,10 @@ static u64 __init get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
  */
 static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 {
-	int i, rc=0;
+	int i, j, rc = 0;
 	Elf64_Phdr *phdr_ptr;
-	Elf64_Nhdr *nhdr_ptr;
+	Elf64_Nhdr *nhdr_ptr, *prev_ptr;
+	bool warn;
 
 	phdr_ptr = (Elf64_Phdr *)(ehdr_ptr + 1);
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
@@ -536,6 +537,7 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 		u64 offset, max_sz, sz, real_sz = 0;
 		if (phdr_ptr->p_type != PT_NOTE)
 			continue;
+		warn = true;
 		max_sz = phdr_ptr->p_memsz;
 		offset = phdr_ptr->p_offset;
 		notes_section = kmalloc(max_sz, GFP_KERNEL);
@@ -556,14 +558,27 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 					nhdr_ptr->n_namesz, nhdr_ptr->n_descsz);
 				break;
 			}
+			prev_ptr = nhdr_ptr;
 			real_sz += sz;
 			nhdr_ptr = (Elf64_Nhdr*)((char*)nhdr_ptr + sz);
+			if ((prev_ptr->n_type == NT_DUMMY)
+			  && !strncmp(KEXEC_CORE_NOTE_NAME,
+				(char *)prev_ptr + sizeof(Elf64_Nhdr),
+				strlen(KEXEC_CORE_NOTE_NAME))) {
+				if (nhdr_ptr->n_namesz == 0) {
+					/* do not copy this dummy note */
+					real_sz = 0;
+					warn = false;
+				} else
+					pr_warn("Warning: Dummy PT_NOTE not overwritten\n");
+			}
 		}
+		if (real_sz != 0)
+			warn = false;
 		kfree(notes_section);
 		phdr_ptr->p_memsz = real_sz;
-		if (real_sz == 0) {
+		if (warn)
 			pr_warn("Warning: Zero PT_NOTE entries found\n");
-		}
 	}
 
 	return 0;
@@ -712,9 +727,10 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
  */
 static int __init update_note_header_size_elf32(const Elf32_Ehdr *ehdr_ptr)
 {
-	int i, rc=0;
+	int i, j, rc = 0;
 	Elf32_Phdr *phdr_ptr;
-	Elf32_Nhdr *nhdr_ptr;
+	Elf32_Nhdr *nhdr_ptr, *prev_ptr;
+	bool warn;
 
 	phdr_ptr = (Elf32_Phdr *)(ehdr_ptr + 1);
 	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
@@ -722,6 +738,7 @@ static int __init update_note_header_size_elf32(const Elf32_Ehdr *ehdr_ptr)
 		u64 offset, max_sz, sz, real_sz = 0;
 		if (phdr_ptr->p_type != PT_NOTE)
 			continue;
+		warn = true;
 		max_sz = phdr_ptr->p_memsz;
 		offset = phdr_ptr->p_offset;
 		notes_section = kmalloc(max_sz, GFP_KERNEL);
@@ -742,14 +759,27 @@ static int __init update_note_header_size_elf32(const Elf32_Ehdr *ehdr_ptr)
 					nhdr_ptr->n_namesz, nhdr_ptr->n_descsz);
 				break;
 			}
+			prev_ptr = nhdr_ptr;
 			real_sz += sz;
 			nhdr_ptr = (Elf32_Nhdr*)((char*)nhdr_ptr + sz);
+			if ((prev_ptr->n_type == NT_DUMMY)
+			  && !strncmp(KEXEC_CORE_NOTE_NAME,
+				(char *)prev_ptr + sizeof(Elf32_Nhdr),
+				strlen(KEXEC_CORE_NOTE_NAME))) {
+				if (nhdr_ptr->n_namesz == 0) {
+					/* do not copy this dummy note */
+					real_sz = 0;
+					warn = false;
+				} else
+					pr_warn("Warning: Dummy PT_NOTE not overwritten\n");
+			}
 		}
+		if (real_sz != 0)
+			warn = false;
 		kfree(notes_section);
 		phdr_ptr->p_memsz = real_sz;
-		if (real_sz == 0) {
+		if (warn)
 			pr_warn("Warning: Zero PT_NOTE entries found\n");
-		}
 	}
 
 	return 0;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
