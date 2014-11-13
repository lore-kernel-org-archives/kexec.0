Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XoiN2-0000TL-9S
 for kexec@lists.infradead.org; Thu, 13 Nov 2014 00:34:44 +0000
From: Anton Blanchard <anton@samba.org>
Subject: [PATCH] kexec/fs2dt: Fix sorting of device tree
Date: Thu, 13 Nov 2014 11:34:18 +1100
Message-Id: <1415838858-3225-1-git-send-email-anton@samba.org>
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
To: horms@verge.net.au, haren@us.ibm.com
Cc: kexec@lists.infradead.org

Commit b02d735bf252 ('ppc64 kdump device_tree sort') added code to
sort device tree properties, but it had a few issues.

A compare routine needs to return -1 and 1. The special case for
sorting properties with unit addresses only returned 1 and ignored
the opposite case, which screwed up the sorting.

We were missing a few more things:

- Need to check both basenames are the same length
- Need to check both basenames match

I noticed this when looking at the NUMA topology after a kexec, and
it had shifted.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 kexec/fs2dt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 1e5f074..304f6cb 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -479,6 +479,8 @@ static int comparefunc(const struct dirent **dentry1,
 {
 	char *str1 = (*(struct dirent **)dentry1)->d_name;
 	char *str2 = (*(struct dirent **)dentry2)->d_name;
+	char *sep1 = strchr(str1, '@');
+	char *sep2 = strchr(str2, '@');
 
 	/*
 	 * strcmp scans from left to right and fails to idetify for some
@@ -486,9 +488,20 @@ static int comparefunc(const struct dirent **dentry1,
 	 * Therefore, we get the wrong sorted order like memory@10000000 and
 	 * memory@f000000.
 	 */
-	if (strchr(str1, '@') && strchr(str2, '@') &&
-		(strlen(str1) > strlen(str2)))
-		return 1;
+	if (sep1 && sep2) {
+		int baselen1 = sep1 - str1;
+		int baselen2 = sep2 - str2;
+		int len1 = strlen(str1);
+		int len2 = strlen(str2);
+
+		/*
+		 * Check the base name matches, and the properties are
+		 * different lengths.
+		 */
+		if ((baselen1 == baselen2) && (len1 != len2) &&
+		    !strncmp(str1, str2, baselen2))
+			return (len1 > len2) - (len1 < len2);
+	}
 
 	return strcmp(str1, str2);
 }
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
