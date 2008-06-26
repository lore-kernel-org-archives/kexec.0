Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBqk0-0005Oo-Hm
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 12:38:20 +0000
Date: Thu, 26 Jun 2008 14:38:32 +0200
From: Bernhard Walle <bwalle@suse.de>(by way of Bernhard Walle
	<bwalle@suse.de>)
Message-ID: <20080626143832.49948500@halley.suse.de>
In-Reply-To: <20080626123518.GA3878@redhat.com>
References: <20080625221635.GD32344@redhat.com>
	<1214465001-12338-1-git-send-email-bwalle@suse.de>
	<20080626012337.a73c91d2.akpm@linux-foundation.org>
	<20080626102803.2a1a46cd@halley.suse.de>
	<20080626123518.GA3878@redhat.com>
Mime-Version: 1.0
Subject: Re: [PATCH] Remove CONFIG_EXPERIMENTAL from kdump
Resent-Message-ID: <20080626143857.3131037e@halley.suse.de>
Resent-To: kexec@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
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

* Vivek Goyal [2008-06-26 08:35]:
>
> On Thu, Jun 26, 2008 at 10:28:03AM +0200, Bernhard Walle wrote:
> > * Andrew Morton [2008-06-26 01:23]:
> > > >  
> > > >  config PROC_VMCORE
> > > >          bool "/proc/vmcore support (EXPERIMENTAL)"
> > > > -        depends on PROC_FS && EXPERIMENTAL && CRASH_DUMP
> > > > +        depends on PROC_FS && CRASH_DUMP
> > > >  	default y
> > > >          help
> > > >          Exports the dump image of crashed kernel in ELF format.
> > > 
> > > What about powerpc, sh and ia64?
> > 
> > At least for ia64 I wouldn't consider it as experimental. Don't know
> > about SH and PPC. But should we mark it as EXPERIMENTAL on all
> > platforms only because some "exotic" (at least SH) platforms have kdump
> > not very long implemented?
> 
> It has been present long enough on ia64 and ppc64. Only new entry seems
> to be SH. I would think of leaving it EXPERIMENTAL only on SH.

So, "PROC_FS && (!SH || EXPERIMENTAL) && CRASH_DUMP" ?



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
