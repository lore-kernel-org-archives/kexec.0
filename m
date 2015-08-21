Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZSgnn-0006N9-5m
 for kexec@lists.infradead.org; Fri, 21 Aug 2015 07:31:52 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: Support ARM64
Date: Fri, 21 Aug 2015 07:25:03 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DE493C@BPXM01GP.gisp.nec.co.jp>
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
In-Reply-To: <20150821034433.GB26132@dhcppc13.redhat.com>
Content-Language: ja-JP
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
To: Pratyush Anand <panand@redhat.com>, "sgoel@codeaurora.org" <sgoel@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>, "virajm@codeaurora.org" <virajm@codeaurora.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Azriel Samson <asamson@codeaurora.org>

Hello,

>> I am not sure if KVBASE should be VMALLOC_START. May be Atsushi can
>> comment on that.

This is a just reply to the above.

[snip]
>> The reason for changing the KVBASE was to get non zero value for mem_map
>> as seen from the crash tool. If KVBASE stays at page offset we do not get
>> into the function that looks for the free pages.
>
>OK.. I made the change for KVBASE and pushed it to my github repo.

KVBASE just means where kernel address spaces begins, it is just set to
PAGE_OFFSET(0xffff880000000000) in x86_64 as an implementation according to
the specification.

In arm64, I'm not sure the memory model but you also should set it
according to the specification of the memory layout of arm64 to walk the
page table correctly.
In my quick check, it looks the kernel address space begins at the vmalloc
region in arm64, so I guess your change is reasonable.


Thanks,
Atsushi Kumagai

>>
>> After looking at the page usage using the crash tool it seems that ~80% of
>> the pages are free.
>>
>> Maybe there is something else that I am missing here. The page look up
>> fails when writing the crashdump file.
>
>Not sure if you can share the output with --message-level 31, but do you see any
>thing susceptible there?
>
># makedumpfile -l --message-level 31 rawvmcore makedumpfilevmcore
>
>Can you compare "Virtual kernel memory layout:" print of Linux kernel boot with
>makedumpfile print for page_offset, vmalloc_start, vmemmap_start etc, and see if
>they match?
>
>They should match.
>
>~Pratyush
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
