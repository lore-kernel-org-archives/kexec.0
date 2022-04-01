From: Eric DeVolder <eric.devolder@oracle.com>
Date: Fri, 1 Apr 2022 13:33:04 -0500
Subject: [PATCH v5 4/8] crash: generic crash hotplug support infrastructure
In-Reply-To: <YkJciuCXKuU4a4gp@MiWiFi-R3L-srv>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <20220324133856.GC354864@MiWiFi-R3L-srv>
 <20220324134911.GA354791@MiWiFi-R3L-srv>
 <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
 <20220324143300.GD354864@MiWiFi-R3L-srv>
 <8b68f5b6-f6e0-ca61-56cf-69046edce58d@oracle.com>
 <6f59af6a-8a70-85ce-b36c-38eb31503c7d@oracle.com>
 <YkJciuCXKuU4a4gp@MiWiFi-R3L-srv>
Message-ID: <0eed9aa8-1229-daca-330c-9d71f2b0688d@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 3/28/22 20:10, Baoquan He wrote:
> On 03/28/22 at 11:08am, Eric DeVolder wrote:
>> Baoquan, a comment below.
>> eric
>>
>> On 3/24/22 09:37, Eric DeVolder wrote:
>>>
>>>
>>> On 3/24/22 09:33, Baoquan He wrote:
>>>> On 03/24/22 at 08:53am, Eric DeVolder wrote:
>>>>> Baoquan,
>>>>> Thanks, I've offered a minor correction below.
>>>>> eric
>>>>>
>>>>> On 3/24/22 08:49, Baoquan He wrote:
>>>>>> On 03/24/22 at 09:38pm, Baoquan He wrote:
>>>>>>> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>>>>>>>> This patch introduces a generic crash hot plug/unplug infrastructure
>>>>>>>> for CPU and memory changes. Upon CPU and memory changes, a generic
>>>>>>>> crash_hotplug_handler() obtains the appropriate lock, does some
>>>>>>>> important house keeping and then dispatches the hot plug/unplug event
>>>>>>>> to the architecture specific arch_crash_hotplug_handler(), and when
>>>>>>>> that handler returns, the lock is released.
>>>>>>>>
>>>>>>>> This patch modifies crash_core.c to implement a subsys_initcall()
>>>>>>>> function that installs handlers for hot plug/unplug events. If CPU
>>>>>>>> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
>>>>>>>> handler for CPU changes. Similarly, if memory hotplug is enabled, then
>>>>>>>> register_memory_notifier() is invoked to install a handler for memory
>>>>>>>> changes. These handlers in turn invoke the common generic handler
>>>>>>>> crash_hotplug_handler().
>>>>>>>>
>>>>>>>> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
>>>>>>>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>>>>>>>> the CPU still shows up in foreach_present_cpu() during the regeneration
>>>>>>>> of the new CPU list, thus the need to explicitly check and exclude the
>>>>>>>> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>>>>>>>>
>>>>>>>> On the memory side, each un/plugged memory block passes through the
>>>>>>>> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
>>>>>>>> memory events, one for each 128MiB memblock.
>>>>>>>
>>>>>>> I rewrite the log as below with my understanding. Hope it's simpler to
>>>>>>> help people get what's going on here. Please consider to take if it's
>>>>>>> OK to you or adjust based on this. The code looks good to me.
>>>>>>>
>>>>>> Made some tuning:
>>>>>>
>>>>>> crash: add generic infrastructure for crash hotplug support
>>>>>>
>>>>>> Upon CPU and memory changes, a generic crash_hotplug_handler() is added
>>>>>> to dispatch the hot plug/unplug event to the architecture specific
>>>>>> arch_crash_hotplug_handler(). During the process, kexec_mutex need be
>>>>>> held.
>>>>>>
>>>>>> To support cpu hotplug, one callback pair are registered to capture
>>>>>> KEXEC_CRASH_HP_ADD_CPU and KEXEC_CRASH_HP_REMOVE_CPU events via
>>>>>> cpuhp_setup_state_nocalls().
>>>>> s/KEXEC_CRASH_HP_ADD}REMOVE_CPU/CPUHP_AP_ONLINE_DYN/ as the KEXEC_CRASH are the
>>>>> names I've introduced with this patch?
>>>>
>>>> Right.

Updated commit message.

>>>>
>>>> While checking it, I notice hp_action which you don't use actually.
>>>> Can you reconsider that part of design, the hp_action, the a, b
>>>> parameter passed to handler?
>>>
>>> Sure I can remove. I initially put in there as this was generic
>>> infrastructure and not sure if it would benefit others.
>>> eric
>>>
>>
>> Actually, I will keep the hp_action as the work by Sourabh Jain for PPC uses
>> the hp_action. I'll drop the a and b.
> 
> Sounds great.

Turns out hp_action and a are utilized, so I just left it alone. If you'd rather I remove b, I can 
do so.

> 
>>
>> Also, shall I post v6, or are you still looking at patches 7 and 8?
> 
> Will check today, thanks for the effort.
> 

