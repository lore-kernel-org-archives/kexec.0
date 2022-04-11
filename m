From: Eric DeVolder <eric.devolder@oracle.com>
Date: Mon, 11 Apr 2022 08:54:28 -0500
Subject: [PATCH v6 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
In-Reply-To: <Yk/tMnoYN/p6vxxT@MiWiFi-R3L-srv>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
 <20220401183040.1624-3-eric.devolder@oracle.com>
 <Yk/tMnoYN/p6vxxT@MiWiFi-R3L-srv>
Message-ID: <657edaae-cb56-9c01-383b-680a0e95f722@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



On 4/8/22 03:07, Baoquan He wrote:
> On 04/01/22 at 02:30pm, Eric DeVolder wrote:
>> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
>>
>> CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
>> the elfcorehdr buffer/segment.
>>
>> This is a preparation for later usage.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> LGTM,
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Excellent, thanks!
eric

> 
>> ---
>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 7340d9f01b62..8b51d3196b82 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2072,6 +2072,32 @@ config CRASH_DUMP
>>   	  (CONFIG_RELOCATABLE=y).
>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>>   
>> +config CRASH_HOTPLUG
>> +	bool "kernel updates of crash elfcorehdr"
>> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
>> +	help
>> +	  Enable the kernel to update the crash elfcorehdr (which contains
>> +	  the list of CPUs and memory regions) directly when hot plug/unplug
>> +	  of CPUs or memory. Otherwise userspace must monitor these hot
>> +	  plug/unplug change notifications via udev in order to
>> +	  unload-then-reload the crash kernel so that the list of CPUs and
>> +	  memory regions is kept up-to-date. Note that the udev CPU and
>> +	  memory change notifications still occur (however, userspace is not
>> +	  required to monitor for crash dump purposes).
>> +
>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
>> +	depends on CRASH_HOTPLUG
>> +	int
>> +	default 131072
>> +	help
>> +	  Specify the maximum size of the elfcorehdr buffer/segment.
>> +	  The 128KiB default is sized so that it can accommodate 2048
>> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
>> +	  region of memory.
>> +	  For example, this size can accommodate a machine with up to 1024
>> +	  CPUs and up to 1024 memory regions, eg. as represented by the
>> +	  'System RAM' entries in /proc/iomem.
>> +
>>   config KEXEC_JUMP
>>   	bool "kexec jump"
>>   	depends on KEXEC && HIBERNATION
>> -- 
>> 2.27.0
>>
> 

