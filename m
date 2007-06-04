Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hv6v8-0006Fz-E9
	for kexec@lists.infradead.org; Mon, 04 Jun 2007 03:24:08 -0400
From: Michael Neuling <mikey@neuling.org>
MIME-Version: 1.0
Subject: [PATCH] kexec ppc64: fix misaligned cmdline
Date: Mon, 04 Jun 2007 17:23:45 +1000
Message-ID: <25445.1180941825@neuling.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, Santhosh Rao <sonny@burdell.org>, miltonm@bga.com, linuxppc-dev@ozlabs.org

If the cmdline changes between boots, we can get misalignment of the
bootargs entry, which in turn corrupts our device tree blob and hence
kills our kexec boot.  

Specifically, if the cmdline length was >= 8 before and the new cmdline
length is < 8, we can get corruption.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 kexec/arch/ppc64/fs2dt.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
===================================================================
--- kexec-tools-testing.orig/kexec/arch/ppc64/fs2dt.c
+++ kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
@@ -197,6 +197,7 @@ static void putprops(char *fn, struct di
 	struct dirent *dp;
 	int i = 0, fd, len;
 	struct stat statbuf;
+	int dt_realigned = 0;
 
 	for (i = 0; i < numlist; i++) {
 		dp = nlist[i];
@@ -243,8 +244,10 @@ static void putprops(char *fn, struct di
 		*dt++ = len;
 		*dt++ = propnum(fn);
 
-		if ((len >= 8) && ((unsigned long)dt & 0x4))
+		if ((len >= 8) && ((unsigned long)dt & 0x4)){
 			dt++;
+			dt_realigned = 1;
+		}
 
 		fd = open(pathname, O_RDONLY);
 		if (fd == -1)
@@ -283,6 +286,8 @@ static void putprops(char *fn, struct di
 			strcat(local_cmdline, " ");
 			cmd_len = strlen(local_cmdline);
 			cmd_len = cmd_len + 1;
+			if (dt_realigned && cmd_len < 8)
+				dt--;
 			memcpy(dt, local_cmdline,cmd_len);
 			len = cmd_len;
 			*dt_len = cmd_len;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
