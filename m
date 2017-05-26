Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam01on0081.outbound.protection.outlook.com
 ([104.47.32.81] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dEI11-0001Pt-1u
 for kexec@lists.infradead.org; Fri, 26 May 2017 16:23:04 +0000
Subject: Re: [PATCH v5 17/32] x86/mm: Add support to access boot related data
 in the clear
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211921.10190.1537.stgit@tlendack-t1.amdoffice.net>
 <20170515183517.mb4k2gp2qobbuvtm@pd.tnic>
 <20170518195051.GA5651@codeblueprint.co.uk>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4c2ef3ba-2940-3330-d362-5b2b0d812c6f@amd.com>
Date: Fri, 26 May 2017 11:22:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170518195051.GA5651@codeblueprint.co.uk>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matt Fleming <matt@codeblueprint.co.uk>, Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 5/18/2017 2:50 PM, Matt Fleming wrote:
> On Mon, 15 May, at 08:35:17PM, Borislav Petkov wrote:
>> On Tue, Apr 18, 2017 at 04:19:21PM -0500, Tom Lendacky wrote:
>>
>>> +		paddr = boot_params.efi_info.efi_memmap_hi;
>>> +		paddr <<= 32;
>>> +		paddr |= boot_params.efi_info.efi_memmap;
>>> +		if (phys_addr == paddr)
>>> +			return true;
>>> +
>>> +		paddr = boot_params.efi_info.efi_systab_hi;
>>> +		paddr <<= 32;
>>> +		paddr |= boot_params.efi_info.efi_systab;
>>
>> So those two above look like could be two global vars which are
>> initialized somewhere in the EFI init path:
>>
>> efi_memmap_phys and efi_systab_phys or so.
>>
>> Matt ?
>>
>> And then you won't need to create that paddr each time on the fly. I
>> mean, it's not a lot of instructions but still...
>
> We should already have the physical memmap address available in
> 'efi.memmap.phys_map'.

Unfortunately memremap_is_efi_data() is called before the efi structure
gets initialized, so I can't use that value.

>
> And the physical address of the system table should be in
> 'efi_phys.systab'. See efi_init().

In addition to the same issue as efi.memmap.phys_map, efi_phys has
the __initdata attribute so it will be released/freed which will cause
problems in checks performed afterwards.

Thanks,
Tom

>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
