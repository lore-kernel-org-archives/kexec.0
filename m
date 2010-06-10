Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OMpH6-0001qi-Lb
	for kexec@lists.infradead.org; Thu, 10 Jun 2010 21:26:57 +0000
Date: Thu, 10 Jun 2010 14:26:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix Oops in crash_shrink_memory
Message-Id: <20100610142622.497061e8.akpm@linux-foundation.org>
In-Reply-To: <1276064834.2622.7.camel@pavan.naregundi>
References: <1275895711.4365.18.camel@pavan.naregundi>
	<1275980857.2583.15.camel@pavan.naregundi>
	<20100608075959.GB7110@cr0.nay.redhat.com>
	<1275986405.5015.13.camel@pavan.naregundi>
	<20100608085440.GC7110@cr0.nay.redhat.com>
	<1275990107.5015.55.camel@pavan.naregundi>
	<20100609034452.GA28948@verge.net.au>
	<1276064834.2622.7.camel@pavan.naregundi>
Mime-Version: 1.0
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
To: Pavan Naregundi <pavan@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Simon Horman <horms@verge.net.au>, =?ISO-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, vgoyal@redhat.com

On Wed, 09 Jun 2010 11:57:14 +0530
Pavan Naregundi <pavan@linux.vnet.ibm.com> wrote:

> Resending the patch with fixed style issues.
> 
> Signed-off-by: Pavan Naregundi <pavan@linux.vnet.ibm.com>
> Reviewed-by: WANG Cong <xiyou.wangcong@gmail.com>
> --
> 
> 
> 
> 
> [fix-kexec.patch  text/x-patch (685B)]
> diff -Naur a/kernel/kexec.c b/kernel/kexec.c
> --- a/kernel/kexec.c	2010-06-08 21:17:21.850000033 +0530
> +++ b/kernel/kexec.c	2010-06-09 18:01:37.590007921 +0530
> @@ -1089,9 +1089,10 @@
>  
>  size_t crash_get_memory_size(void)
>  {
> -	size_t size;
> +	size_t size = 0;
>  	mutex_lock(&kexec_mutex);
> -	size = crashk_res.end - crashk_res.start + 1;
> +	if (crashk_res.end != crashk_res.start)
> +		size = crashk_res.end - crashk_res.start + 1;
>  	mutex_unlock(&kexec_mutex);
>  	return size;
>  }
> @@ -1134,7 +1135,7 @@
>  
>  	free_reserved_phys_range(end, crashk_res.end);
>  
> -	if (start == end)
> +	if ((start == end) && (crashk_res.parent != NULL))
>  		release_resource(&crashk_res);
>  	crashk_res.end = end - 1;

The patch doesn't have a changelog and I'd prefer not to have to crawl
through the email thread and write one myself.

Please resend, including a full description of the bug and of its fix.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
