Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ud8EB-0003Xa-Js
 for kexec@lists.infradead.org; Fri, 17 May 2013 00:08:57 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 4F7AB3EE081
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 09:08:29 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F2BE45DE5B
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 09:08:29 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 26DFC45DE58
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 09:08:29 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1A4151DB804F
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 09:08:29 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id C23281DB8047
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 09:08:28 +0900 (JST)
Message-ID: <519574E8.5020704@jp.fujitsu.com>
Date: Fri, 17 May 2013 09:08:08 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/8] vmcore: allocate buffer for ELF headers on
 page-size alignment
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
 <20130515090551.28109.73350.stgit@localhost6.localdomain6>
 <20130516165105.GB8726@redhat.com>
In-Reply-To: <20130516165105.GB8726@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, jingbai.ma@hp.com

(2013/05/17 1:51), Vivek Goyal wrote:
> On Wed, May 15, 2013 at 06:05:51PM +0900, HATAYAMA Daisuke wrote:
>
> [..]
>> @@ -398,9 +403,7 @@ static int __init process_ptload_program_headers_elf64(char *elfptr,
>>   	phdr_ptr = (Elf64_Phdr*)(elfptr + sizeof(Elf64_Ehdr)); /* PT_NOTE hdr */
>>
>>   	/* First program header is PT_NOTE header. */
>> -	vmcore_off = sizeof(Elf64_Ehdr) +
>> -			(ehdr_ptr->e_phnum) * sizeof(Elf64_Phdr) +
>> -			phdr_ptr->p_memsz; /* Note sections */
>> +	vmcore_off = elfsz + roundup(phdr_ptr->p_memsz, PAGE_SIZE);
>>
>>   	for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
>>   		if (phdr_ptr->p_type != PT_LOAD)
>> @@ -435,9 +438,7 @@ static int __init process_ptload_program_headers_elf32(char *elfptr,
>>   	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr)); /* PT_NOTE hdr */
>>
>>   	/* First program header is PT_NOTE header. */
>> -	vmcore_off = sizeof(Elf32_Ehdr) +
>> -			(ehdr_ptr->e_phnum) * sizeof(Elf32_Phdr) +
>> -			phdr_ptr->p_memsz; /* Note sections */
>> +	vmcore_off = elfsz + roundup(phdr_ptr->p_memsz, PAGE_SIZE);
>
> Hmm.., so we are rounding up ELF note data size too here. I think this belongs
> in some other patch as in this patch we are just rounding up the elf
> headers.
>
> This might create read problems too as we have not taking care of this
> rounding when adding note to vc_list and it might happen that we are
> reading wrong data at a particular offset.
>
> So may be this rounding up we should do in later patches when we take
> care of copying ELF notes data to second kernel.
>
> Vivek
>

This is my careless fault. They should have been in 6/7.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
