Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGXaL-0006rL-QQ
	for kexec@lists.infradead.org; Wed, 09 Jul 2008 11:11:46 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id EBE6145C93
	for <kexec@lists.infradead.org>; Wed,  9 Jul 2008 13:11:44 +0200 (CEST)
Date: Wed, 9 Jul 2008 13:12:08 +0200
From: Bernhard Walle <bwalle@suse.de>(by way of Bernhard Walle
	<bwalle@suse.de>)
Message-ID: <20080709131208.32f90f73@halley.suse.de>
In-Reply-To: <20080709004138.GD13710@verge.net.au>
References: <20080707070621.GD788@verge.net.au>
	<1215441822-13820-3-git-send-email-bwalle@suse.de>
	<20080709004138.GD13710@verge.net.au>
Mime-Version: 1.0
Subject: Re: [PATCH 2/3] Remove redundancy between
	get_memory_ranges_proc_iomem() and get_memory_ranges_sysfs()
Resent-Message-ID: <20080709131225.66bf1535@halley.suse.de>
Resent-To: kexec@lists.infradead.org
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
To: Simon Horman <horms@verge.net.au>

Hi,

* Simon Horman [2008-07-09 10:41]:
>
> On Mon, Jul 07, 2008 at 04:43:41PM +0200, Bernhard Walle wrote:
> > With the previous patch, we have a duplication between that both functions
> > for following tasks:
> > 
> >  - don't report the interrupt table as RAM,
> >  - set the mem_min and mem_max limits for kdump.
> > 
> > This patch removes that redundancy into the function get_memory_ranges()
> > that calls both functions internally.
> 
> these patches seem fine to me, but I am still having minor troubles
> with missing defines. For the record, I am seeing the problems with
> gcc-3.4.5 + glibc-2.3.6. Yes, I know this is old, but it would
> be nice if this minor issue didn't break it.

Yes, of course, I just cannot reproduce it, even with current Debian
and gcc 3.4 ...

> 1. The snippet below looks good, but it needs to be included
>    in or berfore " [PATCH 1/3] Parse /sys/firmware/memmap".

Should be fixed now.

> > diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
> > index cdac6f3..2ad450d 100644
> > --- a/kexec/firmware_memmap.c
> > +++ b/kexec/firmware_memmap.c
> > @@ -31,6 +31,13 @@
> >  #include "firmware_memmap.h"
> >  #include "kexec.h"
> >  
> > +/*
> > + * If the system is too old for ULLONG_MAX, define it here.
> > + */
> > +#ifndef ULLONG_MAX
> > +#    define ULLONG_MAX (~0ULL)
> > +#endif
> > +
> >  /**
> >   * The full path to the sysfs interface that provides the memory map.
> >   */
> 
> 2. I did not realise this at the time that I sent my previous response,
>    but LLONG_MAX is also a problem. I believe that the following
>    code, based on your code above, fixes the problem.

Should also be fixed now.

> Just for good measure, I have also verified, using the same method, that
> your code gives 18446744073709551615 (=2^64-1), which matches the value
> internally provided by gcc-4.3.1 + glibc-2.7.

Thanks for your testing!


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
