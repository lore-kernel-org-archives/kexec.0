Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IAPdd-0004uG-SX
	for kexec@lists.infradead.org; Mon, 16 Jul 2007 08:25:19 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6GCPGWk002618
	for <kexec@lists.infradead.org>; Mon, 16 Jul 2007 08:25:16 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6GCPGW6457260
	for <kexec@lists.infradead.org>; Mon, 16 Jul 2007 08:25:16 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6GCPFfQ006930
	for <kexec@lists.infradead.org>; Mon, 16 Jul 2007 08:25:15 -0400
Date: Mon, 16 Jul 2007 17:55:18 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070716122518.GA10506@in.ibm.com>
References: <20070710120243.GA10121@hmsendeavour.rdu.redhat.com>
	<20070713200533oomichi@mail.jp.nec.com>
	<20070713131550.GB10985@suse.de>
	<20070716041918.GA11390@in.ibm.com>
	<20070716115707.GA29923@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070716115707.GA29923@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bernhard Walle <bwalle@suse.de>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

On Mon, Jul 16, 2007 at 01:57:07PM +0200, Bernhard Walle wrote:
> * Vivek Goyal <vgoyal@in.ibm.com> [2007-07-16 06:19]:
> > On Fri, Jul 13, 2007 at 03:15:50PM +0200, Bernhard Walle wrote:
> > > * Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-07-13 13:05]:
> > > > 
> > > > BTW, I'd like to remove PAGESIZE from a mkdfinfo file.
> > > > While 2nd-kernel is running, new makedumpfile comes to consider
> > > > 2nd-kernel PAGESIZE as 1st-kernel PAGESIZE without getting PAGESIZE
> > > > from a mkdfinfo file.
> > > 
> > > I don't think that's a good idea. IMO the kernel should be modified to
> > > export the page size in a variable for that purpose. That would solve
> > > all problems and dependencies, doesn't it?
> > > 
> > 
> > Agreed. We need to export PAGESIZE from kernel instead of assuming that
> > second kernel as got same page size as first kernel.
> 
> So what about this? Do you think it has a chance to get included?
> Should the variable not be inside mm/ but otherwhere?
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
> ---
>  mm/mmap.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -35,6 +35,16 @@
>  #define arch_mmap_check(addr, len, flags)	(0)
>  #endif
> 
> +#ifdef CONFIG_KEXEC
> +
> +/*
> + * Although that variable is not needed for the kernel, initialise it here
> + * to have the page size available in the vmlinux binary.
> + */
> +int page_size = PAGE_SIZE;
> +

Ok. Now there seems to be two ways for accessing such info.
- Through global variables
- Export through ELF notes.

Personally, I like the approach taken by Dan Aloni of exporting required
info through ELF notes. That seems to be more standard in the sense we 
are not dependent on somebody removing above variable tomorrow.

Dan, are you planning to put the modified patch for discussions on LKML?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
