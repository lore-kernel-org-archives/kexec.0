Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VhKve-0002p3-I4
 for kexec@lists.infradead.org; Fri, 15 Nov 2013 15:03:30 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 15 Nov 2013 15:03:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CFA9C21905B1
 for <kexec@lists.infradead.org>; Fri, 15 Nov 2013 15:01:54 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAFF1gSU55509134
 for <kexec@lists.infradead.org>; Fri, 15 Nov 2013 15:01:42 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAFF1smW005208
 for <kexec@lists.infradead.org>; Fri, 15 Nov 2013 08:01:54 -0700
Subject: [PATCH] kexec/ppc64: bring up new ppc64le architecture
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 15 Nov 2013 16:01:51 +0100
Message-ID: <20131115150151.25401.49768.stgit@nimbus>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au, kexec@lists.infradead.org

This patch provides support for the new Power PC litte endian (LE) mode. The
LE mode only differs in the way the instructions and data are stored in memory
thus there is no real need to duplicate the ppc64 code.

However some compilation's options, especially for the purgatory, differ
between little and big endian mode's support. A new "SUBARCH" build variable
is introduced which is currently only used for PPC64 to specify the
endianness.

Another set of changes in this patch is fixing minor endianess issues in the
ppc64 code and fix an alignment issue raised on Power7 little endian mode.
Among these fixes, the check on the kernel binary endianess is removed,
since we can imagine kexecing a LE kernel from a BE environment, as far as
the specified root filesystem and initrd file are containing the right
binaries.

This patch depends on the patch "kexec/ppc64: use common architecture
fs2dt.c file" I sent earlier on the kexec mailing list.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 Makefile.in                            |    1 +
 config/config.guess                    |    5 ++++-
 configure.ac                           |    6 ++++++
 kexec/arch/ppc64/kexec-elf-ppc64.c     |    6 +++---
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c |    3 ---
 kexec/arch/ppc64/kexec-ppc64.c         |    3 +++
 purgatory/arch/ppc64/Makefile          |    8 +++++++-
 purgatory/arch/ppc64/v2wrap.S          |    1 +
 8 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index c1859d1..54c206f 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -22,6 +22,7 @@ includedir	= @includedir@
 
 # The target architecture
 ARCH		= @ARCH@
+SUBARCH		= @SUBARCH@
 OBJDIR		= @OBJDIR@
 target		= @target@
 host		= @host@
diff --git a/config/config.guess b/config/config.guess
index d622a44..c954d5e 100755
--- a/config/config.guess
+++ b/config/config.guess
@@ -4,7 +4,7 @@
 #   2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010,
 #   2011, 2012 Free Software Foundation, Inc.
 
-timestamp='2012-02-10'
+timestamp='2013-10-21'
 
 # This file is free software; you can redistribute it and/or modify it
 # under the terms of the GNU General Public License as published by
@@ -972,6 +972,9 @@ EOF
     ppc64:Linux:*:*)
 	echo powerpc64-unknown-linux-gnu
 	exit ;;
+    ppc64le:Linux:*:*)
+	echo powerpc64le-unknown-linux-gnu
+	exit ;;
     ppc:Linux:*:*)
 	echo powerpc-unknown-linux-gnu
 	exit ;;
diff --git a/configure.ac b/configure.ac
index 7b61dbf..76126cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -29,6 +29,11 @@ case $target_cpu in
 		;;
 	powerpc64 )
 		ARCH="ppc64"
+		SUBARCH="BE"
+		;;
+	powerpc64le )
+		ARCH="ppc64"
+		SUBARCH="LE"
 		;;
 	arm* )
 		ARCH="arm"
@@ -197,6 +202,7 @@ AC_SUBST([TARGET_CFLAGS])
 AC_SUBST([ASFLAGS])
 
 AC_SUBST([ARCH])
+AC_SUBST([SUBARCH])
 AC_SUBST([OBJDIR])
 AC_SUBST([INSTALL])
 
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 3550fc1..7d49d8a 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -237,13 +237,13 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	 * entry is before this one
 	 */
 	bb_ptr = (struct bootblock *)(seg_buf);
-	rsvmap_ptr = (uint64_t *)(seg_buf + bb_ptr->off_mem_rsvmap);
+	rsvmap_ptr = (uint64_t *)(seg_buf + be32_to_cpu(bb_ptr->off_mem_rsvmap));
 	while (*rsvmap_ptr || *(rsvmap_ptr+1))
 		rsvmap_ptr += 2;
 	rsvmap_ptr -= 2;
-	*rsvmap_ptr = my_dt_offset;
+	*rsvmap_ptr = cpu_to_be64(my_dt_offset);
 	rsvmap_ptr++;
-	*rsvmap_ptr = bb_ptr->totalsize;
+	*rsvmap_ptr = cpu_to_be64((uint64_t)be32_to_cpu(bb_ptr->totalsize));
 #endif
 
 	/* Set kernel */
diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 54d506a..5fc2f87 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -7,9 +7,6 @@
 
 int machine_verify_elf_rel(struct mem_ehdr *ehdr)
 {
-	if (ehdr->ei_data != ELFDATA2MSB) {
-		return 0;
-	}
 	if (ehdr->ei_class != ELFCLASS64) {
 		return 0;
 	}
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 21bd0a8..af9112b 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -532,6 +532,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				perror(fname);
 				goto error_openfile;
 			}
+			rtas_base = be32_to_cpu(rtas_base);
 			memset(fname, 0, sizeof(fname));
 			strcpy(fname, device_tree);
 			strcat(fname, dentry->d_name);
@@ -545,6 +546,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				goto error_openfile;
 			}
 			closedir(cdir);
+			rtas_size = be32_to_cpu(rtas_size);
 			/* Add rtas to exclude_range */
 			exclude_range[i].start = rtas_base;
 			exclude_range[i].end = rtas_base + rtas_size;
@@ -798,6 +800,7 @@ const struct arch_map_entry arches[] = {
 	 * So pass KEXEC_ARCH_PPC64 here
 	 */
 	{ "ppc64", KEXEC_ARCH_PPC64 },
+	{ "ppc64le", KEXEC_ARCH_PPC64 },
 	{ NULL, 0 },
 };
 
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index 67f41ae..6f6716e 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -11,7 +11,13 @@ ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/misc.S
 
 ppc64_PURGATORY_EXTRA_CFLAGS += -m64 -mcall-aixdesc -msoft-float
 ppc64_PURGATORY_EXTRA_ASFLAGS += -m64 -mcall-aixdesc
-ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc
+ifeq ($(SUBARCH),BE)
+	ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64ppc
+else
+	ppc64_PURGATORY_EXTRA_LDFLAGS += -melf64lppc
+	ppc64_PURGATORY_EXTRA_CFLAGS += -mlittle-endian
+	ppc64_PURGATORY_EXTRA_ASFLAGS += -mlittle-endian
+endif
 
 dist += purgatory/arch/ppc64/Makefile $(ppc64_PURGATORY_SRCS)		\
 	purgatory/arch/ppc64/hvCall.h					\
diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
index 3f78620..16fb63d 100644
--- a/purgatory/arch/ppc64/v2wrap.S
+++ b/purgatory/arch/ppc64/v2wrap.S
@@ -46,6 +46,7 @@
 	ori     rn,rn,name##@l
 
 	.machine ppc64
+	.align 8
 	.globl purgatory_start
 purgatory_start:	b	master
 	.org purgatory_start + 0x5c     # ABI: possible run_at_load flag at 0x5c


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
