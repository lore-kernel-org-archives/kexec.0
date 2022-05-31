From: David Hildenbrand <david@redhat.com>
Date: Tue, 31 May 2022 15:15:46 +0200
Subject: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <e4120abd-c3ac-ee4d-1a0d-260126914b09@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
 <e4120abd-c3ac-ee4d-1a0d-260126914b09@oracle.com>
Message-ID: <b38f4597-0d9b-5b17-0b24-13d99605fb69@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 12.05.22 18:10, Eric DeVolder wrote:
> David,
> Great questions! See inline responses below.
> eric

Sorry for the late reply, travel and vacation ...

>>
>>> +
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
>>> +							unsigned int hp_action, unsigned int cpu)
>>> +{
>>> +	WARN(1, "crash hotplug handler not implemented");
>>
>>
>> Won't that trigger on any arch that has CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG?
>> I mean, you only implement it for x86 later in this series. Or what else stops this WARN from
>> triggering?
>>
> You're correct. What about: printk_once(KERN_DEBUG "...") ?

Why even bother about printing anything? If the feature is not
supported, there should be some way for user space to figure out that it
sill has to reload on hot(un)plug manually, no?


[...]

> 
>>
>> 2. Why can't the unprotect+reprotect not be done inside
>> arch_crash_handle_hotplug_event() ? It's all arch specific either way.
>>
>> IMHO, this code here should be as simple as
>>
>> if (kexec_crash_image)
>> 	arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
>>
> 
> The intent of this code was to be generic infrastructure. Just invoking the
> arch_crash_handle_hotplug_event() would certainly be as generic as it gets.
> But there were a series of steps that seemed to be common, so those I hoisted
> into this bit of code.

But most common parts are actually arch_* calls already? :)

Anyhow, no strong opinion.

> 
>> 3. Why do we have to forward the CPU for CPU onlining/offlining but not the
>> memory block id (or similar) when onlining/offlining a memory block?
>  From patch "kexec: exclude hot remove cpu from elfcorehdr notes" commit message:
> 
> Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
> still in the for_each_present_cpu() list when within the
> handle_hotplug_event(). Thus the CPU must be explicitly excluded
> when building the new list of CPUs.
> 
> This change identifies in handle_hotplug_event() the CPU to be
> excluded, and the check for excluding the CPU in
> crash_prepare_elf64_headers().
> 
> If there is a better CPUHP_ to use than _DYN, I'd be all for that!

Ah okay, thanks.

-- 
Thanks,

David / dhildenb


