Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6S0D-0001ai-9h
	for kexec@lists.infradead.org; Wed, 11 Jun 2008 15:12:45 +0000
Date: Wed, 11 Jun 2008 11:12:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Implement support for mem command line parameter
Message-ID: <20080611151242.GC6450@redhat.com>
References: <1212449384-22819-1-git-send-email-bwalle@suse.de>
	<20080603030440.GC32687@redhat.com>
	<20080609235729.43e38e2f@kopernikus.site>
	<20080610030051.GB25390@redhat.com>
	<20080610213158.44e2139c@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080610213158.44e2139c@kopernikus.site>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Tue, Jun 10, 2008 at 09:31:58PM +0200, Bernhard Walle wrote:
> * Vivek Goyal <vgoyal@redhat.com> [2008-06-09 23:00]:
> >
> > > Right. I just checked with 2.6.22.5 (openSUSE 10.3 kernel), and
> > > 
> > >   - i386: /proc/iomem contains full memory
> > >   - x86_64: /proc/iomem contains truncated memory
> > > 
> > > After the x86 merge, x86_64 now has the behaviour of i386.
> > >   
> > 
> > Cool. Now atleast behavior across x86 and x86_64 is same.
> 
> After studying the code, well, that was wrong. I tested again:
> 
>  - i386: /proc/iomem contains truncated memory
>  - x86_64: /proc/iomem contains full memroy
> 
> And after the merge, it stays the same, i.e. /proc/iomem in i386 is
> truncated.

:-(

> 
> Sorry for the confusion. :-|
> 
> The question is: Is that "accidentally" or by design. The file
> Documentation/kernel-parameters.txt:
> 
>         [X86-32] Use together with memmap= to avoid physical
>         address space collisions. Without memmap= PCI devices
>         could be placed at addresses belonging to unused RAM.
> 
> implies that it's "by design".
> 

IIUC, does that mean if a system has got 3G of RAM then during normal
boot PCI devices will be mapped at physical addresses higher than 3G.
But if I boo the system with mem=2G, then there are changes that PCI
devices get mapped at physical address between 2G and 3G? 

If yes, what's the issue with that? Anyway kernel will never see RAM
beyond 2G.

So if we make these two arch consistent, that is /proc/iomem does
not see truncated memory even user passes mem= option, hopefully
it works for everybody.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
