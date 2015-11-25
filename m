Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22d.google.com ([2607:f8b0:400e:c03::22d])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1Pe9-0003fP-Se
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 02:17:27 +0000
Received: by pacdm15 with SMTP id dm15so40740231pac.3
 for <kexec@lists.infradead.org>; Tue, 24 Nov 2015 18:17:06 -0800 (PST)
Received: from monster-15.cumulusnetworks.com. ([216.129.126.126])
 by smtp.googlemail.com with ESMTPSA id xr8sm17475815pab.26.2015.11.24.18.17.04
 for <kexec@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Nov 2015 18:17:05 -0800 (PST)
From: Curt Brune <curt@cumulusnetworks.com>
Subject: [PATCH 1/1] Improve device tree directory sorting
Date: Tue, 24 Nov 2015 18:17:10 -0800
Message-Id: <1448417830-48786-2-git-send-email-curt@cumulusnetworks.com>
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

Previously when sorting the device tree directory entries, if both
device tree entries contained the '@' character then comparison was
made based on the length of the strings.

This did not work in all cases and could result in odd orderings.

This patch modifies the comparison function for the case when both
strings contain the '@' character.

First a lexical comparison is made between the prefix portions of the
strings *before* the '@' character.

Next, if the prefixes are equal, the lengths of the suffixes *after*
the '@' character are compared.  This preserves the intent of the
original code.

Next, if the suffix lengths are equal, a lexical comparison of the
suffixes is made.

This is still not strictly correct, as ideally the portion after the
'@' should be compared numerically.  However, determining what base to
use for all case is difficult.

Signed-off-by: Curt Brune <curt@cumulusnetworks.com>
---
 kexec/arch/ppc/fs2dt.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
index 4121c7d..6e77379 100644
--- a/kexec/arch/ppc/fs2dt.c
+++ b/kexec/arch/ppc/fs2dt.c
@@ -30,6 +30,7 @@
 #include <stdio.h>
 #include "../../kexec.h"
 #include "kexec-ppc.h"
+#include "types.h"
 
 #define MAXPATH			1024	/* max path name length */
 #define NAMESPACE		16384	/* max bytes for property names */
@@ -296,6 +297,8 @@ static int comparefunc(const void *dentry1, const void *dentry2)
 {
 	char *str1 = (*(struct dirent **)dentry1)->d_name;
 	char *str2 = (*(struct dirent **)dentry2)->d_name;
+	char *p1, *p2;
+	int res = 0, max_len;
 
 	/*
 	 * strcmp scans from left to right and fails to idetify for some
@@ -303,11 +306,21 @@ static int comparefunc(const void *dentry1, const void *dentry2)
 	 * Therefore, we get the wrong sorted order like memory@10000000 and
 	 * memory@f000000.
 	 */
-	if (strchr(str1, '@') && strchr(str2, '@') &&
-		(strlen(str1) > strlen(str2)))
-		return 1;
+	if ((p1 = strchr(str1, '@')) && (p2 = strchr(str2, '@'))) {
+		max_len = max(p1 - str1, p2 - str2);
+		if ((res = strncmp(str1, str2, max_len)) == 0) {
+			/* prefix is equal - compare part after '@' by length */
+			p1++; p2++;
+			res = strlen(p1) - strlen(p2);
+			if (res == 0)
+				/* equal length, compare by strcmp() */
+				res = strcmp(p1,p2);
+		}
+        } else {
+		res = strcmp(str1, str2);
+        }
 
-	return strcmp(str1, str2);
+	return res;
 }
 
 /*
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
