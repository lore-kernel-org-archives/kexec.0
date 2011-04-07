Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q7pSS-0007bK-Rb
	for kexec@lists.infradead.org; Thu, 07 Apr 2011 13:41:13 +0000
Date: Thu, 7 Apr 2011 09:40:46 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] generic-ipi: Initialize call_single_queue before
	enabling interrupt
Message-ID: <20110407134046.GA27778@redhat.com>
References: <D6CBEE2F420741indou.takao@jp.fujitsu.com>
	<20110406204742.GH18777@redhat.com>
	<EBCBF4AC9FDAD4indou.takao@jp.fujitsu.com>
	<ECCBF4AD4D39CDindou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ECCBF4AD4D39CDindou.takao@jp.fujitsu.com>
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>, WANG Cong <xiyou.wangcong@gmail.com>, Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wed, Apr 06, 2011 at 06:52:27PM -0400, Takao Indoh wrote:
> On Wed, 06 Apr 2011 18:47:36 -0400, Takao Indoh wrote:
> 
> >On Wed, 6 Apr 2011 16:47:42 -0400, Vivek Goyal wrote:
> >
> >>On Tue, Mar 29, 2011 at 12:35:04PM -0400, Takao Indoh wrote:
> >>> Hi all,
> >>> 
> >>> This patch renames init_call_single_data() to call_function_init() and
> >>> calls it in start_kernel() so that call_single_queue can be initialized
> >>> before enabling interrupt.
> >>> 
> >>> There is a problem that kdump(2nd kernel) sometimes hangs up due to
> >>> pending IPI from 1st kernel. Kernel panic occurs because IPI comes
> >>> before call_single_queue is initialized. The details are as follows.
> >>> (1) 2nd kernel boot up
> >>> (2) A pending IPI from 1st kernel comes when irqs are first enabled
> >>>     in start_kernel().
> >>> (3) Kernel tries to handle the interrupt, but call_single_queue is not
> >>>     initialized yet at this point. As a result, in the
> >>>     generic_smp_call_function_single_interrupt(), NULL pointer
> >>>     dereference occurs when list_replace_init() tries to access
> >>>     &q->list.next.
> >>> Therefore this patch changes the name of init_call_single_data() to
> >>> call_function_init() and calls it before local_irq_enable() in
> >>> start_kernel().
> >>> 
> >>> v2:
> >>> - Rename init_call_single_data() to call_function_init() and calls it in
> >>>   start_kernel()
> >>> - Change insert position in start_kernel().
> >>> - Adjust for CONFIG_SMP/CONFIG_USE_GENERIC_SMP_HELPERS options
> >>> - Rebased to Linus's latest tree
> >>> 
> >>> v1:
> >>> https://lkml.org/lkml/2011/3/25/317
> >>> - Divide init_call_single_data() into two functions,
> >>>    o init_call_single_data: initialize call_single_queue
> >>>    o init_hotplug_cfd: initialize hotplug_cfd_notifier
> >>>   And call init_call_single_data before local_irq_enable() in
> >>>   start_kernel().
> >>> 
> >>> v0:
> >>> https://lkml.org/lkml/2011/3/23/417
> >>> - In generic_smp_call_function_single_interrupt(), check if
> >>>   call_single_queue was initialized or not, and just return if not
> >>>   initialized.
> >>> 
> >>> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>

[..]
> >So, list_empty(list)? is always false, if I am not missing something.
> 
> No, list_empty(list)? is always *true*.
> 

ok, I got it. So list_replace_init() is fine even if q->list is empty. So
when a pending IPI from previous kernel comes, q->list will be empty
and we will simply do nothing. Sounds reaosnable to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
