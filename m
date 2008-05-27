Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K18e6-0001HY-9J
	for kexec@lists.infradead.org; Tue, 27 May 2008 23:31:58 +0000
Date: Wed, 28 May 2008 09:31:49 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec on mips - anyone has it working?
Message-ID: <20080527233148.GB6752@verge.net.au>
References: <483BCB75.4050901@wpkg.org>
	<200805271405.55346.nschichan@freebox.fr>
	<483C0135.9070203@wpkg.org>
	<200805271449.45124.nschichan@freebox.fr>
	<483C4F73.4040909@wpkg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <483C4F73.4040909@wpkg.org>
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
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-mips@linux-mips.org, Kexec Mailing List <kexec@lists.infradead.org>, Nicolas Schichan <nschichan@freebox.fr>

On Tue, May 27, 2008 at 08:14:11PM +0200, Tomasz Chmielewski wrote:
> Nicolas Schichan schrieb:
> > On Tuesday 27 May 2008 14:40:21 you wrote:
> >>> Could you try to add the following line in machine_kexec.c, just before
> >>> jumping to the trampoline:
> >>>
> >>>        change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
> >> And machine_kexec.c file is in where? It's not in the above one, it's
> >> not in kexec-tools-testing-20080324?
> > 
> > 
> > machine_kexec.c is in the kernel not in the kexec userland tools.
> 
> Aah, I see.
> 
> Anyway, it doesn't work - with or without this slight change in 
> machine_kexec.c, with kexec compiled from the sources in the link you 
> gave or with kexec-tools-testing-20080324, it just doesn't work on 
> BCM43XX with OpenWRT patches. At least on Asus WL-500gP.

Hi,

MIPS support was merged into kexec-tools-testing-20080324.
However, as far as I could tell it only supports one of the
many boot protocols that are used by various MIPS machines.

If things aren't working for a particular peice of hardware, I would
start by looking into what boot protocol the kernel uses on that
machine, and making sure that kexec-tools understands it.

As always if there are any patches for MIPS for kexec-tools, please send
them to me and this list.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
