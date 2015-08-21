Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSt4u-0002Uu-3G
 for kexec@lists.infradead.org; Fri, 21 Aug 2015 20:38:20 +0000
Message-ID: <006bee38a745c1ca9199870ca8cc600b.squirrel@www.codeaurora.org>
In-Reply-To: <20150821034433.GB26132@dhcppc13.redhat.com>
References: <20150624033241.GA22348@localhost.localdomain>
 <558A25A3.60504@codeaurora.org>
 <20150627082256.GE21646@localhost.localdomain>
 <ddc87d025100347122b078b5104ec88c.squirrel@www.codeaurora.org>
 <20150703043241.GC21990@dhcppc13.redhat.com>
 <2c41ac3516494a1cc5d05462494b333b.squirrel@www.codeaurora.org>
 <c0ce0a0ea4482e9fca97b5c811f4693b.squirrel@www.codeaurora.org>
 <d0d13b96c02d5b54afcda30723667dab.squirrel@www.codeaurora.org>
 <20150820112150.GA26132@dhcppc13.redhat.com>
 <cd279166af08eba11be211481f319ab8.squirrel@www.codeaurora.org>
 <20150821034433.GB26132@dhcppc13.redhat.com>
Date: Fri, 21 Aug 2015 20:37:57 -0000
Subject: Re: [PATCH] makedumpfile: Support ARM64
From: sgoel@codeaurora.org
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: Timur Tabi <timur@codeaurora.org>, Azriel Samson <asamson@codeaurora.org>, kexec@lists.infradead.org, sgoel@codeaurora.org, virajm@codeaurora.org, ats-kumagai@wm.jp.nec.com

> Can you compare "Virtual kernel memory layout:" print of Linux kernel boot
> with
> makedumpfile print for page_offset, vmalloc_start, vmemmap_start etc, and
> see if
> they match?
>
> They should match.


Yes this was a problem. The assumed Kernel struct page size in the tool is
64. For our platform this evaluates to 56. After changing this value all
the memory mapping values match.

I wanted to ask if the page table translation function would be any
different if the page size is 4k instead of 64k?

Thanks,
Sameer


> Hi Sameer,
>
> On 20/08/2015:04:11:24 PM, sgoel@codeaurora.org wrote:
>> Hi Pratush,
>> I have made the change now.
>>
>> The reason for changing the KVBASE was to get non zero value for mem_map
>> as seen from the crash tool. If KVBASE stays at page offset we do not
>> get
>> into the function that looks for the free pages.
>
> OK.. I made the change for KVBASE and pushed it to my github repo.
>
>>
>> After looking at the page usage using the crash tool it seems that ~80%
>> of
>> the pages are free.
>>
>> Maybe there is something else that I am missing here. The page look up
>> fails when writing the crashdump file.
>
> Not sure if you can share the output with --message-level 31, but do you
> see any
> thing susceptible there?
>
> # makedumpfile -l --message-level 31 rawvmcore makedumpfilevmcore
>
> Can you compare "Virtual kernel memory layout:" print of Linux kernel boot
> with
> makedumpfile print for page_offset, vmalloc_start, vmemmap_start etc, and
> see if
> they match?
>
> They should match.
>
> ~Pratyush
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
