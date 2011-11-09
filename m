Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RO9wm-0001hg-NX
 for kexec@lists.infradead.org; Wed, 09 Nov 2011 15:20:17 +0000
Date: Wed, 9 Nov 2011 10:20:13 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump: kill redundant code
Message-ID: <20111109152012.GA12537@redhat.com>
References: <20111109070452.GA25768@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111109070452.GA25768@darkstar.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On Wed, Nov 09, 2011 at 03:04:52PM +0800, Dave Young wrote:
> in while loop below, hole_end > crashk_res.end is impossible:
> while (hole_end <= crashk_res.end) {
> 	[snip]
> }
> Killing the check code here
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Makes sense.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  kernel/kexec.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- linux-2.6.orig/kernel/kexec.c	2011-11-01 13:06:20.000000000 +0800
> +++ linux-2.6/kernel/kexec.c	2011-11-09 14:57:17.487022644 +0800
> @@ -500,8 +500,6 @@ static struct page *kimage_alloc_crash_c
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
