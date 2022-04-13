From: Eric DeVolder <eric.devolder@oracle.com>
Date: Wed, 13 Apr 2022 07:37:16 -0500
Subject: [PATCH v6 4/8] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <YlY4SlF07iH08Qnj@MiWiFi-R3L-srv>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-5-eric.devolder@oracle.com>
 <YlPy8CKU4zHsx6Bc@MiWiFi-R3L-srv>
 <821b3c62-eedf-c1a3-4aba-671c90d83288@oracle.com>
 <YlY4SlF07iH08Qnj@MiWiFi-R3L-srv>
Message-ID: <d3ae80cd-7e1f-50e3-d90d-becf779788c0@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 4/12/22 21:41, Baoquan He wrote:
> On 04/11/22 at 08:54am, Eric DeVolder wrote:
>>
>>
>> On 4/11/22 04:20, Baoquan He wrote:
>>> Hi Eric,
>>>
>>> On 04/01/22 at 02:30pm, Eric DeVolder wrote:
>>> ... ...
>>>
>>>> +static void crash_hotplug_handler(unsigned int hp_action,
>>>> +	unsigned long a, unsigned long b)
>>>
>>> I am still struggling to consider if these unused parameters should be
>>> kept or removed. Do you foresee or feel on which ARCH they could be used?
>>>
>>> Considering our elfcorehdr updating method, once memory or cpu changed,
>>> we will update elfcorehdr and cpu notes to reflect all existing memory
>>> regions and cpu in the current system. We could end up with having them
>>> but never being used. Then we may finally need to clean them up.
>>>
>>> If you have investigated and foresee or feel they could be used on a
>>> certain architecture, we can keep them for the time being.
>>
>> So 'hp_action' and 'a' are used within the existing patch series.
>> In crash_core.c, there is this bit of code:
>>
>> +       kexec_crash_image->offlinecpu =
>> +           (hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
>> +               (unsigned int)a : ~0U;
>>
>> which is referencing both 'hp_action' and using 'a' from the cpu notifier handler.
>> I looked into removing 'a' and setting offlinecpu directly, but I thought
>> it better that offlinecpu be set within the safety of the kexec_mutex.
>> Also, Sourabh Jain's work with PowerPC utilizing this framework directly
>> references hp_action in the arch-specific handler.
>>
>> The cpu and memory notifier handlers set hp_action accordingly. For cpu handler,
>> the 'a' is set with the impacted cpu. For memory handler, 'a' and 'b' form the
>> impacted memory range. I agree it looks like the memory range is currently
>> not useful.
> 
> OK, memory handler doesn't need the action, memory regions. While cpu
> handler needs it to exclude the hot plugged cpu.
> 
> We could have two ways to acheive this as below. How do you think about
> them?
> 
> static void crash_hotplug_handler(unsigned int hp_action,
>          unsigned long cpu)
> 
> static int crash_memhp_notifier(struct notifier_block *nb,
>          unsigned long val, void *v)
> {
> ......
>          switch (val) {
>          case MEM_ONLINE:
>                  crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>                          -1UL);
>                  break;
> 
>          case MEM_OFFLINE:
>                  crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>                          -1UL);
>                  break;
>          }
>          return NOTIFY_OK;
> }
> 
> static int crash_cpuhp_online(unsigned int cpu)
> {
>          crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu);
>          return 0;
> }
> 
> static int crash_cpuhp_offline(unsigned int cpu)
> {
>          crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>          return 0;
> }

I'm OK with the above. Shall I post v7 or are you still looking at patches 7 and 8?
Thanks!
Eric

> 
> OR,
> 
> static void crash_hotplug_handler(unsigned int hp_action,
>          int* cpu)
> 
> static int crash_cpuhp_online(unsigned int cpu)
> {
>          crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, NULL);
>          return 0;
> }
> 
> static int crash_cpuhp_offline(unsigned int cpu)
> {
> 	int dead_cpu = cpu;
>          crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, &cpu);
>          return 0;
> }
> 

