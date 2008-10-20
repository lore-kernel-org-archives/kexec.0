Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KruEi-0001zj-JF
	for kexec@lists.infradead.org; Mon, 20 Oct 2008 12:51:52 +0000
Date: Mon, 20 Oct 2008 08:51:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] add additional symbols to /sys/kernel/vmcoreinfo data
	for ppc(64)
Message-ID: <20081020125149.GA10905@redhat.com>
References: <20081009151408.GA25268@hmsendeavour.rdu.redhat.com>
	<20081017210854.GB10013@redhat.com>
	<20081020002805.GA23009@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081020002805.GA23009@localhost.localdomain>
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

On Sun, Oct 19, 2008 at 08:28:05PM -0400, Neil Horman wrote:
>  Hey Vivek, as promised, a corrected patch
> 	
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
>  machine_kexec.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> 
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index aab7688..5d51e75 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -44,6 +44,14 @@ void machine_kexec_cleanup(struct kimage *image)
>  		ppc_md.machine_kexec_cleanup(image);
>  }
>  
> +void arch_crash_save_vmcoreinfo(void)
> +{
> +#ifdef CONFIG_NEED_MULTIPLE_NODES
> +	VMCOREINFO_SYMBOL(node_data);
> +	VMCOREINFO_LENGTH(node_data, MAX_NUMNODES);
> +#endif
> +}
> +

Looks good to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
