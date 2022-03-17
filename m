From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Thu, 17 Mar 2022 16:16:07 +0530
Subject: [PATCH v5 4/8] crash: generic crash hotplug support infrastructure
In-Reply-To: <2ca17bd8-fc81-19e2-7a16-e458ce8a097e@oracle.com>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <1b7405e4-e6a3-56ff-5068-d598ba2f2b5e@linux.ibm.com>
 <2ca17bd8-fc81-19e2-7a16-e458ce8a097e@oracle.com>
Message-ID: <79d08021-699a-016e-6ff3-15b67efa895d@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org


On 15/03/22 19:42, Eric DeVolder wrote:
>
>
> On 3/15/22 07:08, Sourabh Jain wrote:
>> Hello Eric,
>>
>> On 03/03/22 21:57, Eric DeVolder wrote:
>>> This patch introduces a generic crash hot plug/unplug infrastructure
>>> for CPU and memory changes. Upon CPU and memory changes, a generic
>>> crash_hotplug_handler() obtains the appropriate lock, does some
>>> important house keeping and then dispatches the hot plug/unplug event
>>> to the architecture specific arch_crash_hotplug_handler(), and when
>>> that handler returns, the lock is released.
>>>
>>> This patch modifies crash_core.c to implement a subsys_initcall()
>>> function that installs handlers for hot plug/unplug events. If CPU
>>> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
>>> handler for CPU changes. Similarly, if memory hotplug is enabled, then
>>> register_memory_notifier() is invoked to install a handler for memory
>>> changes. These handlers in turn invoke the common generic handler
>>> crash_hotplug_handler().
>>>
>>> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
>>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>>> the CPU still shows up in foreach_present_cpu() during the regeneration
>>> of the new CPU list, thus the need to explicitly check and exclude the
>>> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>>>
>>> On the memory side, each un/plugged memory block passes through the
>>> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
>>> memory events, one for each 128MiB memblock.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> ---
>>> ? include/linux/kexec.h |? 16 +++++++
>>> ? kernel/crash_core.c?? | 108 
>>> ++++++++++++++++++++++++++++++++++++++++++
>>> ? 2 files changed, 124 insertions(+)
>>>
>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>> index d7b59248441b..b11d75a6b2bc 100644
>>> --- a/include/linux/kexec.h
>>> +++ b/include/linux/kexec.h
>>> @@ -300,6 +300,13 @@ struct kimage {
>>> ????? /* Information for loading purgatory */
>>> ????? struct purgatory_info purgatory_info;
>>> +
>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>> +??? bool hotplug_event;
>>> +??? int offlinecpu;
>>> +??? bool elf_index_valid;
>>> +??? int elf_index;
>>
>> How about keeping an array to track all kexec segment index need to 
>> be updated in
>> crash hotplug handler.
>>
>> struct hp_segment {
>> ??? name;
>> ??? index;
>> ??? is_valid;
>> ??}
>>
>> It will be helpful if architecture need to updated multiple kexec 
>> segments? for a hotplug event.
>>
>> For example, on PowerPC, we might need to update FDT and elfcorehdr 
>> on memory hot plug/unplug.
>>
>> Thanks,
>> Sourabh Jain
>
> Sourabh,
> I'm OK with that. Another idea might be if there are just two, and one 
> of them is elfcorehdr, then perhaps in addition to elf_index and 
> elf_index_valid, maybe we add an arch_index and arch_index_valid? In 
> the case of PPC, the FDT would be stored in arch_index?

Yes it seems like we might not need to keep more than two kexec indexes. 
Since this indexes are arch specific lets push them to struct 
kimage_arch (part of kimage). So for now I will push fdt_index to struct 
kimage_arch.

Thanks,
Sourabh Jain


