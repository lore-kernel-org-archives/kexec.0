Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dL4nn-0002bL-UU
 for kexec@lists.infradead.org; Wed, 14 Jun 2017 09:41:30 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [makedumpfile PATCHv3 1/2] fold the calc of time delta into a func
Date: Wed, 14 Jun 2017 17:41:01 +0800
Message-Id: <1497433262-5687-1-git-send-email-piliu@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>

This piece of code will be used by more than one function after
introducing the next patch

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 print_info.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/print_info.c b/print_info.c
index 832196d..79dfe5e 100644
--- a/print_info.c
+++ b/print_info.c
@@ -337,6 +337,19 @@ print_usage(void)
 	MSG("\n");
 }
 
+static void calc_delta(struct timeval *tv_start, struct timeval *delta)
+{
+	struct timeval tv_end;
+
+	gettimeofday(&tv_end, NULL);
+	delta->tv_sec = tv_end.tv_sec - tv_start->tv_sec;
+	delta->tv_usec = tv_end.tv_usec - tv_start->tv_usec;
+	if (delta->tv_usec < 0) {
+		delta->tv_sec--;
+		delta->tv_usec += 1000000;
+	}
+}
+
 void
 print_progress(const char *msg, unsigned long current, unsigned long end)
 {
@@ -369,19 +382,10 @@ print_progress(const char *msg, unsigned long current, unsigned long end)
 void
 print_execution_time(char *step_name, struct timeval *tv_start)
 {
-	struct timeval tv_end;
-	time_t diff_sec;
-	suseconds_t diff_usec;
+	struct timeval delta;
 
-	gettimeofday(&tv_end, NULL);
-
-	diff_sec  = tv_end.tv_sec - tv_start->tv_sec;
-	diff_usec = tv_end.tv_usec - tv_start->tv_usec;
-	if (diff_usec < 0) {
-		diff_sec--;
-		diff_usec += 1000000;
-	}
+	calc_delta(tv_start, &delta);
 	REPORT_MSG("STEP [%s] : %ld.%06ld seconds\n",
-		   step_name, diff_sec, diff_usec);
+		   step_name, delta.tv_sec, delta.tv_usec);
 }
 
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
