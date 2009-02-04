Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.248])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LUY6I-0006Yk-LD
	for kexec@lists.infradead.org; Wed, 04 Feb 2009 03:06:58 +0000
Received: by rv-out-0708.google.com with SMTP id b17so2507524rvf.42
	for <kexec@lists.infradead.org>; Tue, 03 Feb 2009 19:06:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090204022905.GM7199@verge.net.au>
References: <1233642168.19806.74.camel@yhuang-dev.sh.intel.com>
	<20090204022905.GM7199@verge.net.au>
Date: Wed, 4 Feb 2009 12:06:52 +0900
Message-ID: <aec7e5c30902031906k7fe8947kc429ffc0274eb930@mail.gmail.com>
Subject: Re: [PATCH resend] kexec/x86_64: Use one page table in x86_64 
	machine_kexec
From: Magnus Damm <magnus.damm@gmail.com>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Feb 4, 2009 at 11:29 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Feb 03, 2009 at 02:22:48PM +0800, Huang Ying wrote:
>> Impact: reduce kernel BSS size by 7 pages, improve code readability
>>
>> Two page tables are used in current x86_64 kexec implementation. One
>> is used to jump from kernel virtual address to identity map address,
>> the other is used to map all physical memory. In fact, on x86_64,
>> there is no conflict between kernel virtual address space and physical
>> memory space, so just one page table is sufficient. The page table
>> pages used to map control page are dynamically allocated to save
>> memory if kexec image is not loaded. ASM code used to map control page
>> is replaced by C code too.
>
> Hi Huang,
>
> this patch looks quite nice to me. I am CCing my former colleague Magnus
> Damm for comment. He did some work in this area a little while ago.

Thanks for the ping Simon!

I like the idea of dynamically allocating pages and writing code in C
instead of ASM. In fact, this patch is not so far away from what V2 of
my patches did a few years ago:

http://lkml.org/lkml/2006/5/24/12

For one reason or another this wasn't acceptable at that point so I
rewrote things and V4 got merged with static page tables and ASM code.

This patch is a step in the right direction IMO, but I'm not sure how
it affects the Xen dom0 implementation. Does it still work and/or does
anyone care?

Cheers,

/ magnus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
