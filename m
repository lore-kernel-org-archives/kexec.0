Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6cGG-0002MV-L6
	for kexec@lists.infradead.org; Thu, 12 Jun 2008 02:10:01 +0000
Date: Thu, 12 Jun 2008 12:09:58 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix implicit declaration of inb/outb
Message-ID: <20080612020957.GF22358@verge.net.au>
References: <e2ed954f0806021843r648e4276v6c0d49aa1f601e17@mail.gmail.com>
	<1212478437-8935-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1212478437-8935-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, Jamey Sharp <jamey@thetovacompany.com>

On Tue, Jun 03, 2008 at 09:33:57AM +0200, Bernhard Walle wrote:
> This patch fixes following compiler warning:
> 
>     purgatory/arch/i386/console-x86.c:84: \
>         warning: implicit declaration of function `outb'
>     purgatory/arch/i386/console-x86.c:89: \
>         warning: implicit declaration of function `inb'
> 
> Found on x86_64. The problem did not happen with i386.
> Fix tested on x86_64-suse-linux and i586-suse-linux.
> 
> I also added __always_inline__ to make sure that the function gets always
> inlined, regardless of optimisation compiler flags.

Thanks, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
