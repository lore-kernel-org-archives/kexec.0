Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3Ijp-0002wU-Ou
 for kexec@lists.infradead.org; Wed, 26 Apr 2017 08:55:55 +0000
Subject: Re: [PATCH v2 1/2] x86/mm/ident_map: Add PUD level 1GB page support
References: <1493192562-6669-1-git-send-email-xlpang@redhat.com>
 <20170426080905.gvfjwpoknsgcrsyd@gmail.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <590060C1.5000904@redhat.com>
Date: Wed, 26 Apr 2017 16:56:33 +0800
MIME-Version: 1.0
In-Reply-To: <20170426080905.gvfjwpoknsgcrsyd@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>, Xunlei Pang <xlpang@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org, Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 04/26/2017 at 04:09 PM, Ingo Molnar wrote:
> * Xunlei Pang <xlpang@redhat.com> wrote:
>
>> The current kernel_ident_mapping_init() creates the identity
>> mapping using 2MB page(PMD level), this patch adds the 1GB
>> page(PUD level) support.
>>
>> This is useful on large machines to save some reserved memory
>> (as paging structures) in the kdump case when kexec setups up
>> identity mappings before booting into the new kernel.
>>
>> We will utilize this new support in the following patch.
> Well, the primary advantage would be better TLB coverage/performance, because we'd 
> utilize 1GB TLBs instead of 2MB ones, right?
>
> Any kexec fallout is secondary.
>
> And I'd like to hear more about the primary advantage: what are the effects of 
> this change on a typical test system you have access to:
>
> - For example what percentage of the identity mapping was 4K mapped (if any) and
>   2MB mapped - and how did this change due to the patch - how many 2MB mappings
>   remained and how many 1GB mappings were added?
>
> - Is there anything else we could do to improve the in-RAM layout of kernel data 
>   structures. For example IIRC the CPU breaks up all TLBs under 2MB physical into 
>   4K TLBs. Is this the current limit and could we just reserve all that space and 
>   not use it for anything important? 2MB of RAM wasted is a very small amount of 
>   space, compared to the potential performance advantages.

Currently kernel_ident_mapping_init() only setups PMD large pages, seems there are no 4KB
mapped or others. Do you mean init_memory_mapping()->kernel_physical_mapping_init()?

The new struct x86_mapping_info::direct_gbpages added has the default value false, it has no
effect on the existing code, after patch 2, there will be 1GB pages(1GB TLBs) for kexec ident
mapping if direct_gbpages is true.

>
>>  	void *(*alloc_pgt_page)(void *); /* allocate buf for page table */
>>  	void *context;			 /* context for alloc_pgt_page */
>> -	unsigned long pmd_flag;		 /* page flag for PMD entry */
>> +	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
>>  	unsigned long offset;		 /* ident mapping offset */
>> +	bool direct_gbpages;		/* PUD level 1GB page support */
> Doesn't follow the existing alignment.

Ah, yes, missed the space. Thanks!

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
