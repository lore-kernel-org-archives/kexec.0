Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1et9VT-00005z-N0
 for kexec@lists.infradead.org; Tue, 06 Mar 2018 10:07:41 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EC12404008D
 for <kexec@lists.infradead.org>; Tue,  6 Mar 2018 10:07:14 +0000 (UTC)
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH] Fix array index out of bound exception
Date: Tue,  6 Mar 2018 18:07:11 +0800
Message-Id: <20180306100711.16786-1-lijiang@redhat.com>
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

A data overflow may lead to a reversal, which may turn a positive
number into a large negative number, in this case, the string's
length will exceed the array size(for example, eta: -2147483648s),
here the array size is defined 16 characters. So, it is nessasary
to consider some exceptions.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 print_info.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/print_info.c b/print_info.c
index e0e6a27..09e215a 100644
--- a/print_info.c
+++ b/print_info.c
@@ -16,6 +16,8 @@
 #include "print_info.h"
 #include <time.h>
 #include <string.h>
+#include <stdint.h>
+#include <inttypes.h>
 
 #define PROGRESS_MAXLEN		"50"
 
@@ -352,18 +354,21 @@ static void calc_delta(struct timeval *tv_start, struct timeval *delta)
 }
 
 /* produce less than 12 bytes on msg */
-static int eta_to_human_short (int secs, char* msg)
+static int eta_to_human_short (int64_t secs, char* msg, int maxsize)
 {
 	strcpy(msg, "eta: ");
 	msg += strlen("eta: ");
 	if (secs < 100)
-		sprintf(msg, "%ds", secs);
+		snprintf(msg, maxsize, "%"PRId64"s", secs);
 	else if (secs < 100 * 60)
-		sprintf(msg, "%dm%ds", secs / 60, secs % 60);
+		snprintf(msg, maxsize, "%"PRId64"m""%"PRId64"s",
+			secs / 60, secs % 60);
 	else if (secs < 48 * 3600)
-		sprintf(msg, "%dh%dm", secs / 3600, (secs / 60) % 60);
+		snprintf(msg, maxsize, "%"PRId64"h""%"PRId64"m",
+			secs / 3600, (secs / 60) % 60);
 	else if (secs < 100 * 86400)
-		sprintf(msg, "%dd%dh", secs / 86400, (secs / 3600) % 24);
+		snprintf(msg, maxsize, "%"PRId64"d""%"PRId64"h",
+			secs / 86400, (secs / 3600) % 24);
 	else
 		sprintf(msg, ">2day");
 	return 0;
@@ -379,8 +384,8 @@ print_progress(const char *msg, unsigned long current, unsigned long end, struct
 	static unsigned int lapse = 0;
 	static const char *spinner = "/|\\-";
 	struct timeval delta;
-	double eta;
-	char eta_msg[16] = " ";
+	int64_t eta;
+	char eta_msg[32] = " ";
 
 	if (current < end) {
 		tm = time(NULL);
@@ -395,7 +400,7 @@ print_progress(const char *msg, unsigned long current, unsigned long end, struct
 		calc_delta(start, &delta);
 		eta = delta.tv_sec + delta.tv_usec / 1e6;
 		eta = (100 - progress) * eta / progress;
-		eta_to_human_short(eta, eta_msg);
+		eta_to_human_short(eta, eta_msg, sizeof(eta_msg));
 	}
 	if (flag_ignore_r_char) {
 		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c  %16s\n",
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
