Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBnVh-0000uY-C5
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 09:11:21 +0000
Date: Thu, 26 Jun 2008 11:11:58 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Remove CONFIG_EXPERIMENTAL from kdump
Message-ID: <20080626111158.59ceaeff@halley.suse.de>
In-Reply-To: <20080626102803.2a1a46cd@halley.suse.de>
References: <20080625221635.GD32344@redhat.com>
	<1214465001-12338-1-git-send-email-bwalle@suse.de>
	<20080626012337.a73c91d2.akpm@linux-foundation.org>
	<20080626102803.2a1a46cd@halley.suse.de>
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

* Bernhard Walle [2008-06-26 10:28]:
>
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
> about SH and PPC.

On PPC it's also quite mature (just talked with our PPC maintainer),
they are also working on relocatable kernel support for kdump.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
