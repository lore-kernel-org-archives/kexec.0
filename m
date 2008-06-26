Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBqhx-0006LR-Ld
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 12:36:14 +0000
Date: Thu, 26 Jun 2008 08:35:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Remove CONFIG_EXPERIMENTAL from kdump
Message-ID: <20080626123518.GA3878@redhat.com>
References: <20080625221635.GD32344@redhat.com>
	<1214465001-12338-1-git-send-email-bwalle@suse.de>
	<20080626012337.a73c91d2.akpm@linux-foundation.org>
	<20080626102803.2a1a46cd@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080626102803.2a1a46cd@halley.suse.de>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Jun 26, 2008 at 10:28:03AM +0200, Bernhard Walle wrote:
> * Andrew Morton [2008-06-26 01:23]:
> > >  
> > >  config PROC_VMCORE
> > >          bool "/proc/vmcore support (EXPERIMENTAL)"
> > > -        depends on PROC_FS && EXPERIMENTAL && CRASH_DUMP
> > > +        depends on PROC_FS && CRASH_DUMP
> > >  	default y
> > >          help
> > >          Exports the dump image of crashed kernel in ELF format.
> > 
> > What about powerpc, sh and ia64?
> 
> At least for ia64 I wouldn't consider it as experimental. Don't know
> about SH and PPC. But should we mark it as EXPERIMENTAL on all
> platforms only because some "exotic" (at least SH) platforms have kdump
> not very long implemented?

It has been present long enough on ia64 and ppc64. Only new entry seems
to be SH. I would think of leaving it EXPERIMENTAL only on SH.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
