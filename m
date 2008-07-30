Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KOBJ7-0005vq-T9
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 13:01:34 +0000
Date: Wed, 30 Jul 2008 09:01:31 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 3/3] kdump: use is_vmcore_usable() and
	vmcore_unusable() in reserve_elfcorehdr()
Message-ID: <20080730130131.GB16373@redhat.com>
References: <20080729081235.293361145@vergenet.net>
	<20080729081629.715923799@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080729081629.715923799@vergenet.net>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-ia64@vger.kernel.org, kexec@lists.infradead.org, lkml@vger.kernel.org

On Tue, Jul 29, 2008 at 06:12:38PM +1000, Simon Horman wrote:
> After recent changes setting elfcorehdr_addr to ELFCORE_ADDR_MAX
> will cause is_kdump_kernel() to return 0 when it should return 1.
> Instead use vmcore_unusable(), which has been added for this purpose.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Index: linux-2.6/arch/ia64/kernel/setup.c
> ===================================================================
> --- linux-2.6.orig/arch/ia64/kernel/setup.c	2008-07-29 17:27:43.000000000 +1000
> +++ linux-2.6/arch/ia64/kernel/setup.c	2008-07-29 17:50:50.000000000 +1000
> @@ -502,11 +502,11 @@ int __init reserve_elfcorehdr(unsigned l
>  	 * to work properly.
>  	 */
>  
> -	if (elfcorehdr_addr >= ELFCORE_ADDR_MAX)
> +	if (!is_vmcore_usable())
>  		return -EINVAL;
>  
>  	if ((length = vmcore_find_descriptor_size(elfcorehdr_addr)) == 0) {
> -		elfcorehdr_addr = ELFCORE_ADDR_MAX;
> +		vmcore_unusable();
>  		return -EINVAL;
>  	}
>  

Hi Simon,

I had a question. I am not very sure what reserve_elfcorehdr is doing
but doing something similar to reserving some memory area where
elfcoreheaders are.

I see that reserve_elfcorehdr is under CONFIG_PROC_VMCORE. Will it work
if CONFIG_PROC_VMCORE=n and somebody wants to use /dev/oldmem?
Or reserve_elfcorehdr should be under CONFIG_CRASH_DUMP?

Thanks
Vivek
  
> 
> -- 
> 
> -- 
> Horms

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
