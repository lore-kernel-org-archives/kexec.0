Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q2s2r-0004Y9-BO
	for kexec@lists.infradead.org; Thu, 24 Mar 2011 21:26:18 +0000
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: Re: [KDUMP] Ignore spurious IPI
Date: Thu, 24 Mar 2011 17:25:18 -0400
MIME-Version: 1.0
In-Reply-To: <smp-ipi-supurious-single-kdump@mdm.bga.com>
References: <C3CBE989BE8833indou.takao@jp.fujitsu.com>
	<smp-ipi-supurious-single-kdump@mdm.bga.com>
Message-Id: <C4CBEA69F94DFCindou.takao@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Milton Miller <miltonm@bga.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, 24 Mar 2011 08:20:32 -0600, Milton Miller wrote:

>On Wed, 23 Mar 2011 about 18:40:12 -0000, Takao Indoh wrote:
>> Hi all,
>> 
>> I found a problem that kdump(2nd kernel) sometimes hangs up. It seems
>> that system panic occurs as follows.
>..
>> (2)
>> A pending IPI from 1st kernel comes after unmasking interrupts at the
>> following point.
>> 
>> asmlinkage void __init start_kernel(void)
>> {
>> (snip)
>>     time_init();
>>     profile_init();
>>     if (!irqs_disabled())
>>             printk(KERN_CRIT "start_kernel(): bug: interrupts were "
>>                              "enabled early\n");
>>     early_boot_irqs_disabled = false;
>>     local_irq_enable(); <=======================================HERE
>> 
>> (3)
>> Kernel tries to handle the interrupt, but some data structures are not
>> initialized yet at this point. As a result, in the
>> generic_smp_call_function_single_interrupt(), NULL pointer dereference
>> occurs when list_replace_init() tries to access &q->list.next.
>> 
>[tried to match lapic timer interrupt]
>> Any comments?
>
>So this occurs because unlike device interrupts, this vector has the action
>defined statically and no per-interrupt disable on your architecture?

I think there is not per-interrupt disable for IPI.

>If so, just initialize the data structure earlier -- change
>init_call_single_data from early_initcall to an explict call after the
>per-cpu areas are initialized.

That makes sense. I'll do this, thanks.

Thanks,
Takao Indoh


>
>milton

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
