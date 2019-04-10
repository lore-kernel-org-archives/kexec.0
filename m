Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEMm3-00084B-8s
 for kexec@lists.infradead.org; Wed, 10 Apr 2019 23:37:01 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Date: Wed, 10 Apr 2019 23:34:51 +0000
Message-ID: <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
 <20190410171431.GE26580@zn.tnic>
In-Reply-To: <20190410171431.GE26580@zn.tnic>
Content-Language: ja-JP
Content-ID: <42379DDBC7FCB549917A8ED9EFB6AABE@gisp.nec.co.jp>
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

On 4/11/19 2:14 AM, Borislav Petkov wrote:
> On Mon, Apr 08, 2019 at 11:10:17PM +0000, Junichi Nomura wrote:
>> -#ifdef CONFIG_EFI
>> -	unsigned long systab, systab_tables, config_tables;
>> -	unsigned int nr_tables;
>> +static void efi_read_boot_params(void)
>> +{
>> +	struct efi_setup_data *esd;
>>  	struct efi_info *ei;
>> -	bool efi_64;
>> -	int size, i;
>>  	char *sig;
>>  
>> +	kexec_efi_setup_data = efi_get_kexec_setup_data_addr();
> 
> Why is that written here and tested in another function?!?

Both efi_get_rsdp_addr() and kexec_get_rsdp_addr() need to check
the result of efi_get_kexec_setup_data_addr(); the former to check
whether to exit early, the latter to use the address of the tables.
I thought it's better to store the result instead of calling twice.

>> +
>>  	ei = &boot_params->efi_info;
>>  	sig = (char *)&ei->efi_loader_signature;
>>  
>>  	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
>>  		efi_64 = true;
>> +		efi_booted = true;
> 
> What is that ugliness for? Have you heard of functions returning values?

Same as above. I didn't want to do signature check twice, in
efi_get_rsdp_addr() and kexec_get_rsdp_addr().
Also, the signature check has 2 return values, whether it was 32bit
or 64bit, and whether the signature was valid or not.
I could return one of them via pointer passed parameter but I thought
it's a little bit ugly.  Or I could encode them as something like
EFI_SIGNATURE_64, EFI_SIGNATURE_32, and EFI_SIGNATURE_INVALID.
But I'm not sure it's good to introduce such a thing just for here.

>> +static acpi_physical_address efi_get_rsdp_addr(void)
>> +{
>> +#ifdef CONFIG_EFI
>> +	unsigned long config_tables;
>> +	unsigned int nr_tables;
>> +
>> +	efi_read_boot_params();
> 
> Why do you read boot params here?
> 
> No, no, no.
> 
> First you do
> 
> 	efi_get_rsdp_addr()
> 
> if you cannot get an address, you

But efi_get_rsdp_addr() needs to check whether the kernel was
kexec booted to avoid accessing invalid EFI table address.
efi_get_kexec_setup_data_addr() is the only method I know
to check if it was kexec-booted.

> 	- parse boot params
> 	- then parse EFI tables from the address the kexeced kernel received
> 
> No intermixing of code paths and assigning variables in one function and
> using them in another.

Yeah, I don't like that. But if we are to handle 32bit EFI case,
efi_get_rsdp_addr() and kexec_get_rsdp_addr() become full of
duplication.

> You were on the right track with v3...

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
