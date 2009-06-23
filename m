Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MItxa-0002zs-To
	for kexec@lists.infradead.org; Tue, 23 Jun 2009 00:34:14 +0000
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n5N0XwGk019288 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Tue, 23 Jun 2009 09:33:59 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 124A945DE50
	for <kexec@lists.infradead.org>; Tue, 23 Jun 2009 09:33:58 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E3B1945DD71
	for <kexec@lists.infradead.org>; Tue, 23 Jun 2009 09:33:57 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CE4311DB803C
	for <kexec@lists.infradead.org>; Tue, 23 Jun 2009 09:33:57 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 83BB61DB803A
	for <kexec@lists.infradead.org>; Tue, 23 Jun 2009 09:33:57 +0900 (JST)
Message-ID: <4A4022EA.1020506@jp.fujitsu.com>
Date: Tue, 23 Jun 2009 09:33:46 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] ia64, kdump: Mask MCA/INIT on freezing cpus
References: <4A39E247.4030908@jp.fujitsu.com> <4A39E2CF.80901@jp.fujitsu.com>
	<20090622134557.GC7084@sgi.com>
In-Reply-To: <20090622134557.GC7084@sgi.com>
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
To: Robin Holt <holt@sgi.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

Robin Holt wrote:
>> To avoid this problem, This patch inserts ia64_set_psr_mc() before the
>> deadloop to mask MCA/INIT on cpus going to be frozen.  I confirmed that
>> weird log like above are disappeared after applying this patch.
> 
> Please do not do this.  Turning off MCA/INIT is just a horrible idea.
> When your code has a bug, the INIT of the cpu is the only tool we have
> to find out what it is doing short of putting special hardware onto the
> machine and trying to track it down.

This patch never mask MCA/INIT while the system is running normally.
The first place I inserted the masking is just after panic, and just after
INIT is asserted.  This patch doesn't prevent you from taking kdump or
stack trace on your machine.

Maybe I could not catch what you pointed.
One of the problems I'm targeting here is that there is no way to allow
INIT while kernel transition.  What are you expecting with INIT if it is
asserted on the beginning of the 2nd kernel?

And note that this patch 1 of 7 is necessary to run the INIT handler of
the 2nd kernel, which might be registered by the 2nd kernel.

> Without thinking about it, I have a gut feeling there must be some way
> to at least allow the MCA/INIT to make it through PROM and be delivered
> to the OS.  From there the OS should be able to sort out a way to handle
> kdump and MCAs received during a kdump.

Do you mean that the 2nd kernel should be able to handle MCA/INIT from its
boot up?  I guess the word PROM is nearly equal to PAL/SAL firmware, if so
then I don't think there are good generic interface/procedure could be
useful here.  Do you have any concrete idea?


Thanks,
H.Seto


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
