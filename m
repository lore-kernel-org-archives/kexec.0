Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from djurbala-pt.tunnel.tserv2.fmt.ipv6.he.net
	([2001:470:1f01:ffff::eb] helo=gate.crashing.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KlNfy-0004it-F1
	for kexec@lists.infradead.org; Thu, 02 Oct 2008 12:53:03 +0000
Message-Id: <2AF4947A-B0E5-4530-9240-55C94A73E9FC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1222896024-22172-4-git-send-email-sebastian@breakpoint.cc>
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: dtb and purgatory support for ppc32
Date: Thu, 2 Oct 2008 07:52:37 -0500
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

I think I might have realized some of my confusion.. is this patch to  
the kernel or to some kexec tool?   If its to the kernel I don't  
answer at all.  If its to some kexec tool than that wasn't clear at all.

- k

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
