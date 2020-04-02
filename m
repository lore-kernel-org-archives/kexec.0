Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJt85-00074j-Qv
 for kexec@lists.infradead.org; Thu, 02 Apr 2020 06:15:08 +0000
Subject: Re: [PATCH 2/3] mm/memory_hotplug: Allow arch override of non boot
 memory resource names
References: <20200326180730.4754-1-james.morse@arm.com>
 <20200326180730.4754-3-james.morse@arm.com>
 <20200402054946.GA97238@dhcp-128-65.nay.redhat.com>
From: piliu <piliu@redhat.com>
Message-ID: <9725d779-e0de-2d8d-8716-22df3e791820@redhat.com>
Date: Thu, 2 Apr 2020 14:12:39 +0800
MIME-Version: 1.0
In-Reply-To: <20200402054946.GA97238@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, Hari Bathini <hbathini@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org



On 04/02/2020 01:49 PM, Dave Young wrote:
> On 03/26/20 at 06:07pm, James Morse wrote:
>> Memory added to the system by hotplug has a 'System RAM' resource created
>> for it. This is exposed to user-space via /proc/iomem.
>>
>> This poses problems for kexec on arm64. If kexec decides to place the
>> kernel in one of these newly onlined regions, the new kernel will find
>> itself booting from a region not described as memory in the firmware
>> tables.
>>
>> Arm64 doesn't have a structure like the e820 memory map that can be
>> re-written when memory is brought online. Instead arm64 uses the UEFI
>> memory map, or the memory node from the DT, sometimes both. We never
>> rewrite these.
> 
> Could arm64 use similar way to update DT, or a cooked UEFI maps?
> 
> Add pingfan in cc, he said ppc64 update the DT after a memremove thus it
> would be good to just redo a kexec load.
> 
Yes, the memory changes will be observed through device-node under
/proc/device-tree/ (which is for powerpc).

Later if running kexec -l/-p , it can build new dtb with the latest info
from /proc/device-tree
> Added Pingfan and Hari for comments and corrections.
> 
>>
>> Allow an architecture to specify a different name for these hotplug
>> regions.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> ---
>>  mm/memory_hotplug.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 0a54ffac8c68..69b03dd7fc74 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -42,6 +42,10 @@
>>  #include "internal.h"
>>  #include "shuffle.h"
>>  
>> +#ifndef MEMORY_HOTPLUG_RES_NAME
>> +#define MEMORY_HOTPLUG_RES_NAME "System RAM"
>> +#endif
>> +
>>  /*
>>   * online_page_callback contains pointer to current page onlining function.
>>   * Initially it is generic_online_page(). If it is required it could be
>> @@ -103,7 +107,7 @@ static struct resource *register_memory_resource(u64 start, u64 size)
>>  {
>>  	struct resource *res;
>>  	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> -	char *resource_name = "System RAM";
>> +	char *resource_name = MEMORY_HOTPLUG_RES_NAME;
>>  
>>  	if (start + size > max_mem_size)
>>  		return ERR_PTR(-E2BIG);
>> -- 
>> 2.25.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
