Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f5TI4-0003xP-4I
 for kexec@lists.infradead.org; Mon, 09 Apr 2018 09:40:54 +0000
Date: Mon, 9 Apr 2018 11:40:20 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH] makedumpfile: Do not print ETA value if current progress is 0
Message-ID: <20180409114020.1b48ba8c@ezekiel.suse.cz>
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
To: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Takuya Nakayama <tak-nakayama@tg.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>, Lianbo Jiang <lijiang@redhat.com>, kexec-ml <kexec@lists.infradead.org>

Essentially, the estimated remaining time is calculated as:

  elapsed * (100 - progress) / progress

However, print_progress() is also called when progress is 0. The
result of a floating point division by zero is either NaN (if
elapsed is zero), or infinity (if the system clock happens to cross
a second's boundary since reading the start timestamp).

The C standard defines only conversion of floating point values
within the range of the destination integer variable. This means
that conversion of NaN or infinity to an integer is undefined
behaviour. Yes, it happens to produce INT_MIN with GCC on major
platforms...

This bug has gone unnoticed, because the very first call to
print_progress() does not specify a start timestamp (so it cannot
trigger the bug), and all subsequent calls are rate-limited to one
per second. As a result, the bug is triggered very rarely.

Before commit e5f96e79d69a1d295f19130da00ec6514d28a8ae, the bug also
caused a buffer overflow. The buffer overflow is mitigated thanks to
using snprintf() instead of sprintf(), but the program may still
invoke undefined behaviour.

Note that all other changes in the above-mentioned commit were
ineffective. They merely reduced the precision of the calculation:
Why would you add delta.tv_usec as a fraction if the fractional part
is immediately truncated by a converstion to int64_t?

Additionally, when the original bug is hit, the output is still
incorrect, e.g. on my system I get:

Copying data                                      : [  0.0 %] /  eta: -9223372036854775808s

For that reason, let me revert the changes from commit
e5f96e79d69a1d295f19130da00ec6514d28a8ae and fix the bug properly,
i.e. do not calculate ETA if progress is 0.

Last but not least, part of the issue was probably caused by the
wrong assumption that integers < 100 can be interpreted with max 3
ASCII characters, but that's not true for signed integers. To make
eta_to_human_short() a bit safer, use an unsigned integer type.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 print_info.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/print_info.c b/print_info.c
index 09e215a..ed701ab 100644
--- a/print_info.c
+++ b/print_info.c
@@ -16,8 +16,6 @@
 #include "print_info.h"
 #include <time.h>
 #include <string.h>
-#include <stdint.h>
-#include <inttypes.h>
 
 #define PROGRESS_MAXLEN		"50"
 
@@ -354,21 +352,18 @@ static void calc_delta(struct timeval *tv_start, struct timeval *delta)
 }
 
 /* produce less than 12 bytes on msg */
-static int eta_to_human_short (int64_t secs, char* msg, int maxsize)
+static int eta_to_human_short (unsigned secs, char* msg)
 {
 	strcpy(msg, "eta: ");
 	msg += strlen("eta: ");
 	if (secs < 100)
-		snprintf(msg, maxsize, "%"PRId64"s", secs);
+		sprintf(msg, "%us", secs);
 	else if (secs < 100 * 60)
-		snprintf(msg, maxsize, "%"PRId64"m""%"PRId64"s",
-			secs / 60, secs % 60);
+		sprintf(msg, "%um%us", secs / 60, secs % 60);
 	else if (secs < 48 * 3600)
-		snprintf(msg, maxsize, "%"PRId64"h""%"PRId64"m",
-			secs / 3600, (secs / 60) % 60);
+		sprintf(msg, "%uh%um", secs / 3600, (secs / 60) % 60);
 	else if (secs < 100 * 86400)
-		snprintf(msg, maxsize, "%"PRId64"d""%"PRId64"h",
-			secs / 86400, (secs / 3600) % 24);
+		sprintf(msg, "%ud%uh", secs / 86400, (secs / 3600) % 24);
 	else
 		sprintf(msg, ">2day");
 	return 0;
@@ -384,8 +379,8 @@ print_progress(const char *msg, unsigned long current, unsigned long end, struct
 	static unsigned int lapse = 0;
 	static const char *spinner = "/|\\-";
 	struct timeval delta;
-	int64_t eta;
-	char eta_msg[32] = " ";
+	double eta;
+	char eta_msg[16] = " ";
 
 	if (current < end) {
 		tm = time(NULL);
@@ -396,11 +391,11 @@ print_progress(const char *msg, unsigned long current, unsigned long end, struct
 	} else
 		progress = 100;
 
-	if (start != NULL) {
+	if (start != NULL && current != 0) {
 		calc_delta(start, &delta);
 		eta = delta.tv_sec + delta.tv_usec / 1e6;
 		eta = (100 - progress) * eta / progress;
-		eta_to_human_short(eta, eta_msg, sizeof(eta_msg));
+		eta_to_human_short(eta, eta_msg);
 	}
 	if (flag_ignore_r_char) {
 		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c  %16s\n",
-- 
2.13.6

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
