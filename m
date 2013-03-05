Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCoJF-0006iI-9w
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 09:37:22 +0000
Message-ID: <5135BC5C.3000908@cn.fujitsu.com>
Date: Tue, 05 Mar 2013 17:35:24 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 02/20] vmcore: rearrange program headers without
 assuming consequtive PT_NOTE entries
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
 <20130302083559.31252.60341.stgit@localhost6.localdomain6>
 <5135AEA5.7000605@cn.fujitsu.com>
 <20130305.180243.45653001.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130305.180243.45653001.d.hatayama@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

于 2013年03月05日 17:02, HATAYAMA Daisuke 写道:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> Subject: Re: [PATCH v2 02/20] vmcore: rearrange program headers without assuming consequtive PT_NOTE entries
> Date: Tue, 5 Mar 2013 16:36:53 +0800
> 
>> 于 2013年03月02日 16:35, HATAYAMA Daisuke 写道:
>>> Current code assumes all PT_NOTE headers are placed at the beginning
>>> of program header table and they are consequtive. But the assumption
>>> could be broken by future changes on either kexec-tools or the 1st
>>> kernel. This patch removes the assumption and rearranges program
>>> headers as the following conditions are satisfied:
>>>
>>> - PT_NOTE entry is unique at the first entry,
>>>
>>> - the order of program headers are unchanged during this
>>>   rearrangement, only their positions are changed in positive
>>>   direction.
>>>
>>> - unused part that occurs in the bottom of program headers are filled
>>>   with 0.
>>>
>>> Also, this patch adds one exceptional case where the number of PT_NOTE
>>> entries is somehow 0. Then, immediately go out of the function.
>>>
>>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>>> ---
>>>
>>>  fs/proc/vmcore.c |   92 +++++++++++++++++++++++++++++++++++++++++++-----------
>>>  1 files changed, 74 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>>> index abf4f01..b5c9e33 100644
>>> --- a/fs/proc/vmcore.c
>>> +++ b/fs/proc/vmcore.c
>>> @@ -251,8 +251,7 @@ static u64 __init get_vmcore_size_elf32(char *elfptr)
>>>  static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>>>  						struct list_head *vc_list)
>>>  {
>>> -	int i, nr_ptnote=0, rc=0;
>>> -	char *tmp;
>>> +	int i, j, nr_ptnote=0, i_ptnote, rc=0;
>>
>> After applying the patch, there are two "j" defined.
>>
>> 251 static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>> 252                                                 struct list_head *vc_list)
>> 253 {
>> 254         int i, j, nr_ptnote=0, i_ptnote, rc=0;
>> 255         Elf64_Ehdr *ehdr_ptr;
>> 256         Elf64_Phdr phdr, *phdr_ptr;
>> 257         Elf64_Nhdr *nhdr_ptr;
>> 258         u64 phdr_sz = 0, note_off;
>> 259 
>> 260         ehdr_ptr = (Elf64_Ehdr *)elfptr;
>> 261         phdr_ptr = (Elf64_Phdr*)(elfptr + ehdr_ptr->e_phoff);
>> 262         for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
>> 263                 int j;
>> 264                 void *notes_section;
>> 265                 struct vmcore *new;
>>
>>
>> line 254 and 263.
>>
> 
> I've already noticed the name of the inner j is never best in meaning
> under development but I didn't make patch for it; it's beyond the
> scope of this patch series.
> 
> I'll replace the outer j by another incremental variable like k. 
> 
>>
>>>  	Elf64_Ehdr *ehdr_ptr;
>>>  	Elf64_Phdr phdr, *phdr_ptr;
>>>  	Elf64_Nhdr *nhdr_ptr;
>>> @@ -302,6 +301,39 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
>>>  		kfree(notes_section);
>>>  	}
>>>  
>>> +	if (nr_ptnote == 0)
>>> +		goto out;
>>> +
>>> +	phdr_ptr = (Elf64_Phdr *)(elfptr + ehdr_ptr->e_phoff);
>>> +
>>> +	/* Remove unwanted PT_NOTE program headers. */
>>> +
>>> +        /* - 1st pass shifts non-PT_NOTE entries until the first
>>> +	     PT_NOTE entry. */
>>> +	i_ptnote = -1;
>>> +	for (i = 0; i < ehdr_ptr->e_phnum; ++i) {
>>> +		if (phdr_ptr[i].p_type == PT_NOTE) {
>>> +			i_ptnote = i;
>>> +			break;
>>> +		}
>>> +	}
>>> +	BUG_ON(i_ptnote == -1); /* impossible case since nr_ptnote > 0. */
>>> +	memmove(phdr_ptr + 1, phdr_ptr,	i_ptnote * sizeof(Elf64_Phdr));
>>
>> is there any problem with this move? What is the batch bytes for every loop
>> of memmove? 
>>
>> if i_ptnode == 2, so we have
>>
>> -------------------------------------
>> | PT_LOAD 1 | PT_LOAD 2 | PT_NOTE 1 |
>> -------------------------------------
>>
>> -->
>>
>> -------------------------------------
>> |           | PT_LOAD 1 | PT_LOAD 2 |
>> -------------------------------------
>>
>> right? In the move, Does PT_LOAD 1 overwrite the original PT_LOAD 2?
>>
> 
> Right and yes, see man memmove and man memcpy, and please compare
> them.
> 

I see. memmove will always handle well even if there is overlapping between dest and src.

Thanks
Zhang

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
