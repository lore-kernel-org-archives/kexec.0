Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBmix-0003RQ-Jd
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 08:21:00 +0000
Date: Thu, 26 Jun 2008 10:21:37 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 2/3] Use /proc/firmware_mem for x86 (e820)
Message-ID: <20080626102137.53cb95ad@halley.suse.de>
In-Reply-To: <20080624182817.GI5642@ucw.cz>
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
	<1213977420-1555-3-git-send-email-bwalle@suse.de>
	<20080624182817.GI5642@ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: Greg KH <greg@kroah.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

* Pavel Machek [2008-06-24 20:28]:
>
> > This patch copies the E820 map very early, before the kernel applies various
> > operations. That copy is used later to register only the BIOS-provided E820
> > map later in the resource tree for /proc/firmware_mem.
> 
> It is not process related -> it should not go to /proc. Talk to Greg.

http://lkml.org/lkml/2008/6/26/75


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
