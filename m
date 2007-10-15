Return-path: <kexec-bounces@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IhUjg-0000ej-Ue
	for kexec@lists.infradead.org; Mon, 15 Oct 2007 19:32:21 +0100
Date: Mon, 15 Oct 2007 11:32:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/2] Add BSS to resource tree
Message-Id: <20071015113206.36c06361.akpm@linux-foundation.org>
In-Reply-To: <20071015115042.958614570@strauss.suse.de>
References: <20071015115042.391348549@strauss.suse.de>
	<20071015115042.958614570@strauss.suse.de>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de

On Mon, 15 Oct 2007 13:50:43 +0200
Bernhard Walle <bwalle@suse.de> wrote:

> --- a/arch/x86/kernel/e820_32.c
> +++ b/arch/x86/kernel/e820_32.c
> @@ -51,6 +51,13 @@ struct resource code_resource = {
>  	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
>  };
>  
> +struct resource bss_resource = {
> +	.name	= "Kernel bss",
> +	.start	= 0,
> +	.end	= 0,
> +	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
> +};
> +
>  static struct resource system_rom_resource = {
>  	.name	= "System ROM",
>  	.start	= 0xf0000,
> @@ -287,6 +294,7 @@ legacy_init_iomem_resources(struct resou
>  			 */
>  			request_resource(res, code_resource);
>  			request_resource(res, data_resource);
> +			request_resource(res, &bss_resource);

Looks ungainly, doesn't it?  Perhaps we should add a third arg to
legacy_init_iomem_resources(), or change legacy_init_iomem_resources() to
take zero args?  

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
