Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kb3n8-00027I-71
	for kexec@lists.infradead.org; Thu, 04 Sep 2008 01:37:46 +0000
Message-ID: <48BF3BE8.2050806@sgi.com>
Date: Wed, 03 Sep 2008 18:37:44 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IA64: kexec allocates too few memory for kdump kernel
	itself
References: <48BEFB47.20004@sgi.com> <20080904000100.GD8974@verge.net.au>
In-Reply-To: <20080904000100.GD8974@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Simon Horman wrote:
> On Wed, Sep 03, 2008 at 02:01:59PM -0700, Jay Lan wrote:
>> Sometimes the kexec would allocate not enough memory for kdump kernel
>> itself on IA64 and caused kdump kernel to panic at boot.
>>
>> When it happens, the /proc/iomem would show a kernel RAM segment like
>> this:
>> 3014000000-3015294fff : System RAM
>>   3014000000-3014823ccf : Kernel code
>>   3014823cd0-3014dee8ef : Kernel data
>>   3014dee8f0-301529448f : Kernel bss
>> 3015295000-307bffdfff : System RAM
>>   3018000000-3037ffffff : Crash kernel
>>
>> But kexec would allocate memory 3018000000-3019290000 for the kernel,
>> which is 0x5000 smaller than the regular kernel. In my cases, the
>> physical_node_map and kern_memmap of the kdump kernel overlaped and
>> caused data corruption.
>>
>> This patch fixes the problem. The patch was generated against
>> kexec-tools 2.0.0 and tested in 2.6.27-rc4.
> 
> Hi Jay,
> 
> I am unclear about why this underallocation occurs.

Hi Simon,

The routine add_loaded_segments_info() set up "loaded_segment" array
that is needed by purgatory code, based on data stored in the
mem_ehdr array passed in as the second parameter.

Upon entrance of the routine, the crash_memory_range[] contains
information about the regular kernel:
crash_memory_range[ 0]: start=  3000080000, end=  30003fffff
crash_memory_range[ 1]: start=  3003000000, end=  3005ffffff
crash_memory_range[ 2]: start=  3006000000, end=  3013ffffff
crash_memory_range[ 3]: start=  3014000000, end=  3015294fff

The #3 entry is the kernel memory segment.

And the mem_ehdr array would contain data as such:
i=0, p_paddr=3018000000, p_memsz=d04480, p_offset=10000, p_type=1
i=1, p_paddr=3018d20000, p_memsz=9620, p_offset=d20000, p_type=1
i=2, p_paddr=3018d30000, p_memsz=564490, p_offset=d30000, p_type=1
i=3, p_paddr=0, p_memsz=0, p_offset=0, p_type=4

The code wants the new loaded_segments contain starting address
all aligned at page boundary, which is 0x10000 in IA64.

Note that the p_memsz of mem_ehdr does not match to entries in
/proc/iomem:
3014000000-3015294fff : System RAM
  3014000000-3014823ccf : Kernel code
  3014823cd0-3014dee8ef : Kernel data
  3014dee8f0-301529448f : Kernel bss

The original code of add_loaded_segments_info() would go through
the mem_ehdr array and use the p_paddr of the first entry (the
beginning of the reserved memory) as the start address, add
the p_memsz of three entries to calculate the end address of
the kernel segment.

But the p_paddr of i=0 plus p_memsz of i=0 should result in
3018d10000 as the p_paddr of i=1 entry, but actually the
p_paddr of i=1 is 3018d20000. The logic of that routine
can not explain the discrepency.

So, where the data of mem_ehdr array come from?

add_loaded_segments_info
<-  load_crashdump_segments
  <-  elf_ia64_load
    <- file_type[i].load
      <- my_load

The elf_ia64_load set up mem_ehdr, probabaly based on data
pointed by *buf, which i think comes from vmlinuz.

So, i failed to find out how the p_memsz were set up initially.
But, i think we did it the way too complicated, IMHO.

The crash_memory_range[] array showed the kernel segment consumed
0x1295000 bytes of memory and we only need to tell the purgatory
code to reserve that amount of memory. The logic in
add_loaded_segments_info() came out with 0x1290000 and caused the
crashkernel to panic on boot.

Hmmm, as i types now, i may not consider the situation where
the crashkernel is not the same as the first kernel...

Note that the underallocation does not _ALWAYS_ happen! It depends
on the vmlinux we build. Honestly i do not understand some part of
the kexec-tools code well enough to make major surgery to the code.
So, i just compare the end address after calculation of i=0 entry
of mem_ehdr array with the start address of the second entry. If it
is too small, i just bring it up to align with the start address of
the second entry. I am happy to allocate one extra page, may not be
needed in some cases, of memory than to panic. Yes, my patch is
a work-around.

If you can find the true cause of the problem and fix it, it
would be great and appreciated!

Regards,
 - jay


> 
>> Signed-off-by: Jay Lan <jlan@sgi.com>
>>
> 
>> ---
>>  kexec/arch/ia64/crashdump-ia64.c |    8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
>> ===================================================================
>> --- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2008-09-03 11:24:14.289758063 -0700
>> +++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2008-09-03 11:29:34.095833316 -0700
>> @@ -90,15 +90,15 @@ static void add_loaded_segments_info(str
>>  			phdr = &ehdr->e_phdr[i];
>>  	                if (phdr->p_type != PT_LOAD)
>>  	                        break;
>> -			if (loaded_segments[loaded_segments_num].end !=
>> -				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
>> -				break;
>> +			if (loaded_segments[loaded_segments_num].end <
>> +			    (phdr->p_paddr & ~(ELF_PAGE_SIZE-1)) )
>> +				loaded_segments[loaded_segments_num].end
>> +				  = phdr->p_paddr & ~(ELF_PAGE_SIZE-1);
>>  			loaded_segments[loaded_segments_num].end +=
>>  				(phdr->p_memsz + ELF_PAGE_SIZE - 1) &
>>  				~(ELF_PAGE_SIZE - 1);
>>  			i++;
>>  		}
>> -
>>  		loaded_segments_num++;
>>  	}
>>  }
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
