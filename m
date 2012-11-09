Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TWimQ-0003CM-MC
 for kexec@lists.infradead.org; Fri, 09 Nov 2012 07:13:31 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.192])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id qA97DSWb005407
 for <kexec@lists.infradead.org>; Fri, 9 Nov 2012 16:13:28 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id qA97DSc09356 for kexec@lists.infradead.org;
 Fri, 9 Nov 2012 16:13:28 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv3.nec.co.jp (8.13.8/8.13.4) with ESMTP id qA97DSWP017967
 for <kexec@lists.infradead.org>; Fri, 9 Nov 2012 16:13:28 +0900 (JST)
Date: Fri, 9 Nov 2012 16:04:44 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 3/3] Remove --cyclic-buffer option.
Message-Id: <20121109160444.d93aac8f5851a51499a8393e@mxc.nes.nec.co.jp>
In-Reply-To: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
References: <20121109160214.afe15ee1a047ff7354471ba0@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org

The size of cyclic buffer will be calculated automatically with
[PATCH 2/3], so users don't have to specify the size manually.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.8 | 16 ----------------
 makedumpfile.c | 31 ++++++-------------------------
 print_info.c   | 11 -----------
 3 files changed, 6 insertions(+), 52 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 9f394f0..41d5822 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -348,22 +348,6 @@ on the following example.
 # makedumpfile \-\-reassemble dumpfile1 dumpfile2 dumpfile
 
 .TP
-\fB\-\-cyclic\-buffer\fR \fIbuffer_size\fR
-Specify the buffer size in kilo bytes for analysis in the cyclic mode.
-Actually, the double of \fIbuffer_size\fR kilo bytes will be allocated in memory.
-In the cyclic mode, the number of cycles is represented as:
-
-    num_of_cycles = system_memory / (\fIbuffer_size\fR * 1024 * bit_per_bytes * page_size )
-
-The lesser number of cycles, the faster working speed is expected.
-Default \fIbuffer_size\fR is 1024.
-
-.br
-.B Example:
-.br
-# makedumpfile \-\-cyclic\-buffer 1024 \-d 31 \-x vmlinux /proc/vmcore dumpfile
-
-.TP
 \fB\-\-non\-cyclic\fR
 Running in the non-cyclic mode, this mode uses the old filtering logic same as v1.4.4 or before.
 If you feel the cyclic mode is too slow, please try this mode.
diff --git a/makedumpfile.c b/makedumpfile.c
index f784400..ac05a87 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2715,27 +2715,8 @@ out:
 		return FALSE;
 
 	if (info->flag_cyclic) {
-		/*
-		 * buffer size is specified as Kbyte
-		 */
-		if (info->bufsize_cyclic == 0) {
-			if (!calculate_cyclic_buffer_size())
-				return FALSE;
-		} else
-			info->bufsize_cyclic <<= 10;
-
-		/*
-		 * Max buffer size is 100 MB
-		 */
-		if (info->bufsize_cyclic > (100 << 20)) {
-			MSG("Specified buffer size is too large, ");
-			MSG("The buffer size for the cyclic mode will be truncated to 100 MB.\n");
-			info->bufsize_cyclic = (100 << 20);
-		}
-		info->pfn_cyclic = info->bufsize_cyclic * BITPERBYTE;
-
-		DEBUG_MSG("\n");
-		DEBUG_MSG("Buffer size for the cyclic mode: %ld\n", info->bufsize_cyclic);
+		if (!calculate_cyclic_buffer_size())
+			return FALSE;
 	}
 
 	if (debug_info) {
@@ -8026,6 +8007,10 @@ calculate_cyclic_buffer_size(void) {
 	needed_size = (info->max_mapnr * 2) / BITPERBYTE;
 
 	info->bufsize_cyclic = (free_size <= needed_size) ? free_size : needed_size;
+	info->pfn_cyclic = info->bufsize_cyclic * BITPERBYTE;
+
+	DEBUG_MSG("\n");
+	DEBUG_MSG("Buffer size for the cyclic mode: %ld\n", info->bufsize_cyclic);
 
 	return TRUE;
 }
@@ -8043,7 +8028,6 @@ static struct option longopts[] = {
 	{"help", no_argument, NULL, 'h'},
 	{"diskset", required_argument, NULL, 'k'},
 	{"non-cyclic", no_argument, NULL, 'Y'},
-	{"cyclic-buffer", required_argument, NULL, 'Z'},
 	{0, 0, 0, 0}
 };
 
@@ -8167,9 +8151,6 @@ main(int argc, char *argv[])
 			info->flag_read_vmcoreinfo = 1;
 			info->name_vmcoreinfo = optarg;
 			break;
-		case 'Z':
-			info->bufsize_cyclic = atoi(optarg);
-			break;
 		case '?':
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
diff --git a/print_info.c b/print_info.c
index f3ee43a..ac96448 100644
--- a/print_info.c
+++ b/print_info.c
@@ -168,17 +168,6 @@ print_usage(void)
 	MSG("      Reassemble multiple DUMPFILEs, which are created by --split option,\n");
 	MSG("      into one DUMPFILE. dumpfile1 and dumpfile2 are reassembled into dumpfile.\n");
 	MSG("\n");
-	MSG("  [--cyclic-buffer BUFFER_SIZE]:\n");
-	MSG("      Specify the buffer size in kilo bytes for analysis in the cyclic mode.\n");
-	MSG("      Actually, the double of BUFFER_SIZE kilo bytes will be allocated in memory.\n");
-	MSG("      In the cyclic mode, the number of cycles is represented as:\n");
-	MSG("\n");
-	MSG("          num_of_cycles = system_memory / \n");
-	MSG("                          (BUFFER_SIZE * 1024 * bit_per_bytes * page_size)\n");
-	MSG("\n");
-	MSG("      The lesser number of cycles, the faster working speed is expected.\n");
-	MSG("      Default BUFFER_SIZE is 1024.\n");
-	MSG("\n");
 	MSG("  [--non-cyclic]:\n");
 	MSG("      Running in the non-cyclic mode, this mode uses the old filtering logic\n");
 	MSG("      same as v1.4.4 or before.\n");
-- 
1.7.11

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
