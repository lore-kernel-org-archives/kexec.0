Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fh9RL-0000XZ-3M
 for kexec@lists.infradead.org; Sun, 22 Jul 2018 08:10:04 +0000
Received: by mail-lf1-f65.google.com with SMTP id l16-v6so4369945lfc.13
 for <kexec@lists.infradead.org>; Sun, 22 Jul 2018 01:09:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bf9dee4f-852d-fc6b-999a-02ea99dceb4d@redhat.com>
References: <1531979021-31780-1-git-send-email-bhsharma@redhat.com>
 <1531979021-31780-2-git-send-email-bhsharma@redhat.com>
 <bf9dee4f-852d-fc6b-999a-02ea99dceb4d@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Sun, 22 Jul 2018 13:14:41 +0530
Message-ID: <CACi5LpOKQ9TX9yWus6i9ZG_Ha8A+vPqs09o1Jh0B9O5vYED9BA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Get 'info->page_offset' from PT_LOAD segments
 to support KASLR boot cases
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>

Hello Kazu,

Many thanks for your review comments.

On Sat, Jul 21, 2018 at 3:18 AM, Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
>
> On 7/19/2018 1:43 AM, Bhupesh Sharma wrote:
>> The existing methodology to obtain 'info->page_offset' from reading
>> _stext symbol (from kallsyms) doesn't work well in KASLR boot cases on
>> arm64 machines as the PAGE_OFFSET (or the virtual address which
>> indicates the start of the linear region) can be randomized as well
>> on basis of the kaslr-seed.
>>
>> Since the value of PAGE_OFFSET inside the kernel is randomized in such
>> cases and there is no existing mechanism of conveying this value from
>> kernel-space to user-space, so we can use the method used by archs like
>> x86_64 to generate the 'info->page_offset' value from the PT_LOAD
>> segments by subtracting the phy_addr from virt_addr of a PT_LOAD
>> segment.
>>
>> This approach works fine both with KASLR and non-KASLR boot cases.
>>
>> I tested this on my qualcomm-amberwing board. Here are some logs from
>> the KASLR boot cases:
>>
>> - Verify that the EFI firmware supports 'kaslr-seed':
>>
>>       chosen {
>>               kaslr-seed = <0x0 0x0>;
>>               <..snip..>
>>       };
>>
>> - Verify that '--mem-usage' works well after this fix as well (I used
>>   kernel 4.18.0-rc4+ for my checks):
>>
>> The kernel version is not supported.
>> The makedumpfile operation may be incomplete.
>>
>> TYPE          PAGES                   EXCLUDABLE      DESCRIPTION
>> ----------------------------------------------------------------------
>> ZERO          4396                    yes             Pages filled
>> with zero
>> NON_PRI_CACHE 27859                   yes             Cache pages
>> without private flag
>> PRI_CACHE     18490                   yes             Cache pages with
>> private flag
>> USER          2728                    yes             User process
>> pages
>> FREE          1465848                 yes             Free pages
>> KERN_DATA     18537                   no              Dumpable kernel
>> data
>>
>> page size:            65536
>> Total pages on system:        1537858
>> Total size on system: 100785061888     Byte
>>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>  arch/arm64.c   | 23 ++++++++++++++++++-----
>>  common.h       |  1 +
>>  makedumpfile.h |  1 +
>>  3 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64.c b/arch/arm64.c
>> index 2fd3e1874376..9e8c77c76935 100644
>> --- a/arch/arm64.c
>> +++ b/arch/arm64.c
>> @@ -265,6 +265,9 @@ get_xen_info_arm64(void)
>>  int
>>  get_versiondep_info_arm64(void)
>>  {
>> +     int i;
>> +     unsigned long long phys_start;
>> +     unsigned long long virt_start;
>>       ulong _stext;
>>
>>       _stext = get_stext_symbol();
>> @@ -289,12 +292,22 @@ get_versiondep_info_arm64(void)
>>               return FALSE;
>>       }
>>
>
>> -     info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
>> -
>> -     DEBUG_MSG("page_offset=%lx, va_bits=%d\n", info->page_offset,
>> -                     va_bits);
>
> According to makedumpfile commit 4944f93484 ("x86_64: Calculate page_offset
> in case of re-filtering/sadump/virsh dump"), in case of re-filtering,
> we don't have any PT_LOAD.  So, with this patch, we cannot re-filter
> dump file on arm64 system?
>
> If we cannot, is it better to leave the above behind the following
> pt_load section for re-filtering non-KASLR dump?
>
>> +     if (get_num_pt_loads()) {
>> +             for (i = 0;
>> +                     get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
>> +                     i++) {
>> +                     if (virt_start != NOT_KV_ADDR
>> +                                     && virt_start < __START_KERNEL_map
>> +                                     && phys_start != NOT_PADDR && phys_start != NOT_PADDR_ARM64) {
>> +                             info->page_offset = virt_start - phys_start;
>> +                             DEBUG_MSG("info->page_offset: %lx, VA_BITS: %d\n",
>> +                                             info->page_offset, va_bits);
>> +                             return TRUE;
>> +                     }
>> +             }
>> +     }
>
> I'll adjust some indents for readability.
>
>>
>> -     return TRUE;
>> +     return FALSE;
>>  }
>>
>>  /*
>> diff --git a/common.h b/common.h
>> index 6e2f657a79c7..a8181777dbb7 100644
>> --- a/common.h
>> +++ b/common.h
>> @@ -48,6 +48,7 @@
>>  #define NOT_MEMMAP_ADDR      (0x0)
>>  #define NOT_KV_ADDR  (0x0)
>>  #define NOT_PADDR    (ULONGLONG_MAX)
>
>> +#define NOT_PADDR_ARM64      (0x0000000010a80000UL)
>
> I think that this should not be in common.h, because it's not for
> arch-specific definitions, so I'll move it to makedumpfile.h.
>
>>  #define BADADDR      ((ulong)(-1))
>>
>>  #endif  /* COMMON_H */
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index 5ff94b8e4ac6..5297279f0f3b 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -2020,6 +2020,7 @@ struct domain_list {
>>  #define MFNS_PER_FRAME               (info->page_size / sizeof(unsigned long))
>>
>>  #ifdef __aarch64__
>> +#define __START_KERNEL_map           (0xffffffff80000000UL)
>
> This #ifdef here is for the definitions related to Xen extraction.
> I'll move it to the same place as the above.
>
>>  unsigned long long kvtop_xen_arm64(unsigned long kvaddr);
>>  #define kvtop_xen(X) kvtop_xen_arm64(X)
>>  #endif /* aarch64 */
>>
>
> I attached a patch that was applied my suggestions.
> How about it?

I agree. The patch looks good with the suggested changes.
Please go ahead and feel free to apply the modified patch.

Thanks a lot for your help.
Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
