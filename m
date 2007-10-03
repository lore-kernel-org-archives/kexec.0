Return-path: <kexec-bounces@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IcvhJ-0006hj-6D
	for kexec@lists.infradead.org; Wed, 03 Oct 2007 05:19:01 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l934FNq1019766
	for <kexec@lists.infradead.org>; Wed, 3 Oct 2007 00:15:23 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l934FNOG470460
	for <kexec@lists.infradead.org>; Tue, 2 Oct 2007 22:15:23 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l934FNR0008919
	for <kexec@lists.infradead.org>; Tue, 2 Oct 2007 22:15:23 -0600
Date: Wed, 3 Oct 2007 09:45:45 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: kdump info request
Message-ID: <20071003041545.GA5343@in.ibm.com>
References: <9738BCBE884FDB42801FAD8A7769C2657E2A01@NAMAIL1.ad.lsil.com>
	<20070919042840.GB7068@in.ibm.com>
	<9738BCBE884FDB42801FAD8A7769C26501B2C4DA@NAMAIL1.ad.lsil.com>
	<20070921041506.GB6156@in.ibm.com>
	<9738BCBE884FDB42801FAD8A7769C26501B2C8D3@NAMAIL1.ad.lsil.com>
	<20070922113553.6898978d.rdunlap@xenotime.net>
	<9738BCBE884FDB42801FAD8A7769C26501B7F450@NAMAIL1.ad.lsil.com>
	<20071001081327.d325959d.rdunlap@xenotime.net>
	<9738BCBE884FDB42801FAD8A7769C26501B7F4A7@NAMAIL1.ad.lsil.com>
	<20071001093145.7205773d.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071001093145.7205773d.rdunlap@xenotime.net>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces@lists.infradead.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: "Mukker, Atul" <Atul.Mukker@lsi.com>, balbir@in.ibm.com, Kexec Mailing List <kexec@lists.infradead.org>, linux kernel mailing list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "Moore, Eric" <Eric.Moore@lsi.com>

On Mon, Oct 01, 2007 at 09:31:45AM -0700, Randy Dunlap wrote:
> On Mon, 1 Oct 2007 09:35:04 -0600 Mukker, Atul wrote:
> 
> > Thanks for the information and the effort.
> > 
> > We need to support all currently shipping products with kdump support
> > available (read Red Hat and SuSE) so sooner it makes into to the
> > upstream kernel the better it is.
> > 
> > So, today there is no alternative way to find out if the driver is being
> > loaded under kdump restrictive environment?
> > 
> > Thanks
> > -Atul
> 
> I'm not the right person to answer that, but going forward, it would
> be nice to have that information and it would be good to do correctly.
> 
> I think that scanning <saved_command_line> is not actually the good/right
> way to do this.  It should just be a flag somewhere, and the flag should
> be available in all (future) kernels (and likely easily backportable
> as well, if that matters), meaning those built without kdump support.
> 
> But it's still up to the kexec developers...
> 
> 

Hi Atul/Randy,

[CCing to LKML]

Thinking more about it, looks like scanning command line is not a very good
idea.

I think we should instead look for if total available RAM in the system and
then let driver make a decision about how much memory to allocate. Pavel
already suggested it on LKML and I like the idea.

This is more generic and can be applied to kdump, kexec based hibernation and
all the future users of kexec on panic infrstrcuture which will boot a 
second kernel in restricted amount of RAM.

I am not sure what's the best way to determine the total RAM in the system
in arch independent manner. Some VM guys can tell it better. One of the ways
could be to parse /proc/iomem, the way kexec-tools does. Balbir mentioned
that traverse through the nodes and sum up present_pages. 

Any suggestions, what's the best way to determine total amount of RAM
in the system in kernel?

Right now this seems to be one odd case so this code can be inside module.
If there are more users of it then we can probably create a flag inside
kernel and export it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
