Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KGrs0-00077z-Ou
	for kexec@lists.infradead.org; Thu, 10 Jul 2008 08:51:21 +0000
Date: Thu, 10 Jul 2008 10:51:57 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] makedumpfile: Improve error handing when
	SIZE(nodemask_t) is undefined
Message-ID: <20080710105157.2af29b21@halley.suse.de>
In-Reply-To: <487562F0.8020606@mxs.nes.nec.co.jp>
References: <20080709134801.149fbdb4@halley.suse.de>
	<487562F0.8020606@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

* Ken'ichi Ohmichi [2008-07-10 10:16]:
>
> > 
> > +	if (SIZE(nodemask_t) == NOT_FOUND_LONG_VALUE) {
> > +		ERRMSG("SIZE(nodemask_t) undefined.\n");
> 
> I like the following message of the same form as another message.
> 
> ERRMSG("Can't get the size of nodemask_t.\n");

Sounds fine, thanks.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
