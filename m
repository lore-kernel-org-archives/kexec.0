Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MOmYi-0007d1-Jd
	for kexec@lists.infradead.org; Thu, 09 Jul 2009 05:52:47 +0000
Date: Thu, 9 Jul 2009 15:52:37 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Enable kdump if 2nd-kernel is loaded.
Message-ID: <20090709055234.GA7282@verge.net.au>
References: <4A5422E3.1030600@mxs.nes.nec.co.jp>
	<20090708091852.GF4040@verge.net.au>
	<4A553D27.8050005@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A553D27.8050005@mxs.nes.nec.co.jp>
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

On Thu, Jul 09, 2009 at 09:43:19AM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi Simon,
> 
> Thank you for the comment.
> 
> Simon Horman wrote:
> > On Wed, Jul 08, 2009 at 01:38:59PM +0900, Ken'ichi Ohmichi wrote:
> >> Hi,
> >>
> >> This patch enables a kdump if 2nd-kernel is loaded.
> >> (The patch is based on linux-2.6.31-rc2.)
> >>
> >> Now, a kdump is enabled if a kernel parameter "oops=panic" is specified and
> >> 2nd-kernel is loaded. I think that a kdump should be enabled regardless of
> >> "oops=panic" if 2nd-kernel is loaded, because a system administrator loads
> >> 2nd-kernel for enabling a kdump.
> > 
> > I'm not sure that I like this change. To my mind, panic on oops
> > should only occur if specifically requested.
> 
> My patch does not make panic_on_oops effective when 2nd-kernel is loaded,
> and it makes a kdump effective.
> 
> kexec_should_crash() is called only by oops_end() for checking whether to
> call crash_kexec(). crash_kexec() is not panic, and I feel it is better
> that crash_kexec() is called when 2nd-kernel is loaded.
> 
> 
> I tried to test a kdump on linux-2.6.31-rc1 *without* a kernel parameter
> "oops=panic" by `echo c > /proc/sysrq-trigger`, but a kdump did not work
> because a kdump, which is occurred by `echo c > /proc/sysrq-trigger`, has
> been changed to a NULL pointer error instead of calling crash_kexec()
> since linux-2.6.31-rc1. Then I tried to boot linux-2.6.31-rc1 *with* a
> kernel parameter "oops=panic", the kernel got a panic while kernel booting
> due to a problem other than a kdump. 
> So I think a kdump should be enabled when 2nd-kernel is loaded.

Hi,

thanks for the more detailed explanation. I've reconsidered my position
and actually I think that I quite like your idea - it does indeed make
sense for kdump to occur if a kdump kernel has been loaded.

Acked-by: Simon Horman <horms@verge.net.au>

> Thanks
> Ken'ichi Ohmichi
> 
> >> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> >> ---
> >> --- a/kernel/kexec.c	2009-07-08 12:30:26.000000000 +0900
> >> +++ b/kernel/kexec.c	2009-07-08 12:38:08.000000000 +0900
> >> @@ -57,6 +57,8 @@ struct resource crashk_res = {
> >>  
> >>  int kexec_should_crash(struct task_struct *p)
> >>  {
> >> +	if (kexec_crash_image)
> >> +		return 1;
> >>  	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
> >>  		return 1;
> >>  	return 0;
> >>
> >> _______________________________________________
> >> kexec mailing list
> >> kexec@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
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
