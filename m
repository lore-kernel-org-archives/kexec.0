Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.molgen.mpg.de ([141.14.17.11] helo=mx1.molgen.mpg.de)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3dIP-0006mh-E0
 for kexec@lists.infradead.org; Fri, 30 Aug 2019 09:34:19 +0000
Subject: Re: [PATCH] x86: Fix PAGE_OFFSET for kernels since 4.20
References: <20190830091258.51133-1-buczek@molgen.mpg.de>
 <20190830092351.GE12242@MiWiFi-R3L-srv>
From: Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <99faeaab-a4ea-e204-f4e8-9b74f86e5e43@molgen.mpg.de>
Date: Fri, 30 Aug 2019 11:34:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190830092351.GE12242@MiWiFi-R3L-srv>
Content-Language: en-US
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
To: Baoquan He <bhe@redhat.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, horms@verge.net.au, kexec@lists.infradead.org, k-hagio@ab.jp.nec.com

Dear Baoquan,

On 8/30/19 11:23 AM, Baoquan He wrote:
> On 08/30/19 at 11:12am, Donald Buczek wrote:
>> Linux kernel commit d52888aa2753 ("x86/mm: Move LDT remap out of KASLR
>> region on 5-level paging") changed the base of the direct mapping
>> from 0xffff880000000000 to 0xffff888000000000. This was merged
>> into v4.20-rc2.
> 
> A good catch and necessary fix, thanks.
> 
> Does it have issue in makedumpfile?

We don't use makedumpfile. We use `cp /proc/vmcore /mnt/crash.vmcore` in the panic kernel.

Without this patch, the file /mnt/crash.vmcore has the wrong vaddr in the elf headers and can't be processed by gdb or crash.

With this patch, the file has the correct vaddr an can be processed by gdb and crash.

Btw:  I've got four strange error replies for my mail.

     Date: 30 Aug 2019 05:13:31 EDT
     From: MAILER_DAEMON@email.uscc.net
     To: buczek@molgen.mpg.de
         Message to 7867650283@email.uscc.net failed.

I hope, my patch reaches the right people anyway.

Best
   Donald


> 
> #ifdef __x86_64__
> #define __PAGE_OFFSET_ORIG      (0xffff810000000000) /* 2.6.26, or former */
> #define __PAGE_OFFSET_2_6_27    (0xffff880000000000) /* 2.6.27, or later  */
> #define __PAGE_OFFSET_5LEVEL    (0xff10000000000000) /* 5-level page table */
> ...
> #endif
> 
> Thanks
> Baoquan
> 
>>
>> Update to new address accordingly.
>> ---
>>   kexec/arch/i386/crashdump-x86.c | 2 ++
>>   kexec/arch/i386/crashdump-x86.h | 3 ++-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
>> index a2aea31..c79791f 100644
>> --- a/kexec/arch/i386/crashdump-x86.c
>> +++ b/kexec/arch/i386/crashdump-x86.c
>> @@ -61,6 +61,8 @@ static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
>>   
>>   		if (kv < KERNEL_VERSION(2, 6, 27))
>>   			elf_info->page_offset = X86_64_PAGE_OFFSET_PRE_2_6_27;
>> +		else if (kv < KERNEL_VERSION(4, 20, 0))
>> +			elf_info->page_offset = X86_64_PAGE_OFFSET_PRE_4_20_0;
>>   		else
>>   			elf_info->page_offset = X86_64_PAGE_OFFSET;
>>   	}
>> diff --git a/kexec/arch/i386/crashdump-x86.h b/kexec/arch/i386/crashdump-x86.h
>> index ddee19f..e4fdc82 100644
>> --- a/kexec/arch/i386/crashdump-x86.h
>> +++ b/kexec/arch/i386/crashdump-x86.h
>> @@ -13,7 +13,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
>>   
>>   #define X86_64__START_KERNEL_map	0xffffffff80000000ULL
>>   #define X86_64_PAGE_OFFSET_PRE_2_6_27	0xffff810000000000ULL
>> -#define X86_64_PAGE_OFFSET		0xffff880000000000ULL
>> +#define X86_64_PAGE_OFFSET_PRE_4_20_0	0xffff880000000000ULL
>> +#define X86_64_PAGE_OFFSET	0xffff888000000000ULL
>>   
>>   #define X86_64_MAXMEM        		0x3fffffffffffUL
>>   
>> -- 
>> 2.22.0
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
