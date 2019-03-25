Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8OmD-0007MY-4h
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 12:32:30 +0000
Date: Mon, 25 Mar 2019 13:32:29 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190325123229.GL12016@zn.tnic>
References: <20190325060128.GB9385@dhcp-128-65.nay.redhat.com>
 <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
 <bcb5bd29-a3b8-e42d-8da7-a8501f695c21@ce.jp.nec.com>
 <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Mar 25, 2019 at 08:23:02PM +0800, Dave Young wrote:
> efi_enter_virtual_mode() can only run once because of efi firmware/spec
> limitation,  and after entered virtual mode, efi firmware just updated

I should remember that - I did it at the time.

> Kexec saved the original physical addresses, and pass them to kexeced
> kernel via x86 setup_data, so  both the early parsing or efi init code
> need to get those physical values from setup_data.

So efi_get_rsdp_addr() needs to be refactored in such a way so that at
least the loop towards the end gets carved out into a separate function
- __efi_get_rsdp_addr() or so - which gets config_tables, nr_tables and
size as arguments and finds the RSDP address in the kexec-ed kernel.

So we'd need something like that:

acpi_physical_address get_rsdp_addr(void)
{
        acpi_physical_address pa;

        pa = get_acpi_rsdp();

        if (!pa)
                pa = boot_params->acpi_rsdp_addr;

        if (!pa)
                pa = efi_get_rsdp_addr();

	if (!pa)
		pa = kexec_get_rdsp_addr();		<--- new function

        if (!pa)
                pa = bios_get_rsdp_addr();

        return pa;
}

which would get config_tables from setup_data and call
__efi_get_rsdp_addr() to dig it out in the kexec'ed kernel.

Junichi, ask if it is still unclear what needs to be done.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
