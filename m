Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.171.30] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KjOMM-00023M-N8
	for kexec@lists.infradead.org; Sat, 27 Sep 2008 01:12:35 +0000
Message-ID: <48DD8854.2040409@sgi.com>
Date: Fri, 26 Sep 2008 18:11:48 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: Re: [PATCH] IA64: better calculate PT_LOAD segment size
References: <48D45D21.7080702@sgi.com> <20080923233615.GE14438@verge.net.au>
In-Reply-To: <20080923233615.GE14438@verge.net.au>
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
Cc: Bernhard Walle <bwalle@suse.de>, "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org

Simon Horman wrote:
> On Fri, Sep 19, 2008 at 07:17:05PM -0700, Jay Lan wrote:
>> This patch combines consecutive PL_LOAD segments into one.
>> The end address of the last PL_LOAD segment, calculated by
>> adding p_memsz to p_paddr & rounded up to ELF_PAGE_SIZE,
>> will be the end address of this loaded_segments[] entry.
>>
>> This patch fixes the kdump kernel MCA problem caused by under-
>> allocation of memory and a "kdump broken on ALtix 350" problem
>> reported by Bernhard Walle.
>>
>> Simon, this patch replaces my previous patch I submitted on the
>> underallocation issue.
>>
>> Signed-off-by: Jay Lan <jlan@sgi.com>
>>
> 
> The logic-bug portion of this fix I am fine with.
> As you pointed out previously & has higher precedence
> than += which makes the following bogus:
> 
>                         loaded_segments[loaded_segments_num].end +=
>                                 (phdr->p_memsz + ELF_PAGE_SIZE - 1) &
>                                 ~(ELF_PAGE_SIZE - 1)
> 
> The segment merging portion I am less clear about.
> Why are there gaps in the first place? 

I think there is still a bug in the kernel.

> If these
> multiple PT_LOAD segments are really one segment,
> why aren't they being fed in as one segment?

I searched a little... My guess is that it was done so that
the program headers provided more information for kexec
and crash? And thus put it back to simulate a boot loader?
I really do not know why it was done. Maybe Vivek or Eric
would know?

The current comparison part of code is basically a no-op.
I think we can simplify the code here.

Regards,
jay

> 
>> ---
>>  kexec/arch/ia64/crashdump-ia64.c |   15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
>> ===================================================================
>> --- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2008-09-19 14:33:07.593344017 -0700
>> +++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2008-09-19 17:39:03.732928237 -0700
>> @@ -86,19 +86,20 @@ static void add_loaded_segments_info(str
>>                  loaded_segments[loaded_segments_num].end =
>>  			loaded_segments[loaded_segments_num].start;
>>  
>> +		/* Consolidate consecutive PL_LOAD segments into one.
>> +		 * The end addr of the last PL_LOAD segment, calculated by
>> +		 * adding p_memsz to p_paddr & rounded up to ELF_PAGE_SIZE,
>> +		 * will be the end address of this loaded_segments entry.
>> +		 */
>>  		while (i < ehdr->e_phnum) {
>>  			phdr = &ehdr->e_phdr[i];
>>  	                if (phdr->p_type != PT_LOAD)
>>  	                        break;
>> -			if (loaded_segments[loaded_segments_num].end !=
>> -				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
>> -				break;
>> -			loaded_segments[loaded_segments_num].end +=
>> -				(phdr->p_memsz + ELF_PAGE_SIZE - 1) &
>> -				~(ELF_PAGE_SIZE - 1);
>> +			loaded_segments[loaded_segments_num].end =
>> +				(phdr->p_paddr + phdr->p_memsz +
>> +				ELF_PAGE_SIZE - 1) & ~(ELF_PAGE_SIZE - 1);
>>  			i++;
>>  		}
>> -
>>  		loaded_segments_num++;
>>  	}
>>  }
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
