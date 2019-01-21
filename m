Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUxr-00044Z-DD
 for kexec@lists.infradead.org; Mon, 21 Jan 2019 08:29:53 +0000
Date: Mon, 21 Jan 2019 09:29:32 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190121082932.GA29166@zn.tnic>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190118102636.GB622@zn.tnic>
 <20190121011830.GA1554@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121011830.GA1554@localhost.localdomain>
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
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: rafael.j.wysocki@intel.com, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, Len Brown <lenb@kernel.org>

On Mon, Jan 21, 2019 at 09:18:30AM +0800, Chao Fan wrote:
> So I have changed as this method and put in my mail thread, you may not
> notice, so I put here for my function if I need to fill the
> boot_parameters:
> 
> static inline acpi_physical_address get_boot_params_rsdp(void)
> {
>         return boot_params->acpi_rsdp_addr;
> }

Why do you need that silly wrapper?

> static acpi_physical_address get_rsdp_addr(void)
> {
>         bool boot_params_rsdp_exist;

What's that bool supposed to do?

>         acpi_physical_address pa;
> 
>         pa = get_acpi_rsdp();
> 
>         if (!pa)
>                 pa = get_boot_params_rsdp();
> 
>         if (!pa) {
>                 pa = efi_get_rsdp_addr();
>                 boot_params_rsdp_exist = false;
>         }
>         else
>                 boot_params_rsdp_exist = true;
> 
>         if (!pa)
>                 pa = bios_get_rsdp_addr();
> 
>         if (pa && !boot_params_rsdp_exist)
>                 boot_params.acpi_rsdp_addr = pa;
> 
>         return pa;
> }
> 
> At the same time, I notice kernel only parses it when
> "#ifdef CONFIG_ACPI", we should keep sync with kernel, but I think
> we are parsing SRAT, CONFIG_ACPI is needed sure, so I am going to
> update the define of EARLY_SRAT_PARSE:
> 
> config EARLY_SRAT_PARSE
>         bool "EARLY SRAT parsing"
>         def_bool y
>         depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE && ACPI

Actually, you don't need that anymore - make it unconditionally
built-in. Because there are a bunch of users which need this and instead
of complicating this config option with a bunch of dependencies, we can
just as well have it always on.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
