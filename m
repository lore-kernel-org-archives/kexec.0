Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.171.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KeJAA-0001M0-Nn
	for kexec@lists.infradead.org; Sat, 13 Sep 2008 00:38:59 +0000
Message-ID: <48CB0B71.2070308@sgi.com>
Date: Fri, 12 Sep 2008 17:38:09 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IA64: kexec allocates too few memory for kdump kernel
	itself
References: <48BEFB47.20004@sgi.com>
	<20080904000100.GD8974@verge.net.au>	<48BF3BE8.2050806@sgi.com>
	<48C028D0.4050202@sgi.com> <20080912232710.GE3832@verge.net.au>
In-Reply-To: <20080912232710.GE3832@verge.net.au>
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
>> Hi,
>>
>> It should be mem_phdr, got it from mem_ehdr->e_phdr.
>>
>>> i=0, p_paddr=3018000000, p_memsz=d04480, p_offset=10000, p_type=1
>>> i=1, p_paddr=3018d20000, p_memsz=9620, p_offset=d20000, p_type=1
>>> i=2, p_paddr=3018d30000, p_memsz=564490, p_offset=d30000, p_type=1
>>> i=3, p_paddr=0, p_memsz=0, p_offset=0, p_type=4
>> Does anyone understand how the array were created and why there
>> was a gap between i=0 and i=1 entries? I think this is the problem
>> but i do not know how to fix it, so tried to work around it.
>>
>> The statement my patch replaced was totally broken:
>>  -			if (loaded_segments[loaded_segments_num].end !=
>>  -				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
>>  -				break;
>>  +			if (loaded_segments[loaded_segments_num].end <
>>  +			    (phdr->p_paddr & ~(ELF_PAGE_SIZE-1)) )
>>  +				loaded_segments[loaded_segments_num].end
>>  +				  = phdr->p_paddr & ~(ELF_PAGE_SIZE-1);
>>
>> My debugging showed that when "loaded_segments[loaded_segments_num].end"
>> != "phdr->p_paddr & ~(ELF_PAGE_SIZE-1)", they were treated as equal
>> and continue to next statement.  However, if i assign both expression
>> to local variables and do comparison, the 'break' statement is
>> executed correctly when two values are not the same. Unfortunately,
>> consequently the kdump kernel would _alawys_ hang.
>>
>> I believe the intent of the original statement is to ensure there is
>> no gap between entries of mem_phdr array. But if there is a gap,
>> kexec should simply exit with failure. The 'break' statement just
>> created a loaded_segment[] array that broke the kernel memory segment
>> into multiple entries and resulted in the kdump kernel hang in
>> find_memory(). The IA64 (at least 2.6.27-rc4) kdump kernel works in
>> some cases today are simply out of luck.
>>
>> I believe the real fix is to fix the contents of the mem_phdr array.
>> Since i do not know how to fix it, my patch would close up the
>> gap where there is the a gap between entries of the mem_phdr array.
>>
>> Does it make more sense to you now, Simon?
> 
> Hi Jay,
> 
> yes that does make sense. I'd like to poke around and see
> if mem_phdr can be fixed.

I think the whole ehdr is read from the kernel binary in
slurp_decompress_file.

Bernhard reported a kdump kernel boot problem caused by a patch
regarding per-cpu variables access in early boot code:
http://article.gmane.org/gmane.linux.ports.ia64/19380

I backed out the offending patch and i was no longer able to
reproduce this problem.

So, it is safe to say the problem was due to how we process
data from the vmlinuz.

The code i tried to change:
-             if (loaded_segments[loaded_segments_num].end !=
-                     phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
-                     break;
has two problems:
1) '!=' operation takes precedence over '&'. If the code is to
   do what it intends to do, the statement should be:
              if (loaded_segments[loaded_segments_num].end !=
                     (phdr->p_paddr & ~(ELF_PAGE_SIZE-1)) )
                     break;
2) When the 'break' is really executed, you breaks the kernel
   segment into multiple segments.

The code needs fix even if the problem i saw was a result of
a bug in the kernel.

Thanks,
jay



> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
