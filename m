Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SZxWJ-0001JL-FS
 for kexec@lists.infradead.org; Thu, 31 May 2012 05:02:03 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.193])
 by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V51cBj001231
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:01:39 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q4V51cA19285 for kexec@lists.infradead.org;
 Thu, 31 May 2012 14:01:38 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id q4V51cbm006514
 for <kexec@lists.infradead.org>; Thu, 31 May 2012 14:01:38 +0900 (JST)
Date: Thu, 31 May 2012 13:54:51 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH 1/4] makedumpfile: Add flag to enable cyclic processing.
Message-Id: <20120531135451.4ae2a0aa.kumagai-atsushi@mxc.nes.nec.co.jp>
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

Introduce -K option to enable cyclic processing. If -K option is specified,
then makedumpfile works cyclically and the memory usage will be constant.

Usage:
      # makedumpfile -K /proc/vmcore dumpfile

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 makedumpfile.c |    5 ++++-
 makedumpfile.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index d024e95..3e5f906 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -6968,7 +6968,7 @@ main(int argc, char *argv[])
 
 	info->block_order = DEFAULT_ORDER;
 	message_level = DEFAULT_MSG_LEVEL;
-	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMRrsvXx:", longopts,
+	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:KlMRrsvXx:", longopts,
 	    NULL)) != -1) {
 		switch (opt) {
 		case 'b':
@@ -7017,6 +7017,9 @@ main(int argc, char *argv[])
 				goto out;
 			info->flag_sadump_diskset = 1;
 			break;
+		case 'K':
+			info->flag_cyclic = TRUE;
+			break;
 		case 'l':
 			info->flag_compress = DUMP_DH_COMPRESSED_LZO;
 			break;
diff --git a/makedumpfile.h b/makedumpfile.h
index 6f5489d..c588e43 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -801,6 +801,7 @@ struct DumpInfo {
 	int		flag_rearrange;      /* flag of creating dumpfile from
 						flattened format */
 	int		flag_split;	     /* splitting vmcore */
+	int		flag_cyclic;	     /* cyclic processing to keep memory consumption */
 	int		flag_reassemble;     /* reassemble multiple dumpfiles into one */
 	int		flag_refiltering;    /* refilter from kdump-compressed file */
 	int		flag_force;	     /* overwrite existing stuff */
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
