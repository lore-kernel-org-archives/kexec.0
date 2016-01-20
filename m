Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aLqIh-0005CM-1i
 for kexec@lists.infradead.org; Wed, 20 Jan 2016 10:47:51 +0000
Subject: [RFC PATCH 2/4] purgatory: Introduce timeout API
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Wed, 20 Jan 2016 19:37:38 +0900
Message-ID: <20160120103738.4234.50715.stgit@softrs>
In-Reply-To: <20160120103734.4234.64015.stgit@softrs>
References: <20160120103734.4234.64015.stgit@softrs>
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Corey Minyard <minyard@acm.org>

This patch introduces timeout API for purgatory code.

Because we don't want to use interrupts in purgatory, this timeout
API is based on polling of the clock.

If you want to start a timer, call init_timeout() with seconds to
the timeout and an instance of struct timeout_info which manages a
virtual timer.  Then, you call EXIT_ON_TIMEOUT() macro periodically
to check if the timeout happens.  If it happens, the control jumps
to timed_out label for timeout handling.  This means you need to
implement timed_out label in each caller function.

To make this timeout API work, an actual implementation of
get_unix_time() which returns a UNIX epoch time is needed.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
---
 purgatory/Makefile       |    4 ++-
 purgatory/include/time.h |   33 ++++++++++++++++++++++++++
 purgatory/time.c         |   58 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 purgatory/include/time.h
 create mode 100644 purgatory/time.c

diff --git a/purgatory/Makefile b/purgatory/Makefile
index ae1d2bd..80caeab 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -13,10 +13,12 @@ PURGATORY_SRCS += purgatory/ipmi.c
 PURGATORY_SRCS += purgatory/purgatory.c
 PURGATORY_SRCS += purgatory/printf.c
 PURGATORY_SRCS += purgatory/string.c
+PURGATORY_SRCS += purgatory/time.c
 PURGATORY_MAP = purgatory/purgatory.map
 
 dist += purgatory/Makefile $(PURGATORY_SRCS)				\
-	purgatory/include/purgatory.h purgatory/include/string.h
+	purgatory/include/purgatory.h purgatory/include/string.h	\
+	purgatory/include/time.h
 
 include $(srcdir)/purgatory/arch/alpha/Makefile
 include $(srcdir)/purgatory/arch/arm/Makefile
diff --git a/purgatory/include/time.h b/purgatory/include/time.h
new file mode 100644
index 0000000..edaf692
--- /dev/null
+++ b/purgatory/include/time.h
@@ -0,0 +1,33 @@
+#ifndef TIME_H
+#define TIME_H
+
+typedef long long time64_t;
+
+struct timeout_info {
+	time64_t start;
+	time64_t end;
+	int timed_out;
+};
+
+time64_t date2unix(int year, int mon, int day, int hour, int min, int sec);
+int check_timeout(struct timeout_info *toi);
+void init_timeout(struct timeout_info *toi, time64_t left);
+
+/**
+ * Check if the timeout happens, and if so, jump to timed_out label.
+ *
+ * @toi: an instance of struct timeout_info initialized by init_timeout().
+ * @check_clock: if this value is 0, this macro doesn't check the actual
+ *               clock.  This is useful for the exit path after timeout.
+ */
+#define EXIT_ON_TIMEOUT(toi, check_clock)       \
+do {                                    	\
+	if ((toi)->timed_out)			\
+		goto timed_out;			\
+	if (check_timeout((toi))) {		\
+		(toi)->timed_out = 1;		\
+		goto timed_out;			\
+	}					\
+} while (0)
+
+#endif /* TIME_H */
diff --git a/purgatory/time.c b/purgatory/time.c
new file mode 100644
index 0000000..0732670
--- /dev/null
+++ b/purgatory/time.c
@@ -0,0 +1,58 @@
+#include "time.h"
+
+/* Calculate unix-epoch time based on Julian day number calculation. */
+time64_t date2unix(int year, int mon, int day, int hour, int min, int sec)
+{
+	time64_t days, seconds;
+
+	mon -= 3;
+	if (mon < 0) {
+		year--;
+		mon += 12;
+	}
+
+	/* days since 1970/1/1 (= 0 day) */
+	days = 365*year + year/4 - year/100 + year/400 + (153*mon + 2)/5 +
+		day - 719469;
+
+	seconds = ((days*24 + hour)*60 + min)*60 + sec;
+
+	return seconds;
+}
+
+/*
+ * Dummy for systems which doesn't have clock access implementation.
+ * You need to override this to enable the timeout mechanism.
+ */
+time64_t __attribute__((weak)) get_unix_time(void)
+{
+	/* This means it never times out. */
+	return 0;
+}
+
+int check_timeout(struct timeout_info *toi)
+{
+	time64_t now;
+
+	if (toi->timed_out)
+		return 1;
+
+	now = get_unix_time();
+	if (toi->end <= now)
+		toi->timed_out = 1;
+
+	return toi->timed_out;
+}
+
+void init_timeout(struct timeout_info *toi, time64_t left)
+{
+	toi->start = get_unix_time();
+
+	/*
+	 * The precision of RTC is one second.  To wait at least specified
+	 * seconds, we do +1.
+	 */
+	toi->end = toi->start + left + 1;
+
+	toi->timed_out = 0;
+}



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
