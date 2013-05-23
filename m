Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ufahd-0005zr-Do
 for kexec@lists.infradead.org; Thu, 23 May 2013 18:57:32 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Thu, 23 May 2013 19:52:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id C08361B0805D
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 19:57:02 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4NIuquD37617878
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 18:56:52 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r4NIv2di019602
 for <kexec@lists.infradead.org>; Thu, 23 May 2013 14:57:02 -0400
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH v3 1/3] kdump: Introduce ELF header in new memory feature
Date: Thu, 23 May 2013 20:56:59 +0200
Message-Id: <1369335421-43058-2-git-send-email-holzheu@linux.vnet.ibm.com>
In-Reply-To: <1369335421-43058-1-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1369335421-43058-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently for s390 we create the ELF core header in the 2nd kernel
with a small trick. We relocate the addresses in the ELF header in
a way that for the /proc/vmcore code it seems to be in the 1st kernel
(old) memory and the read_from_oldmem() returns the correct data.
This allows the /proc/vmcore code to use the ELF header in the
2nd kernel.

This patch now exchanges the old mechanism with the new and much
cleaner function call override feature that now offcially allows to
create the ELF core header in the 2nd kernel.

To use the new feature the following has to be done by the architecture
backend code:

 * Override arch_get_crash_header() to return the address of the ELF
   header in new memory
 * Override arch_free_crash_header() to free the memory of the ELF
   header in new memory
 * Override arch_read_from_crash_header() to read from the ELF header
   in new memory
 * Set elfcorehdr_addr to the address of ELF header in new memory

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c           | 65 +++++++++++++++++++++++++++++++++-------------
 include/linux/crash_dump.h |  4 +++
 2 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 6ba32f8..a9e1b65 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -123,6 +123,28 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
 	return read;
 }
 
+/*
+ * Architetures may override this function to read header data
+ */
+ssize_t __weak arch_read_from_crash_header(char *buf, size_t count, u64 *ppos)
+{
+	return read_from_oldmem(buf, count, ppos, 0);
+}
+
+/*
+ * Architetures may override this function to get header address
+ */
+unsigned long long __weak arch_get_crash_header(void)
+{
+	return elfcorehdr_addr;
+}
+
+/*
+ * Architetures may override this function to free header
+ */
+void __weak arch_free_crash_header(void)
+{}
+
 /* Read from the ELF header and then the crash dump. On error, negative value is
  * returned otherwise number of bytes read are returned.
  */
@@ -356,7 +378,8 @@ static int __init get_note_number_and_size_elf64(const Elf64_Ehdr *ehdr_ptr,
 		notes_section = kmalloc(max_sz, GFP_KERNEL);
 		if (!notes_section)
 			return -ENOMEM;
-		rc = read_from_oldmem(notes_section, max_sz, &offset, 0);
+		rc = arch_read_from_crash_header(notes_section, max_sz,
+						 &offset);
 		if (rc < 0) {
 			kfree(notes_section);
 			return rc;
@@ -412,7 +435,8 @@ static int __init copy_notes_elf64(const Elf64_Ehdr *ehdr_ptr, char *notes_buf)
 		notes_section = kmalloc(max_sz, GFP_KERNEL);
 		if (!notes_section)
 			return -ENOMEM;
-		rc = read_from_oldmem(notes_section, max_sz, &offset, 0);
+		rc = arch_read_from_crash_header(notes_section, max_sz,
+						 &offset);
 		if (rc < 0) {
 			kfree(notes_section);
 			return rc;
@@ -428,8 +452,8 @@ static int __init copy_notes_elf64(const Elf64_Ehdr *ehdr_ptr, char *notes_buf)
 			nhdr_ptr = (Elf64_Nhdr*)((char*)nhdr_ptr + sz);
 		}
 		offset = phdr_ptr->p_offset;
-		rc = read_from_oldmem(notes_buf + phdr_sz, real_sz,
-				      &offset, 0);
+		rc = arch_read_from_crash_header(notes_buf + phdr_sz, real_sz,
+						 &offset);
 		if (rc < 0) {
 			kfree(notes_section);
 			return rc;
@@ -533,7 +557,8 @@ static int __init get_note_number_and_size_elf32(const Elf32_Ehdr *ehdr_ptr,
 		notes_section = kmalloc(max_sz, GFP_KERNEL);
 		if (!notes_section)
 			return -ENOMEM;
-		rc = read_from_oldmem(notes_section, max_sz, &offset, 0);
+		rc = arch_read_from_crash_header(notes_section, max_sz,
+						 &offset);
 		if (rc < 0) {
 			kfree(notes_section);
 			return rc;
@@ -589,7 +614,8 @@ static int __init copy_notes_elf32(const Elf32_Ehdr *ehdr_ptr, char *notes_buf)
 		notes_section = kmalloc(max_sz, GFP_KERNEL);
 		if (!notes_section)
 			return -ENOMEM;
-		rc = read_from_oldmem(notes_section, max_sz, &offset, 0);
+		rc = arch_read_from_crash_header(notes_section, max_sz,
+						 &offset);
 		if (rc < 0) {
 			kfree(notes_section);
 			return rc;
@@ -605,8 +631,8 @@ static int __init copy_notes_elf32(const Elf32_Ehdr *ehdr_ptr, char *notes_buf)
 			nhdr_ptr = (Elf32_Nhdr*)((char*)nhdr_ptr + sz);
 		}
 		offset = phdr_ptr->p_offset;
-		rc = read_from_oldmem(notes_buf + phdr_sz, real_sz,
-				      &offset, 0);
+		rc = arch_read_from_crash_header(notes_buf + phdr_sz, real_sz,
+						 &offset);
 		if (rc < 0) {
 			kfree(notes_section);
 			return rc;
@@ -804,10 +830,11 @@ static int __init parse_crash_elf64_headers(void)
 	Elf64_Ehdr ehdr;
 	u64 addr;
 
-	addr = elfcorehdr_addr;
+	addr = arch_get_crash_header();
 
 	/* Read Elf header */
-	rc = read_from_oldmem((char*)&ehdr, sizeof(Elf64_Ehdr), &addr, 0);
+	rc = arch_read_from_crash_header((char *)&ehdr, sizeof(Elf64_Ehdr),
+					 &addr);
 	if (rc < 0)
 		return rc;
 
@@ -832,8 +859,8 @@ static int __init parse_crash_elf64_headers(void)
 					       get_order(elfcorebuf_sz_orig));
 	if (!elfcorebuf)
 		return -ENOMEM;
-	addr = elfcorehdr_addr;
-	rc = read_from_oldmem(elfcorebuf, elfcorebuf_sz_orig, &addr, 0);
+	addr = arch_get_crash_header();
+	rc = arch_read_from_crash_header(elfcorebuf, elfcorebuf_sz_orig, &addr);
 	if (rc < 0) {
 		free_pages((unsigned long)elfcorebuf,
 			   get_order(elfcorebuf_sz_orig));
@@ -867,10 +894,11 @@ static int __init parse_crash_elf32_headers(void)
 	Elf32_Ehdr ehdr;
 	u64 addr;
 
-	addr = elfcorehdr_addr;
+	addr = arch_get_crash_header();
 
 	/* Read Elf header */
-	rc = read_from_oldmem((char*)&ehdr, sizeof(Elf32_Ehdr), &addr, 0);
+	rc = arch_read_from_crash_header((char *)&ehdr, sizeof(Elf32_Ehdr),
+					 &addr);
 	if (rc < 0)
 		return rc;
 
@@ -895,8 +923,8 @@ static int __init parse_crash_elf32_headers(void)
 					       get_order(elfcorebuf_sz_orig));
 	if (!elfcorebuf)
 		return -ENOMEM;
-	addr = elfcorehdr_addr;
-	rc = read_from_oldmem(elfcorebuf, elfcorebuf_sz_orig, &addr, 0);
+	addr = arch_get_crash_header();
+	rc = arch_read_from_crash_header(elfcorebuf, elfcorebuf_sz_orig, &addr);
 	if (rc < 0) {
 		free_pages((unsigned long)elfcorebuf,
 			   get_order(elfcorebuf_sz_orig));
@@ -930,8 +958,8 @@ static int __init parse_crash_elf_headers(void)
 	u64 addr;
 	int rc=0;
 
-	addr = elfcorehdr_addr;
-	rc = read_from_oldmem(e_ident, EI_NIDENT, &addr, 0);
+	addr = arch_get_crash_header();
+	rc = arch_read_from_crash_header(e_ident, EI_NIDENT, &addr);
 	if (rc < 0)
 		return rc;
 	if (memcmp(e_ident, ELFMAG, SELFMAG) != 0) {
@@ -961,6 +989,7 @@ static int __init parse_crash_elf_headers(void)
 		pr_warn("Warning: Core image elf header is not sane\n");
 		return -EINVAL;
 	}
+	arch_free_crash_header();
 	return 0;
 }
 
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 37e4f8d..c66da41 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -14,6 +14,10 @@ extern unsigned long long elfcorehdr_size;
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
+extern unsigned long long __weak arch_get_crash_header(void);
+extern void __weak arch_free_crash_header(void);
+extern ssize_t __weak arch_read_from_crash_header(char *buf, size_t count,
+						  u64 *ppos);
 
 /* Architecture code defines this if there are other possible ELF
  * machine types, e.g. on bi-arch capable hardware. */
-- 
1.8.1.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
