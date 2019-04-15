Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGAbC-0002hy-Pz
 for kexec@lists.infradead.org; Mon, 15 Apr 2019 23:01:16 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Mon, 15 Apr 2019 23:00:25 +0000
Message-ID: <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
References: <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
In-Reply-To: <20190415102525.GB29317@zn.tnic>
Content-Language: ja-JP
Content-ID: <0BE12C17A1481C41BD1411DC7C61D5DC@gisp.nec.co.jp>
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
To: Borislav Petkov <bp@alien8.de>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>

On 4/15/19 7:25 PM, Borislav Petkov wrote:
> On Mon, Apr 15, 2019 at 11:07:17AM +0200, Borislav Petkov wrote:
>> On Mon, Apr 15, 2019 at 07:01:54AM +0000, Junichi Nomura wrote:
>>> OK. Then I'll go back to v3 and make sure to hang when
>>> something is wrong during kexec boot on EFI system.
>>
>> No need - I have it here locally. I'll clean it up and post it for
>> review.
> 
> Here it is. Ok, not ok?

Thank you.  Basically ok.
I put some comments below about whether to hang or return.

> +static acpi_physical_address kexec_get_rsdp_addr(void)
> +{
> +	efi_system_table_64_t *systab;
> +	struct efi_setup_data *esd;
> +	struct efi_info *ei;
> +	char *sig;
> +
> +	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
> +	if (!esd)
> +		return 0;
> +
> +	if (!esd->tables) {
> +		debug_putstr("Wrong kexec SETUP_EFI data.\n");
> +		return 0;
> +	}

I thought we should hang here instead of return so that we
don't run into efi_get_rsdp_addr() in case of kexec.

> +	ei = &boot_params->efi_info;
> +	sig = (char *)&ei->efi_loader_signature;
> +	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
> +		debug_putstr("Wrong kexec EFI loader signature.\n");
> +		return 0;
> +	}

Same here.

> +	/* Get systab from boot params. */
> +	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
> +	if (!systab)
> +		error("EFI system table not found in kexec boot_params.");
> +
> +	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);

Same here when __efi_get_rsdp_addr() returns 0.

I'm fine with either way, though.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
