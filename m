Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGKbT-0006AN-IB
 for kexec@lists.infradead.org; Fri, 04 Oct 2019 10:14:28 +0000
Date: Fri, 4 Oct 2019 12:14:24 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Fix conversion overflow when compiling on
 32-bit platforms
Message-ID: <20191004101423.jqpakrotimjjyp3w@verge.net.au>
References: <20191001151416.GA25667@ls3530.fritz.box>
 <20191003081406.5qmzlmlpwobydfok@verge.net.au>
 <2ac17dd1-99ef-3528-a05e-d51f8af01c95@gmx.de>
 <20191004093737.wftu7iat2gk3abq6@verge.net.au>
 <8157edc8-69cb-33b8-ae1c-7a0d80845c9d@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8157edc8-69cb-33b8-ae1c-7a0d80845c9d@gmx.de>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Helge Deller <deller@gmx.de>
Cc: Sven Schnelle <svens@stackframe.org>, kexec@lists.infradead.org

On Fri, Oct 04, 2019 at 11:51:05AM +0200, Helge Deller wrote:
> On 04.10.19 11:37, Simon Horman wrote:
> > On Thu, Oct 03, 2019 at 10:52:37AM +0200, Helge Deller wrote:
> > > On 03.10.19 10:14, Simon Horman wrote:
> > > > On Tue, Oct 01, 2019 at 05:14:16PM +0200, Helge Deller wrote:
> > > > > When compiling kexec-tools on a 32-bit platform, assigning an
> > > > > (unsigned long long) value to an (unsigned long) variable creates
> > > > > this warning:
> > > > > 
> > > > > elf_info.c: In function 'read_phys_offset_elf_kcore':
> > > > > elf_info.c:805:14: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295'
> > > > >     805 |  *phys_off = UINT64_MAX;
> > > > >         |              ^~~~~~~~~~
> > > > > 
> > > > > Fix it by casting UINT64_MAX to (unsigned long) before storing it to *phys_off.
> > > > > 
> > > > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > > > 
> > > > > diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
> > > > > index 2bce5cb..4d16983 100644
> > > > > --- a/util_lib/elf_info.c
> > > > > +++ b/util_lib/elf_info.c
> > > > > @@ -802,7 +802,7 @@ int read_phys_offset_elf_kcore(int fd, unsigned long *phys_off)
> > > > >    {
> > > > >    	int ret;
> > > > > 
> > > > > -	*phys_off = UINT64_MAX;
> > > > > +	*phys_off = (unsigned long) UINT64_MAX;
> > > > 
> > > > This seems to mask the problem that UINT64_MAX is not the right
> > > > initialiser for unsigned long values on 32-bit platforms.
> > > > Could we consider using UINT64_MAX from limits.h instead?
> > > 
> > > UINT64 means it is a 64bit value, while "unsigned long" is either 32-bit,
> > > 64bit (or maybe in the future even 128bit?).
> > > Even assigning UINT32_MAX on a 32bit platform might be wrong.
> > > So I think the cast above is probably the best solution.
> > 
> > Sorry, I made a typo above.
> > What I meant is, can we consider using ULONG_MAX.
> 
> Yes, that's probably ok.

Thanks. Will you send an updated patch?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
