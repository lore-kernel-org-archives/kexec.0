Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cortD-0006QZ-6U
 for kexec@lists.infradead.org; Fri, 17 Mar 2017 13:25:57 +0000
Received: by mail-it0-x235.google.com with SMTP id m27so25397816iti.1
 for <kexec@lists.infradead.org>; Fri, 17 Mar 2017 06:25:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317020951.GA3942@dhcp-128-65.nay.redhat.com>
References: <20170308201616.GC8598@vader>
 <20170309063806.GB17257@dhcp-128-65.nay.redhat.com>
 <20170309095408.GA17883@vader>
 <20170313073748.GA6332@dhcp-128-65.nay.redhat.com>
 <20170316124132.GF6261@codeblueprint.co.uk>
 <20170317020951.GA3942@dhcp-128-65.nay.redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 17 Mar 2017 13:25:33 +0000
Message-ID: <CAKv+Gu-tGaM=fCitv1h7qcM7V9qk9yTjM6-zrvsQq2ZscuqbxQ@mail.gmail.com>
Subject: Re: kexec regression since 4.9 caused by efi
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
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com

On 17 March 2017 at 02:09, Dave Young <dyoung@redhat.com> wrote:
> On 03/16/17 at 12:41pm, Matt Fleming wrote:
>> On Mon, 13 Mar, at 03:37:48PM, Dave Young wrote:
>> >
>> > Omar, could you try below patch? Looking at the efi_mem_desc_lookup, it is not
>> > correct to be used in efi_arch_mem_reserve, if it passed your test, I
>> > can rewrite patch log with more background and send it out:
>> >
>> >         for_each_efi_memory_desc(md) {
>> >             [snip]
>> >                 if (!(md->attribute & EFI_MEMORY_RUNTIME) &&
>> >                     md->type != EFI_BOOT_SERVICES_DATA &&
>> >                     md->type != EFI_RUNTIME_SERVICES_DATA) {
>> >                         continue;
>> >                 }
>> >
>> > In above code, it meant to get a md of EFI_MEMORY_RUNTIME of either boot
>> > data or runtime data, this is wrong for efi_mem_reserve, because we are
>> > reserving boot data which has no EFI_MEMORY_RUNTIME attribute at the
>> > running time. Just is happened to work and we did not capture the error.
>>
>> Wouldn't something like this be simpler?
>>
>> ---
>>
>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>> index 30031d5293c4..cdfe8c628959 100644
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -201,6 +201,10 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>>               return;
>>       }
>>
>> +     /* No need to reserve regions that will never be freed. */
>> +     if (md.attribute & EFI_MEMORY_RUNTIME)
>> +             return;
>> +
>
> Matt, I think it should be fine although I think the md type checking in
> efi_mem_desc_lookup() is causing confusion and not easy to understand..
>
> How about move the if chunk early like below because it seems no need
> to sanity check the addr + size any more if the md is still RUNTIME?
>
> --- linux-x86.orig/arch/x86/platform/efi/quirks.c
> +++ linux-x86/arch/x86/platform/efi/quirks.c
> @@ -196,6 +196,10 @@ void __init efi_arch_mem_reserve(phys_ad
>                 return;
>         }
>
> +       /* No need to reserve regions that will never be freed. */
> +       if (md.attribute & EFI_MEMORY_RUNTIME)
> +               return;
> +
>         if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
>                 pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
>                 return;
>

This way, we suppress the error it the region spans multiple
descriptors, and only the first one has the runtime attribute. So the
two patches are not equivalent. I don't have a strong preference
either way, though.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
