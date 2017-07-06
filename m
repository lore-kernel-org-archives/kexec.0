Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dTCMF-0005O1-NC
 for kexec@lists.infradead.org; Thu, 06 Jul 2017 19:22:37 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [makedumpfile PATCH] Allow PFN_EXCLUDED to be tunable via command
 line option --exclude-threshold
Date: Thu,  6 Jul 2017 14:21:22 -0500
Message-Id: <1499368882-2125-1-git-send-email-eric.devolder@oracle.com>
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
To: kexec@lists.infradead.org, ats-kumagai@wm.jp.nec.com
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, konrad.wilk@oracle.com

The PFN_EXCLUDED value is used to control at which point a run of
zeros in the bitmap (zeros denote excluded pages) is large enough
to warrant truncating the current output segment and to create a
new output segment (containing non-excluded pages), in an ELF dump.

If the run is smaller than PFN_EXCLUDED, then those excluded pages
are still output in the ELF dump, for the current output segment.

By using smaller values of PFN_EXCLUDED, the resulting dump file
size can be made smaller by actually removing more excluded pages
from the resulting dump file.

This patch adds the command line option --exclude-threshold=<value>
to indicate the threshold. The default is 256, the legacy value
of PFN_EXCLUDED. The smallest value permitted is 1.

Using an existing vmcore, this was tested by the following:

% makedumpfile -E -d31 --exclude-threshold=256 -x vmlinux vmcore newvmcore256
% makedumpfile -E -d31 --exclude-threshold=4 -x vmlinux vmcore newvmcore4

I utilize -d31 in order to exclude as many page types as possible,
resulting in a [significantly] smaller file sizes than the original
vmcore.

-rwxrwx--- 1 edevolde edevolde 4034564096 Jun 27 10:24 vmcore
-rw------- 1 edevolde edevolde 119808156 Jul  6 13:01 newvmcore256
-rw------- 1 edevolde edevolde 100811276 Jul  6 13:08 newvmcore4

The use of smaller value of PFN_EXCLUDED increases the number of
output segments (the 'Number of program headers' in the readelf
output) in the ELF dump file.

% readelf -h vmcore
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              CORE (Core file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          64 (bytes into file)
  Start of section headers:          0 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         6
                                     ^^^
  Size of section headers:           0 (bytes)
  Number of section headers:         0
  Section header string table index: 0

% readelf -h newvmcore256
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              CORE (Core file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          64 (bytes into file)
  Start of section headers:          0 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         18
                                     ^^^
  Size of section headers:           0 (bytes)
  Number of section headers:         0
  Section header string table index: 0

% readelf -h newvmcore4
ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              CORE (Core file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          64 (bytes into file)
  Start of section headers:          0 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         244
                                     ^^^
  Size of section headers:           0 (bytes)
  Number of section headers:         0
  Section header string table index: 0

The newvmcore4 has an even smaller file size than newvmcore256, with
the small price being that there are now 244 rather than 18 segments
in the dump file.

And with a larger number of segments, loading both vmcore and newvmcore4
into 'crash' resulted in identical outputs when run with the dmesg, ps,
files, mount, and net sub-commands.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
v1: Posted 06jul2017 to kexec-tools mailing list
 - original
---
 makedumpfile.c | 20 +++++++++++++++++---
 makedumpfile.h |  4 +++-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index e69b6df..940f64c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -7236,7 +7236,7 @@ get_loads_dumpfile_cyclic(void)
 
 				/*
 				 * If the number of the contiguous pages to be excluded
-				 * is 256 or more, those pages are excluded really.
+				 * is PFN_EXCLUDED or more, those pages are excluded really.
 				 * And a new PT_LOAD segment is created.
 				 */
 				if (num_excluded >= PFN_EXCLUDED) {
@@ -7352,7 +7352,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 					continue;
 					/*
 					 * If the number of the contiguous pages to be excluded
-					 * is 255 or less, those pages are not excluded.
+					 * is less than PFN_EXCLUDED, those pages are not excluded.
 					 */
 				} else if (num_excluded < PFN_EXCLUDED) {
 					if ((pfn == pfn_end - 1) && frac_tail) {
@@ -7370,7 +7370,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 
 				/*
 				 * If the number of the contiguous pages to be excluded
-				 * is 256 or more, those pages are excluded really.
+				 * is PFN_EXCLUDED or more, those pages are excluded really.
 				 * And a new PT_LOAD segment is created.
 				 */
 				load.p_memsz = memsz;
@@ -11007,6 +11007,7 @@ static struct option longopts[] = {
 	{"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
 	{"work-dir", required_argument, NULL, OPT_WORKING_DIR},
 	{"num-threads", required_argument, NULL, OPT_NUM_THREADS},
+	{"exclude-threshold", required_argument, NULL, OPT_PFN_EXCLUDE_THRESHOLD},
 	{0, 0, 0, 0}
 };
 
@@ -11044,6 +11045,14 @@ main(int argc, char *argv[])
 	 */
 	info->flag_usemmap = MMAP_TRY;
 
+	/*
+	 * A run of zeros in the bitmap (excluded pages) of less than
+	 * pfn_excluded_threshold in length will still be dumped. Runs greater
+	 * than or equal to pfn_excluded_threshold will result in the creation
+	 * of a new output segment, for ELF dumps.
+	 */
+	info->pfn_exclude_threshold = 256;
+
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
 	while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lpRvXx:", longopts,
@@ -11163,6 +11172,11 @@ main(int argc, char *argv[])
 		case OPT_NUM_THREADS:
 			info->num_threads = MAX(atoi(optarg), 0);
 			break;
+		case OPT_PFN_EXCLUDE_THRESHOLD:
+			info->pfn_exclude_threshold = strtoul(optarg, NULL, 0);
+			if (0 == info->pfn_exclude_threshold)
+				info->pfn_exclude_threshold = 1;
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index e32e567..33d3eb0 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -216,7 +216,7 @@ isAnon(unsigned long mapping)
 
 #define BITPERBYTE		(8)
 #define PGMM_CACHED		(512)
-#define PFN_EXCLUDED		(256)
+#define PFN_EXCLUDED		(info->pfn_exclude_threshold)
 #define BUFSIZE			(1024)
 #define BUFSIZE_FGETS		(1500)
 #define BUFSIZE_BITMAP		(4096)
@@ -1139,6 +1139,7 @@ struct DumpInfo {
 	long		page_size;           /* size of page */
 	long		page_shift;
 	mdf_pfn_t	max_mapnr;   /* number of page descriptor */
+	unsigned long	pfn_exclude_threshold;
 	unsigned long   page_offset;
 	unsigned long   section_size_bits;
 	unsigned long   max_physmem_bits;
@@ -2143,6 +2144,7 @@ struct elf_prstatus {
 #define OPT_SPLITBLOCK_SIZE	OPT_START+14
 #define OPT_WORKING_DIR         OPT_START+15
 #define OPT_NUM_THREADS	OPT_START+16
+#define OPT_PFN_EXCLUDE_THRESHOLD	OPT_START+17
 
 /*
  * Function Prototype.
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
