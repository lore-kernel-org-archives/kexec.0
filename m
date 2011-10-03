Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RAdEB-000165-3l
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 07:46:33 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp01.in.ibm.com (8.14.4/8.13.1) with ESMTP id p937jiMU007449
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 13:15:44 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p937jik74215036
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 13:15:44 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p937jhm1019375
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 18:45:44 +1100
Date: Mon, 3 Oct 2011 13:15:42 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: [Patch 4/4][crash] Recognise elf-note of type NT_NOCOREDUMP before
	vmcore analysis
Message-ID: <20111003074542.GD22694@in.ibm.com>
References: <20111003070735.GJ2223@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111003070735.GJ2223@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, crash-utility@redhat.com, kexec@lists.infradead.org
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

The kernel might have added a new elf-note of type NT_NOCOREDUMP for various
reasons. This patch teaches crash tool to look for the same inside a vmcore
before further analysis. If present, display the error description and exit
early.

Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
---
 netdump.c |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 131 insertions(+), 5 deletions(-)

diff --git a/netdump.c b/netdump.c
index 1e9960c..3b4edec 100644
--- a/netdump.c
+++ b/netdump.c
@@ -95,6 +95,74 @@ map_cpus_to_prstatus(void)
 }
 
 /*
+ * Temporary definition of new elf-note type for compilation purposes.
+ * Not required when run on a new kernel containing this definition.
+ */
+#define NT_NOCOREDUMP 21
+
+/*
+ * Function to verify if the vmcore contains and elf-note of type NT_NOCOREDUMP.
+ * The kernel adds such an elf-note when it is known that the crash is
+ * triggered due to a reason that does not need analysis of the entire kernel
+ * memory dump (e.g. crash triggered due to a faulty memory DIMM).
+ */
+static void
+has_nt_nocoredump(void *note_ptr, unsigned long size_note)
+{
+	Elf32_Nhdr *note32 = NULL;
+	Elf64_Nhdr *note64 = NULL;
+	size_t tot, len = 0;
+	int num = 0;
+
+	for (tot = 0; tot < size_note; tot += len) {
+		if (machine_type("X86_64")) {
+			note64 = note_ptr + tot;
+			/*
+			 * If vmcore is generated due to fatal hardware
+			 * errors (such as Machine Check Exception, we only have
+			 * a 'slim' crashdump. Don't analyse further, inform the
+			 * user about it and exit.
+			 */
+			if (note64->n_type == NT_NOCOREDUMP) {
+				fprintf(fp, "\"System crashed due to a hardware"
+					" memory error. No coredump"
+					" available.\"\n");
+
+				/* Do we have an accompanying error message? */
+				if (note64->n_descsz == 0)
+					goto exit;
+				fprintf(fp,"Nocoredump Reason: %s",
+					(char *)note64 + sizeof(Elf64_Nhdr));
+			}
+
+			len = sizeof(Elf64_Nhdr);
+			len = roundup(len + note64->n_namesz, 4);
+			len = roundup(len + note64->n_descsz, 4);
+		} else if (machine_type("X86")) {
+			note32 = note_ptr + tot;
+			if (note32->n_type == NT_NOCOREDUMP) {
+				fprintf(fp, "\"System crashed due to a hardware"
+					" memory error. No coredump"
+					" available.\"\n");
+
+				/* Do we have an accompanying error message? */
+				if (note32->n_descsz == 0)
+					goto exit;
+
+				fprintf(fp,"Nocoredump Reason: %s",
+					(char *)note32 + sizeof(Elf32_Nhdr));
+exit:
+				clean_exit(0);
+			}
+
+			len = sizeof(Elf32_Nhdr);
+			len = roundup(len + note32->n_namesz, 4);
+			len = roundup(len + note32->n_descsz, 4);
+		}
+	}
+}
+
+/*
  *  Determine whether a file is a netdump/diskdump/kdump creation, 
  *  and if TRUE, initialize the vmcore_data structure.
  */
@@ -103,12 +171,12 @@ is_netdump(char *file, ulong source_query)
 {
         int i, fd, swap;
 	Elf32_Ehdr *elf32;
-	Elf32_Phdr *load32;
+	Elf32_Phdr *load32, *myload32;
 	Elf64_Ehdr *elf64;
-	Elf64_Phdr *load64;
+	Elf64_Phdr *load64, *myload64;
 	char eheader[MIN_NETDUMP_ELF_HEADER_SIZE];
 	char buf[BUFSIZE];
-	size_t size, len, tot;
+	size_t size, mysize, len, tot;
         Elf32_Off offset32;
         Elf64_Off offset64;
 	ulong tmp_flags;
@@ -195,7 +263,10 @@ is_netdump(char *file, ulong source_query)
 
                 load32 = (Elf32_Phdr *)
                         &eheader[sizeof(Elf32_Ehdr)+sizeof(Elf32_Phdr)];
-                size = (size_t)load32->p_offset;
+                myload32 = (Elf32_Phdr *)
+                        &eheader[sizeof(Elf32_Ehdr)];
+
+		size = (size_t)myload32->p_offset;
 
 		if ((load32->p_offset & (MIN_PAGE_SIZE-1)) &&
 		    (load32->p_align == 0))
@@ -249,7 +320,10 @@ is_netdump(char *file, ulong source_query)
 
                 load64 = (Elf64_Phdr *)
                         &eheader[sizeof(Elf64_Ehdr)+sizeof(Elf64_Phdr)];
-                size = (size_t)load64->p_offset;
+                myload64 = (Elf64_Phdr *)
+                        &eheader[sizeof(Elf64_Ehdr)];
+
+		size = (size_t)myload64->p_offset;
 		if ((load64->p_offset & (MIN_PAGE_SIZE-1)) &&
 		    (load64->p_align == 0))
                 	tmp_flags |= KDUMP_ELF64;
@@ -362,6 +436,58 @@ is_netdump(char *file, ulong source_query)
                     &nd->elf_header[sizeof(Elf64_Ehdr)];
                 nd->load64 = (Elf64_Phdr *)
                     &nd->elf_header[sizeof(Elf64_Ehdr)+sizeof(Elf64_Phdr)];
+		/*
+		 * Find out if there exists an elf-note of type NT_NOCOREDUMP.
+		 * If so, exit early from crash analysis after displaying the
+		 * description string.
+		 * 
+		 * Allocate a temporary buffer to store the PT_NOTE section and
+		 * loop through them to look for NT_NOCOREDUMP.
+		 */
+		for (i = 0; i < elf64->e_phnum; i++, myload64++) {
+			mysize += myload64->p_memsz;
+			if (myload64->p_type == PT_NOTE) {
+				break;
+			}
+		}
+
+		if (mysize == 0) {
+			fprintf(stderr, "No PT_NOTE section found\n");
+			clean_exit(1);
+		}
+
+		/*
+		 * Size of the buffer should accommodate the Elf_Ehdr, Elf_Phdr
+		 * and all sections upto the first PT_NOTE.
+		 */
+		mysize += size;
+		tmp_elf_header = realloc(tmp_elf_header, mysize);
+		if (tmp_elf_header == NULL) {
+			fprintf(stderr, "cannot malloc notes buffer\n");
+			clean_exit(1);
+		}
+		if (FLAT_FORMAT()) {
+			if (!read_flattened_format(fd, 0, tmp_elf_header, mysize)) {
+				free(tmp_elf_header);
+				goto bailout;
+			}
+		} else {
+			if (lseek(fd, 0, SEEK_SET) != 0) {
+				sprintf(buf, "%s: lseek", file);
+				perror(buf);
+				goto bailout;
+			}
+			if (read(fd, tmp_elf_header, mysize) != mysize) {
+				sprintf(buf, "%s: read", file);
+				perror(buf);
+				free(tmp_elf_header);
+				goto bailout;
+			}
+		}
+
+		has_nt_nocoredump((char *)tmp_elf_header + myload64->p_offset,
+				  myload64->p_memsz);
+
 		if (DUMPFILE_FORMAT(nd->flags) == NETDUMP_ELF64)
 			nd->page_size = (uint)nd->load64->p_align;
                 dump_Elf64_Ehdr(nd->elf64);
-- 
1.7.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
