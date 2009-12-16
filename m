Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]
	helo=master.linux-sh.org)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NKoU1-00052J-8v
	for kexec@lists.infradead.org; Wed, 16 Dec 2009 07:39:46 +0000
Date: Wed, 16 Dec 2009 16:39:32 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] kexec: uImage tidying and SH support.
Message-ID: <20091216073932.GB32515@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Horms <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Marc Andre Tanner <mat@brain-dump.org>

Here is a trivial patch series for tidying up the uImage support a bit
as well as wiring it up on SH. Nothing terribly exciting, just a bit of
refactoring and updating. In addition to testing on SH, it's also been
compile tested on ARM, which at present is the only other platform that
makes use of this code.

The patch series can be pulled directly from:

	git://github.com/pmundt/kexec-tools-sh.git sh/uImage

Which contains:

Paul Mundt (3):
      kexec: Move the uImage header to a better place.
      kexec: Bring the uImage definitions in sync with upstream.
      kexec-sh: uImage support.

 include/Makefile                                   |    1 +
 .../arch/arm/kexec-uImage-arm.h => include/image.h |   41 ++++++++++---------
 kexec/arch/arm/Makefile                            |    1 -
 kexec/arch/arm/kexec-uImage-arm.c                  |    2 +-
 kexec/arch/sh/Makefile                             |    1 +
 kexec/arch/sh/kexec-sh.c                           |    9 +++-
 kexec/arch/sh/kexec-sh.h                           |    4 ++
 kexec/arch/sh/kexec-uImage-sh.c                    |   35 +++++++++++++++++
 8 files changed, 70 insertions(+), 24 deletions(-)
 rename kexec/arch/arm/kexec-uImage-arm.h => include/image.h (85%)
 create mode 100644 kexec/arch/sh/kexec-uImage-sh.c

---

And here is the patch, for reference.

diff --git a/include/Makefile b/include/Makefile
index bf2c4ed..de5a3bb 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -5,6 +5,7 @@ dist += include/Makefile		\
 	include/x86/mb_info.h		\
 	include/x86/mb_header.h		\
 	include/elf.h			\
+	include/image.h			\
 	include/boot/linuxbios_tables.h	\
 	include/boot/beoboot.h		\
 	include/boot/elf_boot.h
diff --git a/include/image.h b/include/image.h
new file mode 100644
index 0000000..e52acbe
--- /dev/null
+++ b/include/image.h
@@ -0,0 +1,164 @@
+/*
+ * (C) Copyright 2000-2005
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ ********************************************************************
+ * NOTE: This header file defines an interface to U-Boot. Including
+ * this (unmodified) header file in another file is considered normal
+ * use of U-Boot, and does *not* fall under the heading of "derived
+ * work".
+ ********************************************************************
+ */
+
+#ifndef __IMAGE_H__
+#define __IMAGE_H__
+
+/*
+ * Operating System Codes
+ */
+#define IH_OS_INVALID		0	/* Invalid OS	*/
+#define IH_OS_OPENBSD		1	/* OpenBSD	*/
+#define IH_OS_NETBSD		2	/* NetBSD	*/
+#define IH_OS_FREEBSD		3	/* FreeBSD	*/
+#define IH_OS_4_4BSD		4	/* 4.4BSD	*/
+#define IH_OS_LINUX		5	/* Linux	*/
+#define IH_OS_SVR4		6	/* SVR4		*/
+#define IH_OS_ESIX		7	/* Esix		*/
+#define IH_OS_SOLARIS		8	/* Solaris	*/
+#define IH_OS_IRIX		9	/* Irix		*/
+#define IH_OS_SCO		10	/* SCO		*/
+#define IH_OS_DELL		11	/* Dell		*/
+#define IH_OS_NCR		12	/* NCR		*/
+#define IH_OS_LYNXOS		13	/* LynxOS	*/
+#define IH_OS_VXWORKS		14	/* VxWorks	*/
+#define IH_OS_PSOS		15	/* pSOS		*/
+#define IH_OS_QNX		16	/* QNX		*/
+#define IH_OS_U_BOOT		17	/* Firmware	*/
+#define IH_OS_RTEMS		18	/* RTEMS	*/
+#define IH_OS_ARTOS		19	/* ARTOS	*/
+#define IH_OS_UNITY		20	/* Unity OS	*/
+#define IH_OS_INTEGRITY		21	/* INTEGRITY	*/
+
+/*
+ * CPU Architecture Codes (supported by Linux)
+ */
+#define IH_ARCH_INVALID		0	/* Invalid CPU	*/
+#define IH_ARCH_ALPHA		1	/* Alpha	*/
+#define IH_ARCH_ARM		2	/* ARM		*/
+#define IH_ARCH_I386		3	/* Intel x86	*/
+#define IH_ARCH_IA64		4	/* IA64		*/
+#define IH_ARCH_MIPS		5	/* MIPS		*/
+#define IH_ARCH_MIPS64		6	/* MIPS	 64 Bit */
+#define IH_ARCH_PPC		7	/* PowerPC	*/
+#define IH_ARCH_S390		8	/* IBM S390	*/
+#define IH_ARCH_SH		9	/* SuperH	*/
+#define IH_ARCH_SPARC		10	/* Sparc	*/
+#define IH_ARCH_SPARC64		11	/* Sparc 64 Bit */
+#define IH_ARCH_M68K		12	/* M68K		*/
+#define IH_ARCH_NIOS		13	/* Nios-32	*/
+#define IH_ARCH_MICROBLAZE	14	/* MicroBlaze   */
+#define IH_ARCH_NIOS2		15	/* Nios-II	*/
+#define IH_ARCH_BLACKFIN	16	/* Blackfin	*/
+#define IH_ARCH_AVR32		17	/* AVR32	*/
+#define IH_ARCH_ST200	        18	/* STMicroelectronics ST200  */
+
+/*
+ * Image Types
+ *
+ * "Standalone Programs" are directly runnable in the environment
+ *	provided by U-Boot; it is expected that (if they behave
+ *	well) you can continue to work in U-Boot after return from
+ *	the Standalone Program.
+ * "OS Kernel Images" are usually images of some Embedded OS which
+ *	will take over control completely. Usually these programs
+ *	will install their own set of exception handlers, device
+ *	drivers, set up the MMU, etc. - this means, that you cannot
+ *	expect to re-enter U-Boot except by resetting the CPU.
+ * "RAMDisk Images" are more or less just data blocks, and their
+ *	parameters (address, size) are passed to an OS kernel that is
+ *	being started.
+ * "Multi-File Images" contain several images, typically an OS
+ *	(Linux) kernel image and one or more data images like
+ *	RAMDisks. This construct is useful for instance when you want
+ *	to boot over the network using BOOTP etc., where the boot
+ *	server provides just a single image file, but you want to get
+ *	for instance an OS kernel and a RAMDisk image.
+ *
+ *	"Multi-File Images" start with a list of image sizes, each
+ *	image size (in bytes) specified by an "uint32_t" in network
+ *	byte order. This list is terminated by an "(uint32_t)0".
+ *	Immediately after the terminating 0 follow the images, one by
+ *	one, all aligned on "uint32_t" boundaries (size rounded up to
+ *	a multiple of 4 bytes - except for the last file).
+ *
+ * "Firmware Images" are binary images containing firmware (like
+ *	U-Boot or FPGA images) which usually will be programmed to
+ *	flash memory.
+ *
+ * "Script files" are command sequences that will be executed by
+ *	U-Boot's command interpreter; this feature is especially
+ *	useful when you configure U-Boot to use a real shell (hush)
+ *	as command interpreter (=> Shell Scripts).
+ */
+
+#define IH_TYPE_INVALID		0	/* Invalid Image		*/
+#define IH_TYPE_STANDALONE	1	/* Standalone Program		*/
+#define IH_TYPE_KERNEL		2	/* OS Kernel Image		*/
+#define IH_TYPE_RAMDISK		3	/* RAMDisk Image		*/
+#define IH_TYPE_MULTI		4	/* Multi-File Image		*/
+#define IH_TYPE_FIRMWARE	5	/* Firmware Image		*/
+#define IH_TYPE_SCRIPT		6	/* Script file			*/
+#define IH_TYPE_FILESYSTEM	7	/* Filesystem Image (any type)	*/
+#define IH_TYPE_FLATDT		8	/* Binary Flat Device Tree Blob	*/
+#define IH_TYPE_KWBIMAGE	9	/* Kirkwood Boot Image		*/
+
+/*
+ * Compression Types
+ */
+#define IH_COMP_NONE		0	/*  No	 Compression Used	*/
+#define IH_COMP_GZIP		1	/* gzip	 Compression Used	*/
+#define IH_COMP_BZIP2		2	/* bzip2 Compression Used	*/
+#define IH_COMP_LZMA		3	/* lzma  Compression Used	*/
+#define IH_COMP_LZO		4	/* lzo   Compression Used	*/
+
+#define IH_MAGIC	0x27051956	/* Image Magic Number		*/
+#define IH_NMLEN		32	/* Image Name Length		*/
+
+/*
+ * all data in network byte order (aka natural aka bigendian)
+ */
+
+typedef struct image_header {
+	uint32_t	ih_magic;	/* Image Header Magic Number	*/
+	uint32_t	ih_hcrc;	/* Image Header CRC Checksum	*/
+	uint32_t	ih_time;	/* Image Creation Timestamp	*/
+	uint32_t	ih_size;	/* Image Data Size		*/
+	uint32_t	ih_load;	/* Data	 Load  Address		*/
+	uint32_t	ih_ep;		/* Entry Point Address		*/
+	uint32_t	ih_dcrc;	/* Image Data CRC Checksum	*/
+	uint8_t		ih_os;		/* Operating System		*/
+	uint8_t		ih_arch;	/* CPU architecture		*/
+	uint8_t		ih_type;	/* Image Type			*/
+	uint8_t		ih_comp;	/* Compression Type		*/
+	uint8_t		ih_name[IH_NMLEN];	/* Image Name		*/
+} image_header_t;
+
+#endif	/* __IMAGE_H__ */
diff --git a/kexec/arch/arm/Makefile b/kexec/arch/arm/Makefile
index 806c4d9..9416339 100644
--- a/kexec/arch/arm/Makefile
+++ b/kexec/arch/arm/Makefile
@@ -8,5 +8,4 @@ arm_KEXEC_SRCS+= kexec/arch/arm/kexec-arm.c
 
 dist += kexec/arch/arm/Makefile $(arm_KEXEC_SRCS)			\
 	kexec/arch/arm/kexec-arm.h					\
-	kexec/arch/arm/kexec-uImage-arm.h				\
 	kexec/arch/arm/include/arch/options.h
diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
index 44c8d5f..2291aae 100644
--- a/kexec/arch/arm/kexec-uImage-arm.c
+++ b/kexec/arch/arm/kexec-uImage-arm.c
@@ -4,9 +4,9 @@
 #include <stdint.h>
 #include <string.h>
 #include <sys/types.h>
+#include <image.h>
 #include "../../kexec.h"
 #include "kexec-arm.h"
-#include "kexec-uImage-arm.h"
 
 int uImage_arm_probe(const char *buf, off_t len)
 {
diff --git a/kexec/arch/arm/kexec-uImage-arm.h b/kexec/arch/arm/kexec-uImage-arm.h
deleted file mode 100644
index cb62cde..0000000
--- a/kexec/arch/arm/kexec-uImage-arm.h
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- * (C) Copyright 2000-2005
- * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
- *
- * See file CREDITS for list of people who contributed to this
- * project.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- *
- ********************************************************************
- * NOTE: This header file defines an interface to U-Boot. Including
- * this (unmodified) header file in another file is considered normal
- * use of U-Boot, and does *not* fall under the heading of "derived
- * work".
- ********************************************************************
- */
-
-#ifndef __IMAGE_H__
-#define __IMAGE_H__
-
-/*
- * Operating System Codes
- */
-#define IH_OS_INVALID		0	/* Invalid OS	*/
-#define IH_OS_OPENBSD		1	/* OpenBSD	*/
-#define IH_OS_NETBSD		2	/* NetBSD	*/
-#define IH_OS_FREEBSD		3	/* FreeBSD	*/
-#define IH_OS_4_4BSD		4	/* 4.4BSD	*/
-#define IH_OS_LINUX		5	/* Linux	*/
-#define IH_OS_SVR4		6	/* SVR4		*/
-#define IH_OS_ESIX		7	/* Esix		*/
-#define IH_OS_SOLARIS		8	/* Solaris	*/
-#define IH_OS_IRIX		9	/* Irix		*/
-#define IH_OS_SCO		10	/* SCO		*/
-#define IH_OS_DELL		11	/* Dell		*/
-#define IH_OS_NCR		12	/* NCR		*/
-#define IH_OS_LYNXOS		13	/* LynxOS	*/
-#define IH_OS_VXWORKS		14	/* VxWorks	*/
-#define IH_OS_PSOS		15	/* pSOS		*/
-#define IH_OS_QNX		16	/* QNX		*/
-#define IH_OS_U_BOOT		17	/* Firmware	*/
-#define IH_OS_RTEMS		18	/* RTEMS	*/
-#define IH_OS_ARTOS		19	/* ARTOS	*/
-#define IH_OS_UNITY		20	/* Unity OS	*/
-
-/*
- * CPU Architecture Codes (supported by Linux)
- */
-#define IH_CPU_INVALID		0	/* Invalid CPU	*/
-#define IH_CPU_ALPHA		1	/* Alpha	*/
-#define IH_CPU_ARM		2	/* ARM		*/
-#define IH_CPU_I386		3	/* Intel x86	*/
-#define IH_CPU_IA64		4	/* IA64		*/
-#define IH_CPU_MIPS		5	/* MIPS		*/
-#define IH_CPU_MIPS64		6	/* MIPS	 64 Bit */
-#define IH_CPU_PPC		7	/* PowerPC	*/
-#define IH_CPU_S390		8	/* IBM S390	*/
-#define IH_CPU_SH		9	/* SuperH	*/
-#define IH_CPU_SPARC		10	/* Sparc	*/
-#define IH_CPU_SPARC64		11	/* Sparc 64 Bit */
-#define IH_CPU_M68K		12	/* M68K		*/
-#define IH_CPU_NIOS		13	/* Nios-32	*/
-#define IH_CPU_MICROBLAZE	14	/* MicroBlaze   */
-#define IH_CPU_NIOS2		15	/* Nios-II	*/
-#define IH_CPU_BLACKFIN		16	/* Blackfin	*/
-#define IH_CPU_AVR32		17	/* AVR32	*/
-
-/*
- * Image Types
- *
- * "Standalone Programs" are directly runnable in the environment
- *	provided by U-Boot; it is expected that (if they behave
- *	well) you can continue to work in U-Boot after return from
- *	the Standalone Program.
- * "OS Kernel Images" are usually images of some Embedded OS which
- *	will take over control completely. Usually these programs
- *	will install their own set of exception handlers, device
- *	drivers, set up the MMU, etc. - this means, that you cannot
- *	expect to re-enter U-Boot except by resetting the CPU.
- * "RAMDisk Images" are more or less just data blocks, and their
- *	parameters (address, size) are passed to an OS kernel that is
- *	being started.
- * "Multi-File Images" contain several images, typically an OS
- *	(Linux) kernel image and one or more data images like
- *	RAMDisks. This construct is useful for instance when you want
- *	to boot over the network using BOOTP etc., where the boot
- *	server provides just a single image file, but you want to get
- *	for instance an OS kernel and a RAMDisk image.
- *
- *	"Multi-File Images" start with a list of image sizes, each
- *	image size (in bytes) specified by an "uint32_t" in network
- *	byte order. This list is terminated by an "(uint32_t)0".
- *	Immediately after the terminating 0 follow the images, one by
- *	one, all aligned on "uint32_t" boundaries (size rounded up to
- *	a multiple of 4 bytes - except for the last file).
- *
- * "Firmware Images" are binary images containing firmware (like
- *	U-Boot or FPGA images) which usually will be programmed to
- *	flash memory.
- *
- * "Script files" are command sequences that will be executed by
- *	U-Boot's command interpreter; this feature is especially
- *	useful when you configure U-Boot to use a real shell (hush)
- *	as command interpreter (=> Shell Scripts).
- */
-
-#define IH_TYPE_INVALID		0	/* Invalid Image		*/
-#define IH_TYPE_STANDALONE	1	/* Standalone Program		*/
-#define IH_TYPE_KERNEL		2	/* OS Kernel Image		*/
-#define IH_TYPE_RAMDISK		3	/* RAMDisk Image		*/
-#define IH_TYPE_MULTI		4	/* Multi-File Image		*/
-#define IH_TYPE_FIRMWARE	5	/* Firmware Image		*/
-#define IH_TYPE_SCRIPT		6	/* Script file			*/
-#define IH_TYPE_FILESYSTEM	7	/* Filesystem Image (any type)	*/
-#define IH_TYPE_FLATDT		8	/* Binary Flat Device Tree Blob	*/
-
-/*
- * Compression Types
- */
-#define IH_COMP_NONE		0	/*  No	 Compression Used	*/
-#define IH_COMP_GZIP		1	/* gzip	 Compression Used	*/
-#define IH_COMP_BZIP2		2	/* bzip2 Compression Used	*/
-#define IH_COMP_LZMA		3	/* lzma  Compression Used	*/
-
-#define IH_MAGIC	0x27051956	/* Image Magic Number		*/
-#define IH_NMLEN		32	/* Image Name Length		*/
-
-/*
- * all data in network byte order (aka natural aka bigendian)
- */
-
-typedef struct image_header {
-	uint32_t	ih_magic;	/* Image Header Magic Number	*/
-	uint32_t	ih_hcrc;	/* Image Header CRC Checksum	*/
-	uint32_t	ih_time;	/* Image Creation Timestamp	*/
-	uint32_t	ih_size;	/* Image Data Size		*/
-	uint32_t	ih_load;	/* Data	 Load  Address		*/
-	uint32_t	ih_ep;		/* Entry Point Address		*/
-	uint32_t	ih_dcrc;	/* Image Data CRC Checksum	*/
-	uint8_t		ih_os;		/* Operating System		*/
-	uint8_t		ih_arch;	/* CPU architecture		*/
-	uint8_t		ih_type;	/* Image Type			*/
-	uint8_t		ih_comp;	/* Compression Type		*/
-	uint8_t		ih_name[IH_NMLEN];	/* Image Name		*/
-} image_header_t;
-
-
-#endif	/* __IMAGE_H__ */
diff --git a/kexec/arch/sh/Makefile b/kexec/arch/sh/Makefile
index 6e53626..9ccd008 100644
--- a/kexec/arch/sh/Makefile
+++ b/kexec/arch/sh/Makefile
@@ -2,6 +2,7 @@
 # kexec sh (linux booting linux)
 #
 sh_KEXEC_SRCS += kexec/arch/sh/kexec-sh.c
+sh_KEXEC_SRCS += kexec/arch/sh/kexec-uImage-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/kexec-zImage-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/kexec-netbsd-sh.c
 sh_KEXEC_SRCS += kexec/arch/sh/kexec-elf-sh.c
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 141ea8b..d04989d 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -73,9 +73,12 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 
 /* Supported file types and callbacks */
 struct file_type file_type[] = {
-       {"zImage-sh", zImage_sh_probe, zImage_sh_load, zImage_sh_usage},
-       {"elf-sh", elf_sh_probe, elf_sh_load, elf_sh_usage},
-       {"netbsd-sh", netbsd_sh_probe, netbsd_sh_load, netbsd_sh_usage},
+	/* uImage is probed before zImage because the latter also accepts
+	   uncompressed images. */
+	{ "uImage-sh", uImage_sh_probe, uImage_sh_load, zImage_sh_usage },
+	{ "zImage-sh", zImage_sh_probe, zImage_sh_load, zImage_sh_usage },
+	{ "elf-sh", elf_sh_probe, elf_sh_load, elf_sh_usage },
+	{ "netbsd-sh", netbsd_sh_probe, netbsd_sh_load, netbsd_sh_usage },
 };
 int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
diff --git a/kexec/arch/sh/kexec-sh.h b/kexec/arch/sh/kexec-sh.h
index 3b46a47..2d50af6 100644
--- a/kexec/arch/sh/kexec-sh.h
+++ b/kexec/arch/sh/kexec-sh.h
@@ -3,6 +3,10 @@
 
 #define COMMAND_LINE_SIZE 2048
 
+int uImage_sh_probe(const char *buf, off_t len);
+int uImage_sh_load(int argc, char **argv, const char *buf, off_t len,
+		        struct kexec_info *info);
+
 int zImage_sh_probe(const char *buf, off_t len);
 int zImage_sh_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info);
diff --git a/kexec/arch/sh/kexec-uImage-sh.c b/kexec/arch/sh/kexec-uImage-sh.c
new file mode 100644
index 0000000..869bbd4
--- /dev/null
+++ b/kexec/arch/sh/kexec-uImage-sh.c
@@ -0,0 +1,35 @@
+/*
+ * uImage support added by Marc Andre Tanner <mat@brain-dump.org>
+ *
+ * Cloned from ARM by Paul Mundt, 2009.
+ */
+#include <stdint.h>
+#include <string.h>
+#include <sys/types.h>
+#include <image.h>
+#include "../../kexec.h"
+#include "kexec-sh.h"
+
+int uImage_sh_probe(const char *buf, off_t len)
+{
+	struct image_header header;
+
+	if (len < sizeof(header))
+		return -1;
+
+	memcpy(&header, buf, sizeof(header));
+
+	if (cpu_to_be32(header.ih_magic) != IH_MAGIC)
+		return -1;
+
+	/* XXX: check CRC Checksum? */
+
+	return 0;
+}
+
+int uImage_sh_load(int argc, char **argv, const char *buf, off_t len,
+	struct kexec_info *info)
+{
+	return zImage_sh_load(argc, argv, buf + sizeof(struct image_header),
+			      len - sizeof(struct image_header), info);
+}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
