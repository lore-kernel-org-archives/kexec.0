Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ko5rx-0002BR-4F
	for kexec@lists.infradead.org; Fri, 10 Oct 2008 00:28:37 +0000
Message-ID: <48EE9FD0.4070501@mxs.nes.nec.co.jp>
Date: Fri, 10 Oct 2008 09:20:32 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] add additional symbols to /sys/kernel/vmcoreinfo data
	for	ppc(64)
References: <20081009151408.GA25268@hmsendeavour.rdu.redhat.com>
In-Reply-To: <20081009151408.GA25268@hmsendeavour.rdu.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1272387458=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

--===============1272387458==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Neil,

I had created similar patch, but your patch is better than mine because
your patch has right configuration dependency. So I think this patch is
fine.

Reviewed-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>


Thanks
Ken'ichi Ohmichi

* Reference:
http://lists.infradead.org/pipermail/kexec/2008-June/001970.html

Neil Horman wrote:
> Hey-
> 	The makdumpdile dump filtering program, in some modes of operation needs
> the node_data and/or contig_page_data symbols to function properly.  These
> symbols are missing from the powerpc kernel.  This patch adds those symbols in
> properly.  Tested successfully by myself and the reporter.
> 
> Regards
> Neil
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> 
>  machine_kexec.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> 
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index aab7688..2f9b5aa 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -44,6 +44,16 @@ void machine_kexec_cleanup(struct kimage *image)
>  		ppc_md.machine_kexec_cleanup(image);
>  }
>  
> +void arch_crash_save_vmcoreinfo(void)
> +{
> +#ifdef CONFIG_NEED_MULTIPLE_NODES
> +	VMCOREINFO_SYMBOL(node_data);
> +	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
> +#else
> +	VMCOREINFO_SYMBOL(contig_page_data);
> +#endif
> +}
> +
>  /*
>   * Do not allocate memory (or fail in any way) in machine_kexec().
>   * We are past the point of no return, committed to rebooting now.




--===============1272387458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1272387458==--
