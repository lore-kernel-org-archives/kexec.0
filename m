Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KIjJw-0007w6-Ig
	for kexec@lists.infradead.org; Tue, 15 Jul 2008 12:07:53 +0000
From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] Use CFLAGS for compiling bin2hex
Date: Tue, 15 Jul 2008 22:04:21 +1000
References: <1216046012-32349-1-git-send-email-bwalle@suse.de>
	<20080715102808.GA29267@verge.net.au>
	<20080715130333.6f22b678@halley.suse.de>
In-Reply-To: <20080715130333.6f22b678@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807152204.22591.jk@ozlabs.org>
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
To: kexec@lists.infradead.org
Cc: Bernhard Walle <bwalle@suse.de>, Simon Horman <horms@verge.net.au>


>    BUILD_CFLAGS=... ./configure
>
> didn't also work. That would be acceptable for me.

OK, patch coming.

However, note that the BUILD_* is only used to compile tools to run on 
the build machine, and hence during the build process. There's not much 
point adding optimisation flags here, as it's only going to 
(potentially) speed up the build process, and not affect the resulting 
kexec binary in any way.

Cheers,


Jeremy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
