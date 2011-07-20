Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QjT57-00080v-OI
	for kexec@lists.infradead.org; Wed, 20 Jul 2011 09:28:42 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p6K9SbX9004927
	for <kexec@lists.infradead.org>; Wed, 20 Jul 2011 09:28:37 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p6K9SbYu2150520
	for <kexec@lists.infradead.org>; Wed, 20 Jul 2011 10:28:37 +0100
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain
	[127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p6K9SarL031294
	for <kexec@lists.infradead.org>; Wed, 20 Jul 2011 03:28:36 -0600
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110719150423.GA7001@redhat.com>
References: <20110714180528.GF6672@redhat.com>
	<1310739717.10789.31.camel@br98xy6r> <20110715143820.GG3428@redhat.com>
	<1310744603.10789.79.camel@br98xy6r>
	<20110718123140.GB31986@redhat.com>
	<1310997641.4427.10.camel@br98xy6r> <20110718141943.GE31986@redhat.com>
	<1311000253.4427.23.camel@br98xy6r> <20110718152532.GF31986@redhat.com>
	<1311012188.4427.58.camel@br98xy6r> <20110719150423.GA7001@redhat.com>
Date: Wed, 20 Jul 2011 11:28:35 +0200
Message-ID: <1311154115.3829.17.camel@br98xy6r>
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

Hello Vivek,

On Tue, 2011-07-19 at 11:04 -0400, Vivek Goyal wrote:
> On Mon, Jul 18, 2011 at 08:03:08PM +0200, Michael Holzheu wrote:

[snip]
 
> > To allow the stand-alone dump tools as kdump triggers, we then only
> > would have to provide an s390 specific way to tell the stand-alone dump
> > tools:
> > 1. Entry point address into purgatory
> > 2. Address, size and checksum for purgatory
> > 
> > We could store address, size and checksum of the purgatory to a fixed
> > offset in the kdump kernel image. This can be done in the kexec tools
> > code.
> 
> I think this will require kernel changes also? Otherwise how would you
> store variables in kernel address space.

We can store purgatory address, size and checksum in the kernel image
from kexec tools user space as we do it currently for the initrd.

[snip]

> > What you as kdump framework maintainer would have to accept with this
> > solution is that it is allowed now to start kdump directly via purgatory
> > without using code from the old kernel (e.g. crash_kexec). This has as
> > implication that all things that the old kernel has to initialize for
> > kdump has to be done before the system crashes. Currently this is only
> > the initialization of vmcoreinfo.
> 
> when would you save vmcoreinfo? I guess I shall have to look at the
> patches.

patch #4: We have to save vmcoreinfo at startup time of the production
kernel.

Perhaps it would be best to send you a new patch series with our latest
proposal.

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
