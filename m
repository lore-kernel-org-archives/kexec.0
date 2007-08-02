Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IGScJ-00065r-0A
	for kexec@lists.infradead.org; Thu, 02 Aug 2007 00:49:01 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l723iJ40029160
	for <kexec@lists.infradead.org>; Wed, 1 Aug 2007 23:44:19 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l724mnG2479126
	for <kexec@lists.infradead.org>; Thu, 2 Aug 2007 00:48:49 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l724mnjU022436
	for <kexec@lists.infradead.org>; Thu, 2 Aug 2007 00:48:49 -0400
Date: Thu, 2 Aug 2007 10:16:53 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Question re: mem= usage and resultant vmcore
Message-ID: <20070802044653.GB8003@in.ibm.com>
References: <46B0B507.5090704@redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46B0B507.5090704@redhat.com>
Reply-To: vgoyal@in.ibm.com
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, Aug 01, 2007 at 12:29:59PM -0400, Dave Anderson wrote:
> 
> On an 4GB x86_64 kernel, with memory restricted with "mem=" like so:
> 
>    kernel /vmlinuz-2.6.18-36.el5 ro root=/dev/VolGroup00/LogVol00
>    console=ttyS0,115200 mem=2000m crashkernel=128M@16M
> 
> The secondary kernel boots fine with this:
> 
>    Kernel command line: ro root=/dev/VolGroup00/LogVol00 console=ttyS0,115200
>    mem=2000m  irqpoll maxcpus=1 memmap=exactmap memmap=640K@0K
>    memmap=5048K@16384K memmap=125368K@22072K elfcorehdr=147440K
>    memmap=76K#3406720K memmap=564K#3406796K
> 
> The /proc/vmcore shows 4GB:
> 
>    # ls -l /proc/vmcore
>    -r-------- 1 root root 4164192032 Aug  1 10:57 /proc/vmcore
>    #
> 
> I'm not sure whether that's supposed to reflect the "mem=2000m" size
> or not?
> 

Hi Dave,

/proc/iomem on i386 and x86_64 behave differently when passed with mem=
parameter. I think on i386, only memory specified by mem= is visible but
in case of x86_64, all the memory passed by BIOS to kernel is visible.

Kexec/kdump retrieve the physical memory info from /proc/iomem. We need
both the behaviours for two scenarios.

- For kexec, we want to see whole of the memory (irrespective of the fact
  how much current kernel is using), so that next kernel can potentially
  use all the memory to boot in.

- For kdump, we want to know about only the physical memory current kernel
  is using and not all the memory system has.

Here the issue is that despite the fact you have passed mem=2000m, /proc/iomem
will show 4G physical memory and kdump will create elf header for 4G of 
memory. That's why /proc/vmcore size is 4G. I am not sure why it did not
copy whole 4G on disk and stoppped after 2000m. To me it should have copied
whole of the 4G.

Bottom line, we need to do some work in this area.

- Make /proc/iomem behaviour consistent across i386 and x86_64. I think
  it can be changed to reflect the physical memory currently used by 
  kernel (based on mem=) parameter.

- Create another /proc interface, lets say /proc/physmem, which will reflect
  all the physical memory system has, irrespective of the fact what is being
  used by the kernel.

In this case kexec can make use of /proc/physmem and kdump can make use
of /proc/iomem and things will be fine.

Anybody interested in writing patches for this?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
