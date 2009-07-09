Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MOhp6-0001zD-5w
	for kexec@lists.infradead.org; Thu, 09 Jul 2009 00:49:34 +0000
Message-ID: <4A553D27.8050005@mxs.nes.nec.co.jp>
Date: Thu, 09 Jul 2009 09:43:19 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Enable kdump if 2nd-kernel is loaded.
References: <4A5422E3.1030600@mxs.nes.nec.co.jp>
	<20090708091852.GF4040@verge.net.au>
In-Reply-To: <20090708091852.GF4040@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec-ml <kexec@lists.infradead.org>


Hi Simon,

Thank you for the comment.

Simon Horman wrote:
> On Wed, Jul 08, 2009 at 01:38:59PM +0900, Ken'ichi Ohmichi wrote:
>> Hi,
>>
>> This patch enables a kdump if 2nd-kernel is loaded.
>> (The patch is based on linux-2.6.31-rc2.)
>>
>> Now, a kdump is enabled if a kernel parameter "oops=panic" is specified and
>> 2nd-kernel is loaded. I think that a kdump should be enabled regardless of
>> "oops=panic" if 2nd-kernel is loaded, because a system administrator loads
>> 2nd-kernel for enabling a kdump.
> 
> I'm not sure that I like this change. To my mind, panic on oops
> should only occur if specifically requested.

My patch does not make panic_on_oops effective when 2nd-kernel is loaded,
and it makes a kdump effective.

kexec_should_crash() is called only by oops_end() for checking whether to
call crash_kexec(). crash_kexec() is not panic, and I feel it is better
that crash_kexec() is called when 2nd-kernel is loaded.


I tried to test a kdump on linux-2.6.31-rc1 *without* a kernel parameter
"oops=panic" by `echo c > /proc/sysrq-trigger`, but a kdump did not work
because a kdump, which is occurred by `echo c > /proc/sysrq-trigger`, has
been changed to a NULL pointer error instead of calling crash_kexec()
since linux-2.6.31-rc1. Then I tried to boot linux-2.6.31-rc1 *with* a
kernel parameter "oops=panic", the kernel got a panic while kernel booting
due to a problem other than a kdump. 
So I think a kdump should be enabled when 2nd-kernel is loaded.


Thanks
Ken'ichi Ohmichi

>> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
>> ---
>> --- a/kernel/kexec.c	2009-07-08 12:30:26.000000000 +0900
>> +++ b/kernel/kexec.c	2009-07-08 12:38:08.000000000 +0900
>> @@ -57,6 +57,8 @@ struct resource crashk_res = {
>>  
>>  int kexec_should_crash(struct task_struct *p)
>>  {
>> +	if (kexec_crash_image)
>> +		return 1;
>>  	if (in_interrupt() || !p->pid || is_global_init(p) || panic_on_oops)
>>  		return 1;
>>  	return 0;
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
