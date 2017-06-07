Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIVFY-0000F0-Vt
 for kexec@lists.infradead.org; Wed, 07 Jun 2017 07:19:31 +0000
Date: Wed, 7 Jun 2017 03:19:05 -0400 (EDT)
From: Pingfan Liu <piliu@redhat.com>
Message-ID: <1962253196.19841266.1496819945660.JavaMail.zimbra@redhat.com>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EDE6B5@BPXM01GP.gisp.nec.co.jp>
References: <1496643479-28351-1-git-send-email-piliu@redhat.com>
 <1496643479-28351-2-git-send-email-piliu@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EDE6B5@BPXM01GP.gisp.nec.co.jp>
Subject: Re: [makedumpfile PATCH 2/2] print_info: show the remaining time of
 dump progress
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: kexec@lists.infradead.org





----- Original Message -----
> From: "Atsushi Kumagai" <ats-kumagai@wm.jp.nec.com>
> To: "Pingfan Liu" <piliu@redhat.com>
> Cc: kexec@lists.infradead.org
> Sent: Wednesday, June 7, 2017 3:06:07 PM
> Subject: RE: [makedumpfile PATCH 2/2] print_info: show the remaining time of dump progress
> 
> Hello Pingfan,
> 
> >If the dump progress is slow, it is better to show  an estimate of
> >remaining time of the progress to the user. The estimator simply uses
> >the average speed to work.
> 
> I like it, thanks for your work.
> I have a minor comment.
> 
> [snip]
> > void
> >-print_progress(const char *msg, unsigned long current, unsigned long end)
> >+print_progress(const char *msg, unsigned long current, unsigned long end,
> >struct timeval *start)
> > {
> > 	float progress;
> > 	time_t tm;
> > 	static time_t last_time = 0;
> > 	static unsigned int lapse = 0;
> > 	static const char *spinner = "/|\\-";
> >+	struct timeval delta;
> >+	double eta;
> >+	char eta_msg[32] = "eta: ";
> 
> I thinks this "eta: " should be set in eta_to_human_short(), because...
> 
> > 	if (current < end) {
> > 		tm = time(NULL);
> >@@ -368,13 +388,19 @@ print_progress(const char *msg, unsigned long current,
> >unsigned long end)
> > 	} else
> > 		progress = 100;
> >
> >+	if (start != NULL) {
> >+		calc_delta(start, &delta);
> >+		eta = delta.tv_sec + delta.tv_usec/1e6;
> >+		eta = (100 - progress) * eta/progress;
> >+		eta_to_human_short(eta, eta_msg+5);
> 
> the offset for "eta: " is here as a magic number.
> It has low maintainability since the number is independent of
> the actual string length.
> 
> 
Thanks for your review. I will modify according to your comment.


Regards,
Pingfan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
