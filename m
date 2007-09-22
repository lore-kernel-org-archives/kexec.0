Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IYz4C-00044H-Na
	for kexec@lists.infradead.org; Sat, 22 Sep 2007 03:06:21 -0400
Date: Sat, 22 Sep 2007 09:06:13 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 7/7] Add documentation for extended crashkernel syntax
Message-ID: <20070922070612.GA6125@suse.de>
References: <20070913161428.343951643@strauss.suse.de>
	<20070913161430.686458007@strauss.suse.de>
	<20070918172108.GD5966@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070918172108.GD5966@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [2007-09-18 19:21]:
> > This adds the documentation for the extended crashkernel syntax into
> > Documentation/kdump/kdump.txt.
> 
> Should you also update kernel-parameters.txt?

Ok, I'll do.

> > +For example:
> > +
> > +    crashkernel=512M-2G:64M,2G-:128M
> > +
> > +This would mean:
> > +
> > +    1) if the RAM is smaller than 512M, then don't reserve anything
> > +       (this is the "rescue" case)
> > +    2) if the RAM size is between 512M and 2G, then reserve 64M
> > +    3) if the RAM size is larger than 2G, then reserve 128M
> 
> Why is this useful? I mean... if 64M is enough to save a dump, why use
> 128M? ...or does the required size somehow scale with memory in
> machine? (pagetables?)

A bit, yes (ELF core headers, DISCONT memory, per-CPU data), but
consider also that saving may be faster if you have more RAM (e.g.
saving over SSH, encryption, ...).


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
