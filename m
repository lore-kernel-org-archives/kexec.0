Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TjB1y-0002Gz-BI
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 15:49:03 +0000
From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH 2/5] fixed strncat size argument on ppc64
Date: Thu, 13 Dec 2012 16:48:47 +0100
Message-Id: <1355413730-18190-2-git-send-email-olaf@aepfle.de>
In-Reply-To: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
References: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Olaf Hering <olaf@aepfle.de>

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 kexec/arch/ppc64/fs2dt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index d2b6b18..f02540d 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -499,7 +499,7 @@ static void putnode(void)
 
 	basename = strrchr(pathname,'/');
 
-	strcat(pathname, "/");
+	strncat(pathname, "/", MAXPATH - strlen(pathname) - 1);
 	dn = pathname + strlen(pathname);
 
 	putprops(dn, namelist, numlist);
@@ -560,7 +560,7 @@ static void putnode(void)
 			char *old_param;
 
 			strcpy(filename, pathname);
-			strcat(filename, "bootargs");
+			strncat(filename, "bootargs", MAXPATH - strlen(filename) - 1);
 			fp = fopen(filename, "r");
 			if (fp) {
 				if (getline(&last_cmdline, &cmd_len, fp) == -1)
@@ -599,7 +599,7 @@ static void putnode(void)
 		 * pseries/hvcterminal is supported.
 		 */
 		strcpy(filename, pathname);
-		strncat(filename, "linux,stdout-path", MAXPATH);
+		strncat(filename, "linux,stdout-path", MAXPATH - strlen(filename) - 1);
 		fd = open(filename, O_RDONLY);
 		if (fd == -1) {
 			printf("Unable to find %s, printing from purgatory is diabled\n",
@@ -623,8 +623,8 @@ static void putnode(void)
 		read(fd, buff, statbuf.st_size);
 		close(fd);
 		strncpy(filename, "/proc/device-tree/", MAXPATH);
-		strncat(filename, buff, MAXPATH);
-		strncat(filename, "/compatible", MAXPATH);
+		strncat(filename, buff, MAXPATH - strlen(filename) - 1);
+		strncat(filename, "/compatible", MAXPATH - strlen(filename) - 1);
 		fd = open(filename, O_RDONLY);
 		if (fd == -1) {
 			printf("Unable to find %s printing from purgatory is diabled\n",
-- 
1.8.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
