From: Eric DeVolder <eric.devolder@oracle.com>
Date: Tue, 26 Apr 2022 09:39:55 -0500
Subject: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
In-Reply-To: <d90f4299-e821-f5d5-957a-1e84f16816e0@linux.ibm.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com>
 <d90f4299-e821-f5d5-957a-1e84f16816e0@linux.ibm.com>
Message-ID: <300a485c-4bc5-c58a-d34a-bacdb1fa4510@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 4/25/22 23:21, Sourabh Jain wrote:
> 
> On 13/04/22 22:12, Eric DeVolder wrote:
>> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
>>
>> CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
>> the elfcorehdr buffer/segment.
>>
>> This is a preparation for later usage.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>> ? arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>> ? 1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index b0142e01002e..f7b92ee1bcc7 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2072,6 +2072,32 @@ config CRASH_DUMP
>> ??????? (CONFIG_RELOCATABLE=y).
>> ??????? For more details see Documentation/admin-guide/kdump/kdump.rst
>> +config CRASH_HOTPLUG
>> +??? bool "kernel updates of crash elfcorehdr"
>> +??? depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
>> +??? help
>> +????? Enable the kernel to update the crash elfcorehdr (which contains
>> +????? the list of CPUs and memory regions) directly when hot plug/unplug
>> +????? of CPUs or memory. Otherwise userspace must monitor these hot
>> +????? plug/unplug change notifications via udev in order to
>> +????? unload-then-reload the crash kernel so that the list of CPUs and
>> +????? memory regions is kept up-to-date. Note that the udev CPU and
>> +????? memory change notifications still occur (however, userspace is not
>> +????? required to monitor for crash dump purposes).
>> +
>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>> +??? depends on CRASH_HOTPLUG
>> +??? int
>> +??? default 131072
>> +??? help
>> +????? Specify the maximum size of the elfcorehdr buffer/segment.
>> +????? The 128KiB default is sized so that it can accommodate 2048
>> +????? Elf64_Phdr, where each Phdr represents either a CPU or a
>> +????? region of memory.
>> +????? For example, this size can accommodate a machine with up to 1024
>> +????? CPUs and up to 1024 memory regions, eg. as represented by the
>> +????? 'System RAM' entries in /proc/iomem.
> 
> Is it possible to get rid of CRASH_HOTPLUG_ELFCOREHDR_SZ?
At the moment, I do not think so. The idea behind this value is to represent the largest number of 
CPUs and memory regions possible in the system. Today there is NR_CPUS which could be used for CPUs, 
but there isn't a similar value for memory. I also am not aware of a kernel variable that could be 
utilized to represent the maximum number of memory regions. If there is, please let me know!
> 
> How about finding the additional buffer space needed for future CPU and memory
> add during the kdump load? Not sure about the feasibility of doing this in
> kexec tool (userspace).

I may not understand what you are asking, but the x86 code, for kexec_file_load, does in fact 
allocate all the space needed (currently via CRASH_HOTPLUG_ELFCOREHDR_SZ) upon kdump load.

For kexec_load, I've had no problem asking the kexec tool to allocate a larger piece of memory for 
the elfcorehdr. But it is the same problem as CRASH_HOTPLUG_ELFCOREHDR_SZ; how big? In my workspace 
I tell kexec tool how big. If there are sysfs visible values for NR_CPU and memory, then we could 
have kexec pull those and compute.

I do think the important thing is that this allocation needs to happen once (for either kexec_load 
or kexec_file_load), so that the buffer is always in the same spot and thus the pointer to that 
buffer does not change; else boot_params cmdline would need to change. I once had this coded this 
way, but Baoquan pointed out this simpler way.

Regards,
eric

> 
> Thanks,
> Sourabh Jain
> 
> 
> 

