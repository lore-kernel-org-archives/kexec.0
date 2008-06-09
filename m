Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5oQu-0004df-4w
	for kexec@lists.infradead.org; Mon, 09 Jun 2008 20:57:40 +0000
Date: Mon, 9 Jun 2008 22:57:34 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
Message-ID: <20080609225734.2bb9ee64@kopernikus.site>
In-Reply-To: <20080609205429.GJ3542@redhat.com>
References: <20080608134628.757299158@halley.suse.de>
	<20080608134629.743220278@halley.suse.de>
	<87bq2bmvro.fsf@saeurebad.de> <20080609132207.GC3542@redhat.com>
	<20080609182341.00d6e746@halley.suse.de>
	<484D5CCB.5020709@firstfloor.org>
	<1213041041.19111.68.camel@ustr-shaha1-linux-dev.na.uis.unisys.com>
	<20080609221732.1e14e5d5@kopernikus.site>
	<20080609202935.GI3542@redhat.com>
	<20080609224211.2ef0f74c@kopernikus.site>
	<20080609205429.GJ3542@redhat.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@saeurebad.de>, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, hpa@zytor.com, "Romer, Benjamin M" <Benjamin.Romer@unisys.com>, Amul Shah <amul.shah@unisys.com>

* Vivek Goyal <vgoyal@redhat.com> [2008-06-09 16:54]:
>
> On Mon, Jun 09, 2008 at 10:42:11PM +0200, Bernhard Walle wrote:
> > Hi Vivek,
> > 
> > * Vivek Goyal <vgoyal@redhat.com> [2008-06-09 16:29]:
> > >
> > > Can you please put some more explanation comment here to explain that
> > > why it is ok to return with success, despite the fact that we never
> > > reserved any memory.
> > 
> > Do you think that's ok?
> > 
> >     When booting the kdump kernel, the MP tables (for example,
> >     or other firmware-reserved memory) of the BIOS are beyond
> >     end_pfn. (kexec-tools adds exactmap parameters to the kernel
> >     so that the E820 map is no longer used.) Therefore, it's ok
> >     to return "success" here. For normal boot, the MP tables
> >     must be reserved normally.
> > 
> 
> Looks good. Thanks

Should I resend the whole patch series to Linus for inclusion?



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Maintenance

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
