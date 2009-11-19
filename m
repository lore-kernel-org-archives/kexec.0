Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NB6xZ-0005Kl-DK
	for kexec@lists.infradead.org; Thu, 19 Nov 2009 13:22:10 +0000
Date: Fri, 20 Nov 2009 00:22:03 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] add kexec-tools support for armv6l processors
Message-ID: <20091119132203.GC30917@verge.net.au>
References: <20091118102921.11977.28946.sendpatchset@rxone.opensource.se>
	<20091119054500.GH11927@verge.net.au>
	<d1b08f940911190017s50478713q72e73b386b09e461@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d1b08f940911190017s50478713q72e73b386b09e461@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: kexec@lists.infradead.org

On Thu, Nov 19, 2009 at 09:17:34AM +0100, Andrea Adami wrote:
> Hello Simon,
> 
> what's the point of adding a single arm family?
> As we discussed before, the check done in phys_arch.c will often fail
> (e.g. kernels utsname are armv5tel).
> Are you going to add each arm family with respective endianness?

Sorry, that conversation had slipped my mind.
To be honest, at this point I'm unsure what
the best approach is.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
