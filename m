Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1etCRw-000186-UZ
 for kexec@lists.infradead.org; Tue, 06 Mar 2018 13:16:14 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH v4 2/5] kexec: do not special-case the -s option
Date: Tue,  6 Mar 2018 14:15:53 +0100
Message-Id: <28358b37c1174572ff6051ec430d750969efa9eb.1520342150.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1520342150.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1520342150.git.msuchanek@suse.de>
In-Reply-To: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
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
To: kexec@lists.infradead.org
Cc: Tony Jones <tonyj@suse.com>, Dave Young <dyoung@redhat.com>, Michal Suchanek <msuchanek@suse.de>, Petr Tesarik <ptesarik@suse.cz>, horms@verge.net.au

It is parsed separately to save a few CPU cycles when setting up other
options but it just complicates the code. So fold it back and set up all
flags both for KEXEC_LOAD and KEXEC_FILE_LOAD

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 kexec/kexec.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index ab8cff7fe083..9ea102e1565a 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1256,19 +1256,6 @@ int main(int argc, char *argv[])
 	};
 	static const char short_options[] = KEXEC_ALL_OPT_STR;
 
-	/*
-	 * First check if --use-kexec-file-syscall is set. That changes lot of
-	 * things
-	 */
-	while ((opt = getopt_long(argc, argv, short_options,
-				  options, 0)) != -1) {
-		switch(opt) {
-		case OPT_KEXEC_FILE_SYSCALL:
-			do_kexec_file_syscall = 1;
-			break;
-		}
-	}
-
 	/* Reset getopt for the next pass. */
 	opterr = 1;
 	optind = 1;
@@ -1310,8 +1297,7 @@ int main(int argc, char *argv[])
 			do_shutdown = 0;
 			do_sync = 0;
 			do_unload = 1;
-			if (do_kexec_file_syscall)
-				kexec_file_flags |= KEXEC_FILE_UNLOAD;
+			kexec_file_flags |= KEXEC_FILE_UNLOAD;
 			break;
 		case OPT_EXEC:
 			do_load = 0;
@@ -1354,11 +1340,8 @@ int main(int argc, char *argv[])
 			do_exec = 0;
 			do_shutdown = 0;
 			do_sync = 0;
-			if (do_kexec_file_syscall)
-				kexec_file_flags |= KEXEC_FILE_ON_CRASH;
-			else
-				kexec_flags = KEXEC_ON_CRASH;
-			break;
+			kexec_file_flags |= KEXEC_FILE_ON_CRASH;
+			kexec_flags = KEXEC_ON_CRASH;
 		case OPT_MEM_MIN:
 			mem_min = strtoul(optarg, &endptr, 0);
 			if (*endptr) {
@@ -1383,7 +1366,7 @@ int main(int argc, char *argv[])
 			do_reuse_initrd = 1;
 			break;
 		case OPT_KEXEC_FILE_SYSCALL:
-			/* We already parsed it. Nothing to do. */
+			do_kexec_file_syscall = 1;
 			break;
 		case OPT_STATUS:
 			do_status = 1;
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
