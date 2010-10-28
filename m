Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nlpi087.prodigy.net ([207.115.36.103])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PBZyS-0006Gr-OC
	for kexec@lists.infradead.org; Thu, 28 Oct 2010 21:25:30 +0000
Received: from alexandria.lan (ppp-70-248-74-84.dsl.ksc2mo.swbell.net
	[70.248.74.84])
	by nlpi087.prodigy.net (8.14.4 biz_spool_out_ldap/8.14.4) with ESMTP id
	o9SLPRpk009495
	for <kexec@lists.infradead.org>; Thu, 28 Oct 2010 16:25:27 -0500
Date: Thu, 28 Oct 2010 16:25:27 -0500
From: Austin Morgan <admorgan@morgancomputers.net>
Subject: [PATCH] slurpfile: use lseek() on block nodes instead of fstat()
	for file size
Message-ID: <20101028212515.GA24848@alexandria.lan>
MIME-Version: 1.0
Content-Disposition: inline
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

fstat() is used to determine the file size before read() and
it requires a files ystem. That means that it can not be used
on block nodes. This makes it impossible to obtain the
kernel from a raw block device.

We can't use this in every case because files in /proc doesn't
support lseek().

Signed-off-by: Austin Morgan <admorgan@morgancomputers.net>
---
 kexec/kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 10ad41d..e9d6a54 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -499,7 +499,7 @@ char *slurp_file(const char *filename, off_t *r_size)
 	 * This does not work on regular files which live in /proc and
 	 * we need this for some /proc/device-tree entries
 	 */
-	if (S_ISCHR(stats.st_mode)) {
+	if (S_ISCHR(stats.st_mode) || S_ISBLK(stats.st_mode)) {
 
 		size = lseek(fd, 0, SEEK_END);
 		if (size < 0)
-- 
1.7.2.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
