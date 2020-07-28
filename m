Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.11.71.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Pvv-0001uI-KZ
 for kexec@lists.infradead.org; Tue, 28 Jul 2020 13:46:20 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RESEND PATCH v5 07/11] ppc64/kexec_file: enable early kernel's
 OPAL calls
In-Reply-To: <159579233676.5790.10701756666641782647.stgit@hbathini>
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <159579233676.5790.10701756666641782647.stgit@hbathini>
Date: Tue, 28 Jul 2020 23:46:15 +1000
Message-ID: <87365b7nx4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hari Bathini <hbathini@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hari Bathini <hbathini@linux.ibm.com> writes:
> Kernel built with CONFIG_PPC_EARLY_DEBUG_OPAL enabled expects r8 & r9
> to be filled with OPAL base & entry addresses respectively. Setting
> these registers allows the kernel to perform OPAL calls before the
> device tree is parsed.

I'm not convinced we want to do this.

If we do it becomes part of the kexec ABI and we have to honour it into
the future.

And in practice there are no non-development kernels built with OPAL early
debugging enabled, so it's not clear it actually helps anyone other than
developers.

cheers

> v4 -> v5:
> * New patch. Updated opal_base & opal_entry values in r8 & r9 respectively.
>   This change was part of the below dropped patch in v4:
>     - https://lore.kernel.org/patchwork/patch/1275667/
>
>
>  arch/powerpc/kexec/file_load_64.c      |   16 ++++++++++++++++
>  arch/powerpc/purgatory/trampoline_64.S |   15 +++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index 8df085a22fd7..a5c1442590b2 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -713,6 +713,8 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
>  			  const void *fdt, unsigned long kernel_load_addr,
>  			  unsigned long fdt_load_addr)
>  {
> +	struct device_node *dn = NULL;
> +	uint64_t val;
>  	int ret;
>  
>  	ret = setup_purgatory(image, slave_code, fdt, kernel_load_addr,
> @@ -735,9 +737,23 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
>  			goto out;
>  	}
>  
> +	/* Setup OPAL base & entry values */
> +	dn = of_find_node_by_path("/ibm,opal");
> +	if (dn) {
> +		of_property_read_u64(dn, "opal-base-address", &val);
> +		ret = kexec_purgatory_get_set_symbol(image, "opal_base", &val,
> +						     sizeof(val), false);
> +		if (ret)
> +			goto out;
> +
> +		of_property_read_u64(dn, "opal-entry-address", &val);
> +		ret = kexec_purgatory_get_set_symbol(image, "opal_entry", &val,
> +						     sizeof(val), false);
> +	}
>  out:
>  	if (ret)
>  		pr_err("Failed to setup purgatory symbols");
> +	of_node_put(dn);
>  	return ret;
>  }
>  
> diff --git a/arch/powerpc/purgatory/trampoline_64.S b/arch/powerpc/purgatory/trampoline_64.S
> index a5a83c3f53e6..464af8e8a4cb 100644
> --- a/arch/powerpc/purgatory/trampoline_64.S
> +++ b/arch/powerpc/purgatory/trampoline_64.S
> @@ -61,6 +61,10 @@ master:
>  	li	%r4,28
>  	STWX_BE	%r17,%r3,%r4	/* Store my cpu as __be32 at byte 28 */
>  1:
> +	/* Load opal base and entry values in r8 & r9 respectively */
> +	ld	%r8,(opal_base - 0b)(%r18)
> +	ld	%r9,(opal_entry - 0b)(%r18)
> +
>  	/* load the kernel address */
>  	ld	%r4,(kernel - 0b)(%r18)
>  
> @@ -102,6 +106,17 @@ dt_offset:
>  	.8byte  0x0
>  	.size dt_offset, . - dt_offset
>  
> +	.balign 8
> +	.globl opal_base
> +opal_base:
> +	.8byte  0x0
> +	.size opal_base, . - opal_base
> +
> +	.balign 8
> +	.globl opal_entry
> +opal_entry:
> +	.8byte  0x0
> +	.size opal_entry, . - opal_entry
>  
>  	.data
>  	.balign 8

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
