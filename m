Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IL4R7-0000bb-4F
	for kexec@lists.infradead.org; Tue, 14 Aug 2007 18:00:35 -0400
Date: Wed, 15 Aug 2007 00:00:25 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [RFC][PATCH 1/3] Embed vmcoreinfo into kernel file
Message-ID: <20070814220025.GB16408@suse.de>
References: <20070813163212oomichi@mail.jp.nec.com>
	<20070813163653oomichi@mail.jp.nec.com>
	<20070813173811.GA14191@localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070813173811.GA14191@localdomain>
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
To: Dan Aloni <da-x@monatomic.org>
Cc: Don Zickus <dzickus@redhat.com>, Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, Neil Horman <nhorman@redhat.com>, Vivek Goyal <vgoyal@in.ibm.com>, kexec-ml <kexec@lists.infradead.org>

* Dan Aloni <da-x@monatomic.org> [2007-08-13 19:38]:
> On Mon, Aug 13, 2007 at 04:36:53PM +0900, Ken'ichi Ohmichi wrote:
> >[..]
> > Patches:
> > - [1/3] patch for linux-2.6.22.
> >   Changelog:
> >   * Rename "mkdfinfo" to "vmcoreinfo".
> >   * Multi memory models (FLATMEM, DISCONTIGMEM, and SPASEMEM) are
> >     supported.
> >   * The elf note typedef for vmcoreinfo is added because the original
> >     elf note size is limited to 1024.
> >   * The generation of the elf note is moved to boot time instead of
> >     crash time.
> 
> This looks very good. Just one suggestion - in order to reduce clutter 
> from kernel/kexec.c (as to avoid #ifdefs) perhaps it might be better 
> to have crash_save_vmcoreinfo_init() additionally call an arch-specific 
> arch_crash_save_vmcoreinfo_init() function and have that append all 
> the arch-specific stuff.

Because the only architecture that is really different is IA64, it may
make sense here to provide a default implementation that is used on
any architecture and declared as __attribute__((weak)). Then, any
architecture (here: IA64) can override that implementation. That would
avoid code duplication.

The rest looks good from my point of view. I'd like to see that in the
mainline kernel. :)



Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
