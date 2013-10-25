Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZWU6-0000rF-Jm
 for kexec@lists.infradead.org; Fri, 25 Oct 2013 01:46:43 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C3D913EE0C1
 for <kexec@lists.infradead.org>; Fri, 25 Oct 2013 10:46:16 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B666C45DE5A
 for <kexec@lists.infradead.org>; Fri, 25 Oct 2013 10:46:16 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id A13FC45DE55
 for <kexec@lists.infradead.org>; Fri, 25 Oct 2013 10:46:16 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 93E461DB804A
 for <kexec@lists.infradead.org>; Fri, 25 Oct 2013 10:46:16 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 551921DB803F
 for <kexec@lists.infradead.org>; Fri, 25 Oct 2013 10:46:16 +0900 (JST)
Message-ID: <5269CD32.200@jp.fujitsu.com>
Date: Fri, 25 Oct 2013 10:45:22 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH] makedumpfile: print spinner in progress information
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On system with huge memory, percentage in progress information is
updated at very slow interval, because 1 percent on 1 TiB memory is
about 10 GiB, which looks like as if system has freezed. Then,
confused users might get tempted to push a reset button to recover the
system. We want to avoid such situation as much as possible.

To address the issue, this patch adds spinner that rotates in the
order of /, |, \ and - next to the progress indicator in percentage,
which helps users to get aware that system is still active and crash
dump process is still in progress now.

This code is borrowed from diskdump code.

The example is like this:

Copying data                       : [  0 %] /
Copying data                       : [  8 %] |
Copying data                       : [ 11 %] \
Copying data                       : [ 14 %] -
Copying data                       : [ 16 %] /
...
Copying data                       : [ 99 %] /
Copying data                       : [100 %] |

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 print_info.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/print_info.c b/print_info.c
index 3527970..879fa4b 100644
--- a/print_info.c
+++ b/print_info.c
@@ -286,6 +286,8 @@ print_progress(const char *msg, unsigned long current, unsigned long end)
 	int progress;
 	time_t tm;
 	static time_t last_time = 0;
+	static unsigned int lapse = 0;
+	const char *spinner = "/|\\-";
 
 	if (current < end) {
 		tm = time(NULL);
@@ -297,13 +299,14 @@ print_progress(const char *msg, unsigned long current, unsigned long end)
 		progress = 100;
 
 	if (flag_ignore_r_char) {
-		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%]\n",
-			     msg, progress);
+		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] %c\n",
+			     msg, progress, spinner[lapse & 3]);
 	} else {
 		PROGRESS_MSG("\r");
-		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ",
-			     msg, progress);
+		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] %c",
+			     msg, progress, spinner[lapse & 3]);
 	}
+	lapse++;
 }
 
 void
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
