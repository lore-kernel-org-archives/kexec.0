Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1emW2j-0006wm-Qb
 for kexec@lists.infradead.org; Fri, 16 Feb 2018 02:46:36 +0000
Received: from mailgate01.nec.co.jp ([114.179.233.122])
 by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w1G2kJRZ027718
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Fri, 16 Feb 2018 11:46:19 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
 by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w1G2kJgA028136
 for <kexec@lists.infradead.org>; Fri, 16 Feb 2018 11:46:19 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
 by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w1G2jx83025389
 for <kexec@lists.infradead.org>; Fri, 16 Feb 2018 11:46:19 +0900
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Fix a bug when multi-threads feature
 meets enospace
Date: Fri, 16 Feb 2018 02:45:33 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE0117C360@BPXM01GP.gisp.nec.co.jp>
References: <1517230479-8440-1-git-send-email-zhouwj.fi@gmail.com>
 <3d76898d-66a2-c733-73e0-6aa8e9854179@gmail.com>
In-Reply-To: <3d76898d-66a2-c733-73e0-6aa8e9854179@gmail.com>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: Masahiko Hayashi <mas-hayashi@tg.jp.nec.com>

Hi,

Atsushi Kumagai has retired, so other members will maintain makedumpfile.


Wenjian

Sorry for the late reply.
Your patch looks good to me.
I'll merge it into V1.6.4.

Thanks
tachibana


> -----Original Message-----
> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Zhou Wenjian
> Sent: Thursday, February 08, 2018 8:53 PM
> To: kexec@lists.infradead.org
> Cc: Kumagai Atsushi() <ats-kumagai@wm.jp.nec.com>; Suzuki Keiichirou() <kei-suzuki@xr.jp.nec.com>
> Subject: Re: [PATCH] makedumpfile: Fix a bug when multi-threads feature meets enospace
> 
> ping...
> 
> 
> On 01/29/2018 08:54 PM, Zhou Wenjian wrote:
> > Currently, when multi-threads feature meets enospace error,
> > the main thread will call pthread_join(). However, there is one
> > thread doing while{} and won't stop.
> >
> >                  pthread_mutex_lock(&info->page_data_mutex);
> >                  while (page_data_buf[index].used != FALSE) {
> >                          index = (index + 1) % info->num_buffers;
> >                  }
> >                  page_data_buf[index].used = TRUE;
> >                  pthread_mutex_unlock(&info->page_data_mutex);
> >
> > Then makedumpfile hangs.
> >
> > This patch add a cancel point in while{}.
> >
> > Signed-off-by: Zhou Wenjian <zhouwj.fi@gmail.com>
> > ---
> >   makedumpfile.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index ed138d3..f7ad50c 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -7731,11 +7731,13 @@ kdump_thread_function_cyclic(void *arg) {
> >   		buf_ready = FALSE;
> >
> >   		pthread_mutex_lock(&info->page_data_mutex);
> > +		pthread_cleanup_push(pthread_mutex_unlock, &info->page_data_mutex);
> >   		while (page_data_buf[index].used != FALSE) {
> > +			pthread_testcancel();
> >   			index = (index + 1) % info->num_buffers;
> >   		}
> >   		page_data_buf[index].used = TRUE;
> > -		pthread_mutex_unlock(&info->page_data_mutex);
> > +		pthread_cleanup_pop(1);
> >
> >   		while (buf_ready == FALSE) {
> >   			pthread_testcancel();
> 
> --
> Thanks
> Zhou
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
