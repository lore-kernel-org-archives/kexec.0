Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1etRJ5-0002y4-H9
 for kexec@lists.infradead.org; Wed, 07 Mar 2018 05:08:05 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH makedumpfile] Fix array index out of bound exception
Date: Wed, 7 Mar 2018 05:07:06 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE011810CC@BPXM01GP.gisp.nec.co.jp>
References: <20180306100711.16786-1-lijiang@redhat.com>
 <88a4037f-e944-5031-7cb7-f08a3d350e93@redhat.com>
In-Reply-To: <88a4037f-e944-5031-7cb7-f08a3d350e93@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Masahiko Hayashi <mas-hayashi@tg.jp.nec.com>, piliu <piliu@redhat.com>

Hi Lianbo,

Thank you for your patch.
I understand the purpose of the patch.
I'll reply formally in 10 days or so.

Thanks
Tachibana

> -----Original Message-----
> From: lijiang [mailto:lijiang@redhat.com]
> Sent: Wednesday, March 07, 2018 10:25 AM
> To: kexec@lists.infradead.org
> Cc: Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>; Hayashi Masahiko() <mas-hayashi@tg.jp.nec.com>;
> piliu <piliu@redhat.com>
> Subject: Re: [PATCH makedumpfile] Fix array index out of bound exception
> 
> Also cc Masaki/Masahiko/piliu.
> 
> Thanks.
> 
> Lianbo
>  20180306 18:07, Lianbo Jiang :
> > A data overflow may lead to a reversal, which may turn a positive
> > number into a large negative number, in this case, the string's
> > length will exceed the array size(for example, eta: -2147483648s),
> > here the array size is defined 16 characters. So, it is nessasary
> > to consider some exceptions.
> >
> > Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> > ---
> >  print_info.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/print_info.c b/print_info.c
> > index e0e6a27..09e215a 100644
> > --- a/print_info.c
> > +++ b/print_info.c
> > @@ -16,6 +16,8 @@
> >  #include "print_info.h"
> >  #include <time.h>
> >  #include <string.h>
> > +#include <stdint.h>
> > +#include <inttypes.h>
> >
> >  #define PROGRESS_MAXLEN		"50"
> >
> > @@ -352,18 +354,21 @@ static void calc_delta(struct timeval *tv_start, struct timeval *delta)
> >  }
> >
> >  /* produce less than 12 bytes on msg */
> > -static int eta_to_human_short (int secs, char* msg)
> > +static int eta_to_human_short (int64_t secs, char* msg, int maxsize)
> >  {
> >  	strcpy(msg, "eta: ");
> >  	msg += strlen("eta: ");
> >  	if (secs < 100)
> > -		sprintf(msg, "%ds", secs);
> > +		snprintf(msg, maxsize, "%"PRId64"s", secs);
> >  	else if (secs < 100 * 60)
> > -		sprintf(msg, "%dm%ds", secs / 60, secs % 60);
> > +		snprintf(msg, maxsize, "%"PRId64"m""%"PRId64"s",
> > +			secs / 60, secs % 60);
> >  	else if (secs < 48 * 3600)
> > -		sprintf(msg, "%dh%dm", secs / 3600, (secs / 60) % 60);
> > +		snprintf(msg, maxsize, "%"PRId64"h""%"PRId64"m",
> > +			secs / 3600, (secs / 60) % 60);
> >  	else if (secs < 100 * 86400)
> > -		sprintf(msg, "%dd%dh", secs / 86400, (secs / 3600) % 24);
> > +		snprintf(msg, maxsize, "%"PRId64"d""%"PRId64"h",
> > +			secs / 86400, (secs / 3600) % 24);
> >  	else
> >  		sprintf(msg, ">2day");
> >  	return 0;
> > @@ -379,8 +384,8 @@ print_progress(const char *msg, unsigned long current, unsigned long end, struct
> >  	static unsigned int lapse = 0;
> >  	static const char *spinner = "/|\\-";
> >  	struct timeval delta;
> > -	double eta;
> > -	char eta_msg[16] = " ";
> > +	int64_t eta;
> > +	char eta_msg[32] = " ";
> >
> >  	if (current < end) {
> >  		tm = time(NULL);
> > @@ -395,7 +400,7 @@ print_progress(const char *msg, unsigned long current, unsigned long end, struct
> >  		calc_delta(start, &delta);
> >  		eta = delta.tv_sec + delta.tv_usec / 1e6;
> >  		eta = (100 - progress) * eta / progress;
> > -		eta_to_human_short(eta, eta_msg);
> > +		eta_to_human_short(eta, eta_msg, sizeof(eta_msg));
> >  	}
> >  	if (flag_ignore_r_char) {
> >  		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%5.1f %%] %c  %16s\n",
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
