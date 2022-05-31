From: David Hildenbrand <david@redhat.com>
Date: Tue, 31 May 2022 15:18:50 +0200
Subject: [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
In-Reply-To: <94fba107-a425-7cf6-2a7b-0562c2dcfce4@linux.ibm.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <311b0834-c675-fd15-8184-82b122f4a9cc@linux.ibm.com>
 <bffb3d9e-1946-f4b6-d58c-9c44bc0bee26@oracle.com>
 <94fba107-a425-7cf6-2a7b-0562c2dcfce4@linux.ibm.com>
Message-ID: <5358be66-e545-4482-bad6-00d3d53aac8a@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 26.05.22 15:39, Sourabh Jain wrote:
> Hello Eric,
> 
> On 26/05/22 18:46, Eric DeVolder wrote:
>>
>>
>> On 5/25/22 10:13, Sourabh Jain wrote:
>>> Hello Eric,
>>>
>>> On 06/05/22 00:15, Eric DeVolder wrote:
>>>> When the kdump service is loaded, if a CPU or memory is hot
>>>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>>>> and memory in the system, must also be updated, else the resulting
>>>> vmcore is inaccurate (eg. missing either CPU context or memory
>>>> regions).
>>>>
>>>> The current solution utilizes udev to initiate an unload-then-reload
>>>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>>>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>>>> outlined the significant performance problems related to offloading
>>>> this activity to userspace.
>>>>
>>>> This patchset introduces a generic crash hot un/plug handler that
>>>> registers with the CPU and memory notifiers. Upon CPU or memory
>>>> changes, this generic handler is invoked and performs important
>>>> housekeeping, for example obtaining the appropriate lock, and then
>>>> invokes an architecture specific handler to do the appropriate
>>>> updates.
>>>>
>>>> In the case of x86_64, the arch specific handler generates a new
>>>> elfcorehdr, and overwrites the old one in memory. No involvement
>>>> with userspace needed.
>>>>
>>>> To realize the benefits/test this patchset, one must make a couple
>>>> of minor changes to userspace:
>>>>
>>>> ? - Disable the udev rule for updating kdump on hot un/plug changes.
>>>> ??? Add the following as the first two lines to the udev rule file
>>>> ??? /usr/lib/udev/rules.d/98-kexec.rules:
>>>
>>> If we can have a sysfs attribute to advertise this feature then 
>>> userspace
>>> utilities (kexec tool/udev rules) can take action accordingly. In 
>>> short, it will
>>> help us maintain backward compatibility.
>>>
>>> kexec tool can use the new sysfs attribute and allocate additional 
>>> buffer space
>>> for elfcorehdr accordingly. Similarly, the checksum-related changes 
>>> can come
>>> under this check.
>>>
>>> Udev rule can use this sysfs file to decide kdump service reload is 
>>> required or not.
>>
>> Great idea. I've been working on the corresponding udev and 
>> kexec-tools changes and your input/idea here is quite timely.
>>
>> I have boolean "crash_hotplug" as a core_param(), so it will show up as:
>>
>> # cat /sys/module/kernel/parameters/crash_hotplug
>> N
> 
> How about using 0-1 instead Y/N?
> 0 = crash hotplug not supported
> 1 = crash hotplug supported
> 
> Also how about keeping sysfs here instead?
> /sys/kernel/kexec_crash_hotplug

It's not only about hotplug, though. And actually we care about
onlining/offlining. Hmm, I wonder if there is a better name for this
automatic handling of cpu and memory devices.

-- 
Thanks,

David / dhildenb


