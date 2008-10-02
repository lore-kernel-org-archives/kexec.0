Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from djurbala-pt.tunnel.tserv2.fmt.ipv6.he.net
	([2001:470:1f01:ffff::eb] helo=gate.crashing.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KlFH6-0001Zk-Nt
	for kexec@lists.infradead.org; Thu, 02 Oct 2008 03:54:49 +0000
Message-Id: <7AB33E84-B8C2-4B32-B1F8-7FA213198FE4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
Date: Wed, 1 Oct 2008 22:54:23 -0500
References: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
	<1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
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
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org


On Oct 1, 2008, at 4:20 PM, Sebastian Andrzej Siewior wrote:

> From: Sebastian Siewior <bigeasy@linutronix.de>
>
> Some code dtb scanning & filling has been borrowed from ppc64.
> The old behavior is still available if compiled with GameCube,
> other PowerPC platform use the can purgatory and specify a new
> dtb.
> The purgatory is disabled because somehting is wrong and I dunno
> the reason. Booting a self containd cuImage (incl. dtb / wiuthout
> the need for a bd sturct) can be booted.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> kexec/arch/ppc/Makefile            |    1 +
> kexec/arch/ppc/kexec-elf-ppc.c     |  167 ++++++++++----
> kexec/arch/ppc/kexec-elf-rel-ppc.c |    4 +
> kexec/arch/ppc/kexec-ppc.c         |  469 +++++++++++++++++++++++++++ 
> ++++++++-
> purgatory/arch/ppc/Makefile        |    1 +
> purgatory/arch/ppc/purgatory-ppc.c |    4 +
> purgatory/arch/ppc/v2wrap.S        |   54 ++++
> 7 files changed, 652 insertions(+), 48 deletions(-)
> create mode 100644 purgatory/arch/ppc/v2wrap.S

are you trying to get this accepted?

- k


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
