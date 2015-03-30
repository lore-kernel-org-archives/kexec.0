Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YcRAc-0007Pr-EW
 for kexec@lists.infradead.org; Mon, 30 Mar 2015 04:19:27 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 2/6] WIP: Add option to specify working directory for the
 bitmap.
Date: Mon, 30 Mar 2015 04:09:01 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D9CABC@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "cpw@sgi.com" <cpw@sgi.com>

Introduce the new option "--work-dir" to specify the directory
used to store the bitmap. This is the alternative to the combination
of --non-cyclic and TMPDIR.

Signed-off-by: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
---
 makedumpfile.c |   14 +++++++++++++-
 makedumpfile.h |    2 ++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b8e1c1b..40aacf9 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1034,7 +1034,9 @@ open_dump_bitmap(void)
 	char *tmpname;
 
 	tmpname = getenv("TMPDIR");
-	if (!tmpname)
+	if (info->working_dir)
+		tmpname = info->working_dir;
+	else if (!tmpname)
 		tmpname = "/tmp";
 
 	if ((info->name_bitmap = (char *)malloc(sizeof(FILENAME_BITMAP) +
@@ -3251,6 +3253,12 @@ out:
 	if (!get_max_mapnr())
 		return FALSE;
 
+	if (info->working_dir || info->flag_refiltering) {
+		/* implemented as non-cyclic mode based on the file */
+		info->flag_cyclic = FALSE;
+		info->pfn_cyclic = info->max_mapnr;
+	}
+
 	if (info->flag_cyclic) {
 		if (info->bufsize_cyclic == 0) {
 			if (!calculate_cyclic_buffer_size())
@@ -9831,6 +9839,7 @@ static struct option longopts[] = {
 	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
 	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
 	{"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
+	{"work-dir", required_argument, NULL, OPT_WORKING_DIR},
 	{0, 0, 0, 0}
 };
 
@@ -9974,6 +9983,9 @@ main(int argc, char *argv[])
 		case OPT_SPLITBLOCK_SIZE:
 			info->splitblock_size = atoi(optarg);
 			break;
+		case OPT_WORKING_DIR:
+			info->working_dir = optarg;
+			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/makedumpfile.h b/makedumpfile.h
index 4beac65..990c76f 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1151,6 +1151,7 @@ struct DumpInfo {
 	 */
 	struct dump_bitmap *partial_bitmap1;
 	struct dump_bitmap *partial_bitmap2;
+	char	           *working_dir;	     /* working directory for bitmap */
 	mdf_pfn_t          num_dumpable;
 	unsigned long      bufsize_cyclic;
 	unsigned long      pfn_cyclic;
@@ -1897,6 +1898,7 @@ struct elf_prstatus {
 #define OPT_NON_MMAP            OPT_START+13
 #define OPT_MEM_USAGE            OPT_START+14
 #define OPT_SPLITBLOCK_SIZE	OPT_START+15
+#define OPT_WORKING_DIR         OPT_START+16
 
 /*
  * Function Prototype.
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
