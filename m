From: Sean Christopherson <seanjc@google.com>
Date: Mon, 7 Feb 2022 22:11:53 +0000
Subject: [PATCH v3 05/10] x86/sev: Setup code to park APs in the AP Jump
 Table
In-Reply-To: <20220127101044.13803-6-joro@8bytes.org>
References: <20220127101044.13803-1-joro@8bytes.org>
 <20220127101044.13803-6-joro@8bytes.org>
Message-ID: <YgGZKdbr3RrzU+xk@google.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Jan 27, 2022, Joerg Roedel wrote:
> +static int __init sev_setup_ap_jump_table(void)

This name is really confusing.  AFAICT, it's specific to SEV-ES, but used only
"sev" for the namespace because sev_es_setup_ap_jump_table() already exists.
I assume this variant is purely for parking/offlining vCPUs?  Adding that in the
name would be helpful.

The two flows are also very, very similar, but apparently do slightly different
things.  Even more odd is that this version applies different sanity checks on
the address than the existing code.  It should be fairly simple to extract a
common helper.  That would likely help with naming problem too.

> +{
> +	size_t blob_size = rm_ap_jump_table_blob_end - rm_ap_jump_table_blob;
> +	u16 startup_cs, startup_ip;
> +	u16 __iomem *jump_table;
> +	phys_addr_t pa;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> +		return 0;
> +
> +	if (ghcb_info.vm_proto < 2) {
> +		pr_warn("AP jump table parking requires at least GHCB protocol version 2\n");
> +		return 0;
> +	}
> +
> +	pa = get_jump_table_addr();
> +
> +	/* On UP guests there is no jump table so this is not a failure */
> +	if (!pa)
> +		return 0;
> +
> +	/* Check overflow and size for untrusted jump table address */
> +	if (pa + PAGE_SIZE < pa || pa + PAGE_SIZE > SZ_4G) {
> +		pr_info("AP jump table is above 4GB or address overflow - not enabling AP jump table parking\n");
> +		return 0;
> +	}
> +
> +	jump_table = ioremap_encrypted(pa, PAGE_SIZE);
> +	if (WARN_ON(!jump_table))
> +		return -EINVAL;
> +
> +	/*
> +	 * Save reset vector to restore it later because the blob will
> +	 * overwrite it.
> +	 */
> +	startup_ip = jump_table[0];
> +	startup_cs = jump_table[1];
> +
> +	/* Install AP jump table Blob with real mode AP parking code */
> +	memcpy_toio(jump_table, rm_ap_jump_table_blob, blob_size);
> +
> +	/* Setup AP jump table GDT */
> +	sev_es_setup_ap_jump_table_data(jump_table, (u32)pa);
> +
> +	writew(startup_ip, &jump_table[0]);
> +	writew(startup_cs, &jump_table[1]);
> +
> +	iounmap(jump_table);
> +
> +	pr_info("AP jump table Blob successfully set up\n");
> +
> +	/* Mark AP jump table blob as available */
> +	sev_ap_jumptable_blob_installed = true;
> +
> +	return 0;
> +}
> +core_initcall(sev_setup_ap_jump_table);

