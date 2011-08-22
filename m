Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QvVCC-00084g-6G
	for kexec@lists.infradead.org; Mon, 22 Aug 2011 14:09:45 +0000
Received: (from localhost user: 'dkiper' uid#4000 fake: STDIN
	(dkiper@router-fw.net-space.pl)) by router-fw-old.local.net-space.pl
	id S1568655Ab1HVOHp (ORCPT <rfc822;kexec@lists.infradead.org>);
	Mon, 22 Aug 2011 16:07:45 +0200
Date: Mon, 22 Aug 2011 16:07:45 +0200
From: Daniel Kiper <dkiper@net-space.pl>
Subject: Re: [PATCH 4/4] kexec/arch/i386: Add get_memory_ranges_xen() function
Message-ID: <20110822140745.GC27902@router-fw-old.local.net-space.pl>
References: <20110821135459.GE17323@router-fw-old.local.net-space.pl>
	<201108220001.24399.konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201108220001.24399.konrad.wilk@oracle.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, ian.campbell@citrix.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, vgoyal@redhat.com, Daniel Kiper <dkiper@net-space.pl>

On Mon, Aug 22, 2011 at 12:01:24AM -0400, Konrad Rzeszutek Wilk wrote:

[...]

> > +#ifdef HAVE_LIBXENCTRL
> > +static unsigned e820_to_kexec_type(uint32_t type)
> > +{
> > +	switch (type) {
> > +		case E820_RAM:
> > +			return RANGE_RAM;
> > +		case E820_ACPI:
> > +			return RANGE_ACPI;
> > +		case E820_NVS:
> > +			return RANGE_ACPI_NVS;
> > +		case E820_RESERVED:
>
> For E820_UNUSABLE you want to do that too?
>
> > +		default:
> > +			return RANGE_RESERVED;
>
> Or should E820_UNUSABLE returne its own type of RANGE?

Kexec does not differentiate between E820_RESERVED and E820_UNUSABLE
(please look into kexec/firmware_memmap.c, parse_memmap_entry()).
It treats both as RANGE_RESERVED. RANGE_UNUSABLE is not defined.
In this situation I stated that it is not worth to change that
and I have mapped all undefined types to RANGE_RESERVED. It means
that E820_UNUSABLE is mapped to RANGE_RESERVED.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
