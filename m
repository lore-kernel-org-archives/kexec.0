Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IGard-000448-Uz
	for kexec@lists.infradead.org; Thu, 02 Aug 2007 09:37:19 -0400
Message-ID: <46B1DF28.9020605@redhat.com>
Date: Thu, 02 Aug 2007 09:42:00 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: Question re: mem= usage and resultant vmcore
References: <46B0B507.5090704@redhat.com> <20070802044653.GB8003@in.ibm.com>
In-Reply-To: <20070802044653.GB8003@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: kexec@lists.infradead.org

Vivek Goyal wrote:
> On Wed, Aug 01, 2007 at 12:29:59PM -0400, Dave Anderson wrote:
> 
>>On an 4GB x86_64 kernel, with memory restricted with "mem=" like so:
>>
>>   kernel /vmlinuz-2.6.18-36.el5 ro root=/dev/VolGroup00/LogVol00
>>   console=ttyS0,115200 mem=2000m crashkernel=128M@16M
>>
>>The secondary kernel boots fine with this:
>>
>>   Kernel command line: ro root=/dev/VolGroup00/LogVol00 console=ttyS0,115200
>>   mem=2000m  irqpoll maxcpus=1 memmap=exactmap memmap=640K@0K
>>   memmap=5048K@16384K memmap=125368K@22072K elfcorehdr=147440K
>>   memmap=76K#3406720K memmap=564K#3406796K
>>
>>The /proc/vmcore shows 4GB:
>>
>>   # ls -l /proc/vmcore
>>   -r-------- 1 root root 4164192032 Aug  1 10:57 /proc/vmcore
>>   #
>>
>>I'm not sure whether that's supposed to reflect the "mem=2000m" size
>>or not?
>>
> 
> 
> Hi Dave,
> 
> /proc/iomem on i386 and x86_64 behave differently when passed with mem=
> parameter. I think on i386, only memory specified by mem= is visible but
> in case of x86_64, all the memory passed by BIOS to kernel is visible.
> 
> Kexec/kdump retrieve the physical memory info from /proc/iomem. We need
> both the behaviours for two scenarios.
> 
> - For kexec, we want to see whole of the memory (irrespective of the fact
>   how much current kernel is using), so that next kernel can potentially
>   use all the memory to boot in.
> 
> - For kdump, we want to know about only the physical memory current kernel
>   is using and not all the memory system has.
> 
> Here the issue is that despite the fact you have passed mem=2000m, /proc/iomem
> will show 4G physical memory and kdump will create elf header for 4G of 
> memory. That's why /proc/vmcore size is 4G. I am not sure why it did not
> copy whole 4G on disk and stoppped after 2000m. To me it should have copied
> whole of the 4G.

Yeah -- I haven't verified it, but I'm guessing that read_vmcore()
fails due to its call to map_offset_to_paddr(), which doesn't
find the physical memory beyond 2000m in the vmcore_list?

Interestingly enough, this may never have been noticed except for
the save_core() function in the /etc/init.d/kdump file in Red Hat's
kexec-tools package:

function save_core()
{
         coredir="/var/crash/`date +"%Y-%m-%d-%H:%M"`"

         mkdir -p $coredir
         cp /proc/vmcore $coredir/vmcore-incomplete
         exitcode=$?
         if [ $exitcode == 0 ]; then
                 mv $coredir/vmcore-incomplete $coredir/vmcore
                 $LOGGER "saved a vmcore to $coredir"
         else
                 $LOGGER "failed to save a vmcore to $coredir"
         fi
         return $exitcode
}

And even though the ELF header reflects the 4GB memory size,
the vmcore-incomplete file is "complete" w/respect to the
primary kernel.  In other words, even though the ELF header
advertises non-existent physical memory beyond the 2000m
limit, there's never a need to access it from the crash utility,
so it's kind of a benign bug.

Dave


> 
> Bottom line, we need to do some work in this area.
> 
> - Make /proc/iomem behaviour consistent across i386 and x86_64. I think
>   it can be changed to reflect the physical memory currently used by 
>   kernel (based on mem=) parameter.
> 
> - Create another /proc interface, lets say /proc/physmem, which will reflect
>   all the physical memory system has, irrespective of the fact what is being
>   used by the kernel.
> 
> In this case kexec can make use of /proc/physmem and kdump can make use
> of /proc/iomem and things will be fine.
> 
> Anybody interested in writing patches for this?
> 
> Thanks
> Vivek



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
