From: Baoquan He <bhe@redhat.com>
Date: Thu, 3 Mar 2022 20:08:02 +0800
Subject: [PATCH v4 02/10] crash hp: Introduce CRASH_HOTPLUG configuration
 options
In-Reply-To: <5b0a9bac-cd00-35df-8e55-44624729015f@redhat.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
 <20220209195706.51522-3-eric.devolder@oracle.com>
 <YhWpF/Cj/V+Cx6+d@MiWiFi-R3L-srv>
 <10d67f14-c5fe-0a17-e8b5-97702823cc1c@oracle.com>
 <f23efdc0-20c8-ccfd-f54d-69a9b4ee531f@redhat.com>
 <YiCW8gEb3n1CpI6x@MiWiFi-R3L-srv>
 <5b0a9bac-cd00-35df-8e55-44624729015f@redhat.com>
Message-ID: <YiCvomsNsTrx0dhR@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 03/03/22 at 12:36pm, David Hildenbrand wrote:
> On 03.03.22 11:22, Baoquan He wrote:
> > On 03/02/22 at 10:20am, David Hildenbrand wrote:
> >> On 01.03.22 21:04, Eric DeVolder wrote:
> >>>
> >>>
> >>> On 2/22/22 21:25, Baoquan He wrote:
> >>>> On 02/09/22 at 02:56pm, Eric DeVolder wrote:
> >>>>> Support for CPU and memory hotplug for crash is controlled by the
> >>>>> CRASH_HOTPLUG configuration option, introduced by this patch.
> >>>>>
> >>>>> The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
> >>>>> also introduced with this patch.
> >>>>>
> >>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> >>>>> ---
> >>>>>   arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
> >>>>>   1 file changed, 26 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >>>>> index ebe8fc76949a..4e3374edab02 100644
> >>>>> --- a/arch/x86/Kconfig
> >>>>> +++ b/arch/x86/Kconfig
> >>>>> @@ -2060,6 +2060,32 @@ config CRASH_DUMP
> >>>>>   	  (CONFIG_RELOCATABLE=y).
> >>>>>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
> >>>>>   
> >>>>> +config CRASH_HOTPLUG
> >>>>> +	bool "kernel updates of crash elfcorehdr"
> >>>>> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
> >>>>> +	help
> >>>>> +	  Enable the kernel to update the crash elfcorehdr (which contains
> >>>>> +	  the list of CPUs and memory regions) directly when hot plug/unplug
> >>>>> +	  of CPUs or memory. Otherwise userspace must monitor these hot
> >>>>> +	  plug/unplug change notifications via udev in order to
> >>>>> +	  unload-then-reload the crash kernel so that the list of CPUs and
> >>>>> +	  memory regions is kept up-to-date. Note that the udev CPU and
> >>>>> +	  memory change notifications still occur (however, userspace is not
> >>>>> +	  required to monitor for crash dump purposes).
> >>>>> +
> >>>>> +config CRASH_HOTPLUG_ELFCOREHDR_SZ
> >>>>> +	depends on CRASH_HOTPLUG
> >>>>> +	int
> >>>>> +	default 131072
> >>>>> +	help
> >>>>> +	  Specify the maximum size of the elfcorehdr buffer/segment.
> >>>>> +	  The 128KiB default is sized so that it can accommodate 2048
> >>>>> +	  Elf64_Phdr, where each Phdr represents either a CPU or a
> >>>>> +	  region of memory.
> >>>>> +	  For example, this size can accommodate hotplugging a machine
> >>>>> +	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
> >>>>> +	  with 1024 1GiB memory DIMMs).
> >>>>
> >>>> This example of memory could be a little misleading. The memory regions
> >>>> may not be related to memory DIMMs. System could split them into many
> >>>> smaller regions during bootup.
> >>>
> >>> I changed "with 1024 1GiB memory DIMMs" to "with 1024 1GiB hotplug memories".
> >>> eric
> >>
> >> It's still not quite precise. Essentially it's the individual "System
> >> RAM" entries in /proc/iomem
> >>
> >> Boot memory (i.e., a single DIMM) might be represented by multiple
> >> entries due to rearranged holes (by the BIOS).
> >>
> >> While hoplugged DIMMs (under virt!) are usually represented using a
> >> single range, it can be different on physical machines. Last but not
> >> least, dax/kmem and virtio-mem behave in a different way.
> > 
> > Right. How about only mentioning the 'System RAM' entries in /proc/iomem
> > as below? It's just giving an example, talking about the details of
> > memory regions from each type may not be necessry here. People
> > interested can refer to code or document related to get it.
> > 
> > 
> > + default 131072
> > + help
> > +   Specify the maximum size of the elfcorehdr buffer/segment.
> > +   The 128KiB default is sized so that it can accommodate 2048
> > +   Elf64_Phdr, where each Phdr represents either a CPU or a
> > +   region of memory.
> > +   For example, this size can accommodate hotplugging a machine
> > +   with up to 1024 CPUs and up to 1024 memory regions which are
> >     represented by 'System RAM' entries in /proc/iomem.
> 
> Maybe changing the last paragraph to:
> 
> "For example, this size can accommodate a machine with up to 1024 CPUs
> and up to 1024 memory regions, for example, as represented by 'System
> RAM' entries in /proc/iomem."

Yeah, this looks good. Can the 2nd 'for example' be removed or replaced
with 'e.g'? Please ignore it if it's normal to have two 'for example' in
one sentence, just gentlely ask.


