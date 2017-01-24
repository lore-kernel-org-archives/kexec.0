Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVwZ2-00087q-Cr
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 08:34:53 +0000
Received: by mail-pf0-f176.google.com with SMTP id f144so48689386pfa.2
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 00:34:32 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v5 1/9] kexec: exntend the semantics of
 kexec_iomem_for_each_line
Date: Tue, 24 Jan 2017 17:33:23 +0900
Message-Id: <20170124083331.3468-2-takahiro.akashi@linaro.org>
In-Reply-To: <20170124083331.3468-1-takahiro.akashi@linaro.org>
References: <20170124083331.3468-1-takahiro.akashi@linaro.org>
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
To: horms@verge.net.au
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

The current kexec_iomem_for_each_line() counts up all the lines for which
a callback function returns zero(0) or positive, and otherwise it stops
further scanning.
This behavior is incovenient in some cases. For instance, on arm64, we want
to count up "System RAM" entries, but need to skip "reserved" entries.

So this patch extends the semantics so that we will continue to scan
succeeding entries but not count lines for which a callback function
returns positive.

The current users of kexec_iomem_for_each_line(), arm, sh and x86, will not
be affected by this change because
* arm
  The callback function only returns -1 or 0, and the return value of
  kexec_iomem_for_each_line() will never be used.
* sh, x86
  The callback function may return (-1 for sh,) 0 or 1, but always returns
  1 once we have reached the maximum number of entries allowed.
  Even so the current kexec_iomem_for_each_line() counts them up.
  This change actually fixes this bug.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/kexec-iomem.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kexec/kexec-iomem.c b/kexec/kexec-iomem.c
index 485a2e8..0a0277a 100644
--- a/kexec/kexec-iomem.c
+++ b/kexec/kexec-iomem.c
@@ -18,6 +18,9 @@
  * Iterate over each line in the file returned by proc_iomem(). If match is
  * NULL or if the line matches with our match-pattern then call the
  * callback if non-NULL.
+ * If match is NULL, callback should return a negative if error.
+ * Otherwise the interation goes on, incrementing nr but only if callback
+ * returns 0 (matched).
  *
  * Return the number of lines matched.
  */
@@ -37,7 +40,7 @@ int kexec_iomem_for_each_line(char *match,
 	char *str;
 	int consumed;
 	int count;
-	int nr = 0;
+	int nr = 0, ret;
 
 	fp = fopen(iomem, "r");
 	if (!fp)
@@ -50,11 +53,13 @@ int kexec_iomem_for_each_line(char *match,
 		str = line + consumed;
 		size = end - start + 1;
 		if (!match || memcmp(str, match, strlen(match)) == 0) {
-			if (callback
-			    && callback(data, nr, str, start, size) < 0) {
-				break;
+			if (callback) {
+				ret = callback(data, nr, str, start, size);
+				if (ret < 0)
+					break;
+				else if (ret == 0)
+					nr++;
 			}
-			nr++;
 		}
 	}
 
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
