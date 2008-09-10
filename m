Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KdOB7-00056f-Ge
	for kexec@lists.infradead.org; Wed, 10 Sep 2008 11:48:09 +0000
Date: Wed, 10 Sep 2008 13:48:05 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kdump broken on Altix 350
Message-ID: <20080910134805.488b43f9@kepler.site>
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA30A0067D6@orsmsx505.amr.corp.intel.com>
References: <20080829180302.6e67c26e@halley.suse.de>
	<20080829180531.0524a1e4@halley.suse.de>
	<57C9024A16AD2D4C97DC78E552063EA30A0067D6@orsmsx505.amr.corp.intel.com>
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
To: kexec@lists.infradead.org, jlan@sgi.com

* "Luck, Tony" <tony.luck@intel.com> [2008-08-29]: 

> > your commit
> >
> >     commit 10617bbe84628eb18ab5f723d3ba35005adde143
> >     Author: Tony Luck <tony.luck@intel.com>
> >     Date:   Tue Aug 12 10:34:20 2008 -0700
> >
> >     [IA64] Ensure cpu0 can access per-cpu variables in early boot
> > code
> >
> > broke kdump on our Altix 350. I get following early crash in kdump
> > kernel
> 
> Sorry about that.  I'll try to reproduce it here.

I had some discussion about that with Jay Lan that he could not
reproduce that on his machine. We thought it was different config, but
now I can verify that the problem is reproducible here with the default
configuration (plus CONFIG_SATA_VITESSE).


Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
