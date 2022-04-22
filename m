From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 22 Apr 2022 14:22:12 +1000
Subject: [RFC v4 PATCH 2/5] powerpc/crash hp: introduce a new config
 option CRASH_HOTPLUG
In-Reply-To: <35ccca7c-07c2-1fc4-70da-2cc581ba818a@oracle.com>
References: <20220411084357.157308-1-sourabhjain@linux.ibm.com>
 <20220411084357.157308-3-sourabhjain@linux.ibm.com>
 <874k2mfz5t.fsf@mpe.ellerman.id.au>
 <35ccca7c-07c2-1fc4-70da-2cc581ba818a@oracle.com>
Message-ID: <87h76liw7f.fsf@mpe.ellerman.id.au>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Eric DeVolder <eric.devolder@oracle.com> writes:
> On 4/21/22 06:34, Michael Ellerman wrote:
>> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>>> The option CRASH_HOTPLUG enables, in kernel update to kexec segments on
>>> hotplug events.
>>>
>>> All the updates needed on the capture kernel load path in the kernel for
>>> both kexec_load and kexec_file_load system will be kept under this config.
>>>
>>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>> Reviewed-by: Eric DeVolder <eric.devolder@oracle.com>
>>> ---
>>>   arch/powerpc/Kconfig | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index b779603978e1..777db33f75b5 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -623,6 +623,17 @@ config FA_DUMP
>>>   	  If unsure, say "y". Only special kernels like petitboot may
>>>   	  need to say "N" here.
>>>   
>>> +config CRASH_HOTPLUG
>>> +	bool "kernel updates of crash kexec segments"
>>> +	depends on CRASH_DUMP && (HOTPLUG_CPU) && KEXEC_FILE
>>> +	help
>>> +	  An efficient way to keep the capture kernel up-to-date with CPU
>>> +	  hotplug events. On CPU hotplug event the kexec segments of capture
>>> +	  kernel becomes stale and need to be updated with latest CPU data.
>>> +	  In this method the kernel performs minimal update to only relevant
>>> +	  kexec segments on CPU hotplug event, instead of triggering full
>>> +	  capture kernel reload from userspace using udev rule.
>> 
>> Why would a user ever want to turn this off?
>> 
>> Seems to me we should just make it always behave this way, and not have
>> a CONFIG option at all.
>
> Sourabh,
>
> Borislav Petkov also requested I remove the config option, which will be the
> case in upcoming v8.
>
> Where I was using CONFIG_CRASH_HOTPLUG, I've replaced it with the
> CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG.

If you're having to spell "CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG"
in many places then you can still add CONFIG_CRASH_HOTPLUG to represent
the sum of all the dependencies, just don't make it user-selectable.

cheers

