Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QleBI-0003a6-HT
	for kexec@lists.infradead.org; Tue, 26 Jul 2011 09:44:05 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6Q9i2Zi004006
	for <kexec@lists.infradead.org>; Tue, 26 Jul 2011 09:44:02 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6Q9i2e32560006
	for <kexec@lists.infradead.org>; Tue, 26 Jul 2011 10:44:02 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6Q9i1Ma000859
	for <kexec@lists.infradead.org>; Tue, 26 Jul 2011 03:44:02 -0600
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110725160244.GB11009@redhat.com>
References: <20110718123140.GB31986@redhat.com>
	<1310997641.4427.10.camel@br98xy6r> <20110718141943.GE31986@redhat.com>
	<1311000253.4427.23.camel@br98xy6r> <20110718152532.GF31986@redhat.com>
	<1311012188.4427.58.camel@br98xy6r> <20110720192509.GD10079@redhat.com>
	<1311260298.6160.43.camel@br98xy6r> <20110721212257.GI12373@redhat.com>
	<1311327191.5772.51.camel@br98xy6r> <20110725160244.GB11009@redhat.com>
Date: Tue, 26 Jul 2011 11:44:01 +0200
Message-ID: <1311673441.4146.10.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org

On Mon, 2011-07-25 at 12:02 -0400, Vivek Goyal wrote:
> On Fri, Jul 22, 2011 at 11:33:11AM +0200, Michael Holzheu wrote:

[snip]

> > crash_kexec can be entered by e.g.:
> > * panic -> kdump shutdown action -> crash_kexec
> > * panic -> s390 dump shutdown action -> auto IPL dump tool -> s390_kdump_entry -> crash_kexec
> 
> So after panic() You will still jump to dump tools?

This is our current mechanism to create an automatic dump in case of
panic. I do not see a reason to change that now.

>  The only thing you
> need to do there is installing program check handler and could have been
> easily done in kernel too.
> 
> > * hard hang -> manual IPL dump tool -> s390_kdump_entry -> crash_kexec
> 
> This one makes sense as kernel is hard hung and dump tools need to
> force crash_kexec() now. It is more like x86 NMI handler.
> 
> > 
> > Handling for corrupted kdump:
> > 
> > New idea for returning to dump tools in case of program check:
> > We could force a program check for s390, if purgatory checksum
> > fails. Then we would automatically return to stand-alone dump
> > tools.
> > 
> > The flow would look like the following in this case:
> > 
> > IPL dump tool -> s390_kdump_entry -> crash_kexec +--> purgatory -+->[checksum ok]---> kdump
> >       ^                                          |               |
> >       |                                          |        [checksum fail]
> >       |                                          |               |
> >       |                                          |     [forced program check]
> >       +------[program check]---------------------+               |
> >       |                                                          |
> >       +----------------------------------------------------------+
> > 
> > Then of course also the kernel code would have to install a special
> > program check handler before calling purgatory.
> 
> If kernel code is going to install the program check handler before
> calling purgatory, then we don't need to jump to dump tools at all
> after panic()?

Independent from hard wait or panic, if dump tools have control, we want
to jump back to the dump tools code in order to be able to create
full-blown dump as backup method.

I think we now have a design, where almost no change of your kdump
framework is needed. I will resend the updated patch series.

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
