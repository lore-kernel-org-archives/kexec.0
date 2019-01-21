Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glOG9-0001t9-Se
 for kexec@lists.infradead.org; Mon, 21 Jan 2019 01:20:19 +0000
Date: Mon, 21 Jan 2019 09:18:30 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190121011830.GA1554@localhost.localdomain>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190118102636.GB622@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118102636.GB622@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: rafael.j.wysocki@intel.com, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, Len Brown <lenb@kernel.org>

On Fri, Jan 18, 2019 at 11:26:36AM +0100, Borislav Petkov wrote:
>On Thu, Jan 17, 2019 at 03:41:13PM +0800, Kairui Song wrote:
>> How about we refill the boot_params.acpi_rsdp_addr if it is not valid
>> in early code, so it could be used as a reliable RSDP address source?
>> That should make things easier.
>> 
>> But if early code should parse it and store it should be done in
>> Chao's patch, or I can post another patch to do it if Chao's patch is
>> merged.
>
>Chao's stuff does the as early as possible parsing of RDSP. Then, it
>should be saved into boot_params and everything else should read it from
>there. Simple.

Hi Boris,

So I have changed as this method and put in my mail thread, you may not
notice, so I put here for my function if I need to fill the
boot_parameters:

static inline acpi_physical_address get_boot_params_rsdp(void)
{
        return boot_params->acpi_rsdp_addr;
}

static acpi_physical_address get_rsdp_addr(void)
{
        bool boot_params_rsdp_exist;
        acpi_physical_address pa;

        pa = get_acpi_rsdp();

        if (!pa)
                pa = get_boot_params_rsdp();

        if (!pa) {
                pa = efi_get_rsdp_addr();
                boot_params_rsdp_exist = false;
        }
        else
                boot_params_rsdp_exist = true;

        if (!pa)
                pa = bios_get_rsdp_addr();

        if (pa && !boot_params_rsdp_exist)
                boot_params.acpi_rsdp_addr = pa;

        return pa;
}

At the same time, I notice kernel only parses it when
"#ifdef CONFIG_ACPI", we should keep sync with kernel, but I think
we are parsing SRAT, CONFIG_ACPI is needed sure, so I am going to
update the define of EARLY_SRAT_PARSE:

config EARLY_SRAT_PARSE
        bool "EARLY SRAT parsing"
        def_bool y
        depends on RANDOMIZE_BASE && MEMORY_HOTREMOVE && ACPI

If I miss something, please let me know.
Or in my PATCHSET, I don't need to fill boot_parameters, just
leave the job another PATCH?

Thanks,
Chao Fan

>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
