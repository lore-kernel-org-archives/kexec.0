Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KIiJ3-0003Qf-Ne
	for kexec@lists.infradead.org; Tue, 15 Jul 2008 11:02:54 +0000
Date: Tue, 15 Jul 2008 13:03:33 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Use CFLAGS for compiling bin2hex
Message-ID: <20080715130333.6f22b678@halley.suse.de>
In-Reply-To: <20080715102808.GA29267@verge.net.au>
References: <1216046012-32349-1-git-send-email-bwalle@suse.de>
	<200807151141.31994.jk@ozlabs.org>
	<20080715104803.04b5001f@halley.suse.de>
	<20080715102808.GA29267@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>

* Simon Horman [2008-07-15 20:28]:
>
> On Tue, Jul 15, 2008 at 10:48:03AM +0200, Bernhard Walle wrote:
> > * Jeremy Kerr [2008-07-15 11:41]:
> > >
> > > 
> > > >  $(BIN_TO_HEX): CC=$(BUILD_CC)
> > > > -$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
> > > > +$(BIN_TO_HEX): CFLAGS+=$(BUILD_CFLAGS)
> > > >  $(BIN_TO_HEX): LDFLAGS=
> > > 
> > > Are you sure? CFLAGS will include stuff for $host (eg, -m64 for a 64-bit 
> > > host machine).
> > 
> > No, I'm not sure since I don't use the cross compilation feature, but
> > what's your proposal to use custom cflags like $RPM_OPT_FLAGS?
> 
> I wonder if we can make BUILD_CFLAGS and friends be accepted fron the
> envionment.

   BUILD_CFLAGS=... ./configure

didn't also work. That would be acceptable for me.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
