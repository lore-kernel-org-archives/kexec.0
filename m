Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9XKy-0007j9-OD
 for kexec@lists.infradead.org; Thu, 28 Mar 2019 15:53:06 +0000
Date: Thu, 28 Mar 2019 16:52:56 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190328155256.GP22720@zn.tnic>
References: <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>

On Thu, Mar 28, 2019 at 07:43:38AM +0000, Junichi Nomura wrote:
>  /* Search EFI system tables for RSDP. */
> -static acpi_physical_address efi_get_rsdp_addr(void)
> +static acpi_physical_address __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables, int size, bool efi_64)

Break this line like this:

static acpi_physical_address
__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
                    int size, bool efi_64)


>  {
>  	acpi_physical_address rsdp_addr = 0;

You don't need that variable and can return "table" or 0 after the endif
below.

>  #ifdef CONFIG_EFI
> -	unsigned long systab, systab_tables, config_tables;
> +	int i;
> +
> +	/* Get EFI tables from systab. */
> +	for (i = 0; i < nr_tables; i++) {
> +		acpi_physical_address table;
> +		efi_guid_t guid;
> +
> +		config_tables += size;
> +
> +		if (efi_64) {
> +			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables;
> +
> +			guid  = tbl->guid;
> +			table = tbl->table;
> +
> +			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
> +				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
> +				return 0;
> +			}
> +		} else {
> +			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables;
> +
> +			guid  = tbl->guid;
> +			table = tbl->table;
> +		}
> +
> +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
> +			rsdp_addr = table;
> +		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> +			return table;
> +	}
> +#endif
> +	return rsdp_addr;
> +}
> +
> +static acpi_physical_address kexec_get_rsdp_addr(void)
> +{
> +#ifdef CONFIG_EFI
> +	struct efi_setup_data *esd;
> +	efi_system_table_64_t *systab;
> +	struct efi_info *ei;
> +	char *sig;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +
> +	esd = (struct efi_setup_data *) efi_get_kexec_setup_data_addr();
> +	if (!esd)
> +		return 0;

<---- newline here.

> +	if (!esd->tables) {
> +		debug_putstr("Wrong kexec SETUP_EFI data.\n");
> +		return 0;
> +	}
> +
> +	ei = &boot_params->efi_info;
> +	sig = (char *)&ei->efi_loader_signature;
> +	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +		debug_putstr("Wrong EFI loader signature.\n");

  "Wrong kexec EFI loader signature."

so that it differs from the other error message and we can know where we
are when debugging.

> +		return 0;
> +	}
> +
> +	/* Get systab from boot params. */
> +	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
> +	if (!systab)
> +		error("EFI system table not found.");

Ditto.

> +
> +	return __efi_get_rsdp_addr((unsigned long) esd->tables, systab->nr_tables, sizeof(efi_config_table_64_t), true);

You can easily break that line - no need to let it stick out.

> +#else
> +	return 0;
> +#endif
> +}

Other than those nitpicks, yes, it looks ok to me. Please send a proper
patch.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
