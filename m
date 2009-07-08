Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MOTIk-0004Hg-DZ
	for kexec@lists.infradead.org; Wed, 08 Jul 2009 09:19:00 +0000
Date: Wed, 8 Jul 2009 19:18:52 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Enable kdump if 2nd-kernel is loaded.
Message-ID: <20090708091852.GF4040@verge.net.au>
References: <4A5422E3.1030600@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A5422E3.1030600@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec-ml <kexec@lists.infradead.org>

On Wed, Jul 08, 2009 at 01:38:59PM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi,
> 
> This patch enables a kdump if 2nd-kernel is loaded.
> (The patch is based on linux-2.6.31-rc2.)
> 
> Now, a kdump is enabled if a kernel parameter "oops=panic" is specified and
> 2nd-kernel is loaded. I think that a kdump should be enabled regardless of
> "oops=panic" if 2nd-kernel is loaded, because a system administrator loads
> 2nd-kernel for enabling a kdump.

I'm not sure that I like this change. To my mind, panic on oops
should only occur if specifically requested.

> Thanks
> Ken'ichi Ohmichi
> 
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> ---
> --- a/kernel/kexec.c	2009-07-08 12:30:26.000000000 +0900
> +++ b/kernel/kexec.c	2009-07-08 12:38:08.000000000 +0900
> @@ -57,6 +57,8 @@ struct resource crashk_res = {
>  
>  int kexec_should_crash(struct task_struct *p)
>  {
> +	if (kexec_crash_image)
> +		return 1;
>  	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
>  		return 1;
>  	return 0;
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
