Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QJTs3-00046g-K7
	for kexec@lists.infradead.org; Mon, 09 May 2011 17:03:49 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p49H3in0025301
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 03:03:44 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p49H3fp6770112
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 03:03:41 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p49H3hcg005414
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 03:03:43 +1000
Date: Mon, 9 May 2011 22:33:36 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
Message-ID: <20110509170336.GC1963@in.ibm.com>
References: <20110506165412.GB2719@in.ibm.com>
	<20110509123902.GA5975@redhat.com> <4DC80662.9000703@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DC80662.9000703@canonical.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Bouchard Louis <louis.bouchard@canonical.com>
Cc: Andi Kleen <andi@firstfloor.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On Mon, May 09, 2011 at 05:21:06PM +0200, Bouchard Louis wrote:
> Hello,
> =

> Le 09/05/2011 14:39, Vivek Goyal a =E9crit :
> >
> > Prasad,
> >
> > I have never tried taking dump in MCE situation. Does kdump work on this
> > machine with normal panic()?
> >
> > Use --debug and --serial option in kexec-tools to print some debug mess=
age
> > and look for "I am in purgatory". This will tell you whether you hanged
> > in first kernel or second kernel.
> >
> > Then put "outb()" messages in the kernel to trace what happened. =

> >
> > Thanks
> > Vivek
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> I have seen numerous occurrences of MCE triggered kernel panics on both
> RHEL & SLES environment used on IA32 architecture. Both in contexts
> where kexec/kdump was being used.
>

That's interesting! Assuming that these are not software induced MCEs
but panic() calls invoked due to unrecoverable memory errors in a
physical machine, did you experience any situation where the kdump
kernel hung/rebooted due to a second MCE (triggered while reading the
faulty memory location belonging to the first kernel)?
 =

>  Matter of fact, MCE triggered panic are part of the reason that pushed
> me to work on crashdc : only one crash command is required to get the
> MCE trace out of the kernel ring buffer. This avoids transfering massive
> amount of vmcore file over the net.
> =


What is the data that is contained in the faulty memory location (whose
I/O triggered an MCE in the first place)? Basically we'd like to
understand what a 'read' operation on the corrupted memory location
would result in.

> crashdc does well on those, mcelog can be applied on the data gathered.
>

We're contemplating a solution on the similar lines (refer the
description of 'slim' kdump at https://lkml.org/lkml/2011/5/4/396) to
create a 'crash tool readable coredump containing a message that
indicates the cause of the crash as MCE (and not any data from the old
memory).

I'll take a look at the crashdc code and see if there are ideas that we
can borrow from there.

Thanks,
K.Prasad
 =


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
