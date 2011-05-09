Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QJTio-00042m-2d
	for kexec@lists.infradead.org; Mon, 09 May 2011 16:54:15 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id p49GnCU3032709
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 02:49:12 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p49Gs5BC872620
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 02:54:05 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p49Gs5DO032485
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 02:54:05 +1000
Date: Mon, 9 May 2011 22:23:57 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
Message-ID: <20110509165357.GB1963@in.ibm.com>
References: <20110506165412.GB2719@in.ibm.com>
	<20110509123902.GA5975@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110509123902.GA5975@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Luck,
	Tony" <tony.luck@intel.com>

On Mon, May 09, 2011 at 08:39:02AM -0400, Vivek Goyal wrote:
> On Fri, May 06, 2011 at 10:24:12PM +0530, K.Prasad wrote:
> > Hi All,
> > 	I wanted to test the behaviour of kdump when panic is triggered
> > due to MCE on x86 and found that kdump is not captured.
> > 
> > While the kdump service is configured and running and non-MCE panics
> > (such as those triggered through to /proc/sysrq-trigger) successfully
> > capture a kdump, any fatal MCE error injected through the mce-inject
> > tool causes a reboot of the machine.
> > 
> > The code has been traced (using early_serial_putc()) to enter the kexec
> > path i.e. panic()->crash_kexec()->machine_kexec()->relocate_kernel()
> > but is untraceable further.
> > 
> > Kdump works fine when the same the similar test is carried out inside a
> > KVM guest.
> > 
> > Has anybody tested this before? Or have found kdump working when fatal
> > MCEs have actually occurred?
> 
> Prasad,
> 
> I have never tried taking dump in MCE situation. Does kdump work on this
> machine with normal panic()?
> 

Hi Vivek,
	kdump worked fine on this machine for non-MCE triggered panic
calls (the /proc/sysrq-trigger initiated crashes got the kdump fine).

> Use --debug and --serial option in kexec-tools to print some debug message
> and look for "I am in purgatory". This will tell you whether you hanged
> in first kernel or second kernel.
> 

There were no boot logs from the second kernel while the "Rebooting in X
seconds..." message had appeared before the system rebooted, suggesting
that the second kernel did not boot at all.

> Then put "outb()" messages in the kernel to trace what happened. 
> 

The outb logs showed that the system entered machine_kexec function (traceable
upto relocate_kernel) but then rebooted from inside the panic() function.

Thanks,
K.Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
