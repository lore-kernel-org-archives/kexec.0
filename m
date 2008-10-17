Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KqwZe-0000G0-Hm
	for kexec@lists.infradead.org; Fri, 17 Oct 2008 21:09:31 +0000
Date: Fri, 17 Oct 2008 17:08:54 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] add additional symbols to /sys/kernel/vmcoreinfo data
	for ppc(64)
Message-ID: <20081017210854.GB10013@redhat.com>
References: <20081009151408.GA25268@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081009151408.GA25268@hmsendeavour.rdu.redhat.com>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Oct 09, 2008 at 11:20:27AM -0400, Neil Horman wrote:
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

Hi Neil,

Looks like contig_page_data is already being saved in arch independent
portion of kexec (crash_save_vmcoreinfo_init()). We probably don't need
to save it here again?

#ifndef CONFIG_NEED_MULTIPLE_NODES
        VMCOREINFO_SYMBOL(mem_map);
        VMCOREINFO_SYMBOL(contig_page_data);
#endif

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
