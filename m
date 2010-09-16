Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OwNea-0007Tu-AE
	for kexec@lists.infradead.org; Thu, 16 Sep 2010 23:14:09 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <5C4C569E8A4B9B42A84A977CF070A35B2C0979C90E@USINDEVS01.corp.hds.com>
Date: Thu, 16 Sep 2010 16:13:38 -0700
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2C0979C90E@USINDEVS01.corp.hds.com>
	(Seiji Aguchi's message of "Thu, 16 Sep 2010 16:16:14 -0400")
Message-ID: <m1wrql2sf1.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix kexec abort due to IPI from panic().
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
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Satoru Moriya <satoru.moriya@hds.com>, "simon.kagstrom@netinsight.net" <simon.kagstrom@netinsight.net>, "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

Seiji Aguchi <seiji.aguchi@hds.com> writes:

> Hi,
>
> I'm Seiji Aguchi.
> I work for Hitachi Data Systems.
> It's a first time to send a patch to lkml.
> Nice to meet you.
>  
> I found an issue in kexec.
> Please give me your comments and suggestions.
>  
> Kexec abort when two cpus panic at the same time.
> An example scenario:
> 1. Two cpus panic at the same time .
> 2. One cpu ,cpu0, get kexec_mutex in crash_kexec().
> 3. The other cpu ,cpu1, can't get kexec_mutex and return from crash_kexec().
> 4. Cpu0 runs kmsg_dump(KMSG_DUMP_KEXEC).
> 5. Cpu1 can't get dump_list_lock and return from kmsg_dump(KMSG_DUMP_PANIC).
> 6. Cpu1 runs smp_send_stop() in panic() and sends IPI to other cpus.
> 7. Cpu0 may receive IPI from cpu1 while running kmsg_dump(KMSG_DUMP_KEXEC),
>    crash_setup_regs(), or crash_save_vmcore().
>  
> We can solve this issue by disabling external interrupt while getting kexec_mutex 
> in crash_kexec().

Disabling interrupts is fine, I thought we did that already at some
point.  However that call to kmsg_dump(KMSG_DUMP_KEXEC) is a bug as it
introduces locks into a path that should not be taking locks.  Please
remove that broken kmsg_dump call as well.

Nothing in the crash_kexec path should even have the option of blocking.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
