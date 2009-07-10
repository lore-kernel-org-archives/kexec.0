Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MP9et-0001Av-Mu
	for kexec@lists.infradead.org; Fri, 10 Jul 2009 06:32:44 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n6A6WVP9014048 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Fri, 10 Jul 2009 15:32:31 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id D4E7D45DE4F
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2009 15:32:30 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B65C745DD6F
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2009 15:32:30 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8A75E1DB803A
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2009 15:32:30 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1A83F1DB8042
	for <kexec@lists.infradead.org>; Fri, 10 Jul 2009 15:32:30 +0900 (JST)
Message-ID: <4A56E069.5040907@jp.fujitsu.com>
Date: Fri, 10 Jul 2009 15:32:09 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump: Enable kdump if 2nd-kernel is loaded.
References: <4A55A4AE.3000206@mxs.nes.nec.co.jp>
In-Reply-To: <4A55A4AE.3000206@mxs.nes.nec.co.jp>
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
Cc: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

Hi Ohmichi-san,

Ken'ichi Ohmichi wrote:
> Hi,
> 
> This patch enables a kdump if 2nd-kernel is loaded.
> (The patch is based on linux-2.6.31-rc2.)
> 
> Now, a kdump is enabled if a kernel parameter "oops=panic" is specified and
> 2nd-kernel is loaded. I think that a kdump should be enabled regardless of
> "oops=panic" if 2nd-kernel is loaded, because a system administrator loads
> 2nd-kernel for enabling a kdump.

I think this description is slightly wrong because kdump will be invoked
from panic, regardless of the panic_on_oops.

Maybe:
 A kdump on oops is enabled if a kernel parameter "oops=panic" ...
         ~~~~~~~

> 
> * Reference
>   The discussion about this patch
>   http://lists.infradead.org/pipermail/kexec/2009-July/003417.html

I'd like to quote your comment:

>> I tried to test a kdump on linux-2.6.31-rc1 *without* a kernel parameter
>> "oops=panic" by `echo c > /proc/sysrq-trigger`, but a kdump did not work
>> because a kdump, which is occurred by `echo c > /proc/sysrq-trigger`, has
>> been changed to a NULL pointer error instead of calling crash_kexec()
>> since linux-2.6.31-rc1.

So the real problem is that kdump is not triggered by the NULL pointer oops
if !panic_on_oops, isn't it?

It seems that you should report this trouble of sysrq-c as a regression.

> 
> 
> Thanks
> Ken'ichi Ohmichi
> 
> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> Acked-by: Simon Horman <horms@verge.net.au>
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

I think kexec cannot crash if there is no image, right?

Then:

 if (kexec_crash_image)
 	return 1;
 return 0;

or

 return (kexec_crash_image) ? 1 : 0;

or

 since crash_kexec() is nop if !kexec_crash_image,
 replace all:
   if (kexec_should_crash(p))
   	crash_kexec(reg);
 at everywhere in kernel to a simple line:
   crash_kexec(reg);
 and remove kexec_should_crash() completely

would be better fix.


Thanks,
H.Seto


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
