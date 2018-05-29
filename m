Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fNa8G-0002fh-Ev
 for kexec@lists.infradead.org; Tue, 29 May 2018 08:37:32 +0000
Date: Tue, 29 May 2018 10:36:55 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] Remove obsolete kdump tool
Message-ID: <20180529083655.oxp5xmqqafeu5fuz@verge.net.au>
References: <1527147483-11139-1-git-send-email-bhsharma@redhat.com>
 <20180525080033.GA5310@dhcp-128-65.nay.redhat.com>
 <20180525100214.apb3zsk2mbw3tnjc@verge.net.au>
 <CACi5LpOJPAFA61QZHUR+Ay-KD=LnuQtjy=u--_chbF66TpeH4w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpOJPAFA61QZHUR+Ay-KD=LnuQtjy=u--_chbF66TpeH4w@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Dave Young <dyoung@redhat.com>, Russell King <rmk@arm.linux.org.uk>

On Mon, May 28, 2018 at 02:28:58PM +0530, Bhupesh Sharma wrote:
> Hello Simon,
> 
> On Fri, May 25, 2018 at 3:32 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, May 25, 2018 at 04:00:33PM +0800, Dave Young wrote:
> >> On 05/24/18 at 01:08pm, Bhupesh Sharma wrote:
> >> > The kdump tool presently allows one to generate an ELF file containing
> >> > the ELF header, PT_NOTE and PT_LOAD segments (which can be analyzed
> >> > later by tools like 'readelf') of the crashdump read from memory, when
> >> > passed with an appropriate 'elfcorehdr' value(which represents the
> >> > physical address of the start of the ELF header).
> >> >
> >> > With the availability of tools like crash/gdb the analysis of the
> >> > crashdump core has become rather easy, and it makes the kdump tool
> >> > obsolete. Also the same naming convention (man page) causes confusion
> >> > when compared to similarly named distribution specific kdump
> >> > service/utilities.
> >> >
> >> > Also most distributions (like Fedora for e.g.) now support more
> >> > enhanced kdump service and utilities which can be used to analyze the
> >> > crashdump core contents better. Taking an example of the Fedora
> >> > specific kdump service and utilities, the following sequence of steps
> >> > happen when the primary kernel crashes:
> >> >
> >> > 1. If the crashkernel is loaded, then the system starts executing the
> >> > same.
> >> >
> >> > 2. When the boot process gets to the point when kdump service is
> >> > started, the crashdump core is usually copied out to disk (for e.g.
> >> > inside '/var/crash') using 'cp' command from '/proc/vmcore':
> >> >    # cp /proc/vmcore <dump-file>
> >> >
> >> > 3. Thereafter the system is rebooted back into the normal kernel.
> >> >
> >> > 4. Once back to your normal kernel, one can use the crashdump core
> >> > available on hard disk in conjunction with the previously installed
> >> > kernel (with debuginfo) to perform postmortem analysis with tools like
> >> > gdb/crash:
> >> >    # gdb vmlinux <dump-file>
> >> >
> >> > Accordingly, this patch removes the obsolete kdump tool from
> >> > 'kexec-tools'.
> >>
> >> The main issue for me is the manpage kdump.8 cause confusion to people
> >> The kdump tools is not a main problem to exist or not, but I think
> >> removing the kdump tool along with the man page looks a good cleanup :)
> >>
> >> Reviewed-by: Dave Young <dyoung@redhat.com>
> >
> > Thanks, applied.
> 
> Thanks for applying this patch, but it seems some files were missed
> while applying the patch.
> 
> I can see that while the changes for Makefile.in where picked (please
> see <https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/>
> for details), the kdump directory is still present in the tree (please
> see <https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/kdump>
> for details).

Thanks for noticing, I have reapplied the patch forcibly pushed the result
which is as follows:

From 7acd257ae67b4ca94f8c23cb8bda0ee0709b9216 Mon Sep 17 00:00:00 2001
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 24 May 2018 13:08:03 +0530
Subject: [PATCH] Remove obsolete kdump tool

The kdump tool presently allows one to generate an ELF file containing
the ELF header, PT_NOTE and PT_LOAD segments (which can be analyzed
later by tools like 'readelf') of the crashdump read from memory, when
passed with an appropriate 'elfcorehdr' value(which represents the
physical address of the start of the ELF header).

With the availability of tools like crash/gdb the analysis of the
crashdump core has become rather easy, and it makes the kdump tool
obsolete. Also the same naming convention (man page) causes confusion
when compared to similarly named distribution specific kdump
service/utilities.

Also most distributions (like Fedora for e.g.) now support more
enhanced kdump service and utilities which can be used to analyze the
crashdump core contents better. Taking an example of the Fedora
specific kdump service and utilities, the following sequence of steps
happen when the primary kernel crashes:

1. If the crashkernel is loaded, then the system starts executing the
same.

2. When the boot process gets to the point when kdump service is
started, the crashdump core is usually copied out to disk (for e.g.
inside '/var/crash') using 'cp' command from '/proc/vmcore':
   # cp /proc/vmcore <dump-file>

3. Thereafter the system is rebooted back into the normal kernel.

4. Once back to your normal kernel, one can use the crashdump core
available on hard disk in conjunction with the previously installed
kernel (with debuginfo) to perform postmortem analysis with tools like
gdb/crash:
   # gdb vmlinux <dump-file>

Accordingly, this patch removes the obsolete kdump tool from
'kexec-tools'.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
Reviewed-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in         |   9 +-
 kdump/Makefile      |  30 -----
 kdump/kdump.8       |  39 -------
 kdump/kdump.c       | 327 ----------------------------------------------------
 kexec-tools.spec.in |   2 -
 5 files changed, 2 insertions(+), 405 deletions(-)
 delete mode 100644 kdump/Makefile
 delete mode 100644 kdump/kdump.8
 delete mode 100644 kdump/kdump.c

diff --git a/Makefile.in b/Makefile.in
index 273d06ebea55..fb01134d9880 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -155,11 +155,6 @@ include $(srcdir)/purgatory/Makefile
 #
 include $(srcdir)/kexec/Makefile
 
-
-# kdump (read a crashdump from memory)
-#
-include $(srcdir)/kdump/Makefile
-
 # vmcore-dmesg (read dmesg from a vmcore)
 #
 include $(srcdir)/vmcore-dmesg/Makefile
@@ -177,10 +172,10 @@ SRCS:= $(dist)
 PSRCS:=$(foreach s, $(SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
 PGSRCS:=$(foreach s, $(GENERATED_SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
 
-MAN_PAGES:=$(KEXEC_MANPAGE) $(KDUMP_MANPAGE) $(VMCORE_DMESG_MANPAGE)
+MAN_PAGES:=$(KEXEC_MANPAGE) $(VMCORE_DMESG_MANPAGE)
 BINARIES_i386:=$(KEXEC_TEST)
 BINARIES_x86_64:=$(KEXEC_TEST)
-BINARIES:=$(KEXEC) $(KDUMP) $(VMCORE_DMESG) $(BINARIES_$(ARCH))
+BINARIES:=$(KEXEC) $(VMCORE_DMESG) $(BINARIES_$(ARCH))
 
 UNINSTALL_KDUMP = $(sbindir)/kdump
 UNINSTALL_KDUMP_MANPAGE = $(mandir)/man8/kdump.8
diff --git a/kdump/Makefile b/kdump/Makefile
deleted file mode 100644
index 307d59d4d3b5..000000000000
--- a/kdump/Makefile
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# kdump (reading a crashdump from memory)
-#
-
-KDUMP_SRCS:= kdump/kdump.c
-
-KDUMP_OBJS = $(call objify, $(KDUMP_SRCS))
-KDUMP_DEPS = $(call depify, $(KDUMP_OBJS))
-
-KDUMP = $(SBINDIR)/kdump
-KDUMP_MANPAGE = $(MANDIR)/man8/kdump.8
-
-dist += kdump/Makefile $(KDUMP_SRCS) kdump/kdump.8
-clean += $(KDUMP_OBJS) $(KDUMP_DEPS) $(KDUMP) $(KDUMP_MANPAGE)
-
--include $(KDUMP_DEPS)
-
-$(KDUMP): CC=$(TARGET_CC)
-$(KDUMP): $(KDUMP_OBJS)
-	@$(MKDIR) -p $(@D)
-	$(LINK.o) -o $@ $^ $(CFLAGS) $(LIBS)
-
-$(KDUMP_MANPAGE): kdump/kdump.8
-	$(MKDIR) -p     $(MANDIR)/man8
-	cp $^ $(KDUMP_MANPAGE)
-echo::
-	@echo "KDUMP_SRCS $(KDUMP_SRCS)"
-	@echo "KDUMP_DEPS $(KDUMP_DEPS)"
-	@echo "KDUMP_OBJS $(KDUMP_OBJS)"
-
diff --git a/kdump/kdump.8 b/kdump/kdump.8
deleted file mode 100644
index e53516262e3f..000000000000
--- a/kdump/kdump.8
+++ /dev/null
@@ -1,39 +0,0 @@
-.\"                                      Hey, EMACS: -*- nroff -*-
-.\" First parameter, NAME, should be all caps
-.\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
-.\" other parameters are allowed: see man(7), man(1)
-.TH KDUMP 8 "Jul 27, 2005"
-.\" Please adjust this date whenever revising the manpage.
-.\"
-.\" Some roff macros, for reference:
-.\" .nh        disable hyphenation
-.\" .hy        enable hyphenation
-.\" .ad l      left justify
-.\" .ad b      justify to both left and right margins
-.\" .nf        disable filling
-.\" .fi        enable filling
-.\" .br        insert line break
-.\" .sp <n>    insert n+1 empty lines
-.\" for manpage-specific macros, see man(7)
-.SH NAME
-kdump \- This is just a placeholder until real man page has been written
-.SH SYNOPSIS
-.B kdump
-.RI [ options ] " start_address" ...
-.SH DESCRIPTION
-.PP
-.\" TeX users may be more comfortable with the \fB<whatever>\fP and
-.\" \fI<whatever>\fP escape sequences to invode bold face and italics,
-.\" respectively.
-\fBkdump\fP does not have a man page yet.
-.SH OPTIONS
-.\"These programs follow the usual GNU command line syntax, with long
-.\"options starting with two dashes (`-').
-.\"A summary of options is included below.
-.\"For a complete description, see the Info files.
-.SH SEE ALSO
-.SH AUTHOR
-kdump was written by Eric Biederman.
-.PP
-This manual page was written by Khalid Aziz <khalid.aziz@hp.com>,
-for the Debian project (but may be used by others).
diff --git a/kdump/kdump.c b/kdump/kdump.c
deleted file mode 100644
index de46d288dc29..000000000000
--- a/kdump/kdump.c
+++ /dev/null
@@ -1,327 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/mman.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <endian.h>
-#include <elf.h>
-
-#if !defined(__BYTE_ORDER) || !defined(__LITTLE_ENDIAN) || !defined(__BIG_ENDIAN)
-#error Endian defines missing
-#endif
-
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-# define ELFDATALOCAL ELFDATA2LSB
-#elif __BYTE_ORDER == __BIG_ENDIAN
-# define ELFDATALOCAL ELFDATA2MSB
-#else
-# error Unknown byte order
-#endif
-
-#define MAP_WINDOW_SIZE (64*1024*1024)
-#define DEV_MEM "/dev/mem"
-
-#define ALIGN_MASK(x,y) (((x) + (y)) & ~(y))
-#define ALIGN(x,y)	ALIGN_MASK(x, (y) - 1)
-
-static void *map_addr(int fd, unsigned long size, off_t offset)
-{
-	unsigned long page_size = getpagesize();
-	unsigned long map_offset = offset & (page_size - 1);
-	size_t len = ALIGN(size + map_offset, page_size);
-	void *result;
-
-	result = mmap(0, len, PROT_READ, MAP_SHARED, fd, offset - map_offset);
-	if (result == MAP_FAILED) {
-		fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %#llx size: %lu: %s\n",
-			(unsigned long long)offset, size, strerror(errno));
-		exit(5);
-	}
-	return result + map_offset;
-}
-
-static void unmap_addr(void *addr, unsigned long size)
-{
-	unsigned long page_size = getpagesize();
-	unsigned long map_offset = (uintptr_t)addr & (page_size - 1);
-	size_t len = ALIGN(size + map_offset, page_size);
-	int ret;
-
-	addr -= map_offset;
-
-	ret = munmap(addr, len);
-	if (ret < 0) {
-		fprintf(stderr, "munmap failed: %s\n",
-			strerror(errno));
-		exit(6);
-	}
-}
-
-static void *xmalloc(size_t size)
-{
-	void *result;
-	result = malloc(size);
-	if (result == NULL) {
-		fprintf(stderr, "malloc of %u bytes failed: %s\n",
-			(unsigned int)size, strerror(errno));
-		exit(7);
-	}
-	return result;
-}
-
-static void *collect_notes(
-	int fd, Elf64_Ehdr *ehdr, Elf64_Phdr *phdr, size_t *note_bytes)
-{
-	int i;
-	size_t bytes, result_bytes;
-	char *notes;
-
-	result_bytes = 0;
-	/* Find the worst case note memory usage */
-	bytes = 0;
-	for(i = 0; i < ehdr->e_phnum; i++) {
-		if (phdr[i].p_type == PT_NOTE) {
-			bytes += phdr[i].p_filesz;
-		}
-	}
-
-	/* Allocate the worst case note array */
-	notes = xmalloc(bytes);
-
-	/* Walk through and capture the notes */
-	for(i = 0; i < ehdr->e_phnum; i++) {
-		Elf64_Nhdr *hdr, *lhdr, *nhdr;
-		void *pnotes;
-		if (phdr[i].p_type != PT_NOTE) {
-			continue;
-		}
-		/* First snapshot the notes */
-		pnotes = map_addr(fd, phdr[i].p_filesz, phdr[i].p_offset);
-		memcpy(notes + result_bytes, pnotes, phdr[i].p_filesz);
-		unmap_addr(pnotes, phdr[i].p_filesz);
-
-		/* Walk through the new notes and find the real length */
-		hdr = (Elf64_Nhdr *)(notes + result_bytes);
-		lhdr = (Elf64_Nhdr *)(notes + result_bytes + phdr[i].p_filesz);
-		for(; hdr < lhdr; hdr = nhdr) {
-			size_t hdr_size;
-			/* If there is not a name this is a invalid/reserved note
-			 * stop here.
-			 */
-			if (hdr->n_namesz == 0) {
-				break;
-			}
-			hdr_size = 
-				sizeof(*hdr) + 
-				((hdr->n_namesz + 3) & ~3) +
-				((hdr->n_descsz + 3) & ~3);
-
-			nhdr = (Elf64_Nhdr *)(((char *)hdr) + hdr_size); 
-			/* if the note does not fit in the segment stop here */
-			if (nhdr > lhdr) {
-				break;
-			}
-			/* Update result_bytes for after each good header */
-			result_bytes = ((char *)hdr) - notes;
-		}
-	}
-	*note_bytes = result_bytes;
-	return notes;
-}
-
-static void *generate_new_headers(
-	Elf64_Ehdr *ehdr, Elf64_Phdr *phdr, size_t note_bytes, size_t *header_bytes)
-{
-	unsigned phnum;
-	size_t bytes;
-	char *headers;
-	Elf64_Ehdr *nehdr;
-	Elf64_Phdr *nphdr;
-	unsigned long long offset;
-	int i;
-	/* Count the number of program headers.
-	 * When we are done there will be only one note header.
-	 */
-	phnum = 1;
-	for(i = 0; i < ehdr->e_phnum; i++) {
-		if (phdr[i].p_type == PT_NOTE) {
-			continue;
-		}
-		phnum++;
-	}
-
-	/* Compute how many bytes we will need for headers */
-	bytes = sizeof(*ehdr) + sizeof(*phdr)*phnum;
-
-	/* Allocate memory for the headers */
-	headers = xmalloc(bytes);
-
-	/* Setup pointers to the new headers */
-	nehdr = (Elf64_Ehdr *)headers;
-	nphdr = (Elf64_Phdr *)(headers + sizeof(*nehdr));
-	
-	/* Copy and adjust the Elf header */
-	memcpy(nehdr, ehdr, sizeof(*nehdr));
-	nehdr->e_phoff = sizeof(*nehdr);
-	nehdr->e_phnum = phnum;
-	nehdr->e_shoff = 0;
-	nehdr->e_shentsize = 0;
-	nehdr->e_shnum = 0;
-	nehdr->e_shstrndx = 0;
-
-	/* Write the note program header */
-	nphdr->p_type = PT_NOTE;
-	nphdr->p_offset = bytes;
-	nphdr->p_vaddr  = 0;
-	nphdr->p_paddr  = 0;
-	nphdr->p_filesz = note_bytes;
-	nphdr->p_memsz  = note_bytes;
-	nphdr->p_flags  = 0;
-	nphdr->p_align  = 0;
-	nphdr++;
-
-	/* Write the rest of the program headers */
-	offset = bytes + note_bytes;
-	for(i = 0; i < ehdr->e_phnum; i++) {
-		if (phdr[i].p_type == PT_NOTE) {
-			continue;
-		}
-		memcpy(nphdr, &phdr[i], sizeof(*nphdr));
-		nphdr->p_offset = offset;
-		nphdr++;
-		offset += phdr[i].p_filesz;
-	}
-	
-	*header_bytes = bytes;
-	return headers;
-}
-
-static void write_all(int fd, const void *buf, size_t count)
-{
-	ssize_t result;
-	size_t written = 0;
-	const char *ptr;
-	size_t left;
-	ptr = buf;
-	left = count;
-	do {
-		result = write(fd, ptr, left);
-		if (result >= 0) {
-			written += result;
-			ptr += result;
-			left -= result;
-		}
-		else if ((errno != EAGAIN) && (errno != EINTR)) {
-			fprintf(stderr, "write failed: %s\n",
-				strerror(errno));
-			exit(8);
-		}
-	} while(written < count);
-}
-
-int main(int argc, char **argv)
-{
-	char *start_addr_str, *end;
-	unsigned long long start_addr;
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	void *notes, *headers;
-	size_t note_bytes, header_bytes;
-	int fd;
-	int i;
-	start_addr_str = 0;
-	if (argc > 2) {
-		fprintf(stderr, "Invalid argument count\n");
-		exit(9);
-	}
-	if (argc == 2) {
-		start_addr_str = argv[1];
-	}
-	if (!start_addr_str) {
-		start_addr_str = getenv("elfcorehdr");
-	}
-	if (!start_addr_str) {
-		fprintf(stderr, "Cannot find the start of the core dump\n");
-		exit(1);
-	}
-	start_addr = strtoull(start_addr_str, &end, 0);
-	if ((start_addr_str == end) || (*end != '\0')) {
-		fprintf(stderr, "Bad core dump start addres: %s\n",
-			start_addr_str);
-		exit(2);
-	}
-	
-	fd = open(DEV_MEM, O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "Cannot open " DEV_MEM ": %s\n",
-			strerror(errno));
-		exit(3);
-	}
-
-	/* Get the elf header */
-	ehdr = map_addr(fd, sizeof(*ehdr), start_addr);
-
-	/* Verify the ELF header */
-	if (	(ehdr->e_ident[EI_MAG0] != ELFMAG0) ||
-		(ehdr->e_ident[EI_MAG1] != ELFMAG1) ||
-		(ehdr->e_ident[EI_MAG2] != ELFMAG2) ||
-		(ehdr->e_ident[EI_MAG3] != ELFMAG3) ||
-		(ehdr->e_ident[EI_CLASS] != ELFCLASS64) ||
-		(ehdr->e_ident[EI_DATA] != ELFDATALOCAL) ||
-		(ehdr->e_ident[EI_VERSION] != EV_CURRENT) ||
-		(ehdr->e_type != ET_CORE) ||
-		(ehdr->e_version != EV_CURRENT) ||
-		(ehdr->e_ehsize != sizeof(Elf64_Ehdr)) ||
-		(ehdr->e_phentsize != sizeof(Elf64_Phdr)) ||
-		(ehdr->e_phnum == 0))
-	{
-		fprintf(stderr, "Invalid Elf header\n");
-		exit(4);
-	}
-	
-	/* Get the program header */
-	phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum),
-			start_addr + ehdr->e_phoff);
-
-	/* Collect up the notes */
-	note_bytes = 0;
-	notes = collect_notes(fd, ehdr, phdr, &note_bytes);
-	
-	/* Generate new headers */
-	header_bytes = 0;
-	headers = generate_new_headers(ehdr, phdr, note_bytes, &header_bytes);
-
-	/* Write out everything */
-	write_all(STDOUT_FILENO, headers, header_bytes);
-	write_all(STDOUT_FILENO, notes, note_bytes);
-	for(i = 0; i < ehdr->e_phnum; i++) {
-		unsigned long long offset, size;
-		size_t wsize;
-		if (phdr[i].p_type == PT_NOTE) {
-			continue;
-		}
-		offset = phdr[i].p_offset;
-		size   = phdr[i].p_filesz;
-		wsize  = MAP_WINDOW_SIZE;
-		if (wsize > size) {
-			wsize = size;
-		}
-		for(;size > 0; size -= wsize, offset += wsize) {
-			void *buf;
-			wsize = MAP_WINDOW_SIZE;
-			if (wsize > size) {
-				wsize = size;
-			}
-			buf = map_addr(fd, wsize, offset);
-			write_all(STDOUT_FILENO, buf, wsize);
-			unmap_addr(buf, wsize);
-		}
-	}
-	free(notes);
-	close(fd);
-	return 0;
-}
diff --git a/kexec-tools.spec.in b/kexec-tools.spec.in
index 8871f2891921..3e57a22dc9ab 100644
--- a/kexec-tools.spec.in
+++ b/kexec-tools.spec.in
@@ -30,13 +30,11 @@ make install DESTDIR=${RPM_BUILD_ROOT}
 %files
 %defattr(-,root,root)
 %{_sbindir}/kexec
-%{_sbindir}/kdump
 %{_sbindir}/vmcore-dmesg
 %doc News
 %doc COPYING
 %doc TODO
 %{_mandir}/man8/kexec.8.gz
-%{_mandir}/man8/kdump.8.gz
 %{_mandir}/man8/vmcore-dmesg.8.gz
 
 %changelog
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
