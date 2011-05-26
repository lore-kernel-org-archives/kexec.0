Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QPeHn-0002aT-II
	for kexec@lists.infradead.org; Thu, 26 May 2011 17:23:53 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p4QHMw2s009805
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 03:22:58 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4QHN0Cd692326
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 03:23:00 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4QHNPdb015799
	for <kexec@lists.infradead.org>; Fri, 27 May 2011 03:23:25 +1000
Date: Thu, 26 May 2011 22:53:05 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: [RFC Patch 5/6] slimdump: Capture slimdump for fatal MCE generated
	crashes
Message-ID: <20110526172305.GA18295@in.ibm.com>
References: <20110526170722.GB23266@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110526170722.GB23266@in.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>


slimdump: Capture slimdump for fatal MCE generated crashes

System crashes resulting from fatal hardware errors (such as MCE) don't need
all the contents from crashing-kernel's memory. Generate a new 'slimdump' that
retains only essential information while discarding the old memory.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c |  130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 2 deletions(-)

Index: linux-2.6.slim_kdump/fs/proc/vmcore.c
===================================================================
--- linux-2.6.slim_kdump.orig/fs/proc/vmcore.c
+++ linux-2.6.slim_kdump/fs/proc/vmcore.c
@@ -483,9 +483,60 @@ static void __init set_vmcore_list_offse
 	}
 }
 
+/*
+ * Check if the crash was due to a fatal Memory Check Exception
+ */
+static int is_mce_crash64(void)
+{
+	int i, j, len = 0, rc;
+	Elf64_Ehdr *ehdr_ptr;
+	Elf64_Phdr *phdr_ptr;
+	Elf64_Nhdr *nhdr_ptr;
+
+	ehdr_ptr = (Elf64_Ehdr *)elfcorebuf;
+	phdr_ptr = (Elf64_Phdr *)(elfcorebuf + sizeof(Elf64_Ehdr));
+
+	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
+		void *notes_section;
+		u64 offset, max_sz;
+		if (phdr_ptr->p_type != PT_NOTE)
+			continue;
+		max_sz = phdr_ptr->p_memsz;
+		offset = phdr_ptr->p_offset;
+		notes_section = kmalloc(max_sz, GFP_KERNEL);
+		if (!notes_section)
+			return -ENOMEM;
+		rc = read_from_oldmem(notes_section, max_sz, &offset, 0);
+		if (rc < 0) {
+			kfree(notes_section);
+			return rc;
+		}
+
+		for (j = 0; j < phdr_ptr->p_filesz; j += len) {
+			nhdr_ptr = notes_section + j;
+			if (nhdr_ptr->n_type == NT_MCE)
+			{
+				kfree(notes_section);
+				return 1;
+			}
+			/*
+			 * The elf-64 standard specifies 8-byte alignment while
+			 * append_elf_note function does only 4-byte roundup.
+			 * Hence this code also does a 4-byte roundup.
+			 */
+			len = sizeof(Elf64_Nhdr);
+			len = roundup(len + nhdr_ptr->n_namesz, 4);
+			len = roundup(len + nhdr_ptr->n_descsz, 4);
+		}
+		kfree(notes_section);
+	}
+	return 0;
+}
+
 static int __init parse_crash_elf64_headers(void)
 {
-	int rc=0;
+	int i, rc = 0;
+	Elf64_Phdr *phdr_ptr;
 	Elf64_Ehdr ehdr;
 	u64 addr;
 
@@ -523,6 +574,18 @@ static int __init parse_crash_elf64_head
 		return rc;
 	}
 
+	phdr_ptr = (Elf64_Phdr *)(elfcorebuf + sizeof(Elf64_Ehdr));
+	if (is_mce_crash64() > 0) {
+		/*
+		 * If crash is due to Machine Check exception, don't populate
+		 * sections other than elf-notes. Mark their sizes as zero.
+		 */
+		for (i = 0; i < ehdr.e_phnum; i++, phdr_ptr++) {
+			if (phdr_ptr->p_type != PT_NOTE)
+				phdr_ptr->p_memsz = phdr_ptr->p_filesz = 0;
+		}
+	}
+
 	/* Merge all PT_NOTE headers into one. */
 	rc = merge_note_headers_elf64(elfcorebuf, &elfcorebuf_sz, &vmcore_list);
 	if (rc) {
@@ -539,9 +602,60 @@ static int __init parse_crash_elf64_head
 	return 0;
 }
 
+/*
+ * Check if the crash was due to a fatal Memory Check Exception
+ */
+static int is_mce_crash32(void)
+{
+	int i, j, len = 0, rc;
+	Elf32_Ehdr *ehdr_ptr;
+	Elf32_Phdr *phdr_ptr;
+	Elf32_Nhdr *nhdr_ptr;
+
+	ehdr_ptr = (Elf32_Ehdr *)elfcorebuf;
+	phdr_ptr = (Elf32_Phdr *)(elfcorebuf + sizeof(Elf32_Ehdr));
+
+	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
+		void *notes_section;
+		u64 offset, max_sz;
+		if (phdr_ptr->p_type != PT_NOTE)
+			continue;
+		max_sz = phdr_ptr->p_memsz;
+		offset = phdr_ptr->p_offset;
+		notes_section = kmalloc(max_sz, GFP_KERNEL);
+		if (!notes_section)
+			return -ENOMEM;
+		rc = read_from_oldmem(notes_section, max_sz, &offset, 0);
+		if (rc < 0) {
+			kfree(notes_section);
+			return rc;
+		}
+
+		for (j = 0; j < phdr_ptr->p_filesz; j += len) {
+			nhdr_ptr = notes_section + j;
+			if (nhdr_ptr->n_type == NT_MCE)
+			{
+				kfree(notes_section);
+				return 1;
+			}
+			/*
+			 * The elf-64 standard specifies 8-byte alignment while
+			 * append_elf_note function does only 4-byte roundup.
+			 * Hence this code also does a 4-byte roundup.
+			 */
+			len = sizeof(Elf64_Nhdr);
+			len = roundup(len + nhdr_ptr->n_namesz, 4);
+			len = roundup(len + nhdr_ptr->n_descsz, 4);
+		}
+		kfree(notes_section);
+	}
+	return 0;
+}
+
 static int __init parse_crash_elf32_headers(void)
 {
-	int rc=0;
+	int i, rc = 0;
+	Elf32_Phdr *phdr_ptr;
 	Elf32_Ehdr ehdr;
 	u64 addr;
 
@@ -579,6 +693,18 @@ static int __init parse_crash_elf32_head
 		return rc;
 	}
 
+	phdr_ptr = (Elf32_Phdr *)(elfcorebuf + sizeof(Elf32_Ehdr));
+	if (is_mce_crash32() > 0) {
+		/*
+		 * If crash is due to Machine Check exception, don't populate
+		 * sections other than elf-notes. Mark their sizes as zero.
+		 */
+		for (i = 0; i < ehdr.e_phnum; i++, phdr_ptr++) {
+			if (phdr_ptr->p_type != PT_NOTE)
+				phdr_ptr->p_memsz = phdr_ptr->p_filesz = 0;
+		}
+	}
+
 	/* Merge all PT_NOTE headers into one. */
 	rc = merge_note_headers_elf32(elfcorebuf, &elfcorebuf_sz, &vmcore_list);
 	if (rc) {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
