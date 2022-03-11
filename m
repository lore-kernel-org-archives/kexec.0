From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 11 Mar 2022 16:26:14 +0100
Subject: [PATCH] kexec/powerpc: fix exporting memory limit
In-Reply-To: <201403070838.07820@blacky.localdomain>
References: <1394115854-11709-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <1394153258.21206.1.camel@concordia> <201403070838.07820@blacky.localdomain>
Message-ID: <cca14ed0-0fc3-a286-9b06-621cff20a447@csgroup.eu>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



Le 07/03/2014 ? 05:38, Nikita Yushchenko a ?crit?:
>> On Thu, 2014-03-06 at 18:24 +0400, Nikita Yushchenko wrote:
>>> When preparing dump-capturing kernel, kexec userspace tool needs to
>>> know actual amount of memory used by the running kernel. This may
>>> differ from extire available DRAM for a couple of reasons. To address
>>> this issue, kdump kernel support code injects several attributes into
>>> device tree that are later captured by userspace kexec tool via /proc
>>> interface.
>>>
>>> One such attrubute is 'chosen/linux,memory_limit' that is used to pass
>>> memory limit of the running kernel.
>>>
>>> This was initialized using kernel's 'memory_limit' variable, that is
>>> set by early init code based on mem= kernel parameter and other
>>> reasons.
>>>
>>> But there are cases when memory_limit variable does not contain proper
>>> information. One such case is when !CONFIG_HIGHMEM kernel runs on
>>> system with memory large enough not to fit into lowmem.
>>
>> Why doesn't the !CONFIG_HIGHMEM code update memory_limit to reflect
>> reality.
> 
> I guess because memory_limit is used for ... well, memory limit, set by
> mem=. And for the rest memblock is used (and it *is* updated).
> 
> And code elsewhere does use memblock, see e.g. numa_enforce_memory_limit()
> in arch/powerpc/mm/numa.c
> 
> In MMU init (MMU_init() in arch/powerpc/mm/init_32.c -which is the point
> where final memory configuration is set) memblock, not memory_limit, is
> both used and updated.


We still have this patch as "New" in patchwork.

I don't know if it is relevant but directory structure has changed so if 
still needed this patch needs rebase.

Christophe

