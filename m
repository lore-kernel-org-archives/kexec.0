Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com
 ([104.47.41.57] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d7iaj-0005uz-Si
 for kexec@lists.infradead.org; Mon, 08 May 2017 13:20:48 +0000
Subject: Re: [PATCH v5 15/32] efi: Update efi_mem_type() to return an error
 rather than 0
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211900.10190.98158.stgit@tlendack-t1.amdoffice.net>
 <20170507171822.x7grrqg2tcvbv6j5@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <eb677bb2-ec20-c7a4-cd37-80f3f381981f@amd.com>
Date: Mon, 8 May 2017 08:20:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170507171822.x7grrqg2tcvbv6j5@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 5/7/2017 12:18 PM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:19:00PM -0500, Tom Lendacky wrote:
>> The efi_mem_type() function currently returns a 0, which maps to
>> EFI_RESERVED_TYPE, if the function is unable to find a memmap entry for
>> the supplied physical address. Returning EFI_RESERVED_TYPE implies that
>> a memmap entry exists, when it doesn't.  Instead of returning 0, change
>> the function to return a negative error value when no memmap entry is
>> found.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>
> ...
>
>> diff --git a/include/linux/efi.h b/include/linux/efi.h
>> index cd768a1..a27bb3f 100644
>> --- a/include/linux/efi.h
>> +++ b/include/linux/efi.h
>> @@ -973,7 +973,7 @@ static inline void efi_esrt_init(void) { }
>>  extern int efi_config_parse_tables(void *config_tables, int count, int sz,
>>  				   efi_config_table_type_t *arch_tables);
>>  extern u64 efi_get_iobase (void);
>> -extern u32 efi_mem_type (unsigned long phys_addr);
>> +extern int efi_mem_type (unsigned long phys_addr);
>
> WARNING: space prohibited between function name and open parenthesis '('
> #101: FILE: include/linux/efi.h:976:
> +extern int efi_mem_type (unsigned long phys_addr);
>
> Please integrate scripts/checkpatch.pl in your patch creation workflow.
> Some of the warnings/errors *actually* make sense.

I do/did run scripts/checkpatch.pl against all my patches. In this case
I chose to keep the space in order to stay consistent with some of the
surrounding functions.  No problem though, I can remove the space.

Thanks,
Tom

>
> I know, the other function prototypes have a space too but that's not
> our coding style. Looks like this trickled in from ia64, from looking at
> arch/ia64/kernel/efi.c.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
