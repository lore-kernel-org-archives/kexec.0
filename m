From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Fri, 25 Mar 2022 14:02:44 +0530
Subject: [RFC v3 PATCH 0/5] In kernel handling of CPU hotplug events for
 crash kernel
In-Reply-To: <fbea3816-1a7b-3f9b-1ebf-1f388537af5b@oracle.com>
References: <20220321080422.56255-1-sourabhjain@linux.ibm.com>
 <fbea3816-1a7b-3f9b-1ebf-1f388537af5b@oracle.com>
Message-ID: <cebcb5d0-0468-57e9-c9b0-46de8766c724@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org


On 24/03/22 00:02, Eric DeVolder wrote:
>
>
> On 3/21/22 03:04, Sourabh Jain wrote:
>> This patch series implements the crash hotplug handler on PowerPC 
>> introduced
>> by https://lkml.org/lkml/2022/3/3/674 patch series.
>>
>>
>> The Problem:
>> ============
>> Post hotplug/DLPAR events the capture kernel holds stale information 
>> about the
>> system. Dump collection with stale capture kernel might end up in 
>> dump capture
>> failure or an inaccurate dump collection.
>>
>>
>> Existing solution:
>> ==================
>> The existing solution to keep the capture kernel up-to-date is 
>> observe the
>> hotplug event via udev rule and trigger a full capture kernel reload 
>> post
>> hotplug event.
>>
>> Shortcomings:
>> ------------------------------------------------
>> - Leaves a window where kernel crash might not lead to successful dump
>> ?? collection.
>> - Reloading all kexec components for each hotplug is inefficient. 
>> Since only
>> ?? one or two kexec components need to be updated due to hotplug 
>> event reloading
>> ?? all kexec component is redundant.
>> - udev rules are prone to races if hotplug events are frequent.
>>
>> More about issues with an existing solution is posted here:
>> ? - https://lkml.org/lkml/2020/12/14/532
>> ? - 
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-February/240254.html
>>
>> Proposed Solution:
>> ==================
>> Instead of reloading all kexec segments on hotplug event, this patch 
>> series
>> focuses on updating only the relevant kexec segment. Once the kexec
>> segments are loaded in the kernel reserved area then an arch-specific 
>> hotplug handler
>> will update the relevant kexec segment based on hotplug event type.
>>
>> As mentioned above this patch series implemented a PowerPC crash hotplug
>> handler for the CPU. The crash hotplug handler memory is in our TODO 
>> list.
>>
>>
>> A couple of minor changes are required to realize the benefit of the 
>> patch
>> series:
>>
>> - disalble the udev rule:
>>
>> ?? comment out the below line in kdump udev rule file:
> fwiw, this will need to be conditionalized on arch, ie to skip for 
> ppc64. I'm doing the same for x86_64.


I think kexec-tools maintains a separate udev rule file for PowerPC. I 
will ensure CPU rules gets removed from kdump udev rules once this 
feature is upstream.

Thanks,
- Sourabh Jain


