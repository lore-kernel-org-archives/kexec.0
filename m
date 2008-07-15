Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KIgBw-00012q-Bb
	for kexec@lists.infradead.org; Tue, 15 Jul 2008 08:47:24 +0000
Date: Tue, 15 Jul 2008 10:48:03 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Use CFLAGS for compiling bin2hex
Message-ID: <20080715104803.04b5001f@halley.suse.de>
In-Reply-To: <200807151141.31994.jk@ozlabs.org>
References: <1216046012-32349-1-git-send-email-bwalle@suse.de>
	<200807151141.31994.jk@ozlabs.org>
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
To: Jeremy Kerr <jk@ozlabs.org>
Cc: kexec@lists.infradead.org

* Jeremy Kerr [2008-07-15 11:41]:
>
> 
> >  $(BIN_TO_HEX): CC=$(BUILD_CC)
> > -$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
> > +$(BIN_TO_HEX): CFLAGS+=$(BUILD_CFLAGS)
> >  $(BIN_TO_HEX): LDFLAGS=
> 
> Are you sure? CFLAGS will include stuff for $host (eg, -m64 for a 64-bit 
> host machine).

No, I'm not sure since I don't use the cross compilation feature, but
what's your proposal to use custom cflags like $RPM_OPT_FLAGS?



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
