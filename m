Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from djurbala-pt.tunnel.tserv2.fmt.ipv6.he.net
	([2001:470:1f01:ffff::eb] helo=gate.crashing.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L340K-0003j2-Mj
	for kexec@lists.infradead.org; Thu, 20 Nov 2008 07:31:09 +0000
Subject: Re: [PATCH] powerpc/mpic: don't reset affinity for secondary MPIC
	on boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <200811191450.59361.arnd@arndb.de>
References: <200811191450.59361.arnd@arndb.de>
Date: Thu, 20 Nov 2008 18:30:40 +1100
Message-Id: <1227166240.7185.207.camel@pasglop>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kexec@lists.infradead.org, cbe-oss-dev@ozlabs.org, Max Krasnyansky <maxk@qualcomm.com>

On Wed, 2008-11-19 at 14:50 +0100, Arnd Bergmann wrote:
> This patch implements the first approach, because it can work on
> machines that have a secondary controller that needs to deliver
> interrupts to a destination other than CPU 0. The disadvantage
> is that it requires the system to set up the affinity register
> correctly on bootup.
> 
That won't fly with MPICs that get reset.

I would rather, for non primary, set it to a cpu provided as
either a new argument or an mpic struct member initially set to 1 with
an accessor to change it if necessary. Or should we define a flag to
have it read it at init time from the chip ?

Ben.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
