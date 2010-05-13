Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1OCTC8-0008VI-UI
	for kexec@lists.infradead.org; Thu, 13 May 2010 07:51:02 +0000
Message-ID: <4BEBAF60.5000300@ozlabs.org>
Date: Thu, 13 May 2010 17:50:56 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec-tools: remove unused code from arch_process_options
	(arm, cris, ia64, mips, ppc)
References: <4BEBAB67.30107@ozlabs.org>
In-Reply-To: <4BEBAB67.30107@ozlabs.org>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

Matt Evans wrote:
> These architectures don't have any architecture-specific options
> (note: distinct from loader options, which are more specific), yet
> their arch_process_options() functions contain getopts_long() calls
> followed by no argument processing.  The code doesn't do anything,
> so this patch removes it.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  kexec/arch/arm/kexec-arm.c   |   17 -----------------
>  kexec/arch/cris/kexec-cris.c |   17 -----------------
>  kexec/arch/ia64/kexec-ia64.c |   21 +++------------------
>  kexec/arch/mips/kexec-mips.c |   17 -----------------
>  kexec/arch/ppc/kexec-ppc.c   |   17 -----------------
>  5 files changed, 3 insertions(+), 86 deletions(-)

I forgot to add that unfortunately I have only been able to compile this patch on ppc.  Since the code carefully removed doesn't have any effect I am hopeful for the rest...  :-)


Cheers,


Matt


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
