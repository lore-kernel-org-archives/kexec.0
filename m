Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ejkm1-0005ND-2B
 for kexec@lists.infradead.org; Thu, 08 Feb 2018 11:53:54 +0000
Received: by mail-io0-x242.google.com with SMTP id m11so5469646iob.2
 for <kexec@lists.infradead.org>; Thu, 08 Feb 2018 03:53:42 -0800 (PST)
Subject: Re: [PATCH] makedumpfile: Fix a bug when multi-threads feature meets
 enospace
References: <1517230479-8440-1-git-send-email-zhouwj.fi@gmail.com>
From: Zhou Wenjian <zhouwj.fi@gmail.com>
Message-ID: <3d76898d-66a2-c733-73e0-6aa8e9854179@gmail.com>
Date: Thu, 8 Feb 2018 19:53:11 +0800
MIME-Version: 1.0
In-Reply-To: <1517230479-8440-1-git-send-email-zhouwj.fi@gmail.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: ats-kumagai@wm.jp.nec.com, Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>

ping...


On 01/29/2018 08:54 PM, Zhou Wenjian wrote:
> Currently, when multi-threads feature meets enospace error,
> the main thread will call pthread_join(). However, there is one
> thread doing while{} and won't stop.
>
>                  pthread_mutex_lock(&info->page_data_mutex);
>                  while (page_data_buf[index].used != FALSE) {
>                          index = (index + 1) % info->num_buffers;
>                  }
>                  page_data_buf[index].used = TRUE;
>                  pthread_mutex_unlock(&info->page_data_mutex);
>
> Then makedumpfile hangs.
>
> This patch add a cancel point in while{}.
>
> Signed-off-by: Zhou Wenjian <zhouwj.fi@gmail.com>
> ---
>   makedumpfile.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ed138d3..f7ad50c 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -7731,11 +7731,13 @@ kdump_thread_function_cyclic(void *arg) {
>   		buf_ready = FALSE;
>   
>   		pthread_mutex_lock(&info->page_data_mutex);
> +		pthread_cleanup_push(pthread_mutex_unlock, &info->page_data_mutex);
>   		while (page_data_buf[index].used != FALSE) {
> +			pthread_testcancel();
>   			index = (index + 1) % info->num_buffers;
>   		}
>   		page_data_buf[index].used = TRUE;
> -		pthread_mutex_unlock(&info->page_data_mutex);
> +		pthread_cleanup_pop(1);
>   
>   		while (buf_ready == FALSE) {
>   			pthread_testcancel();

-- 
Thanks
Zhou


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
