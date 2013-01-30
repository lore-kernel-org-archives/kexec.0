Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0Mqe-0005i7-2o
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 01:52:25 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <51087878.4010109@cn.fujitsu.com>
Date: Tue, 29 Jan 2013 17:52:03 -0800
In-Reply-To: <51087878.4010109@cn.fujitsu.com> (Zhang Yanfei's message of
 "Wed, 30 Jan 2013 09:33:44 +0800")
Message-ID: <87boc74ev0.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] KEXEC: Get rid of duplicate check for hole_end
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Zhang Yanfei <zhangyanfei@cn.fujitsu.com> writes:

> hole_end has been checked to make sure it is <= crash_res.end in the
> while condition check, so the if condition check is duplicate.

That test is definitely a duplicate.

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  kernel/kexec.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 5e4bd78..c2826fc 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -497,8 +497,6 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  
>  		if (hole_end > KEXEC_CRASH_CONTROL_MEMORY_LIMIT)
>  			break;
> -		if (hole_end > crashk_res.end)
> -			break;
>  		/* See if I overlap any of the segments */
>  		for (i = 0; i < image->nr_segments; i++) {
>  			unsigned long mstart, mend;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
