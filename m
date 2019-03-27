Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8xgX-0001tS-Vk
 for kexec@lists.infradead.org; Wed, 27 Mar 2019 01:48:59 +0000
Date: Wed, 27 Mar 2019 09:48:52 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v2] x86/boot: Use EFI setup data if provided
Message-ID: <20190327014852.GA3659@MiWiFi-R3L-srv>
References: <20190325065921.GA11096@dhcp-128-65.nay.redhat.com>
 <20190325082720.GA20771@jeru.linux.bs1.fc.nec.co.jp>
 <51D9A7D1-49BF-4679-B102-0FC5AC300C9F@alien8.de>
 <20190325101509.GA13160@dhcp-128-65.nay.redhat.com>
 <701c8e69-e1d4-c653-1d87-1c41789d3d54@ce.jp.nec.com>
 <20190325120149.GI12016@zn.tnic>
 <20190325122302.GC13160@dhcp-128-65.nay.redhat.com>
 <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190326135714.GG1867@zn.tnic>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>, Borislav Petkov <bp@alien8.de>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>

Hi Junichi,

On 03/26/19 at 02:57pm, Borislav Petkov wrote:
> On Mon, Mar 25, 2019 at 11:10:01PM +0000, Junichi Nomura wrote:
> > efi_get_rsdp_addr() and kexec_get_rsdp_addr() could be implemented
> > like this (sorry about the pseudo code):
> 
> This doesn't look like what I suggested:
> 
> > So efi_get_rsdp_addr() needs to be refactored in such a way so that at
> > least the loop towards the end gets carved out into a separate function
> > - __efi_get_rsdp_addr() or so - which gets config_tables, nr_tables and
> > size as arguments and finds the RSDP address in the kexec-ed kernel.
> 
> You need to carve out the loop at the end and make it into a separate
> __efi_get_rsdp_addr() function which gets the physical or the virtual
> address.

I guess Boris is suggesting code like below. Please correct me if I am
wrong.

static acpi_physical_address _efi_get_rsdp_addr(efi_config_table tbl, ...)
{
	/* Get EFI tables from systab. */
	for (i = 0; i < nr_tables; i++) {
		...
	}
	return rsdp_addr;
}

static acpi_physical_address efi_get_rsdp_addr(void)
{
	...
	/* Get systab from boot params. */		
	...
	/* Handle EFI bitness properly */
	...
	return _efi_get_rsdp_addr();
}


static acpi_physical_address kexec_get_rsdp_addr(void)
{
	if (!is_kexec_booted)
		return 0;

	efi_get_setup_data_addr();
	...
	/* Handle EFI bitness properly */
	...
	return _efi_get_rsdp_addr();
}

acpi_physical_address get_rsdp_addr(void)
{
        acpi_physical_address pa;

        pa = get_acpi_rsdp();

        if (!pa)
                pa = boot_params->acpi_rsdp_addr;


	/**
	/*I think here we should check if it's kexec booted firstly.
	 * Skip it if not kexec. this can avoid the wrong kexec virt
	 * addr parsing./
        if (!pa)
                pa = kexec_get_rdsp_addr();             <--- new function

        if (!pa)
                pa = efi_get_rsdp_addr();

        if (!pa)
                pa = bios_get_rsdp_addr();

        return pa;
}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
