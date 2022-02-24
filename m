From: Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Thu, 24 Feb 2022 13:21:40 +0530
Subject: [RFC PATCH 0/5] Avoid kdump service reload on CPU hotplug events
In-Reply-To: <YhRdfu++s5dJMS5L@MiWiFi-R3L-srv>
References: <20220221084624.85792-1-sourabhjain@linux.ibm.com>
 <YhRdfu++s5dJMS5L@MiWiFi-R3L-srv>
Message-ID: <091f4e0b-540b-ee5b-c07c-0362d53821df@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello Baoquan,

> Hi,
>
> On 02/21/22 at 02:16pm, Sourabh Jain wrote:
>> On hotplug event (CPU/memory) the CPU information prepared for the kdump kernel
>> becomes stale unless it is prepared again. To keep the CPU information
>> up-to-date a kdump service reload is triggered via the udev rule.
>>
>> The above approach has two downsides:
>>
>> 1) The udev rules are prone to races if hotplug event is frequent. The time is
>>     taken to settle down all the kdump service reload requested is significant
>>     when multiple CPU/memory hotplug is performed at the same time. This creates
>>     a window where kernel crash might not lead to successfully dump collection.
>>
>> 2) Unnecessary CPU cycles are consumed to reload all the kdump components
>>     including initrd, vmlinux, FDT, etc. whereas only one component needs to
>>     update that is FDT.
> I roughly went through this sereis, while haven't read the code
> carefully. Seems the issue and the approach are similar to what below
> patchset is doing. Do you notice below patchset from Oracle engineer?
> And is there stuff the ppc code can be rebased on and reused?
>
> [PATCH v4 00/10] crash: Kernel handling of CPU and memory hot un/plug
> https://lore.kernel.org/all/20220209195706.51522-1-eric.devolder at oracle.com/T/#u

Thanks for the suggestion. I have seen earlier versions of this patch series
but since it did not have support for kexec_load system call we tried 
implementing
something from scratch.

Since Eric's added support for kexec_load and has a generic handler for 
CPU and
memory hotplug let me see if I can rebase my PowerPC changes on top of 
his patches.
The major difference across the distro is that on PowerPC we need to 
update FDT instead
of elfcorehdr on hotplug event.

Thanks,
Sourabh Jain


