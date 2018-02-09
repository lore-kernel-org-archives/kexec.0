Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ek6ut-0000u1-Km
 for kexec@lists.infradead.org; Fri, 09 Feb 2018 11:32:33 +0000
From: Masahiko Hayashi <mas-hayashi@tg.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Fix a bug when multi-threads feature
 meets enospace
Date: Fri, 9 Feb 2018 11:31:44 +0000
Message-ID: <7670A259544D1E42B1C54D20021FB1A669DF7D6C@BPXM05GP.gisp.nec.co.jp>
References: <1517230479-8440-1-git-send-email-zhouwj.fi@gmail.com>
 <3d76898d-66a2-c733-73e0-6aa8e9854179@gmail.com>
 <61D4E5D821F1674CB87C99F080A210BE0117AC32@BPXM01GP.gisp.nec.co.jp> 
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhou Wenjian <zhouwj.fi@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi  Zhou-san

I will forward Tachibana's mail.

Thank you

>-----Original Message-----
>From: Hayashi Masahiko(林 正彦)
>Sent: Friday, February 09, 2018 8:24 PM
>To: Zhou Wenjian <zhouwj.fi@gmail.com>
>Cc: kexec@lists.infradead.org
>Subject: FW: [PATCH] makedumpfile: Fix a bug when multi-threads feature meets enospace
>
>>-----Original Message-----
>>From: Tachibana Masaki(橘 正樹)
>>Sent: Friday, February 09, 2018 8:05 PM
>>To: Zhou Wenjian <zhouwj.fi@gmail.com>
>>Cc: kexec@lists.infradead.org; Hayashi Masahiko(林 正彦) <mas-hayashi@tg.jp.nec.com>
>>Subject: RE: [PATCH] makedumpfile: Fix a bug when multi-threads feature meets enospace
>>
>>Hi Zhou,
>>
>>Sorry for the late reply.
>>Makedumpfile team are busy now for another development.
>>I'll reply in about a week.
>>
>>Thanks
>>tachibana
>>
>>> -----Original Message-----
>>> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Zhou Wenjian
>>> Sent: Thursday, February 08, 2018 8:53 PM
>>> To: kexec@lists.infradead.org
>>> Cc: Kumagai Atsushi <ats-kumagai@wm.jp.nec.com>; Suzuki Keiichirou <kei-suzuki@xr.jp.nec.com>
>>> Subject: Re: [PATCH] makedumpfile: Fix a bug when multi-threads feature meets enospace
>>>
>>> ping...
>>>
>>>
>>> On 01/29/2018 08:54 PM, Zhou Wenjian wrote:
>>> > Currently, when multi-threads feature meets enospace error,
>>> > the main thread will call pthread_join(). However, there is one
>>> > thread doing while{} and won't stop.
>>> >
>>> >                  pthread_mutex_lock(&info->page_data_mutex);
>>> >                  while (page_data_buf[index].used != FALSE) {
>>> >                          index = (index + 1) % info->num_buffers;
>>> >                  }
>>> >                  page_data_buf[index].used = TRUE;
>>> >                  pthread_mutex_unlock(&info->page_data_mutex);
>>> >
>>> > Then makedumpfile hangs.
>>> >
>>> > This patch add a cancel point in while{}.
>>> >
>>> > Signed-off-by: Zhou Wenjian <zhouwj.fi@gmail.com>
>>> > ---
>>> >   makedumpfile.c | 4 +++-
>>> >   1 file changed, 3 insertions(+), 1 deletion(-)
>>> >
>>> > diff --git a/makedumpfile.c b/makedumpfile.c
>>> > index ed138d3..f7ad50c 100644
>>> > --- a/makedumpfile.c
>>> > +++ b/makedumpfile.c
>>> > @@ -7731,11 +7731,13 @@ kdump_thread_function_cyclic(void *arg) {
>>> >   		buf_ready = FALSE;
>>> >
>>> >   		pthread_mutex_lock(&info->page_data_mutex);
>>> > +		pthread_cleanup_push(pthread_mutex_unlock, &info->page_data_mutex);
>>> >   		while (page_data_buf[index].used != FALSE) {
>>> > +			pthread_testcancel();
>>> >   			index = (index + 1) % info->num_buffers;
>>> >   		}
>>> >   		page_data_buf[index].used = TRUE;
>>> > -		pthread_mutex_unlock(&info->page_data_mutex);
>>> > +		pthread_cleanup_pop(1);
>>> >
>>> >   		while (buf_ready == FALSE) {
>>> >   			pthread_testcancel();
>>>
>>> --
>>> Thanks
>>> Zhou
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
