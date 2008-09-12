Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=IE1EHSOBE004.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KeE0M-0001yO-BB
	for kexec@lists.infradead.org; Fri, 12 Sep 2008 19:08:31 +0000
Message-ID: <48CABE27.10301@am.sony.com>
Date: Fri, 12 Sep 2008 12:08:23 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch kexec] Fix test for loaded kernel
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

Fix these reboot errors with NFS mounted root filesystems:

  nfs: server 192.168.1.1 not responding, still trying

The main kexec code that uses kexec_loaded() expects a non-zero 
return to mean a kexec kernel has been loaded for execution.
Here is the current check:

	if ((result == 0) && (do_shutdown || do_exec) && !kexec_loaded())
		die

In cases where the currently running kernel does not have kexec enabled,
or in cases where the distro init scripts (YDL, maybe others) have unmounted
the sys filesystem prior to running kexec, the open of
"/sys/kernel/kexec_loaded" will fail.  This result should be returned as
(0), meaning NOT LOADED.  The current kexec_loaded() code returns (-1),
meaning LOADED.

With the current code, kexec will continue on.  The next steps are to
shutdown the network, then call sys_kexec.  The shutdown of the network
will succeed, but the call to sys_kexec will fail.  In this case, control
will pass back to the init scripts, but the network will be down.
Systems with NFS mounted root filesystem cannot work in this state.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 kexec/kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -805,7 +805,7 @@ static int kexec_loaded(void)
 
 	fp = fopen("/sys/kernel/kexec_loaded", "r");
 	if (fp == NULL)
-		return -1;
+		return 0;
 	fscanf(fp, "%d", &ret);
 	fclose(fp);
 	return ret;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
