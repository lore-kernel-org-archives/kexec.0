Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QUCPx-0005SE-7W
	for kexec@lists.infradead.org; Wed, 08 Jun 2011 06:39:07 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p586LKRa029766
	for <kexec@lists.infradead.org>; Wed, 8 Jun 2011 00:21:20 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p586d0Vv163546
	for <kexec@lists.infradead.org>; Wed, 8 Jun 2011 00:39:00 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p580cxxb019306
	for <kexec@lists.infradead.org>; Tue, 7 Jun 2011 18:38:59 -0600
Message-ID: <4DEF18FF.6070206@in.ibm.com>
Date: Wed, 08 Jun 2011 12:08:55 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: [RFC][PATCH] kexec-tools: powerpc: Use the #address-cells information
	to parsememory/reg - V2
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, David Laight <David.Laight@ACULAB.COM>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,

This is version 2 of the patch

Changes from Version 1 :
  : Changed the interface for read_memory_region_limits to use 'int fd'
	instead of FILE*.
  : Use sizeof(variable) for read(, instead of sizeof(type).


---

Fix parsing of the memory region information from the device-tree.

The format of memory/reg is based on the #address-cells,#size-cells. Currently,
the kexec-tools doesn't use the above values in parsing the memory/reg values.
Hence the kexec cannot handle cases where #address-cells, #size-cells are
different, (for e.g, PPC440X ).

This patch introduces a read_memory_region_limits(), which parses the
memory/reg contents based on the values of #address-cells and #size-cells.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

---
  kexec/arch/ppc/crashdump-powerpc.c |   33 +------
  kexec/arch/ppc/fs2dt.c             |   14 ---
  kexec/arch/ppc/kexec-ppc.c         |  158 ++++++++++++++++++++++++++-----------
  kexec/arch/ppc/kexec-ppc.h         |    6 +
  4 files changed, 129 insertions(+), 82 deletions(-)

Index: kexec-tools-2.0.4/kexec/arch/ppc/kexec-ppc.c
===================================================================
--- kexec-tools-2.0.4.orig/kexec/arch/ppc/kexec-ppc.c
+++ kexec-tools-2.0.4/kexec/arch/ppc/kexec-ppc.c
@@ -16,6 +16,7 @@
  #include <dirent.h>
  #include <stdlib.h>
  #include <sys/stat.h>
+#include <fcntl.h>
  #include <unistd.h>
  
  #include "../../kexec.h"
@@ -26,6 +27,7 @@
  
  #include "config.h"
  
+unsigned long dt_address_cells = 0, dt_size_cells = 0;
  uint64_t rmo_top;
  unsigned long long crash_base = 0, crash_size = 0;
  unsigned long long initrd_base = 0, initrd_size = 0;
@@ -34,6 +36,98 @@ unsigned int rtas_base, rtas_size;
  int max_memory_ranges;
  const char *ramdisk;
  
+/*
+ * Reads the #address-cells and #size-cells on this platform.
+ * This is used to parse the memory/reg info from the device-tree
+ */
+int init_memory_region_info()
+{
+	size_t res = 0;
+	int fd;
+	char *file;
+
+	file = "/proc/device-tree/#address-cells";
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Unable to open %s\n", file);
+		return -1;
+	}
+
+	res = read(fd, &dt_address_cells, sizeof(dt_address_cells));
+	if (res != sizeof(dt_address_cells)) {
+		fprintf(stderr, "Error reading %s\n", file);
+		return -1;
+	}
+	close(fd);
+
+	file = "/proc/device-tree/#size-cells";
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Unable to open %s\n", file);
+		return -1;
+	}
+
+	res = read(fd, &dt_size_cells, sizeof(dt_size_cells));
+	if (res != sizeof(dt_size_cells)) {
+		fprintf(stderr, "Error reading %s\n", file);
+		return -1;
+	}
+	close(fd);
+
+	/* Convert the sizes into bytes */
+	dt_size_cells *= sizeof(unsigned long);
+	dt_address_cells *= sizeof(unsigned long);
+
+	return 0;
+}
+
+#define MAXBYTES 128
+/*
+ * Reads the memory region info from the device-tree node pointed
+ * by @fd and fills the *start, *end with the boundaries of the region
+ */
+int read_memory_region_limits(int fd, unsigned long long *start,
+				unsigned long long *end)
+{
+	char buf[MAXBYTES];
+	unsigned long *p;
+	unsigned long nbytes = dt_address_cells + dt_size_cells;
+
+	if (lseek(fd, 0, SEEK_SET) == -1) {
+		fprintf(stderr, "Error in file seek\n");
+		return -1;
+	}
+	if (read(fd, buf, nbytes) != nbytes) {
+		fprintf(stderr, "Error reading the memory region info\n");
+		return -1;
+	}
+
+	p = (unsigned long*)buf;
+	if (dt_address_cells == sizeof(unsigned long)) {
+		*start = p[0];
+		p++;
+	} else if (dt_address_cells == sizeof(unsigned long long)) {
+		*start = ((unsigned long long *)p)[0];
+		p = (unsigned long long *)p + 1;
+	} else {
+		fprintf(stderr, "Unsupported value for #address-cells : %ld\n",
+					dt_address_cells);
+		return -1;
+	}
+
+	if (dt_size_cells == sizeof(unsigned long))
+		*end = *start + p[0];
+	else if (dt_size_cells == sizeof(unsigned long long))
+		*end = *start + ((unsigned long long *)p)[0];
+	else {
+		fprintf(stderr, "Unsupported value for #size-cells : %ld\n",
+					dt_size_cells);
+		return -1;
+	}
+
+	return 0;
+}
+
  void arch_reuse_initrd(void)
  {
  	reuse_initrd = 1;
@@ -182,9 +276,6 @@ static int sort_base_ranges(void)
  	return 0;
  }
  
-
-#define MAXBYTES 128
-
  static int realloc_memory_ranges(void)
  {
  	size_t memory_range_len;
@@ -228,9 +319,8 @@ static int get_base_ranges(void)
  	char fname[256];
  	char buf[MAXBYTES];
  	DIR *dir, *dmem;
-	FILE *file;
  	struct dirent *dentry, *mentry;
-	int n;
+	int n, fd;
  
  	if ((dir = opendir(device_tree)) == NULL) {
  		perror(device_tree);
@@ -248,54 +338,39 @@ static int get_base_ranges(void)
  			return -1;
  		}
  		while ((mentry = readdir(dmem)) != NULL) {
+			unsigned long long start, end;
+
  			if (strcmp(mentry->d_name, "reg"))
  				continue;
  			strcat(fname, "/reg");
-			if ((file = fopen(fname, "r")) == NULL) {
+			if ((fd = open(fname, O_RDONLY)) < 0) {
  				perror(fname);
  				closedir(dmem);
  				closedir(dir);
  				return -1;
  			}
-			if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
-				perror(fname);
-				fclose(file);
+			if (read_memory_region_limits(fd, &start, &end) != 0) {
+				close(fd);
  				closedir(dmem);
  				closedir(dir);
  				return -1;
  			}
  			if (local_memory_ranges >= max_memory_ranges) {
  				if (realloc_memory_ranges() < 0){
-					fclose(file);
+					close(fd);
  					break;
  				}
  			}
  
-			if (n == sizeof(uint32_t) * 2) {
-				base_memory_range[local_memory_ranges].start =
-					((uint32_t *)buf)[0];
-				base_memory_range[local_memory_ranges].end  =
-					base_memory_range[local_memory_ranges].start +
-					((uint32_t *)buf)[1];
-			}
-			else if (n == sizeof(uint64_t) * 2) {
-				base_memory_range[local_memory_ranges].start =
-                                        ((uint64_t *)buf)[0];
-                                base_memory_range[local_memory_ranges].end  =
-                                        base_memory_range[local_memory_ranges].start +
-                                        ((uint64_t *)buf)[1];
-			}
-			else {
-				fprintf(stderr, "Mem node has invalid size: %d\n", n);
-				return -1;
-			}
+			base_memory_range[local_memory_ranges].start = start;
+			base_memory_range[local_memory_ranges].end  = end;
  			base_memory_range[local_memory_ranges].type = RANGE_RAM;
  			local_memory_ranges++;
  			dbgprintf("%016llx-%016llx : %x\n",
  					base_memory_range[local_memory_ranges-1].start,
  					base_memory_range[local_memory_ranges-1].end,
  					base_memory_range[local_memory_ranges-1].type);
-			fclose(file);
+			close(fd);
  		}
  		closedir(dmem);
  	}
@@ -572,29 +647,19 @@ static int get_devtree_details(unsigned
  
  		if (!strncmp(dentry->d_name, "memory@", 7) ||
  				!strcmp(dentry->d_name, "memory")) {
+			int fd;
  			strcat(fname, "/reg");
-			if ((file = fopen(fname, "r")) == NULL) {
+			if ((fd = open(fname, O_RDONLY)) < 0) {
  				perror(fname);
  				goto error_opencdir;
  			}
-			if ((n = fread(buf, 1, MAXBYTES, file)) < 0) {
-				perror(fname);
-				goto error_openfile;
-			}
-			if (n == sizeof(uint64_t)) {
-				rmo_base = ((uint32_t *)buf)[0];
-				rmo_top = rmo_base + ((uint32_t *)buf)[1];
-			} else if (n == 16) {
-				rmo_base = ((uint64_t *)buf)[0];
-				rmo_top = rmo_base + ((uint64_t *)buf)[1];
-			} else {
-				fprintf(stderr, "Mem node has invalid size: %d\n", n);
+			if (read_memory_region_limits(fd, &rmo_base, &rmo_top) != 0)
  				goto error_openfile;
-			}
+
  			if (rmo_top > 0x30000000UL)
  				rmo_top = 0x30000000UL;
  
-			fclose(file);
+			close(fd);
  			closedir(cdir);
  		} /* memory */
  
@@ -778,6 +843,11 @@ int get_memory_ranges_dt(struct memory_r
  int get_memory_ranges(struct memory_range **range, int *ranges,
  					unsigned long kexec_flags)
  {
+	int res = 0;
+
+	res = init_memory_region_info();
+	if (res != 0)
+		return res;
  #ifdef WITH_GAMECUBE
  	return get_memory_ranges_gc(range, ranges, kexec_flags);
  #else
Index: kexec-tools-2.0.4/kexec/arch/ppc/kexec-ppc.h
===================================================================
--- kexec-tools-2.0.4.orig/kexec/arch/ppc/kexec-ppc.h
+++ kexec-tools-2.0.4/kexec/arch/ppc/kexec-ppc.h
@@ -69,6 +69,12 @@ extern unsigned long long initrd_base, i
  extern unsigned long long ramdisk_base, ramdisk_size;
  extern unsigned char reuse_initrd;
  extern const char *ramdisk;
+
+/* Method to parse the memory/reg nodes in device-tree */
+extern unsigned long dt_address_cells, dt_size_cells;
+extern int init_memory_region_info(void);
+extern int read_memory_region_limits(int fd, unsigned long long *start,
+					unsigned long long *end);
  #define COMMAND_LINE_SIZE	512 /* from kernel */
  /*fs2dt*/
  void reserve(unsigned long long where, unsigned long long length);
Index: kexec-tools-2.0.4/kexec/arch/ppc/crashdump-powerpc.c
===================================================================
--- kexec-tools-2.0.4.orig/kexec/arch/ppc/crashdump-powerpc.c
+++ kexec-tools-2.0.4/kexec/arch/ppc/crashdump-powerpc.c
@@ -81,7 +81,7 @@ static int get_crash_memory_ranges(struc
  	char fname[256];
  	char buf[MAXBYTES];
  	DIR *dir, *dmem;
-	FILE *file;
+	int fd;
  	struct dirent *dentry, *mentry;
  	int i, n, crash_rng_len = 0;
  	unsigned long long start, end, cstart, cend;
@@ -123,17 +123,16 @@ static int get_crash_memory_ranges(struc
  			if (strcmp(mentry->d_name, "reg"))
  				continue;
  			strcat(fname, "/reg");
-			file = fopen(fname, "r");
-			if (!file) {
+			fd = open(fname, O_RDONLY);
+			if (fd < 0) {
  				perror(fname);
  				closedir(dmem);
  				closedir(dir);
  				goto err;
  			}
-			n = fread(buf, 1, MAXBYTES, file);
-			if (n < 0) {
-				perror(fname);
-				fclose(file);
+			n = read_memory_region_limits(fd, &start, &end);
+			if (n != 0) {
+				close(fd);
  				closedir(dmem);
  				closedir(dir);
  				goto err;
@@ -146,24 +145,6 @@ static int get_crash_memory_ranges(struc
  				goto err;
  			}
  
-			/*
-			 * FIXME: This code fails on platforms that
-			 * have more than one memory range specified
-			 * in the device-tree's /memory/reg property.
-			 * or where the #address-cells and #size-cells
-			 * are not identical.
-			 *
-			 * We should interpret the /memory/reg property
-			 * based on the values of the #address-cells and
-			 * #size-cells properites.
-			 */
-			if (n == (sizeof(unsigned long) * 2)) {
-				start = ((unsigned long *)buf)[0];
-				end = start + ((unsigned long *)buf)[1];
-			} else {
-				start = ((unsigned long long *)buf)[0];
-				end = start + ((unsigned long long *)buf)[1];
-			}
  			if (start == 0 && end >= (BACKUP_SRC_END + 1))
  				start = BACKUP_SRC_END + 1;
  
@@ -212,7 +193,7 @@ static int get_crash_memory_ranges(struc
  					= RANGE_RAM;
  				memory_ranges++;
  			}
-			fclose(file);
+			close(fd);
  		}
  		closedir(dmem);
  	}
Index: kexec-tools-2.0.4/kexec/arch/ppc/fs2dt.c
===================================================================
--- kexec-tools-2.0.4.orig/kexec/arch/ppc/fs2dt.c
+++ kexec-tools-2.0.4/kexec/arch/ppc/fs2dt.c
@@ -137,21 +137,11 @@ static void add_usable_mem_property(int
  	if (strncmp(bname, "/memory@", 8) && strcmp(bname, "/memory"))
  		return;
  
-	if (len < 2 * sizeof(unsigned long))
-		die("unrecoverable error: not enough data for mem property\n");
-	len = 2 * sizeof(unsigned long);
-
  	if (lseek(fd, 0, SEEK_SET) < 0)
  		die("unrecoverable error: error seeking in \"%s\": %s\n",
  		    pathname, strerror(errno));
-	if (read(fd, buf, len) != len)
-		die("unrecoverable error: error reading \"%s\": %s\n",
-		    pathname, strerror(errno));
-
-	if (~0ULL - buf[0] < buf[1])
-		die("unrecoverable error: mem property overflow\n");
-	base = buf[0];
-	end = base + buf[1];
+	if (read_memory_region_limits(fd, &base, &end) != 0)
+		die("unrecoverable error: error parsing memory/reg limits\n");
  
  	for (range = 0; range < usablemem_rgns.size; range++) {
  		loc_base = usablemem_rgns.ranges[range].start;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
