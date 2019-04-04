Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hBx6m-0001sv-4m
 for kexec@lists.infradead.org; Thu, 04 Apr 2019 07:48:25 +0000
Date: Thu, 4 Apr 2019 15:48:17 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190404074817.GM1555@localhost.localdomain>
References: <20190403082305.GG1555@localhost.localdomain>
 <20190403090210.GH1555@localhost.localdomain>
 <c8613886-7014-cbd2-788f-a4f29bb5b4a5@ce.jp.nec.com>
 <20190404025234.GA12658@dhcp-128-65.nay.redhat.com>
 <20190404030037.GT7627@MiWiFi-R3L-srv>
 <20190404031030.GU7627@MiWiFi-R3L-srv>
 <20190404032238.GA16267@dhcp-128-65.nay.redhat.com>
 <20190404064130.GA5530@dhcp-128-65.nay.redhat.com>
 <20190404072007.GL1555@localhost.localdomain>
 <20190404074102.GA5970@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190404074102.GA5970@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On Thu, Apr 04, 2019 at 03:41:02PM +0800, Dave Young wrote:
>Hi Chao,
>On 04/04/19 at 03:20pm, Chao Fan wrote:
>> On Thu, Apr 04, 2019 at 02:41:30PM +0800, Dave Young wrote:
>> >On 04/04/19 at 11:22am, Dave Young wrote:
>> >> On 04/04/19 at 11:10am, Baoquan He wrote:
>> >> > On 04/04/19 at 11:00am, Baoquan He wrote:
>> >> > > On 04/04/19 at 10:52am, Dave Young wrote:
>> >> > > > On 04/04/19 at 01:23am, Junichi Nomura wrote:
>> >> >  +	/* Save RSDP address for later use. */
>> >> >  +	boot_params->acpi_rsdp_addr = get_rsdp_addr();
>> >> >  +
>> >> >  +	error("Hang kernel for kexec debugging");
>> >> > 
>> >> > Sorry, here I means calling error() to hang kernel after calling
>> >> > get_rsdp_addr().
>> >> 
>> >> Thanks, it did not hang, it always reset to firmware/grub boot menu.
>> >> I'm pretty sure now the bug exists in get_rsdp_addr().
>> >
>> >static acpi_physical_address kexec_get_rsdp_addr(void)
>> >{
>> >...
>> >        /* Get systab from boot params. */
>> >        systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
>> >        if (!systab)
>> >              error("EFI system table not found in kexec boot_params.");
>> > 
>> >...
>> >  -> add error("hang me") here will have a hang
>> >...
>> >        return __efi_get_rsdp_addr((unsigned long)esd->tables,
>> >                                   systab->nr_tables, true);
>> > 
>> 
>> I have an idea, but not sure whether is a problem.
>> In code of Nomura:
>> 
>> #if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
>> [...]
>>         if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
>>                 debug_putstr("Wrong kexec EFI loader signature.\n");
>>                 return 0;
>>         }
>> 
>>         /* Get systab from boot params. */
>>         systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
>> [...]
>> #endif
>> 
>> After review agian, I wonder what will happen if 32bit-efi boot 64bit
>> OS.
>
>It is hard to find 32bit efi hardware, I can confirm all the laptop I
>have are 64bit efi.
>
>In case 32bit efi EFI64_LOADER_SIGNATURE checking will be false.

Yes, just when reviewing code, I notice this problem.

Thanks,
Chao Fan
>
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
