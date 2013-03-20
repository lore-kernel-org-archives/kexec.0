Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIItz-0003nV-VP
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 13:18:05 +0000
Received: by mail-pd0-f172.google.com with SMTP id w10so607407pde.17
 for <kexec@lists.infradead.org>; Wed, 20 Mar 2013 06:17:58 -0700 (PDT)
Message-ID: <5149B6FF.70908@gmail.com>
Date: Wed, 20 Mar 2013 21:17:51 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] kexec: Use err() instead of fprintf()
References: <5149B68C.1080704@gmail.com>
In-Reply-To: <5149B68C.1080704@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Since we have the err() interface, so replace the error printing
function with err().

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/arch/arm/kexec-arm.c            |    3 +-
 kexec/arch/arm/kexec-zImage-arm.c     |   18 ++++-----
 kexec/arch/i386/crashdump-x86.c       |   37 ++++++++---------
 kexec/arch/i386/kexec-bzImage.c       |   18 ++++----
 kexec/arch/i386/kexec-elf-x86.c       |    4 +-
 kexec/arch/i386/kexec-multiboot-x86.c |   11 ++---
 kexec/arch/i386/kexec-nbi.c           |   14 +++---
 kexec/arch/i386/kexec-x86-common.c    |   27 ++++++-------
 kexec/arch/i386/kexec-x86.c           |    9 +---
 kexec/arch/i386/x86-linux-setup.c     |   19 ++++-----
 kexec/arch/ia64/crashdump-ia64.c      |    5 +-
 kexec/arch/ia64/kexec-elf-ia64.c      |   12 +++---
 kexec/arch/ia64/kexec-ia64.c          |    3 +-
 kexec/arch/mips/crashdump-mips.c      |   11 ++---
 kexec/arch/mips/kexec-elf-mips.c      |    2 +-
 kexec/arch/mips/kexec-mips.c          |    4 +-
 kexec/arch/ppc/crashdump-powerpc.c    |    5 +-
 kexec/arch/ppc/fixup_dtb.c            |    3 +-
 kexec/arch/ppc/kexec-dol-ppc.c        |   14 +++----
 kexec/arch/ppc/kexec-elf-ppc.c        |    4 +-
 kexec/arch/ppc/kexec-ppc.c            |   36 ++++++++--------
 kexec/arch/ppc/kexec-uImage-ppc.c     |    2 +-
 kexec/arch/ppc64/crashdump-ppc64.c    |   10 ++---
 kexec/arch/ppc64/fs2dt.c              |    2 +-
 kexec/arch/ppc64/kexec-elf-ppc64.c    |   17 ++++----
 kexec/arch/ppc64/kexec-ppc64.c        |    6 +-
 kexec/arch/ppc64/kexec-zImage-ppc64.c |   18 +++-----
 kexec/arch/s390/kexec-image.c         |    4 +-
 kexec/arch/s390/kexec-s390.c          |    2 +-
 kexec/arch/sh/kexec-sh.c              |    2 +-
 kexec/arch/x86_64/kexec-bzImage64.c   |   16 ++++----
 kexec/arch/x86_64/kexec-elf-x86_64.c  |    6 +-
 kexec/arch/x86_64/kexec-x86_64.c      |    5 +-
 kexec/crashdump-xen.c                 |    8 ++--
 kexec/firmware_memmap.c               |   12 ++---
 kexec/fs2dt.c                         |    2 +-
 kexec/kernel_version.c                |   17 +++-----
 kexec/kexec-elf-exec.c                |    8 ++--
 kexec/kexec-elf-rel.c                 |   10 ++--
 kexec/kexec-elf.c                     |   70 ++++++++++++++++-----------------
 kexec/kexec.c                         |   64 ++++++++++++------------------
 kexec/phys_arch.c                     |    6 +--
 kexec/zlib.c                          |    2 +-
 43 files changed, 249 insertions(+), 299 deletions(-)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 8646833..c1aac4e 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -31,8 +31,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	FILE *fp;
 	fp = fopen(iomem, "r");
 	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n",
-			iomem, strerror(errno));
+		err("Cannot open %s: %s\n", iomem, strerror(errno));
 		return -1;
 	}
 
diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index dd2e06f..d653832 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -114,8 +114,7 @@ struct tag * atag_read_tags(void)
 	FILE *fp;
 	fp = fopen(fn, "r");
 	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n", 
-			fn, strerror(errno));
+		err("Cannot open %s: %s\n", fn, strerror(errno));
 		return NULL;
 	}
 
@@ -125,8 +124,7 @@ struct tag * atag_read_tags(void)
 	}
 
 	if (ferror(fp)) {
-		fprintf(stderr, "Cannot read %s: %s\n",
-			fn, strerror(errno));
+		err("Cannot read %s: %s\n", fn, strerror(errno));
 		fclose(fp);
 		return NULL;
 	}
@@ -149,7 +147,7 @@ int atag_arm_load(struct kexec_info *info, unsigned long base,
 	
 	buf = xmalloc(getpagesize());
 	if (!buf) {
-		fprintf(stderr, "Compiling ATAGs: out of memory\n");
+		err("Compiling ATAGs: out of memory\n");
 		return -1;
 	}
 
@@ -282,7 +280,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	}
 
 	if (use_atags && dtb_file) {
-		fprintf(stderr, "You can only use ATAGs if you don't specify a "
+		err("You can only use ATAGs if you don't specify a "
 		        "dtb file.\n");
 		return -1;
 	}
@@ -361,7 +359,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			dtb_buf = slurp_file(dtb_file, &dtb_length);
 
 			if (fdt_check_header(dtb_buf) != 0) {
-				fprintf(stderr, "Invalid FDT buffer.\n");
+				err("Invalid FDT buffer.\n");
 				return -1;
 			}
 
@@ -382,13 +380,13 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 					off = fdt_add_subnode(dtb_buf, off, node_name);
 
 				if (off < 0) {
-					fprintf(stderr, "FDT: Error adding %s node.\n", node_name);
+					err("FDT: Error adding %s node.\n", node_name);
 					return -1;
 				}
 
 				if (fdt_setprop(dtb_buf, off, prop_name,
 						command_line, strlen(command_line) + 1) != 0) {
-					fprintf(stderr, "FDT: Error setting %s/%s property.\n",
+					err("FDT: Error setting %s/%s property.\n",
 						node_name, prop_name);
 					return -1;
 				}
@@ -401,7 +399,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		}
 
 		if (base + atag_offset + dtb_length > base + offset) {
-			fprintf(stderr, "DTB too large!\n");
+			err("DTB too large!\n");
 			return -1;
 		}
 
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 31748c2..b5b483e 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -101,7 +101,7 @@ static int get_kernel_paddr(struct kexec_info *UNUSED(info),
 		return 0;
 	}
 
-	fprintf(stderr, "Cannot determine kernel physical load addr\n");
+	err("Cannot determine kernel physical load addr\n");
 	return -1;
 }
 
@@ -134,7 +134,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 	size = KCORE_ELF_HEADERS_SIZE;
 	buf = slurp_file_len(kcore, size);
 	if (!buf) {
-		fprintf(stderr, "Cannot read %s: %s\n", kcore, strerror(errno));
+		err("Cannot read %s: %s\n", kcore, strerror(errno));
 		return -1;
 	}
 
@@ -147,7 +147,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 	result = build_elf_core_info(buf, size, &ehdr, elf_flags);
 	if (result < 0) {
 		/* Perhaps KCORE_ELF_HEADERS_SIZE is too small? */
-		fprintf(stderr, "ELF core (kcore) parse failed\n");
+		err("ELF core (kcore) parse failed\n");
 		return -1;
 	}
 
@@ -175,7 +175,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info *UNUSED(info),
 			}
 		}
 	}
-	fprintf(stderr, "Can't find kernel text map area from kcore\n");
+	err("Can't find kernel text map area from kcore\n");
 	return -1;
 }
 
@@ -215,8 +215,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 
 	fp = fopen(iomem, "r");
 	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n",
-			iomem, strerror(errno));
+		err("Cannot open %s: %s\n", iomem, strerror(errno));
 		return -1;
 	}
 
@@ -277,8 +276,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 			}
 		}
 		if (crash_reserved_mem.start >= mem_max) {
-			fprintf(stderr, "Too small mem_max: 0x%llx.\n",
-				mem_max);
+			err("Too small mem_max: 0x%llx.\n", mem_max);
 			return -1;
 		}
 		crash_reserved_mem.end = mem_max;
@@ -320,14 +318,14 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 	xc = xc_interface_open(NULL, NULL, 0);
 
 	if (!xc) {
-		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
+		err("%s: Failed to open Xen control interface\n", __func__);
 		goto err;
 	}
 #else
 	xc = xc_interface_open();
 
 	if (xc == -1) {
-		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
+		err("%s: Failed to open Xen control interface\n", __func__);
 		goto err;
 	}
 #endif
@@ -335,7 +333,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 	rc = xc_get_machine_memory_map(xc, e820entries, CRASH_MAX_MEMORY_RANGES);
 
 	if (rc < 0) {
-		fprintf(stderr, "%s: xc_get_machine_memory_map: %s\n", __func__, strerror(-rc));
+		err("%s: xc_get_machine_memory_map: %s\n", __func__, strerror(-rc));
 		goto err;
 	}
 
@@ -375,7 +373,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 	fd = open("/proc/xen/privcmd", O_RDWR);
 
 	if (fd == -1) {
-		fprintf(stderr, "%s: open(/proc/xen/privcmd): %m\n", __func__);
+		err("%s: open(/proc/xen/privcmd): %m\n", __func__);
 		goto err;
 	}
 
@@ -383,7 +381,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 			    sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES);
 
 	if (rc) {
-		fprintf(stderr, "%s: posix_memalign(e820entries): %s\n", __func__, strerror(rc));
+		err("%s: posix_memalign(e820entries): %s\n", __func__, strerror(rc));
 		e820entries = NULL;
 		goto err;
 	}
@@ -392,18 +390,18 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 			    sizeof(struct xen_memory_map));
 
 	if (rc) {
-		fprintf(stderr, "%s: posix_memalign(xen_memory_map): %s\n", __func__, strerror(rc));
+		err("%s: posix_memalign(xen_memory_map): %s\n", __func__, strerror(rc));
 		xen_memory_map = NULL;
 		goto err;
 	}
 
 	if (mlock(e820entries, sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES) == -1) {
-		fprintf(stderr, "%s: mlock(e820entries): %m\n", __func__);
+		err("%s: mlock(e820entries): %m\n", __func__);
 		goto err;
 	}
 
 	if (mlock(xen_memory_map, sizeof(struct xen_memory_map)) == -1) {
-		fprintf(stderr, "%s: mlock(xen_memory_map): %m\n", __func__);
+		err("%s: mlock(xen_memory_map): %m\n", __func__);
 		goto err;
 	}
 
@@ -417,7 +415,7 @@ static int get_crash_memory_ranges_xen(struct memory_range **range,
 	rc = ioctl(fd, IOCTL_PRIVCMD_HYPERCALL, &hypercall);
 
 	if (rc == -1) {
-		fprintf(stderr, "%s: ioctl(IOCTL_PRIVCMD_HYPERCALL): %m\n", __func__);
+		err("%s: ioctl(IOCTL_PRIVCMD_HYPERCALL): %m\n", __func__);
 		goto err;
 	}
 
@@ -513,7 +511,7 @@ static int exclude_region(int *nr_ranges, uint64_t start, uint64_t end)
 	if (tidx >= 0) {
 		if (*nr_ranges == CRASH_MAX_MEMORY_RANGES) {
 			/* No space to insert another element. */
-			fprintf(stderr, "Error: Number of crash memory ranges"
+			err("Error: Number of crash memory ranges"
 					" excedeed the max limit\n");
 			return -1;
 		}
@@ -970,8 +968,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		elf_info.get_note_info = get_crash_notes;
 		break;
 	default:
-		fprintf(stderr, "unsupported crashdump architecture: %04x\n",
-			kexec_arch);
+		err("unsupported crashdump architecture: %04x\n", kexec_arch);
 		return -1;
 	}
 
diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 99fd790..d80edee 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -46,41 +46,41 @@ int bzImage_probe(const char *buf, off_t len)
 	const struct x86_linux_header *header;
 	if ((uintmax_t)len < (uintmax_t)(2 * 512)) {
 		if (probe_debug) {
-			fprintf(stderr, "File is too short to be a bzImage!\n");
+			err("File is too short to be a bzImage!\n");
 		}
 		return -1;
 	}
 	header = (const struct x86_linux_header *)buf;
 	if (memcmp(header->header_magic, "HdrS", 4) != 0) {
 		if (probe_debug) {
-			fprintf(stderr, "Not a bzImage\n");
+			err("Not a bzImage\n");
 		}
 		return -1;
 	}
 	if (header->boot_sector_magic != 0xAA55) {
 		if (probe_debug) {
-			fprintf(stderr, "No x86 boot sector present\n");
+			err("No x86 boot sector present\n");
 		}
 		/* No x86 boot sector present */
 		return -1;
 	}
 	if (header->protocol_version < 0x0200) {
 		if (probe_debug) {
-			fprintf(stderr, "Must be at least protocol version 2.00\n");
+			err("Must be at least protocol version 2.00\n");
 		}
 		/* Must be at least protocol version 2.00 */
 		return -1;
 	}
 	if ((header->loadflags & 1) == 0) {
 		if (probe_debug) {
-			fprintf(stderr, "zImage not a bzImage\n");
+			err("zImage not a bzImage\n");
 		}
 		/* Not a bzImage */
 		return -1;
 	}
 	/* I've got a bzImage */
 	if (probe_debug) {
-		fprintf(stderr, "It's a bzImage\n");
+		err("It's a bzImage\n");
 	}
 	return 0;
 }
@@ -135,7 +135,7 @@ int do_bzImage_load(struct kexec_info *info,
 	kern16_size = (setup_sects +1) *512;
 	kernel_version = ((char *)&setup_header) + 512 + setup_header.kver_addr;
 	if (kernel_len < kern16_size) {
-		fprintf(stderr, "BzImage truncated?\n");
+		err("BzImage truncated?\n");
 		return -1;
 	}
 
@@ -158,13 +158,13 @@ int do_bzImage_load(struct kexec_info *info,
 
 	/* Can't use bzImage for crash dump purposes with real mode entry */
 	if((info->kexec_flags & KEXEC_ON_CRASH) && real_mode_entry) {
-		fprintf(stderr, "Can't use bzImage for crash dump purposes"
+		err("Can't use bzImage for crash dump purposes"
 				" with real mode entry\n");
 		return -1;
 	}
 
 	if((info->kexec_flags & KEXEC_ON_CRASH) && !relocatable_kernel) {
-		fprintf(stderr, "BzImage is not relocatable. Can't be used"
+		err("BzImage is not relocatable. Can't be used"
 				" as capture kernel.\n");
 		return -1;
 	}
diff --git a/kexec/arch/i386/kexec-elf-x86.c b/kexec/arch/i386/kexec-elf-x86.c
index e62ebcb..b0908fd 100644
--- a/kexec/arch/i386/kexec-elf-x86.c
+++ b/kexec/arch/i386/kexec-elf-x86.c
@@ -50,7 +50,7 @@ int elf_x86_probe(const char *buf, off_t len)
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
 	if (result < 0) {
 		if (probe_debug) {
-			fprintf(stderr, "Not an ELF executable\n");
+			err("Not an ELF executable\n");
 		}
 		goto out;
 	}
@@ -59,7 +59,7 @@ int elf_x86_probe(const char *buf, off_t len)
 	if ((ehdr.e_machine != EM_386) && (ehdr.e_machine != EM_486)) {
 		/* for a different architecture */
 		if (probe_debug) {
-			fprintf(stderr, "Not i386 ELF executable\n");
+			err("Not i386 ELF executable\n");
 		}
 		result = -1;
 		goto out;
diff --git a/kexec/arch/i386/kexec-multiboot-x86.c b/kexec/arch/i386/kexec-multiboot-x86.c
index 3f787e1..09ee081 100644
--- a/kexec/arch/i386/kexec-multiboot-x86.c
+++ b/kexec/arch/i386/kexec-multiboot-x86.c
@@ -93,16 +93,14 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
 		}
 		if (mbh->flags & MULTIBOOT_AOUT_KLUDGE) {
 			/* Requires options we don't support */
-			fprintf(stderr, 
-				"Found a multiboot header, but it uses "
+			err("Found a multiboot header, but it uses "
 				"a non-ELF header layout,\n"
 				"and I can't do that (yet).  Sorry.\n");
 			return -1;
 		} 
 		if (mbh->flags & MULTIBOOT_UNSUPPORTED) {
 			/* Requires options we don't support */
-			fprintf(stderr, 
-				"Found a multiboot header, but it "
+			err("Found a multiboot header, but it "
 				"requires multiboot options that I\n"
 				"don't understand.  Sorry.\n");
 			return -1;
@@ -110,8 +108,7 @@ int multiboot_x86_probe(const char *buf, off_t buf_len)
 		if (mbh->flags & MULTIBOOT_VIDEO_MODE) { 
 			/* Asked for screen mode information */
 			/* XXX carry on regardless */
-			fprintf(stderr, 
-				"BEWARE!  Found a multiboot header which asks "
+			err("BEWARE!  Found a multiboot header which asks "
 				"for screen mode information.\n"
 				"BEWARE!  I am NOT supplying screen mode "
                                 "information, but loading it regardless.\n");
@@ -171,7 +168,7 @@ int multiboot_x86_load(int argc, char **argv, const char *buf, off_t len,
 	/* Probe for the MB header if it's not already found */
 	if (mbh == NULL && multiboot_x86_probe(buf, len) != 1) 
 	{
-		fprintf(stderr, "Cannot find a loadable multiboot header.\n");
+		err("Cannot find a loadable multiboot header.\n");
 		return -1;
 	}
 
diff --git a/kexec/arch/i386/kexec-nbi.c b/kexec/arch/i386/kexec-nbi.c
index 443a3a7..c0d936a 100644
--- a/kexec/arch/i386/kexec-nbi.c
+++ b/kexec/arch/i386/kexec-nbi.c
@@ -84,7 +84,7 @@ int nbi_probe(const char *buf, off_t len)
 	/* Ensure we have a properly sized header */
 	if (((hdr.length & 0xf)*4) != sizeof(hdr)) {
 		if (probe_debug) {
-			fprintf(stderr, "NBI: Bad vendor header size\n");
+			err("NBI: Bad vendor header size\n");
 		}
 		return -1;
 	}
@@ -93,14 +93,14 @@ int nbi_probe(const char *buf, off_t len)
 	 */
 	if ((((hdr.length & 0xf0) >> 4)*4) > (512 - sizeof(hdr))) {
 		if (probe_debug) {
-			fprintf(stderr, "NBI: vendor headr too large\n");
+			err("NBI: vendor headr too large\n");
 		}
 		return -1;
 	}
 	/* Reserved bits are set in the image... */
 	if ((hdr.length & 0x7ffffe00)) {
 		if (probe_debug) {
-			fprintf(stderr, "NBI: Reserved header bits set\n");
+			err("NBI: Reserved header bits set\n");
 		}
 		return -1;
 	}
@@ -117,26 +117,26 @@ int nbi_probe(const char *buf, off_t len)
 		memcpy(&seg, buf + seg_off, sizeof(seg));
 		if ((seg.length & 0xf) != 4) {
 			if (probe_debug) {
-				fprintf(stderr, "NBI: Invalid segment length\n");
+				err("NBI: Invalid segment length\n");
 			}
 			return -1;
 		}
 		seg_off += ((seg.length & 0xf) + ((seg.length >> 4) & 0xf)) << 2;
 		if (seg.flags & 0xf8) {
 			if (probe_debug) {
-				fprintf(stderr, "NBI: segment reserved flags set\n");
+				err("NBI: segment reserved flags set\n");
 			}
 			return -1;
 		}
 		if ((seg.flags & NBI_SEG) == NBI_SEG_NEGATIVE) {
 			if (probe_debug) {
-				fprintf(stderr, "NBI: negative segment addresses not supported\n");
+				err("NBI: negative segment addresses not supported\n");
 			}
 			return -1;
 		}
 		if (seg_off > 512) {
 			if (probe_debug) {
-				fprintf(stderr, "NBI: segment outside 512 header\n");
+				err("NBI: segment outside 512 header\n");
 			}
 			return -1;
 		}
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 234823c..5934ead 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -70,8 +70,7 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
 	FILE *fp;
 	fp = fopen(iomem, "r");
 	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n",
-			iomem, strerror(errno));
+		err("Cannot open %s: %s\n", iomem, strerror(errno));
 		return -1;
 	}
 	while(fgets(line, sizeof(line), fp) != 0) {
@@ -137,7 +136,7 @@ static int get_memory_ranges_sysfs(struct memory_range **range, int *ranges)
 
 	ret = get_firmware_memmap_ranges(memory_range, &range_number);
 	if (ret != 0) {
-		fprintf(stderr, "Parsing the /sys/firmware memory map failed. "
+		err("Parsing the /sys/firmware memory map failed. "
 			"Falling back to /proc/iomem.\n");
 		return get_memory_ranges_proc_iomem(range, ranges);
 	}
@@ -189,14 +188,14 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 	xc = xc_interface_open(NULL, NULL, 0);
 
 	if (!xc) {
-		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
+		err("%s: Failed to open Xen control interface\n", __func__);
 		goto err;
 	}
 #else
 	xc = xc_interface_open();
 
 	if (xc == -1) {
-		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
+		err("%s: Failed to open Xen control interface\n", __func__);
 		goto err;
 	}
 #endif
@@ -204,7 +203,7 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 	rc = xc_get_machine_memory_map(xc, e820entries, MAX_MEMORY_RANGES);
 
 	if (rc < 0) {
-		fprintf(stderr, "%s: xc_get_machine_memory_map: %s\n", __func__, strerror(rc));
+		err("%s: xc_get_machine_memory_map: %s\n", __func__, strerror(rc));
 		goto err;
 	}
 
@@ -238,7 +237,7 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 	fd = open("/proc/xen/privcmd", O_RDWR);
 
 	if (fd == -1) {
-		fprintf(stderr, "%s: open(/proc/xen/privcmd): %m\n", __func__);
+		err("%s: open(/proc/xen/privcmd): %m\n", __func__);
 		goto err;
 	}
 
@@ -246,7 +245,7 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 			    sizeof(struct e820entry) * MAX_MEMORY_RANGES);
 
 	if (rc) {
-		fprintf(stderr, "%s: posix_memalign(e820entries): %s\n", __func__, strerror(rc));
+		err("%s: posix_memalign(e820entries): %s\n", __func__, strerror(rc));
 		e820entries = NULL;
 		goto err;
 	}
@@ -255,18 +254,18 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 			    sizeof(struct xen_memory_map));
 
 	if (rc) {
-		fprintf(stderr, "%s: posix_memalign(xen_memory_map): %s\n", __func__, strerror(rc));
+		err("%s: posix_memalign(xen_memory_map): %s\n", __func__, strerror(rc));
 		xen_memory_map = NULL;
 		goto err;
 	}
 
 	if (mlock(e820entries, sizeof(struct e820entry) * MAX_MEMORY_RANGES) == -1) {
-		fprintf(stderr, "%s: mlock(e820entries): %m\n", __func__);
+		err("%s: mlock(e820entries): %m\n", __func__);
 		goto err;
 	}
 
 	if (mlock(xen_memory_map, sizeof(struct xen_memory_map)) == -1) {
-		fprintf(stderr, "%s: mlock(xen_memory_map): %m\n", __func__);
+		err("%s: mlock(xen_memory_map): %m\n", __func__);
 		goto err;
 	}
 
@@ -280,7 +279,7 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 	rc = ioctl(fd, IOCTL_PRIVCMD_HYPERCALL, &hypercall);
 
 	if (rc == -1) {
-		fprintf(stderr, "%s: ioctl(IOCTL_PRIVCMD_HYPERCALL): %m\n", __func__);
+		err("%s: ioctl(IOCTL_PRIVCMD_HYPERCALL): %m\n", __func__);
 		goto err;
 	}
 
@@ -347,7 +346,7 @@ again:
 	for (i = 0; i < (nr_ranges-1); i++) {
 		j = i+1;
 		if (rp[i].start > rp[j].start) {
-			fprintf(stderr, "memory out of order!!\n");
+			err("memory out of order!!\n");
 			return 1;
 		}
 
@@ -467,7 +466,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 
 		ret = parse_iomem_single("Crash kernel\n", &start, &end);
 		if (ret != 0) {
-			fprintf(stderr, "parse_iomem_single failed.\n");
+			err("parse_iomem_single failed.\n");
 			return -1;
 		}
 
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 014ecd5..f1c1820 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -106,8 +106,7 @@ int arch_process_options(int argc, char **argv)
 				}
 			}
 			if (value >= 65536) {
-				fprintf(stderr, "Bad serial port base '%s'\n",
-					optarg);
+				err("Bad serial port base '%s'\n", optarg);
 				usage();
 				return -1;
 
@@ -119,8 +118,7 @@ int arch_process_options(int argc, char **argv)
 			if ((value > 115200) || ((115200 %value) != 0) ||
 				(value < 9600) || (*end))
 			{
-				fprintf(stderr, "Bad serial port baud rate '%s'\n",
-					optarg);
+				err("Bad serial port baud rate '%s'\n", optarg);
 				usage();
 				return -1;
 
@@ -158,8 +156,7 @@ int arch_compat_trampoline(struct kexec_info *info)
 	if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64)
 	{
 		if (!info->rhdr.e_shdr) {
-			fprintf(stderr,
-				"A trampoline is required for cross architecture support\n");
+			err("A trampoline is required for cross architecture support\n");
 			return -1;
 		}
 		elf_rel_set_symbol(&info->rhdr, "compat_x86_64_entry32",
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 454fad6..e6475dd 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -272,7 +272,7 @@ static int read_edd_raw_data(const char *dir, struct edd_info *edd_info)
 	dbgprintf("EDD raw data has length %d\n", len);
 
 	if (read_chars < len) {
-		fprintf(stderr, "BIOS reported EDD length of %hd but only "
+		err("BIOS reported EDD length of %hd but only "
 			"%d chars read.\n", len, (int)read_chars);
 		return -1;
 	}
@@ -288,7 +288,7 @@ static int add_edd_entry(struct x86_linux_param_header *real_mode,
 	struct edd_info *edd_info;
 
 	if (!current_mbr || !current_edd) {
-		fprintf(stderr, "%s: current_edd and current_edd "
+		err("%s: current_edd and current_edd "
 				"must not be NULL", __FUNCTION__);
 		return -1;
 	}
@@ -298,7 +298,7 @@ static int add_edd_entry(struct x86_linux_param_header *real_mode,
 
 	/* extract the device number */
 	if (sscanf(basename(sysfs_name), "int13_dev%hhx", &devnum) != 1) {
-		fprintf(stderr, "Invalid format of int13_dev dir "
+		err("Invalid format of int13_dev dir "
 				"entry: %s\n", basename(sysfs_name));
 		return -1;
 	}
@@ -324,33 +324,33 @@ static int add_edd_entry(struct x86_linux_param_header *real_mode,
 		/* legacy_max_cylinder */
 		if (file_scanf(sysfs_name, "legacy_max_cylinder", "%hu",
 					&edd_info->legacy_max_cylinder) != 1) {
-			fprintf(stderr, "Reading legacy_max_cylinder failed.\n");
+			err("Reading legacy_max_cylinder failed.\n");
 			return -1;
 		}
 
 		/* legacy_max_head */
 		if (file_scanf(sysfs_name, "legacy_max_head", "%hhu",
 					&edd_info->legacy_max_head) != 1) {
-			fprintf(stderr, "Reading legacy_max_head failed.\n");
+			err("Reading legacy_max_head failed.\n");
 			return -1;
 		}
 
 		/* legacy_sectors_per_track */
 		if (file_scanf(sysfs_name, "legacy_sectors_per_track", "%hhu",
 					&edd_info->legacy_sectors_per_track) != 1) {
-			fprintf(stderr, "Reading legacy_sectors_per_track failed.\n");
+			err("Reading legacy_sectors_per_track failed.\n");
 			return -1;
 		}
 
 		/* Parse the EDD extensions */
 		if (parse_edd_extensions(sysfs_name, edd_info) != 0) {
-			fprintf(stderr, "Parsing EDD extensions failed.\n");
+			err("Parsing EDD extensions failed.\n");
 			return -1;
 		}
 
 		/* Parse the raw info */
 		if (read_edd_raw_data(sysfs_name, edd_info) != 0) {
-			fprintf(stderr, "Reading EDD raw data failed.\n");
+			err("Reading EDD raw data failed.\n");
 			return -1;
 		}
 	}
@@ -513,8 +513,7 @@ void setup_linux_system_parameters(struct kexec_info *info,
 			 * this e820 not used for capture kernel, see
 			 * do_bzImage_load()
 			 */
-			fprintf(stderr,
-				"Too many memory ranges, truncating...\n");
+			err("Too many memory ranges, truncating...\n");
 		ranges = E820MAX;
 	}
 	real_mode->e820_map_nr = ranges;
diff --git a/kexec/arch/ia64/crashdump-ia64.c b/kexec/arch/ia64/crashdump-ia64.c
index 726c9f4..b97245d 100644
--- a/kexec/arch/ia64/crashdump-ia64.c
+++ b/kexec/arch/ia64/crashdump-ia64.c
@@ -140,7 +140,7 @@ static int exclude_crash_reserve_region(int *nr_ranges)
 	if (tidx >= 0) {
 		if (*nr_ranges == max_memory_ranges) {
 			/* No space to insert another element. */
-			fprintf(stderr, "Error: Number of crash memory ranges"
+			err("Error: Number of crash memory ranges"
 					" excedeed the max limit\n");
 			return -1;
 		}
@@ -165,8 +165,7 @@ static int get_crash_memory_ranges(int *ranges)
 				max_memory_ranges);
         fp = fopen(iomem, "r");
         if (!fp) {
-                fprintf(stderr, "Cannot open %s: %s\n",
-                        iomem, strerror(errno));
+                err("Cannot open %s: %s\n", iomem, strerror(errno));
                 return -1;
         }
 	while(fgets(line, sizeof(line), fp) != 0) {
diff --git a/kexec/arch/ia64/kexec-elf-ia64.c b/kexec/arch/ia64/kexec-elf-ia64.c
index 7303c03..f53fe16 100644
--- a/kexec/arch/ia64/kexec-elf-ia64.c
+++ b/kexec/arch/ia64/kexec-elf-ia64.c
@@ -60,7 +60,7 @@ int elf_ia64_probe(const char *buf, off_t len)
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
 	if (result < 0) {
 		if (probe_debug) {
-			fprintf(stderr, "Not an ELF executable\n");
+			err("Not an ELF executable\n");
 		}
 		return -1;
 	}
@@ -68,7 +68,7 @@ int elf_ia64_probe(const char *buf, off_t len)
 	if (ehdr.e_machine != EM_IA_64) {
 		/* for a different architecture */
 		if (probe_debug) {
-			fprintf(stderr, "Not for this architecture.\n");
+			err("Not for this architecture.\n");
 		}
 		return -1;
 	}
@@ -186,21 +186,21 @@ int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
 	/* Parse the Elf file */
 	result = build_elf_exec_info(kernel_buf, kernel_size, &ehdr, 0);
 	if (result < 0) {
-		fprintf(stderr, "ELF parse failed\n");
+		err("ELF parse failed\n");
 		free_elf_info(&ehdr);
 		return result;
 	}
 
 	if (info->kexec_flags & KEXEC_ON_CRASH ) {
 		if ((mem_min == 0x00) && (mem_max == ULONG_MAX)) {
-			fprintf(stderr, "Failed to find crash kernel region "
+			err("Failed to find crash kernel region "
 				"in %s\n", proc_iomem());
 			free_elf_info(&ehdr);
 			return -1;
 		}
 		move_loaded_segments(&ehdr, mem_min);
 	} else if (update_loaded_segments(&ehdr) < 0) {
-		fprintf(stderr, "Failed to place kernel\n");
+		err("Failed to place kernel\n");
 		return -1;
 	}
 
@@ -210,7 +210,7 @@ int elf_ia64_load(int argc, char **argv, const char *buf, off_t len,
 	/* Load the Elf data */
 	result = elf_exec_load(&ehdr, info);
 	if (result < 0) {
-		fprintf(stderr, "ELF load failed\n");
+		err("ELF load failed\n");
 		free_elf_info(&ehdr);
 		return result;
 	}
diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
index 418d997..c41c924 100644
--- a/kexec/arch/ia64/kexec-ia64.c
+++ b/kexec/arch/ia64/kexec-ia64.c
@@ -84,8 +84,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	FILE *fp;
 	fp = fopen(iomem, "r");
 	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n",
-			iomem, strerror(errno));
+		err("Cannot open %s: %s\n", iomem, strerror(errno));
 		return -1;
 	}
 
diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 8e7b1c3..2fda451 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -64,7 +64,7 @@ static int get_kernel_paddr(struct crash_elf_info *elf_info)
 		return 0;
 	}
 
-	fprintf(stderr, "Cannot determine kernel physical load addr\n");
+	err("Cannot determine kernel physical load addr\n");
 	return -1;
 }
 
@@ -86,7 +86,7 @@ static int get_kernel_vaddr_and_size(struct crash_elf_info *elf_info,
 		dbgprintf("kernel size = 0x%lx\n", elf_info->kern_size);
 		return 0;
 		}
-	fprintf(stderr, "Cannot determine kernel virtual load addr and  size\n");
+	err("Cannot determine kernel virtual load addr and  size\n");
 	return -1;
 }
 
@@ -128,8 +128,8 @@ static int exclude_crash_reserve_region(int *nr_ranges)
 	if (tidx >= 0) {
 		if (*nr_ranges == CRASH_MAX_MEMORY_RANGES) {
 			/* No space to insert another element. */
-			fprintf(stderr, "Error: Number of crash memory ranges"
-					" excedeed the max limit\n");
+			err("Error: Number of crash memory ranges"
+				" excedeed the max limit\n");
 			return -1;
 		}
 		for (j = (*nr_ranges - 1); j >= tidx; j--)
@@ -162,8 +162,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 
 	fp = fopen(iomem, "r");
 	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n",
-			iomem, strerror(errno));
+		err("Cannot open %s: %s\n", iomem, strerror(errno));
 		return -1;
 	}
 	/* Separate segment for backup region */
diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
index 6951247..b1651b5 100644
--- a/kexec/arch/mips/kexec-elf-mips.c
+++ b/kexec/arch/mips/kexec-elf-mips.c
@@ -50,7 +50,7 @@ int elf_mips_probe(const char *buf, off_t len)
 	if (ehdr.e_machine != EM_MIPS) {
 		/* for a different architecture */
 		if (probe_debug) {
-			fprintf(stderr, "Not for this architecture.\n");
+			err("Not for this architecture.\n");
 		}
 		result = -1;
 		goto out;
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index fe0c945..01f8402 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -38,7 +38,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 
 	fp = fopen(iomem, "r");
 	if (!fp) {
-		fprintf(stderr, "Cannot open %s: %s\n", iomem, strerror(errno));
+		err("Cannot open %s: %s\n", iomem, strerror(errno));
 		return -1;
 	}
 	while (fgets(line, sizeof(line), fp) != 0) {
@@ -75,7 +75,7 @@ int file_types = sizeof(file_type) / sizeof(file_type[0]);
 void arch_usage(void)
 {
 #ifdef __mips64
-	fprintf(stderr, "     --elf32-core-headers Prepare core headers in "
+	err("     --elf32-core-headers Prepare core headers in "
 			"ELF32 format\n");
 #endif
 }
diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index eee5b37..cff678a 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -90,7 +90,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 
 	crash_memory_range = (struct memory_range *) malloc(crash_rng_len);
 	if (!crash_memory_range) {
-		fprintf(stderr, "Allocation for crash memory range failed\n");
+		err("Allocation for crash memory range failed\n");
 		return -1;
 	}
 	memset(crash_memory_range, 0, crash_rng_len);
@@ -141,8 +141,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 			}
 			if (memory_ranges >= (max_memory_ranges + 1)) {
 				/* No space to insert another element. */
-				fprintf(stderr,
-					"Error: Number of crash memory ranges"
+				err("Error: Number of crash memory ranges"
 					" excedeed the max limit\n");
 				goto err;
 			}
diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index f832026..b7f5f01 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -58,8 +58,7 @@ static void fixup_nodes(char *nodes[])
 
 		content = slurp_file(fname, &content_size);
 		if (!content) {
-			fprintf(stderr, "Can't open %s: %s\n",
-					fname, strerror(errno));
+			err("Can't open %s: %s\n", fname, strerror(errno));
 			exit(1);
 		}
 
diff --git a/kexec/arch/ppc/kexec-dol-ppc.c b/kexec/arch/ppc/kexec-dol-ppc.c
index 8d0d1a0..7deb263 100644
--- a/kexec/arch/ppc/kexec-dol-ppc.c
+++ b/kexec/arch/ppc/kexec-dol-ppc.c
@@ -242,7 +242,7 @@ int dol_ppc_probe(const char *buf, off_t dol_length)
 	/* the DOL file should be at least as long as the DOL header */
 	if (dol_length < DOL_HEADER_SIZE) {
 		if (debug) {
-			fprintf(stderr, "Not a DOL file, too short.\n");
+			err("Not a DOL file, too short.\n");
 		}
 		return -1;
 	}
@@ -257,8 +257,7 @@ int dol_ppc_probe(const char *buf, off_t dol_length)
 		if ((dol_sect_offset(h, i) != 0)
 		    && (dol_sect_offset(h, i) < DOL_HEADER_SIZE)) {
 			if (debug) {
-				fprintf(stderr,
-					"%s segment offset within DOL header\n",
+				err("%s segment offset within DOL header\n",
 					dol_sect_type(i));
 			}
 			return -1;
@@ -268,8 +267,7 @@ int dol_ppc_probe(const char *buf, off_t dol_length)
 		if ((uintmax_t)(dol_sect_offset(h, i) + dol_sect_size(h, i)) >
 		    (uintmax_t)dol_length) {
 			if (debug) {
-				fprintf(stderr,
-					"%s segment past DOL file size\n",
+				err("%s segment past DOL file size\n",
 					dol_sect_type(i));
 			}
 			return -1;
@@ -278,7 +276,7 @@ int dol_ppc_probe(const char *buf, off_t dol_length)
 		/* we only should accept DOLs with segments above 2GB */
 		if (dol_sect_address(h, i) != 0
 		    && !(dol_sect_address(h, i) & 0x80000000)) {
-			fprintf(stderr, "warning, %s segment below 2GB\n",
+			err("warning, %s segment below 2GB\n",
 				dol_sect_type(i));
 		}
 
@@ -293,13 +291,13 @@ int dol_ppc_probe(const char *buf, off_t dol_length)
 
 	/* if there is a BSS segment it must^H^H^H^Hshould be above 2GB, too */
 	if (h->address_bss != 0 && !(h->address_bss & 0x80000000)) {
-		fprintf(stderr, "warning, BSS segment below 2GB\n");
+		err("warning, BSS segment below 2GB\n");
 	}
 
 	/* if entrypoint is not within a code segment reject this file */
 	if (!valid) {
 		if (debug) {
-			fprintf(stderr, "Entry point out of text segment\n");
+			err("Entry point out of text segment\n");
 		}
 		return -1;
 	}
diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
index 65a65cc..c75727c 100644
--- a/kexec/arch/ppc/kexec-elf-ppc.c
+++ b/kexec/arch/ppc/kexec-elf-ppc.c
@@ -88,7 +88,7 @@ int elf_ppc_probe(const char *buf, off_t len)
 	if (ehdr.e_machine != EM_PPC) {
 		/* for a different architecture */
 		if (probe_debug) {
-			fprintf(stderr, "Not for this architecture.\n");
+			err("Not for this architecture.\n");
 		}
 		result = -1;
 		goto out;
@@ -223,7 +223,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
 
 		case OPT_NODES:
 			if (cur_fixup >= FIXUP_ENTRYS) {
-				fprintf(stderr, "The number of entries for the fixup is too large\n");
+				err("The number of entries for the fixup is too large\n");
 				exit(1);
 			}
 			fixup_nodes[cur_fixup] = optarg;
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index 5a2966e..26f441f 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -50,13 +50,13 @@ int init_memory_region_info()
 	file = "/proc/device-tree/#address-cells";
 	fd = open(file, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stderr, "Unable to open %s\n", file);
+		err("Unable to open %s\n", file);
 		return -1;
 	}
 
 	res = read(fd, &dt_address_cells, sizeof(dt_address_cells));
 	if (res != sizeof(dt_address_cells)) {
-		fprintf(stderr, "Error reading %s\n", file);
+		err("Error reading %s\n", file);
 		return -1;
 	}
 	close(fd);
@@ -64,13 +64,13 @@ int init_memory_region_info()
 	file = "/proc/device-tree/#size-cells";
 	fd = open(file, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stderr, "Unable to open %s\n", file);
+		err("Unable to open %s\n", file);
 		return -1;
 	}
 
 	res = read(fd, &dt_size_cells, sizeof(dt_size_cells));
 	if (res != sizeof(dt_size_cells)) {
-		fprintf(stderr, "Error reading %s\n", file);
+		err("Error reading %s\n", file);
 		return -1;
 	}
 	close(fd);
@@ -95,11 +95,11 @@ int read_memory_region_limits(int fd, unsigned long long *start,
 	unsigned long nbytes = dt_address_cells + dt_size_cells;
 
 	if (lseek(fd, 0, SEEK_SET) == -1) {
-		fprintf(stderr, "Error in file seek\n");
+		err("Error in file seek\n");
 		return -1;
 	}
 	if (read(fd, buf, nbytes) != nbytes) {
-		fprintf(stderr, "Error reading the memory region info\n");
+		err("Error reading the memory region info\n");
 		return -1;
 	}
 
@@ -111,8 +111,8 @@ int read_memory_region_limits(int fd, unsigned long long *start,
 		*start = ((unsigned long long *)p)[0];
 		p = (unsigned long long *)p + 1;
 	} else {
-		fprintf(stderr, "Unsupported value for #address-cells : %ld\n",
-					dt_address_cells);
+		err("Unsupported value for #address-cells : %ld\n",
+			dt_address_cells);
 		return -1;
 	}
 
@@ -121,8 +121,8 @@ int read_memory_region_limits(int fd, unsigned long long *start,
 	else if (dt_size_cells == sizeof(unsigned long long))
 		*end = *start + ((unsigned long long *)p)[0];
 	else {
-		fprintf(stderr, "Unsupported value for #size-cells : %ld\n",
-					dt_size_cells);
+		err("Unsupported value for #size-cells : %ld\n",
+			dt_size_cells);
 		return -1;
 	}
 
@@ -228,7 +228,7 @@ static int alloc_memory_ranges(void)
 	return 0;
 
 err1:
-	fprintf(stderr, "memory range structure allocation failure\n");
+	err("memory range structure allocation failure\n");
 	cleanup_memory_ranges();
 	return -1;
 }
@@ -308,7 +308,7 @@ static int realloc_memory_ranges(void)
 	return 0;
 
 err:
-	fprintf(stderr, "memory range structure re-allocation failure\n");
+	err("memory range structure re-allocation failure\n");
 	return -1;
 }
 
@@ -411,7 +411,7 @@ static int read_kernel_memory_limit(char *fname, char *buf)
 			goto err_out;
 		}
 		if (n != sizeof(uint64_t)) {
-			fprintf(stderr, "%s node has invalid size: %d\n",
+			err("%s node has invalid size: %d\n",
 						fname, n);
 			goto err_out;
 		}
@@ -479,7 +479,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				} else if (n == sizeof(uint64_t)) {
 					kernel_end = ((uint64_t *)buf)[0];
 				} else {
-					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					err("%s node has invalid size: %d\n", fname, n);
 					goto error_openfile;
 				}
 				fclose(file);
@@ -508,7 +508,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				} else if (n == sizeof(uint64_t)) {
 					crash_base = ((uint64_t *)buf)[0];
 				} else {
-					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					err("%s node has invalid size: %d\n", fname, n);
 					goto error_openfile;
 				}
 				fclose(file);
@@ -531,7 +531,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				} else if (n == sizeof(uint64_t)) {
 					crash_size = ((uint64_t *)buf)[0];
 				} else {
-					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					err("%s node has invalid size: %d\n", fname, n);
 					goto error_openfile;
 				}
 				fclose(file);
@@ -581,7 +581,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				} else if (n == sizeof(uint64_t)) {
 					initrd_start = ((uint64_t *)buf)[0];
 				} else {
-					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					err("%s node has invalid size: %d\n", fname, n);
 					goto error_openfile;
 				}
 				fclose(file);
@@ -605,7 +605,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 				} else if (n == sizeof(uint64_t)) {
 					initrd_end = ((uint64_t *)buf)[0];
 				} else {
-					fprintf(stderr, "%s node has invalid size: %d\n", fname, n);
+					err("%s node has invalid size: %d\n", fname, n);
 					goto error_openfile;
 				}
 				fclose(file);
diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
index 900cd16..2fcf78f 100644
--- a/kexec/arch/ppc/kexec-uImage-ppc.c
+++ b/kexec/arch/ppc/kexec-uImage-ppc.c
@@ -127,7 +127,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
 
 		case OPT_NODES:
 			if (cur_fixup >= FIXUP_ENTRYS) {
-				fprintf(stderr, "The number of entries for the fixup is too large\n");
+				err("The number of entries for the fixup is too large\n");
 				exit(1);
 			}
 			fixup_nodes[cur_fixup] = optarg;
diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 6b2eb4c..25cac94 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -151,9 +151,8 @@ static int get_dyn_reconf_crash_memory_ranges(void)
 		}
 		if (memory_ranges >= (max_memory_ranges + 1)) {
 			/* No space to insert another element. */
-				fprintf(stderr,
-				"Error: Number of crash memory ranges"
-				" excedeed the max limit\n");
+				err("Error: Number of crash memory ranges"
+					" excedeed the max limit\n");
 			return -1;
 		}
 
@@ -203,7 +202,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 
 	crash_memory_range = (struct memory_range *) malloc(crash_rng_len);
 	if (!crash_memory_range) {
-		fprintf(stderr, "Allocation for crash memory range failed\n");
+		err("Allocation for crash memory range failed\n");
 		return -1;
 	}
 	memset(crash_memory_range, 0, crash_rng_len);
@@ -257,8 +256,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 			}
 			if (memory_ranges >= (max_memory_ranges + 1)) {
 				/* No space to insert another element. */
-				fprintf(stderr,
-					"Error: Number of crash memory ranges"
+				err("Error: Number of crash memory ranges"
 					" excedeed the max limit\n");
 				goto err;
 			}
diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index 924c7ff..cd1f2d9 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -591,7 +591,7 @@ static void putnode(void)
 		memcpy(dt, local_cmdline,cmd_len);
 		dt += (cmd_len + 3)/4;
 
-		fprintf(stderr, "Modified cmdline:%s\n", local_cmdline);
+		err("Modified cmdline:%s\n", local_cmdline);
 
 		/*
 		 * Determine the platform type/stdout type, so that purgatory
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index f68f2bc..ffbccd9 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -209,8 +209,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	 */
 	if (ramdisk) {
 		if (devicetreeblob) {
-			fprintf(stderr,
-			"Can't use ramdisk with device tree blob input\n");
+			err("Can't use ramdisk with device tree blob input\n");
 			return -1;
 		}
 		seg_buf = slurp_file(ramdisk, &seg_size);
@@ -332,7 +331,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	dbgprintf("debug is %d\n", my_debug);
 
 	for (i = 0; i < info->nr_segments; i++)
-		fprintf(stderr, "segment[%d].mem:%p memsz:%zu\n", i,
+		err("segment[%d].mem:%p memsz:%zu\n", i,
 			info->segment[i].mem, info->segment[i].memsz);
 
 	return 0;
@@ -340,11 +339,11 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 
 void elf_ppc64_usage(void)
 {
-	fprintf(stderr, "     --command-line=<Command line> command line to append.\n");
-	fprintf(stderr, "     --append=<Command line> same as --command-line.\n");
-	fprintf(stderr, "     --ramdisk=<filename> Initial RAM disk.\n");
-	fprintf(stderr, "     --initrd=<filename> same as --ramdisk.\n");
-	fprintf(stderr, "     --devicetreeblob=<filename> Specify device tree blob file.\n");
+	err("     --command-line=<Command line> command line to append.\n");
+	err("     --append=<Command line> same as --command-line.\n");
+	err("     --ramdisk=<filename> Initial RAM disk.\n");
+	err("     --initrd=<filename> same as --ramdisk.\n");
+	err("     --devicetreeblob=<filename> Specify device tree blob file.\n");
 
-	fprintf(stderr, "elf support is still broken\n");
+	err("elf support is still broken\n");
 }
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 389741a..67f2b41 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -91,7 +91,7 @@ static int alloc_memory_ranges(void)
 	return 0;
 
 err1:
-	fprintf(stderr, "memory range structure allocation failure\n");
+	err("memory range structure allocation failure\n");
 	cleanup_memory_ranges();
 	return -1;
 
@@ -124,7 +124,7 @@ static int realloc_memory_ranges(void)
 	return 0;
 
 err:
-	fprintf(stderr, "memory range structure re-allocation failure\n");
+	err("memory range structure re-allocation failure\n");
 	return -1;
 }
 
@@ -759,7 +759,7 @@ int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
 void arch_usage(void)
 {
-	fprintf(stderr, "     --elf64-core-headers Prepare core headers in ELF64 format\n");
+	err("     --elf64-core-headers Prepare core headers in ELF64 format\n");
 }
 
 struct arch_options_t arch_options = {
diff --git a/kexec/arch/ppc64/kexec-zImage-ppc64.c b/kexec/arch/ppc64/kexec-zImage-ppc64.c
index 24a87c6..7c87b6f 100644
--- a/kexec/arch/ppc64/kexec-zImage-ppc64.c
+++ b/kexec/arch/ppc64/kexec-zImage-ppc64.c
@@ -38,18 +38,16 @@ int zImage_ppc64_probe(FILE *file)
 	Elf32_Ehdr elf;
 
 	if (fseek(file, 0, SEEK_SET) < 0) {
-		fprintf(stderr, "seek error: %s\n",
-			strerror(errno));
+		err("seek error: %s\n", strerror(errno));
 		return -1;
 	}
 	if (fread(&elf, sizeof(Elf32_Ehdr), 1, file) != 1) {
-		fprintf(stderr, "read error: %s\n",
-			strerror(errno));
+		err("read error: %s\n", strerror(errno));
 		return -1;
 	}
 
 	if (elf.e_machine == EM_PPC64) {
-		fprintf(stderr, "Elf64 not supported\n");
+		err("Elf64 not supported\n");
 		return -1;
 	}
 
@@ -85,8 +83,7 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 		return -1;
 	}
 	if (elf.e_phnum > MAX_HEADERS) {
-		fprintf(stderr,
-			"Only kernels with %i program headers are supported\n",
+		err("Only kernels with %i program headers are supported\n",
 			MAX_HEADERS);
 		return -1;
 	}
@@ -108,8 +105,7 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 
 	*ret_segments = malloc(elf.e_phnum * sizeof(struct kexec_segment));
 	if (*ret_segments == 0) {
-		fprintf(stderr, "malloc failed: %s\n",
-			strerror(errno));
+		err("malloc failed: %s\n", strerror(errno));
 		return -1;
 	}
 	segment = ret_segments[0];
@@ -131,7 +127,7 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 		}
 	}
 	if (memsize == 0) {
-		fprintf(stderr, "Can't find a loadable segment.\n");
+		err("Can't find a loadable segment.\n");
 		return -1;
 	}
 
@@ -170,5 +166,5 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 
 void zImage_ppc64_usage(void)
 {
-	fprintf(stderr, "zImage support is still broken\n");
+	err("zImage support is still broken\n");
 }
diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index d3af800..a500e93 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -39,7 +39,7 @@ static void add_segment_check(struct kexec_info *info, const void *buf,
 int command_line_add(const char *str)
 {
 	if (strlen(command_line) + strlen(str) + 1 > COMMAND_LINESIZE) {
-		fprintf(stderr, "Command line too long.\n");
+		err("Command line too long.\n");
 		return -1;
 	}
 	strcat(command_line, str);
@@ -108,7 +108,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 	if (ramdisk) {
 		rd_buffer = slurp_file(ramdisk, &ramdisk_len);
 		if (rd_buffer == NULL) {
-			fprintf(stderr, "Could not read ramdisk.\n");
+			err("Could not read ramdisk.\n");
 			return -1;
 		}
 		ramdisk_origin = MAX(RAMDISK_ORIGIN_ADDR, kernel_size);
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index 074575e..2f1adac 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -157,7 +157,7 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
 
 	fp = fopen(iomem,"r");
 	if(fp == 0) {
-		fprintf(stderr,"Unable to open %s: %s\n",iomem,strerror(errno));
+		err("Unable to open %s: %s\n",iomem,strerror(errno));
 		return -1;
 	}
 
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 7710fdf..a5490db 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -58,7 +58,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 
 		ret = parse_iomem_single("Crash kernel\n", &start, &end);
 		if (ret != 0) {
-			fprintf(stderr, "parse_iomem_single failed.\n");
+			err("parse_iomem_single failed.\n");
 			return -1;
 		}
 
diff --git a/kexec/arch/x86_64/kexec-bzImage64.c b/kexec/arch/x86_64/kexec-bzImage64.c
index 86e6d13..5548342 100644
--- a/kexec/arch/x86_64/kexec-bzImage64.c
+++ b/kexec/arch/x86_64/kexec-bzImage64.c
@@ -49,42 +49,42 @@ int bzImage64_probe(const char *buf, off_t len)
 
 	if ((uintmax_t)len < (uintmax_t)(2 * 512)) {
 		if (probe_debug)
-			fprintf(stderr, "File is too short to be a bzImage!\n");
+			err("File is too short to be a bzImage!\n");
 		return -1;
 	}
 	header = (const struct x86_linux_header *)buf;
 	if (memcmp(header->header_magic, "HdrS", 4) != 0) {
 		if (probe_debug)
-			fprintf(stderr, "Not a bzImage\n");
+			err("Not a bzImage\n");
 		return -1;
 	}
 	if (header->boot_sector_magic != 0xAA55) {
 		if (probe_debug)
-			fprintf(stderr, "No x86 boot sector present\n");
+			err("No x86 boot sector present\n");
 		/* No x86 boot sector present */
 		return -1;
 	}
 	if (header->protocol_version < 0x020C) {
 		if (probe_debug)
-			fprintf(stderr, "Must be at least protocol version 2.12\n");
+			err("Must be at least protocol version 2.12\n");
 		/* Must be at least protocol version 2.12 */
 		return -1;
 	}
 	if ((header->loadflags & 1) == 0) {
 		if (probe_debug)
-			fprintf(stderr, "zImage not a bzImage\n");
+			err("zImage not a bzImage\n");
 		/* Not a bzImage */
 		return -1;
 	}
 	if ((header->xloadflags & 3) != 3) {
 		if (probe_debug)
-			fprintf(stderr, "Not a relocatable bzImage64\n");
+			err("Not a relocatable bzImage64\n");
 		/* Must be KERNEL_64 and CAN_BE_LOADED_ABOVE_4G */
 		return -1;
 	}
 	/* I've got a relocatable bzImage64 */
 	if (probe_debug)
-		fprintf(stderr, "It's a relocatable bzImage64\n");
+		err("It's a relocatable bzImage64\n");
 	return 0;
 }
 
@@ -129,7 +129,7 @@ static int do_bzImage64_load(struct kexec_info *info,
 		setup_sects = 4;
 	kern16_size = (setup_sects + 1) * 512;
 	if (kernel_len < kern16_size) {
-		fprintf(stderr, "BzImage truncated?\n");
+		err("BzImage truncated?\n");
 		return -1;
 	}
 
diff --git a/kexec/arch/x86_64/kexec-elf-x86_64.c b/kexec/arch/x86_64/kexec-elf-x86_64.c
index a3fc728..76c9f08 100644
--- a/kexec/arch/x86_64/kexec-elf-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-x86_64.c
@@ -50,7 +50,7 @@ int elf_x86_64_probe(const char *buf, off_t len)
 	result = build_elf_exec_info(buf, len, &ehdr, 0);
 	if (result < 0) {
 		if (probe_debug) {
-			fprintf(stderr, "Not an ELF executable\n");
+			err("Not an ELF executable\n");
 		}
 		goto out;
 	}
@@ -59,7 +59,7 @@ int elf_x86_64_probe(const char *buf, off_t len)
 	if (ehdr.e_machine != EM_X86_64) {
 		/* for a different architecture */
 		if (probe_debug) {
-			fprintf(stderr, "Not x86_64 ELF executable\n");
+			err("Not x86_64 ELF executable\n");
 		}
 		result = -1;
 		goto out;
@@ -127,7 +127,7 @@ int elf_x86_64_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX) {
 				break;
 			}
-			fprintf(stderr, "Unknown option: opt: %d\n", opt);
+			err("Unknown option: opt: %d\n", opt);
 		case '?':
 			usage();
 			return -1;
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index 5c23e01..f7801a3 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -105,7 +105,7 @@ int arch_process_options(int argc, char **argv)
 				}
 			}
 			if (value >= 65536) {
-				fprintf(stderr, "Bad serial port base '%s'\n",
+				err("Bad serial port base '%s'\n",
 					optarg);
 				usage();
 				return -1;
@@ -118,8 +118,7 @@ int arch_process_options(int argc, char **argv)
 			if ((value > 115200) || ((115200 %value) != 0) ||
 				(value < 9600) || (*end))
 			{
-				fprintf(stderr, "Bad serial port baud rate '%s'\n",
-					optarg);
+				err("Bad serial port baud rate '%s'\n", optarg);
 				usage();
 				return -1;
 
diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index d8bd0f4..d9738c3 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -145,20 +145,20 @@ unsigned long xen_architecture(struct crash_elf_info *elf_info)
 #ifdef XENCTRL_HAS_XC_INTERFACE
 	xc = xc_interface_open(NULL, NULL, 0);
 	if ( !xc ) {
-		fprintf(stderr, "failed to open xen control interface.\n");
+		err("failed to open xen control interface.\n");
 		goto out;
 	}
 #else
 	xc = xc_interface_open();
 	if ( xc == -1 ) {
-		fprintf(stderr, "failed to open xen control interface.\n");
+		err("failed to open xen control interface.\n");
 		goto out;
 	}
 #endif
 
 	rc = xc_version(xc, XENVER_capabilities, &capabilities[0]);
 	if ( rc == -1 ) {
-		fprintf(stderr, "failed to make Xen version hypercall.\n");
+		err("failed to make Xen version hypercall.\n");
 		goto out_close;
 	}
 
@@ -200,7 +200,7 @@ int xen_get_nr_phys_cpus(void)
 		n = sizeof(struct crash_note_info) * cpus;
 		xen_phys_notes = malloc(n);
 		if (!xen_phys_notes) {
-			fprintf(stderr, "failed to allocate xen_phys_notes.\n");
+			err("failed to allocate xen_phys_notes.\n");
 			return -1;
 		}
 		memset(xen_phys_notes, 0, n);
diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
index 9598933..60675cc 100644
--- a/kexec/firmware_memmap.c
+++ b/kexec/firmware_memmap.c
@@ -62,8 +62,7 @@ static unsigned long long parse_numeric_sysfs(const char *filename)
 
 	fp = fopen(filename, "r");
 	if (!fp) {
-		fprintf(stderr, "Opening \"%s\" failed: %s\n",
-			filename, strerror(errno));
+		err("Opening \"%s\" failed: %s\n", filename, strerror(errno));
 		return ULLONG_MAX;
 	}
 
@@ -98,8 +97,7 @@ static char *parse_string_sysfs(const char *filename)
 
 	fp = fopen(filename, "r");
 	if (!fp) {
-		fprintf(stderr, "Opening \"%s\" failed: %s\n",
-			filename, strerror(errno));
+		err("Opening \"%s\" failed: %s\n", filename, strerror(errno));
 		return NULL;
 	}
 
@@ -170,7 +168,7 @@ static int parse_memmap_entry(const char *entry, struct memory_range *range)
 	else if (strcmp(type, "Uncached RAM") == 0)
 		range->type = RANGE_UNCACHED;
 	else {
-		fprintf(stderr, "Unknown type (%s) while parsing %s. Please "
+		err("Unknown type (%s) while parsing %s. Please "
 			"report this as bug. Using RANGE_RESERVED now.\n",
 			type, filename);
 		range->type = RANGE_RESERVED;
@@ -219,7 +217,7 @@ int get_firmware_memmap_ranges(struct memory_range *range, size_t *ranges)
 
 	/* argument checking */
 	if (!range || !ranges) {
-		fprintf(stderr, "%s: Invalid arguments.\n", __FUNCTION__);
+		err("%s: Invalid arguments.\n", __FUNCTION__);
 		return -1;
 	}
 
@@ -237,7 +235,7 @@ int get_firmware_memmap_ranges(struct memory_range *range, size_t *ranges)
 
 		/* array overflow check */
 		if ((size_t)i >= *ranges) {
-			fprintf(stderr, "The firmware provides more entries "
+			err("The firmware provides more entries "
 				"allowed (%zd). Please report that as bug.\n",
 				*ranges);
 			goto error;
diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 1f5b0cf..9506e8e 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -607,7 +607,7 @@ static void putnode(void)
 		memcpy(dt, local_cmdline,cmd_len);
 		dt += (cmd_len + 3)/4;
 
-		fprintf(stderr, "Modified cmdline:%s\n", local_cmdline);
+		err("Modified cmdline:%s\n", local_cmdline);
 
 		/*
 		 * Determine the platform type/stdout type, so that purgatory
diff --git a/kexec/kernel_version.c b/kexec/kernel_version.c
index 079312b..5a0ade2 100644
--- a/kexec/kernel_version.c
+++ b/kexec/kernel_version.c
@@ -13,44 +13,41 @@ long kernel_version(void)
 	char *p;
 
 	if (uname(&utsname) < 0) {
-		fprintf(stderr, "uname failed: %s\n", strerror(errno));
+		err("uname failed: %s\n", strerror(errno));
 		return -1;
 	}
 
 	p = utsname.release;
 	major = strtoul(p, &p, 10);
 	if (major == ULONG_MAX) {
-		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
+		err("strtoul failed: %s\n", strerror(errno));
 		return -1;
 	}
 
 	if (*p++ != '.') {
-		fprintf(stderr, "Unsupported utsname.release: %s\n",
-			utsname.release);
+		err("Unsupported utsname.release: %s\n", utsname.release);
 		return -1;
 	}
 
 	minor = strtoul(p, &p, 10);
 	if (major == ULONG_MAX) {
-		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
+		err("strtoul failed: %s\n", strerror(errno));
 		return -1;
 	}
 
 	if (*p++ != '.') {
-		fprintf(stderr, "Unsupported utsname.release: %s\n",
-			utsname.release);
+		err("Unsupported utsname.release: %s\n", utsname.release);
 		return -1;
 	}
 
 	patch = strtoul(p, &p, 10);
 	if (major == ULONG_MAX) {
-		fprintf(stderr, "strtoul failed: %s\n", strerror(errno));
+		err("strtoul failed: %s\n", strerror(errno));
 		return -1;
 	}
 
 	if (major >= 256 || minor >= 256 || patch >= 256) {
-		fprintf(stderr, "Unsupported utsname.release: %s\n",
-			utsname.release);
+		err("Unsupported utsname.release: %s\n", utsname.release);
 		return -1;
 	}
 
diff --git a/kexec/kexec-elf-exec.c b/kexec/kexec-elf-exec.c
index cb62d04..57dcd45 100644
--- a/kexec/kexec-elf-exec.c
+++ b/kexec/kexec-elf-exec.c
@@ -24,13 +24,13 @@ int build_elf_exec_info(const char *buf, off_t len, struct mem_ehdr *ehdr,
 	    (ehdr->e_type != ET_CORE)) {
 		/* not an ELF executable */
 		if (probe_debug) {
-			fprintf(stderr, "Not ELF type ET_EXEC or ET_DYN\n");
+			err("Not ELF type ET_EXEC or ET_DYN\n");
 		}
 		return -1;
 	}
 	if (!ehdr->e_phdr) {
 		/* No program header */
-		fprintf(stderr, "No ELF program header\n");
+		err("No ELF program header\n");
 		return -1; 
 	}
 	end_phdr = &ehdr->e_phdr[ehdr->e_phnum];
@@ -40,7 +40,7 @@ int build_elf_exec_info(const char *buf, off_t len, struct mem_ehdr *ehdr,
 		 * to kexec ordinay executables.
 		 */
 		if (phdr->p_type == PT_INTERP) {
-			fprintf(stderr, "Requires an ELF interpreter\n");
+			err("Requires an ELF interpreter\n");
 			return -1;
 		}
 	}
@@ -56,7 +56,7 @@ int elf_exec_load(struct mem_ehdr *ehdr, struct kexec_info *info)
 	size_t i;
 
 	if (!ehdr->e_phdr) {
-		fprintf(stderr, "No program header?\n");
+		err("No program header?\n");
 		result = -1;
 		goto out;
 	}
diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
index 38e34ec..398bda0 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -146,22 +146,22 @@ int build_elf_rel_info(const char *buf, off_t len, struct mem_ehdr *ehdr,
 	if (ehdr->e_type != ET_REL) {
 		/* not an ELF relocate object */
 		if (probe_debug) {
-			fprintf(stderr, "Not ELF type ET_REL\n");
-			fprintf(stderr, "ELF Type: %x\n", ehdr->e_type);
+			err("Not ELF type ET_REL\n");
+			err("ELF Type: %x\n", ehdr->e_type);
 		}
 		return -1;
 	}
 	if (!ehdr->e_shdr) {
 		/* No section headers */
 		if (probe_debug) {
-			fprintf(stderr, "No ELF section headers\n");
+			err("No ELF section headers\n");
 		}
 		return -1;
 	}
 	if (!machine_verify_elf_rel(ehdr)) {
 		/* It does not meant the native architecture constraints */
 		if (probe_debug) {
-			fprintf(stderr, "ELF architecture constraint failure\n");
+			err("ELF architecture constraint failure\n");
 		}
 		return -1;
 	}
@@ -183,7 +183,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 		max = elf_max_addr(ehdr);
 	}
 	if (!ehdr->e_shdr) {
-		fprintf(stderr, "No section header?\n");
+		err("No section header?\n");
 		result = -1;
 		goto out;
 	}
diff --git a/kexec/kexec-elf.c b/kexec/kexec-elf.c
index 3515203..084f6dc 100644
--- a/kexec/kexec-elf.c
+++ b/kexec/kexec-elf.c
@@ -102,7 +102,7 @@ static int build_mem_elf32_ehdr(const char *buf, off_t len, struct mem_ehdr *ehd
 	if ((uintmax_t)len < (uintmax_t)sizeof(lehdr)) {
 		/* Buffer is to small to be an elf executable */
 		if (probe_debug) {
-			fprintf(stderr, "Buffer is to small to hold ELF header\n");
+			err("Buffer is to small to hold ELF header\n");
 		}
 		return -1;
 	}
@@ -110,28 +110,28 @@ static int build_mem_elf32_ehdr(const char *buf, off_t len, struct mem_ehdr *ehd
 	if (elf16_to_cpu(ehdr, lehdr.e_ehsize) != sizeof(Elf32_Ehdr)) {
 		/* Invalid Elf header size */
 		if (probe_debug) {
-			fprintf(stderr, "Bad ELF header size\n");
+			err("Bad ELF header size\n");
 		}
 		return -1;
 	}
 	if (elf32_to_cpu(ehdr, lehdr.e_entry) > UINT32_MAX) {
 		/* entry is to large */
 		if (probe_debug) {
-			fprintf(stderr, "ELF e_entry to large\n");
+			err("ELF e_entry to large\n");
 		}
 		return -1;
 	}
 	if (elf32_to_cpu(ehdr, lehdr.e_phoff) > UINT32_MAX) {
 		/* phoff is to large */
 		if (probe_debug) {
-			fprintf(stderr, "ELF e_phoff to large\n");
+			err("ELF e_phoff to large\n");
 		}
 		return -1;
 	}
 	if (elf32_to_cpu(ehdr, lehdr.e_shoff) > UINT32_MAX) {
 		/* shoff is to large */
 		if (probe_debug) {
-			fprintf(stderr, "ELF e_shoff to large\n");
+			err("ELF e_shoff to large\n");
 		}
 		return -1;
 	}
@@ -151,7 +151,7 @@ static int build_mem_elf32_ehdr(const char *buf, off_t len, struct mem_ehdr *ehd
 	{
 		/* Invalid program header size */
 		if (probe_debug) {
-			fprintf(stderr, "ELF bad program header size\n");
+			err("ELF bad program header size\n");
 		}
 		return -1;
 	}
@@ -160,7 +160,7 @@ static int build_mem_elf32_ehdr(const char *buf, off_t len, struct mem_ehdr *ehd
 	{
 		/* Invalid section header size */
 		if (probe_debug) {
-			fprintf(stderr, "ELF bad section header size\n");
+			err("ELF bad section header size\n");
 		}
 		return -1;
 	}
@@ -174,7 +174,7 @@ static int build_mem_elf64_ehdr(const char *buf, off_t len, struct mem_ehdr *ehd
 	if ((uintmax_t)len < (uintmax_t)sizeof(lehdr)) {
 		/* Buffer is to small to be an elf executable */
 		if (probe_debug) {
-			fprintf(stderr, "Buffer is to small to hold ELF header\n");
+			err("Buffer is to small to hold ELF header\n");
 		}
 		return -1;
 	}
@@ -182,28 +182,28 @@ static int build_mem_elf64_ehdr(const char *buf, off_t len, struct mem_ehdr *ehd
 	if (elf16_to_cpu(ehdr, lehdr.e_ehsize) != sizeof(Elf64_Ehdr)) {
 		/* Invalid Elf header size */
 		if (probe_debug) {
-			fprintf(stderr, "Bad ELF header size\n");
+			err("Bad ELF header size\n");
 		}
 		return -1;
 	}
 	if (elf32_to_cpu(ehdr, lehdr.e_entry) > UINT32_MAX) {
 		/* entry is to large */
 		if (probe_debug) {
-			fprintf(stderr, "ELF e_entry to large\n");
+			err("ELF e_entry to large\n");
 		}
 		return -1;
 	}
 	if (elf32_to_cpu(ehdr, lehdr.e_phoff) > UINT32_MAX) {
 		/* phoff is to large */
 		if (probe_debug) {
-			fprintf(stderr, "ELF e_phoff to large\n");
+			err("ELF e_phoff to large\n");
 		}
 		return -1;
 	}
 	if (elf32_to_cpu(ehdr, lehdr.e_shoff) > UINT32_MAX) {
 		/* shoff is to large */
 		if (probe_debug) {
-			fprintf(stderr, "ELF e_shoff to large\n");
+			err("ELF e_shoff to large\n");
 		}
 		return -1;
 	}
@@ -223,7 +223,7 @@ static int build_mem_elf64_ehdr(const char *buf, off_t len, struct mem_ehdr *ehd
 	{
 		/* Invalid program header size */
 		if (probe_debug) {
-			fprintf(stderr, "ELF bad program header size\n");
+			err("ELF bad program header size\n");
 		}
 		return -1;
 	}
@@ -232,7 +232,7 @@ static int build_mem_elf64_ehdr(const char *buf, off_t len, struct mem_ehdr *ehd
 	{
 		/* Invalid section header size */
 		if (probe_debug) {
-			fprintf(stderr, "ELF bad section header size\n");
+			err("ELF bad section header size\n");
 		}
 		return -1;
 	}
@@ -248,7 +248,7 @@ static int build_mem_ehdr(const char *buf, off_t len, struct mem_ehdr *ehdr)
 	if ((uintmax_t)len < (uintmax_t)sizeof(e_ident)) {
 		/* Buffer is to small to be an elf executable */
 		if (probe_debug) {
-			fprintf(stderr, "Buffer is to small to hold ELF e_ident\n");
+			err("Buffer is to small to hold ELF e_ident\n");
 		}
 		return -1;
 	}
@@ -256,7 +256,7 @@ static int build_mem_ehdr(const char *buf, off_t len, struct mem_ehdr *ehdr)
 	if (memcmp(e_ident, ELFMAG, SELFMAG) != 0) {
 		/* No ELF header magic */
 		if (probe_debug) {
-			fprintf(stderr, "NO ELF header magic\n");
+			err("NO ELF header magic\n");
 		}
 		return -1;
 	}
@@ -267,7 +267,7 @@ static int build_mem_ehdr(const char *buf, off_t len, struct mem_ehdr *ehdr)
 	{
 		/* Not a supported elf class */
 		if (probe_debug) {
-			fprintf(stderr, "Not a supported ELF class\n");
+			err("Not a supported ELF class\n");
 		}
 		return -1;
 	}
@@ -276,7 +276,7 @@ static int build_mem_ehdr(const char *buf, off_t len, struct mem_ehdr *ehdr)
 	{
 		/* Not a supported elf data type */
 		if (probe_debug) {
-			fprintf(stderr, "Not a supported ELF data format\n");
+			err("Not a supported ELF data format\n");
 		}
 		return -1;
 	}
@@ -295,7 +295,7 @@ static int build_mem_ehdr(const char *buf, off_t len, struct mem_ehdr *ehdr)
 		(ehdr->e_version != EV_CURRENT))
 	{
 		if (probe_debug) {
-			fprintf(stderr, "Unknown ELF version\n");
+			err("Unknown ELF version\n");
 		}
 		/* Unknwon elf version */
 		return -1;
@@ -319,7 +319,7 @@ static int build_mem_elf32_phdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 		(elf32_to_cpu(ehdr, lphdr.p_vaddr)  > UINT32_MAX) ||
 		(elf32_to_cpu(ehdr, lphdr.p_align)  > UINT32_MAX))
 	{
-		fprintf(stderr, "Program segment size out of range\n");
+		err("Program segment size out of range\n");
 		return -1;
 	}
 
@@ -351,7 +351,7 @@ static int build_mem_elf64_phdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 		(elf64_to_cpu(ehdr, lphdr.p_vaddr)  > UINT64_MAX) ||
 		(elf64_to_cpu(ehdr, lphdr.p_align)  > UINT64_MAX))
 	{
-		fprintf(stderr, "Program segment size out of range\n");
+		err("Program segment size out of range\n");
 		return -1;
 	}
 
@@ -384,14 +384,14 @@ static int build_mem_phdrs(const char *buf, off_t len, struct mem_ehdr *ehdr,
 		phdr_size = sizeof(Elf64_Phdr);
 	}
 	else {
-		fprintf(stderr, "Invalid ei_class?\n");
+		err("Invalid ei_class?\n");
 		return -1;
 	}
 	phdr_size *= ehdr->e_phnum;
 	if ((uintmax_t)(ehdr->e_phoff + phdr_size) > (uintmax_t)len) {
 		/* The program header did not fit in the file buffer */
 		if (probe_debug || (flags & ELF_SKIP_FILESZ_CHECK)) {
-			fprintf(stderr, "ELF program headers truncated"
+			err("ELF program headers truncated"
 				" have %ju bytes need %ju bytes\n",
 				(uintmax_t)len,
 				(uintmax_t)(ehdr->e_phoff + phdr_size));
@@ -428,14 +428,14 @@ static int build_mem_phdrs(const char *buf, off_t len, struct mem_ehdr *ehdr,
 			   (uintmax_t)len) {
 			/* The segment does not fit in the buffer */
 			if (probe_debug) {
-				fprintf(stderr, "ELF segment not in file\n");
+				err("ELF segment not in file\n");
 			}
 			return -1;
 		}
 		if ((phdr->p_paddr + phdr->p_memsz) < phdr->p_paddr) {
 			/* The memory address wraps */
 			if (probe_debug) {
-				fprintf(stderr, "ELF address wrap around\n");
+				err("ELF address wrap around\n");
 			}
 			return -1;
 		}
@@ -462,7 +462,7 @@ static int build_mem_elf32_shdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 		(elf32_to_cpu(ehdr, lshdr.sh_addralign) > UINT32_MAX) ||
 		(elf32_to_cpu(ehdr, lshdr.sh_entsize)   > UINT32_MAX))
 	{
-		fprintf(stderr, "Program section size out of range\n");
+		err("Program section size out of range\n");
 		return -1;
 	}
 
@@ -507,7 +507,7 @@ static int build_mem_elf32_shdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 		break;
 	}
 	if (!size_ok) {
-		fprintf(stderr, "Bad section header(%x) entsize: %lld\n",
+		err("Bad section header(%x) entsize: %lld\n",
 			shdr->sh_type, shdr->sh_entsize);
 		return -1;
 	}
@@ -531,7 +531,7 @@ static int build_mem_elf64_shdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 		(elf64_to_cpu(ehdr, lshdr.sh_addralign) > UINT64_MAX) ||
 		(elf64_to_cpu(ehdr, lshdr.sh_entsize)   > UINT64_MAX))
 	{
-		fprintf(stderr, "Program section size out of range\n");
+		err("Program section size out of range\n");
 		return -1;
 	}
 
@@ -576,7 +576,7 @@ static int build_mem_elf64_shdr(const char *buf, struct mem_ehdr *ehdr, int idx)
 		break;
 	}
 	if (!size_ok) {
-		fprintf(stderr, "Bad section header(%x) entsize: %lld\n",
+		err("Bad section header(%x) entsize: %lld\n",
 			shdr->sh_type, shdr->sh_entsize);
 		return -1;
 	}
@@ -600,14 +600,14 @@ static int build_mem_shdrs(const char *buf, off_t len, struct mem_ehdr *ehdr,
 		shdr_size = sizeof(Elf64_Shdr);
 	}
 	else {
-		fprintf(stderr, "Invalid ei_class?\n");
+		err("Invalid ei_class?\n");
 		return -1;
 	}
 	shdr_size *= ehdr->e_shnum;
 	if ((uintmax_t)(ehdr->e_shoff + shdr_size) > (uintmax_t)len) {
 		/* The section header did not fit in the file buffer */
 		if (probe_debug) {
-			fprintf(stderr, "ELF section header does not fit in file\n");
+			err("ELF section header does not fit in file\n");
 		}
 		return -1;
 	}
@@ -640,15 +640,14 @@ static int build_mem_shdrs(const char *buf, off_t len, struct mem_ehdr *ehdr,
 			   (uintmax_t)len) {
 			/* The section does not fit in the buffer */
 			if (probe_debug) {
-				fprintf(stderr, "ELF section %zd not in file\n",
-					i);
+				err("ELF section %zd not in file\n", i);
 			}
 			return -1;
 		}
 		if ((shdr->sh_addr + shdr->sh_size) < shdr->sh_addr) {
 			/* The memory address wraps */
 			if (probe_debug) {
-				fprintf(stderr, "ELF address wrap around\n");
+				err("ELF address wrap around\n");
 			}
 			return -1;
 		}
@@ -727,8 +726,7 @@ static int build_mem_notes(struct mem_ehdr *ehdr)
 			 * where /proc/kcore elf notes were not null
 			 * terminated. It has been fixed in 2.6.19.
 			 */
-			fprintf(stderr, "Warning: Elf Note name is not null "
-					"terminated\n");
+			err("Warning: Elf Note name is not null terminated\n");
 		}
 		ehdr->e_note[i].n_type = hdr.n_type;
 		ehdr->e_note[i].n_name = (char *)name;
diff --git a/kexec/kexec.c b/kexec/kexec.c
index f3928af..cb46174 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -179,8 +179,7 @@ int sort_segments(struct kexec_info *info)
 	end = 0;
 	for (i = 0; i < info->nr_segments; i++) {
 		if (end > info->segment[i].mem) {
-			fprintf(stderr, "Overlapping memory segments at %p\n",
-				end);
+			err("Overlapping memory segments at %p\n", end);
 			return -1;
 		}
 		end = ((char *)info->segment[i].mem) + info->segment[i].memsz;
@@ -282,12 +281,12 @@ unsigned long locate_hole(struct kexec_info *info,
 	}
 	free(mem_range);
 	if (hole_base == ULONG_MAX) {
-		fprintf(stderr, "Could not find a free area of memory of "
+		err("Could not find a free area of memory of "
 			"%lx bytes...\n", hole_size);
 		return ULONG_MAX;
 	}
 	if ((hole_base + hole_size)  > hole_max) {
-		fprintf(stderr, "Could not find a free area of memory below: "
+		err("Could not find a free area of memory below: "
 			"%lx...\n", hole_max);
 		return ULONG_MAX;
 	}
@@ -341,7 +340,7 @@ void add_segment_phys_virt(struct kexec_info *info,
 	info->segment[info->nr_segments].memsz = memsz;
 	info->nr_segments++;
 	if (info->nr_segments > KEXEC_MAX_SEGMENTS) {
-		fprintf(stderr, "Warning: kernel segment limit reached. "
+		err("Warning: kernel segment limit reached. "
 			"This will likely fail\n");
 	}
 }
@@ -547,8 +546,7 @@ char *slurp_file_len(const char *filename, off_t size)
 		return 0;
 	fd = open(filename, O_RDONLY | _O_BINARY);
 	if (fd < 0) {
-		fprintf(stderr, "Cannot open %s: %s\n", filename,
-				strerror(errno));
+		err("Cannot open %s: %s\n", filename, strerror(errno));
 		return 0;
 	}
 	buf = xmalloc(size);
@@ -558,9 +556,9 @@ char *slurp_file_len(const char *filename, off_t size)
 		if (result < 0) {
 			if ((errno == EINTR) ||	(errno == EAGAIN))
 				continue;
-			fprintf(stderr, "read on %s of %ld bytes failed: %s\n",
-					filename, (size - progress)+ 0UL,
-					strerror(errno));
+			err("read on %s of %ld bytes failed: %s\n",
+				filename, (size - progress)+ 0UL,
+				strerror(errno));
 			free(buf);
 			return 0;
 		}
@@ -661,7 +659,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 
 	result = 0;
 	if (argc - fileind <= 0) {
-		fprintf(stderr, "No kernel specified\n");
+		err("No kernel specified\n");
 		usage();
 		return -1;
 	}
@@ -674,7 +672,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 
 	if (get_memory_ranges(&info.memory_range, &info.memory_ranges,
 		info.kexec_flags) < 0 || info.memory_ranges == 0) {
-		fprintf(stderr, "Could not get memory layout\n");
+		err("Could not get memory layout\n");
 		return -1;
 	}
 	/* if a kernel type was specified, try to honor it */
@@ -684,7 +682,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 				break;
 		}
 		if (i == file_types) {
-			fprintf(stderr, "Unsupported kernel type %s\n", type);
+			err("Unsupported kernel type %s\n", type);
 			return -1;
 		} else {
 			/* make sure our file is really of that type */
@@ -698,12 +696,11 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 				break;
 		}
 		if (i == file_types) {
-			fprintf(stderr, "Cannot determine the file type "
-					"of %s\n", kernel);
+			err("Cannot determine the file type of %s\n", kernel);
 			return -1;
 		} else {
 			if (guess_only) {
-				fprintf(stderr, "Wrong file type %s, "
+				err("Wrong file type %s, "
 					"file matches type %s\n",
 					type, file_type[i].name);
 				return -1;
@@ -721,13 +718,12 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	if (result < 0) {
 		switch (result) {
 		case ENOCRASHKERNEL:
-			fprintf(stderr,
-				"No crash kernel segment found in /proc/iomem\n"
+			err("No crash kernel segment found in /proc/iomem\n"
 				"Please check the crashkernel= boot parameter.\n");
 			break;
 		case EFAILED:
 		default:
-			fprintf(stderr, "Cannot load %s\n", kernel);
+			err("Cannot load %s\n", kernel);
 			break;
 		}
 		return result;
@@ -742,7 +738,7 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	/* Verify all of the segments load to a valid location in memory */
 	for (i = 0; i < info.nr_segments; i++) {
 		if (!valid_memory_segment(&info, info.segment +i)) {
-			fprintf(stderr, "Invalid memory segment %p - %p\n",
+			err("Invalid memory segment %p - %p\n",
 				info.segment[i].mem,
 				((char *)info.segment[i].mem) + 
 				info.segment[i].memsz);
@@ -767,9 +763,8 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 		info.entry, info.nr_segments, info.segment, info.kexec_flags);
 	if (result != 0) {
 		/* The load failed, print some debugging information */
-		fprintf(stderr, "kexec_load failed: %s\n", 
-			strerror(errno));
-		fprintf(stderr, "entry       = %p flags = %lx\n", 
+		err("kexec_load failed: %s\n", strerror(errno));
+		err("entry       = %p flags = %lx\n", 
 			info.entry, info.kexec_flags);
 		print_segments(stderr, &info);
 	}
@@ -791,8 +786,7 @@ static int k_unload (unsigned long kexec_flags)
 	result = kexec_load(NULL, 0, NULL, kexec_flags);
 	if (result != 0) {
 		/* The unload failed, print some debugging information */
-		fprintf(stderr, "kexec_load (0 segments) failed: %s\n",
-			strerror(errno));
+		err("kexec_load (0 segments) failed: %s\n", strerror(errno));
 	}
 	return result;
 }
@@ -824,8 +818,7 @@ static int my_exec(void)
 {
 	reboot(LINUX_REBOOT_CMD_KEXEC);
 	/* I have failed if I make it here */
-	fprintf(stderr, "kexec failed: %s\n", 
-		strerror(errno));
+	err("kexec failed: %s\n", strerror(errno));
 	return -1;
 }
 
@@ -849,19 +842,17 @@ static int my_load_jump_back_helper(unsigned long kexec_flags, void *entry)
 	int result;
 
 	if (kexec_loaded()) {
-		fprintf(stderr, "There is kexec kernel loaded, make sure "
+		err("There is kexec kernel loaded, make sure "
 			"you are in kexeced kernel.\n");
 		return -1;
 	}
 	if (!entry) {
-		fprintf(stderr, "Please specify jump back entry "
-			"in command line\n");
+		err("Please specify jump back entry in command line\n");
 		return -1;
 	}
 	result = load_jump_back_helper_image(kexec_flags, entry);
 	if (result) {
-		fprintf(stderr, "load jump back kernel failed: %s\n",
-			strerror(errno));
+		err("load jump back kernel failed: %s\n", strerror(errno));
 		return result;
 	}
 	return result;
@@ -1120,8 +1111,7 @@ int main(int argc, char *argv[])
 		case OPT_ENTRY:
 			entry = (void *)strtoul(optarg, &endptr, 0);
 			if (*endptr) {
-				fprintf(stderr,
-					"Bad option value in --load-jump-back-helper=%s\n",
+				err("Bad option value in --load-jump-back-helper=%s\n",
 					optarg);
 				usage();
 				return 1;
@@ -1147,8 +1137,7 @@ int main(int argc, char *argv[])
 		case OPT_MEM_MIN:
 			mem_min = strtoul(optarg, &endptr, 0);
 			if (*endptr) {
-				fprintf(stderr,
-					"Bad option value in --mem-min=%s\n",
+				err("Bad option value in --mem-min=%s\n",
 					optarg);
 				usage();
 				return 1;
@@ -1157,8 +1146,7 @@ int main(int argc, char *argv[])
 		case OPT_MEM_MAX:
 			mem_max = strtoul(optarg, &endptr, 0);
 			if (*endptr) {
-				fprintf(stderr,
-					"Bad option value in --mem-max=%s\n",
+				err("Bad option value in --mem-max=%s\n",
 					optarg);
 				usage();
 				return 1;
diff --git a/kexec/phys_arch.c b/kexec/phys_arch.c
index 1571a0f..26297ad 100644
--- a/kexec/phys_arch.c
+++ b/kexec/phys_arch.c
@@ -8,8 +8,7 @@ long physical_arch(void)
 	struct utsname utsname;
 	int i, result = uname(&utsname);
 	if (result < 0) {
-		fprintf(stderr, "uname failed: %s\n",
-			strerror(errno));
+		err("uname failed: %s\n", strerror(errno));
 		return -1;
 	}
 
@@ -22,7 +21,6 @@ long physical_arch(void)
 			return arches[i].arch;
 	}
 
-	fprintf(stderr, "Unsupported machine type: %s\n",
-		utsname.machine);
+	err("Unsupported machine type: %s\n", utsname.machine);
 	return -1;
 }
diff --git a/kexec/zlib.c b/kexec/zlib.c
index d44df12..55065ef 100644
--- a/kexec/zlib.c
+++ b/kexec/zlib.c
@@ -34,7 +34,7 @@ char *zlib_decompress_file(const char *filename, off_t *r_size)
 		if (errnum == Z_ERRNO) {
 			msg = strerror(errno);
 		}
-		fprintf(stderr, "Cannot open `%s': %s\n", filename, msg);
+		err("Cannot open `%s': %s\n", filename, msg);
 		return NULL;
 	}
 	size = 0;
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
