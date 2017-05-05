Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d6XjK-0001WK-6L
 for kexec@lists.infradead.org; Fri, 05 May 2017 07:32:47 +0000
Subject: Re: [PATCH v3 2/2] x86_64/kexec: Use PUD level 1GB page for identity
 mapping if available
References: <1493862171-8799-1-git-send-email-xlpang@redhat.com>
 <1493862171-8799-2-git-send-email-xlpang@redhat.com>
 <20170505065253.s5yv7c2cxgfcf4i3@gmail.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <590C2A96.3090106@redhat.com>
Date: Fri, 5 May 2017 15:32:38 +0800
MIME-Version: 1.0
In-Reply-To: <20170505065253.s5yv7c2cxgfcf4i3@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>, Xunlei Pang <xlpang@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On 05/05/2017 at 02:52 PM, Ingo Molnar wrote:
> * Xunlei Pang <xlpang@redhat.com> wrote:
>
>> @@ -122,6 +122,10 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>>  
>>  	level4p = (pgd_t *)__va(start_pgtable);
>>  	clear_page(level4p);
>> +
>> +	if (direct_gbpages)
>> +		info.direct_gbpages = true;
> No, this should be keyed off the CPU feature (X86_FEATURE_GBPAGES) automatically, 
> not set blindly! AFAICS this patch will crash kexec on any CPU that does not 
> support gbpages.

It should be fine, probe_page_size_mask() already takes care of this:
    if (direct_gbpages && boot_cpu_has(X86_FEATURE_GBPAGES)) {
        printk(KERN_INFO "Using GB pages for direct mapping\n");
        page_size_mask |= 1 << PG_LEVEL_1G;
    } else {
        direct_gbpages = 0;
    }

So if X86_FEATURE_GBPAGES is not supported, direct_gbpages will be set to 0.

>
> I only noticed this problem after having fixed/enhanced all the changelogs - so 
> please pick up the new changelog up from the log below.

Thanks for the rewrite, it looks better.

Regards,
Xunlei

>
> Thanks,
>
> 	Ingo
>
>
> ============================>
>
> Author: Xunlei Pang <xlpang@redhat.com>
>
> x86/mm: Add support for gbpages to kernel_ident_mapping_init()
>
> Kernel identity mappings on x86-64 kernels are created in two
> ways: by the early x86 boot code, or by kernel_ident_mapping_init().
>
> Native kernels (which is the dominant usecase) use the former,
> but the kexec and the hibernation code uses kernel_ident_mapping_init().
>
> There's a subtle difference between these two ways of how identity
> mappings are created, the current kernel_ident_mapping_init() code
> creates identity mappings always using 2MB page(PMD level) - while
> the native kernel boot path also utilizes gbpages where available.
>
> This difference is suboptimal both for performance and for memory
> usage: kernel_ident_mapping_init() needs to allocate pages for the
> page tables when creating the new identity mappings.
>
> This patch adds 1GB page(PUD level) support to kernel_ident_mapping_init()
> to address these concerns.
>
> The primary advantage would be better TLB coverage/performance,
> because we'd utilize 1GB TLBs instead of 2MB ones.
>
> It is also useful for machines with large number of memory to
> save paging structure allocations(around 4MB/TB using 2MB page)
> when setting identity mappings for all the memory, after using
> 1GB page it will consume only 8KB/TB.
>
> ( Note that this change alone does not activate gbpages in kexec,
>   we are doing that in a separate patch. )
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
