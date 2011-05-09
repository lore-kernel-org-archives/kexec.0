Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QJUHE-0004Cq-3n
	for kexec@lists.infradead.org; Mon, 09 May 2011 17:29:49 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p49HTiMo005600
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 03:29:44 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p49HTWtA1183836
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 03:29:32 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p49HTho6024299
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 03:29:44 +1000
Date: Mon, 9 May 2011 22:59:35 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC] Kdump and memory error handling
Message-ID: <20110509172935.GD1963@in.ibm.com>
References: <20110504193509.GA5342@in.ibm.com>
	<20110504203914.GC1737@one.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110504203914.GC1737@one.firstfloor.org>
Reply-To: prasad@linux.vnet.ibm.com
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Luck,
	Tony" <tony.luck@intel.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, May 04, 2011 at 10:39:14PM +0200, Andi Kleen wrote:
> > Any thoughts/suggestions?
> 
> My old attempts to solve this are
> 
> Don't dump on MCE:
> 
> http://git.kernel.org/?p=linux/kernel/git/ak/linux-mce-2.6.git;a=shortlog;h=refs/heads/mce/xpanic
> 

The problem we seen in avoiding a panic->crash_kexec->[coredump capture] is
that the user may not have a means to know the reason for crash, unless
the serial console is connected to capture and store the panic string.

Alternatively a 'slim' kdump (as described here:
https://lkml.org/lkml/2011/5/4/396) would not contain meaningless data from
the old memory, but inform the user about the cause of the crash. I'm
intending to post some patches with a quick implementation of it soon.

> Handle dumps of corrupted memory regresions:
> 
> http://git.kernel.org/?p=linux/kernel/git/ak/linux-mce-2.6.git;a=shortlog;h=refs/heads/mce/crashdump
> 

> IMHO these patches are still the right solutions for this.
> 

Like Vatsa had raised, the processor's behaviour upon reading (or any I/O
operation) the faulty memory location isn't clearly defined (to the
extent I read through System Programming Guide Part 1, Volume 3A,
Chapter 15). In such a scenario, disabling MCE for the kdump kernel (which can
potentially read the faulty memory) is making things hazy.

Thanks,
K.Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
