Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yhzlo-000242-JR
 for kexec@lists.infradead.org; Tue, 14 Apr 2015 12:16:49 +0000
Received: by qkhg7 with SMTP id g7so15427257qkh.2
 for <kexec@lists.infradead.org>; Tue, 14 Apr 2015 05:16:27 -0700 (PDT)
Date: Tue, 14 Apr 2015 08:16:02 -0400
From: Tejun Heo <tj@kernel.org>
Subject: [PATCH REPOST 2/2] kexec: remove ordering constraints from -x
 (--no-ifdown) and -y (--no-sync)
Message-ID: <20150414121602.GK2596@htj.duckdns.org>
References: <20150326191608.GE1953@htj.duckdns.org>
 <20150326191644.GF1953@htj.duckdns.org>
 <20150413170156.GH2596@htj.duckdns.org>
 <20150414002944.GB10790@verge.net.au>
 <20150414121509.GJ2596@htj.duckdns.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150414121509.GJ2596@htj.duckdns.org>
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
Cc: Chris Mason <clm@fb.com>, kexec@lists.infradead.org

From 81b5889b49f0f2448c3e9543c5c936d52348910c Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 26 Mar 2015 15:11:09 -0400

Currently, the two options must be the last ones to be honored;
otherwise, they can get silently ignored and both the manpage and help
text point it out.  This is error-prone and trivial to fix.  There
isn't much point in pointing something out in documentation when the
peculiarity can be removed with four lines of extra code.

Update option handling so that the two arguments are honored
regardless of their positions.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kexec/kexec.8 |  6 ++----
 kexec/kexec.c | 17 +++++++++--------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 24d1969..4d0c1d1 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -147,12 +147,10 @@ target kernel. If a capture kernel is being unloaded then specify -p with -u.
 Return the version number of the installed utility.
 .TP
 .B \-x\ (\-\-no\-ifdown)
-Shut down the running kernel, but restore the interface on reload. (If
-this option is used, it must be one of last options specified.)
+Shut down the running kernel, but restore the interface on reload.
 .TP
 .B \-y\ (\-\-no\-sync)
-Shut down the running kernel, but skip syncing the filesystems. (If
-this option is used, it must be one of last options specified.)
+Shut down the running kernel, but skip syncing the filesystems.
 .TP
 .BI \-\-mem\-min= addr
 Specify the lowest memory address
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 7123460..8ce6885 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -913,11 +913,7 @@ void usage(void)
 	       " -f, --force          Force an immediate kexec,\n"
 	       "                      don't call shutdown.\n"
 	       " -x, --no-ifdown      Don't bring down network interfaces.\n"
-	       "                      (if used, must be one of last options\n"
-	       "                       specified)\n"
 	       " -y, --no-sync        Don't sync filesystems before kexec.\n"
-	       "                      (if used, must be one of last options\n"
-	       "                       specified)\n"
 	       " -l, --load           Load the new kernel into the\n"
 	       "                      current kernel.\n"
 	       " -p, --load-panic     Load the new kernel for use on panic.\n"
@@ -1170,8 +1166,8 @@ int main(int argc, char *argv[])
 	int do_exec = 0;
 	int do_load_jump_back_helper = 0;
 	int do_shutdown = 1;
-	int do_sync = 1;
-	int do_ifdown = 0;
+	int do_sync = 1, skip_sync = 0;
+	int do_ifdown = 0, skip_ifdown = 0;
 	int do_unload = 0;
 	int do_reuse_initrd = 0;
 	int do_kexec_file_syscall = 0;
@@ -1219,10 +1215,10 @@ int main(int argc, char *argv[])
 		case OPT_DEBUG:
 			kexec_debug = 1;
 		case OPT_NOIFDOWN:
-			do_ifdown = 0;
+			skip_ifdown = 1;
 			break;
 		case OPT_NOSYNC:
-			do_sync = 0;
+			skip_sync = 1;
 			break;
 		case OPT_FORCE:
 			do_load = 1;
@@ -1321,6 +1317,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (skip_ifdown)
+		do_ifdown = 0;
+	if (skip_sync)
+		do_sync = 0;
+
 	if (do_load && (kexec_flags & KEXEC_ON_CRASH) &&
 	    !is_crashkernel_mem_reserved()) {
 		die("Memory for crashkernel is not reserved\n"
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
