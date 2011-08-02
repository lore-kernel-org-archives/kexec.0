Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QoAxZ-0000zw-Dl
	for kexec@lists.infradead.org; Tue, 02 Aug 2011 09:08:22 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p72989Mg007901
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 09:08:09 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p72988pl2334898
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 10:08:08 +0100
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p72988hg014868
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 10:08:08 +0100
Subject: Re: [patch v2 03/10] kdump: Add size to elfcorehdr kernel parameter
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110801203607.GI3805@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125807.853426542@linux.vnet.ibm.com>
	<20110801203607.GI3805@redhat.com>
Date: Tue, 02 Aug 2011 11:08:07 +0200
Message-ID: <1312276087.4881.24.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

#On Mon, 2011-08-01 at 16:36 -0400, Vivek Goyal wrote: 
> On Wed, Jul 27, 2011 at 02:55:07PM +0200, Michael Holzheu wrote:
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > Currently only the address of the pre-allocated ELF header is passed with
> > the elfcorehdr= kernel parameter. In order to reserve memory for the header
> > in the 2nd kernel also the size is required. To pass the size with this
> > patch the syntax of the kernel parameter is extended as follows:
> > 
> > elfcorehdr=[size[KMG]@]offset[KMG]
> > 
> > This change is backward compatible because elfcorehdr=size is still allowed.
> 
> Generally vmcore parses elfcorehdr to figure out the sizes. kexec-tools
> knows about it and relevant memory is excluded from second kernel's map
> with the help of memmap= command line option.
> 
> Can you please mention that this is only s390 specific requirement as
> there are no memmap= equivalent options and somehow dump tools wants
> to know how big the elf header size is?

I updated the description: 

Currently only the address of the pre-allocated ELF header is passed with
the elfcorehdr= kernel parameter. In order to reserve memory for the header
in the 2nd kernel also the size is required. Current kdump architecture
backends use different methods to do that, e.g. x86 uses the memmap= kernel
parameter. On s390 there is no easy way to transfer this information.
Therefore the elfcorehdr kernel parameter is extended to also pass the size.
This now can also be used as standard mechanism by all future kdump
architecture backends.

The syntax of the kernel parameter is extended as follows:

elfcorehdr=[size[KMG]@]offset[KMG]

This change is backward compatible because elfcorehdr=size is still allowed.

Ok?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
