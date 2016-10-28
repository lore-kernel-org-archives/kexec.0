Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c00Uu-0004PO-EA
 for kexec@lists.infradead.org; Fri, 28 Oct 2016 06:18:37 +0000
Received: by mail-qk0-f171.google.com with SMTP id v138so20121578qka.0
 for <kexec@lists.infradead.org>; Thu, 27 Oct 2016 23:18:16 -0700 (PDT)
Subject: Re: [PATCH] Fix module module_init/init_size offsets for v4.5 kernel
References: <1477631234-15500-1-git-send-email-kamalesh@linux.vnet.ibm.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <14d7f3de-37f1-786c-e7e3-96d7f9c89bed@redhat.com>
Date: Fri, 28 Oct 2016 11:48:10 +0530
MIME-Version: 1.0
In-Reply-To: <1477631234-15500-1-git-send-email-kamalesh@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, kexec@lists.infradead.org



On Friday 28 October 2016 10:37 AM, Kamalesh Babulal wrote:
> Kernel commit 7523e4dc50 (module: use a structure to encapsulate layout.)
> encapsulates core_layout and init_layout into module_layout structure.
>
> commit fa6a75a93 (Fix module core base and size offset for kernel v4.5)
> fixes offset value calculation for core layout's base and size, whereas
> Kernel v4.5 module changes also needs fixing of module init_size and
> module_init for the makedumpfile to read the correct module address.
>
> This patch fixes calculation of offsets values for module init_size and
> module_init.
>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Cc: Pratyush Anand <panand@redhat.com>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  makedumpfile.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 853b999..f33a90d 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1689,7 +1689,25 @@ get_structure_info(void)
>  		OFFSET(module.core_size) += core_layout;
>  	}
>  	OFFSET_INIT(module.module_init, "module", "module_init");
> +	if (OFFSET(module.module_init) == NOT_FOUND_STRUCTURE) {
> +		/* for kernel version 4.5 and above */
> +		long init_layout;
> +
> +		OFFSET_INIT(module.module_init, "module", "init_layout");
> +		init_layout = OFFSET(module.module_init);
> +		OFFSET_INIT(module.module_init, "module_layout", "base");
> +		OFFSET(module.module_init) += init_layout;
> +	}
>  	OFFSET_INIT(module.init_size, "module", "init_size");
> +	if (OFFSET(module.init_size) == NOT_FOUND_STRUCTURE) {
> +		/* for kernel version 4.5 and above */
> +		long init_layout;
> +
> +		OFFSET_INIT(module.init_size, "module", "init_layout");
> +		init_layout = OFFSET(module.init_size);
> +		OFFSET_INIT(module.init_size, "module_layout", "size");
> +		OFFSET(module.init_size) += init_layout;
> +	}
>
>  	ENUM_NUMBER_INIT(NR_FREE_PAGES, "NR_FREE_PAGES");
>  	ENUM_NUMBER_INIT(N_ONLINE, "N_ONLINE");
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
