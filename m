From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Thu, 31 Mar 2022 14:35:41 +0530
Subject: [RFC v3 PATCH 0/5] In kernel handling of CPU hotplug events for
 crash kernel
In-Reply-To: <4f67f1ca-26e4-fbd6-bff7-692cd87da1b5@linux.ibm.com>
References: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
 <4f67f1ca-26e4-fbd6-bff7-692cd87da1b5@linux.ibm.com>
Message-ID: <3f72552f-7c69-510b-2e09-8149f9c584b9@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org


On 25/03/22 22:34, Laurent Dufour wrote:
> On 21/03/2022, 09:04:17, Sourabh Jain wrote:
>> This patch series implements the crash hotplug handler on PowerPC introduced
>> by https://lkml.org/lkml/2022/3/3/674 patch series.
> Hi Sourabh,
>
> That's a great idea!
>
>> The Problem:
>> ============
>> Post hotplug/DLPAR events the capture kernel holds stale information about the
>> system. Dump collection with stale capture kernel might end up in dump capture
>> failure or an inaccurate dump collection.
>>
>>
>> Existing solution:
>> ==================
>> The existing solution to keep the capture kernel up-to-date is observe the
>> hotplug event via udev rule and trigger a full capture kernel reload post
>> hotplug event.
>>
>> Shortcomings:
>> ------------------------------------------------
>> - Leaves a window where kernel crash might not lead to successful dump
>>    collection.
>> - Reloading all kexec components for each hotplug is inefficient. Since only
>>    one or two kexec components need to be updated due to hotplug event reloading
>>    all kexec component is redundant.
>> - udev rules are prone to races if hotplug events are frequent.
>>
>> More about issues with an existing solution is posted here:
>>   - https://lkml.org/lkml/2020/12/14/532
>>   - https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-February/240254.html
>>
>> Proposed Solution:
>> ==================
>> Instead of reloading all kexec segments on hotplug event, this patch series
>> focuses on updating only the relevant kexec segment. Once the kexec
>> segments are loaded in the kernel reserved area then an arch-specific hotplug handler
>> will update the relevant kexec segment based on hotplug event type.
>>
>> As mentioned above this patch series implemented a PowerPC crash hotplug
>> handler for the CPU. The crash hotplug handler memory is in our TODO list.
> If I understand corrrectly, and based on the change in the patch 4/5,
> memory hotplug operations are ignored. Does this means that once this
> series is applied, the capture kenrel will not be able to work correctly on
> this hot plug/unplugged memory areas?
It will work because we will not remove the kdump udev rule to restart the
kdump service on memory hotplug until that feature is available in the 
kernel.


Thanks,
Sourabh Jain


