Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH2n9-0000ad-A1
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 06:11:52 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH 2/2] [fs] proc/vmcore: check the dummy place holder for
 offline cpu to avoid warning
Date: Wed, 14 Dec 2016 14:11:27 +0800
Message-Id: <1481695887-21090-2-git-send-email-piliu@redhat.com>
In-Reply-To: <1481695887-21090-1-git-send-email-piliu@redhat.com>
References: <1481695887-21090-1-git-send-email-piliu@redhat.com>
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
Cc: Dave Young <dyoung@redhat.com>, kernelfans@gmail.com, Baoquan He <bhe@redhat.com>

kexec-tools always allocates program headers for possible cpus. But
when crashing, offline cpus have dummy headers. We do not copy these
dummy notes into ELF file, also have no need of warning on them.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 fs/proc/vmcore.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 8ab782d..bbc9dad 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -526,9 +526,10 @@ static u64 __init get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
  */
 static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 {
-	int i, rc=0;
+	int i, j, rc = 0;
 	Elf64_Phdr *phdr_ptr;
 	Elf64_Nhdr *nhdr_ptr;
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
@@ -547,7 +549,7 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 			return rc;
 		}
 		nhdr_ptr = notes_section;
-		while (nhdr_ptr->n_namesz != 0) {
+		for (j = 0; nhdr_ptr->n_namesz != 0; j++) {
 			sz = sizeof(Elf64_Nhdr) +
 				(((u64)nhdr_ptr->n_namesz + 3) & ~3) +
 				(((u64)nhdr_ptr->n_descsz + 3) & ~3);
@@ -559,11 +561,22 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
 			real_sz += sz;
 			nhdr_ptr = (Elf64_Nhdr*)((char*)nhdr_ptr + sz);
 		}
+		if (real_sz != 0)
+			warn = false;
+		if (j == 1) {
+			nhdr_ptr = notes_section;
+			if ((nhdr_ptr->n_type == NT_DUMMY)
+			  && !strncmp(KEXEC_CORE_NOTE_NAME,
+				(char *)nhdr_ptr + sizeof(Elf64_Nhdr),
+				strlen(KEXEC_CORE_NOTE_NAME))) {
+				/* do not copy this dummy note */
+				real_sz = 0;
+			}
+		}
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
