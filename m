Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBmpC-0000l4-EI
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 08:27:27 +0000
Date: Thu, 26 Jun 2008 10:28:03 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Remove CONFIG_EXPERIMENTAL from kdump
Message-ID: <20080626102803.2a1a46cd@halley.suse.de>
In-Reply-To: <20080626012337.a73c91d2.akpm@linux-foundation.org>
References: <20080625221635.GD32344@redhat.com>
	<1214465001-12338-1-git-send-email-bwalle@suse.de>
	<20080626012337.a73c91d2.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

* Andrew Morton [2008-06-26 01:23]:
> >  
> >  config PROC_VMCORE
> >          bool "/proc/vmcore support (EXPERIMENTAL)"
> > -        depends on PROC_FS && EXPERIMENTAL && CRASH_DUMP
> > +        depends on PROC_FS && CRASH_DUMP
> >  	default y
> >          help
> >          Exports the dump image of crashed kernel in ELF format.
> 
> What about powerpc, sh and ia64?

At least for ia64 I wouldn't consider it as experimental. Don't know
about SH and PPC. But should we mark it as EXPERIMENTAL on all
platforms only because some "exotic" (at least SH) platforms have kdump
not very long implemented?



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
