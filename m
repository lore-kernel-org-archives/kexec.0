Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-da0-f49.google.com ([209.85.210.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TeEDj-0004P3-Bb
 for kexec@lists.infradead.org; Fri, 30 Nov 2012 00:12:44 +0000
Received: by mail-da0-f49.google.com with SMTP id v40so5233083dad.36
 for <kexec@lists.infradead.org>; Thu, 29 Nov 2012 16:12:41 -0800 (PST)
Message-ID: <50B7F9F6.1030806@gmail.com>
Date: Thu, 29 Nov 2012 16:12:38 -0800
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: Fix compile errors in  crashdump-mips.c
References: <1354219369-10520-1-git-send-email-ddaney.cavm@gmail.com>
 <20121130000243.GC21935@verge.net.au>
In-Reply-To: <20121130000243.GC21935@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, ralf@linux-mips.org, David Daney <ddaney.cavm@gmail.com>, David Daney <david.daney@cavium.com>

On 11/29/2012 04:02 PM, Simon Horman wrote:
> On Thu, Nov 29, 2012 at 12:02:49PM -0800, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> When building configured as '--host=mips64-octeon-linux-gnu' using
>> GCC-4.7.0 there are two compile errors, fix them.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>
> Thanks, is the first hunk also ok on 32bit?

Yes,  in crashdump.h kern_size is declared as type unsigned long, so the 
proper printf format is ABI independent and should be "%lx"

>
>> ---
>>   kexec/arch/mips/crashdump-mips.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
>> index f988698..6f9f6c6 100644
>> --- a/kexec/arch/mips/crashdump-mips.c
>> +++ b/kexec/arch/mips/crashdump-mips.c
>> @@ -83,7 +83,7 @@ static int get_kernel_vaddr_and_size(struct crash_elf_info *elf_info,
>>   		dbgprintf("kernel_vaddr= 0x%llx paddr %llx\n",
>>   				elf_info->kern_vaddr_start,
>>   				elf_info->kern_paddr_start);
>> -		dbgprintf("kernel size = 0x%llx\n", elf_info->kern_size);
>> +		dbgprintf("kernel size = 0x%lx\n", elf_info->kern_size);
>>   		return 0;
>>   		}
>>   	fprintf(stderr, "Cannot determine kernel virtual load addr and  size\n");
>> @@ -356,7 +356,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
>>   #ifdef __mips64
>>   	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
>>   		elf_info = &elf_info64;
>> -		crash_create = crash_create_elf64;
>> +		crash_create = crash_create_elf64_headers;
>>   		start_offset = 0xffffffff80000000UL;
>>   	}
>>   #endif
>> --
>> 1.7.11.7
>>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
