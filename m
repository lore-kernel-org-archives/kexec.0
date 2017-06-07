Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIV5v-0002N6-TN
 for kexec@lists.infradead.org; Wed, 07 Jun 2017 07:09:37 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [makedumpfile PATCH 2/2] print_info: show the remaining time of
 dump progress
Date: Wed, 7 Jun 2017 07:06:07 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EDE6B5@BPXM01GP.gisp.nec.co.jp>
References: <1496643479-28351-1-git-send-email-piliu@redhat.com>
 <1496643479-28351-2-git-send-email-piliu@redhat.com>
In-Reply-To: <1496643479-28351-2-git-send-email-piliu@redhat.com>
Content-Language: ja-JP
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
To: Pingfan Liu <piliu@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Pingfan,

>If the dump progress is slow, it is better to show  an estimate of
>remaining time of the progress to the user. The estimator simply uses
>the average speed to work.

I like it, thanks for your work.
I have a minor comment.

[snip]
> void
>-print_progress(const char *msg, unsigned long current, unsigned long end)
>+print_progress(const char *msg, unsigned long current, unsigned long end, struct timeval *start)
> {
> 	float progress;
> 	time_t tm;
> 	static time_t last_time = 0;
> 	static unsigned int lapse = 0;
> 	static const char *spinner = "/|\\-";
>+	struct timeval delta;
>+	double eta;
>+	char eta_msg[32] = "eta: ";

I thinks this "eta: " should be set in eta_to_human_short(), because...

> 	if (current < end) {
> 		tm = time(NULL);
>@@ -368,13 +388,19 @@ print_progress(const char *msg, unsigned long current, unsigned long end)
> 	} else
> 		progress = 100;
>
>+	if (start != NULL) {
>+		calc_delta(start, &delta);
>+		eta = delta.tv_sec + delta.tv_usec/1e6;
>+		eta = (100 - progress) * eta/progress;
>+		eta_to_human_short(eta, eta_msg+5);

the offset for "eta: " is here as a magic number.
It has low maintainability since the number is independent of
the actual string length.


Thanks,
Atsushi Kumagai

>+	}
> 	if (flag_ignore_r_char) {
>-		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c\n",
>-			     msg, progress, spinner[lapse % 4]);
>+		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c  %16s\n",
>+			     msg, progress, spinner[lapse % 4], eta_msg);
> 	} else {
> 		PROGRESS_MSG("\r");
>-		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c",
>-			     msg, progress, spinner[lapse % 4]);
>+		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c  %16s",
>+			     msg, progress, spinner[lapse % 4], eta_msg);
> 	}
> 	lapse++;
> }
>diff --git a/print_info.h b/print_info.h
>index 01e3706..1ce3593 100644
>--- a/print_info.h
>+++ b/print_info.h
>@@ -25,7 +25,8 @@ extern int flag_ignore_r_char;
>
> void show_version(void);
> void print_usage(void);
>-void print_progress(const char *msg, unsigned long current, unsigned long end);
>+void print_progress(const char *msg, unsigned long current, unsigned long end, struct timeval *start);
>+
> void print_execution_time(char *step_name, struct timeval *tv_start);
>
> /*
>--
>2.7.4
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
