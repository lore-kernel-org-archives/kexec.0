Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqmlE-00072S-O1
 for kexec@lists.infradead.org; Mon, 04 Feb 2019 22:30:42 +0000
Date: Mon, 4 Feb 2019 15:30:16 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190204223016.GB11986@anatevka>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190131234740.GO6749@zn.tnic>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: Jerry.Hoemann@hpe.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, Baoquan He <bhe@redhat.com>, yinghai@kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On Fri, Feb 01, 2019 at 12:47:40AM +0100, Borislav Petkov wrote:
> On Thu, Jan 31, 2019 at 03:27:32PM -0700, Jerry Hoemann wrote:
> > So even if a system administrator is diligent and tests
> > that a chosen kdump configuration works, that configuration
> > might not work on some random reboot 7 months in the future.
> 
> Jerry, did you read the rest of the thread where I'm *actually*
> suggesting to make the allocation code more robust against such
> failures?


Boris,

I may have misunderstood your earlier comment:

  So we don't really need this - we simply need to tell people to use high
  if it fails with KASLR, AFAICT

To imply an iterative approach to crashkernel size discovery.  Whereas you
may simply have ment:  Always use ,high as the old way is broken.


> Now let's look at the code:
> 
> The "high" allocation does:
> 
>                 crash_base = memblock_find_in_range(CRASH_ALIGN,
>                                                     high ? CRASH_ADDR_HIGH_MAX
>                                                          : CRASH_ADDR_LOW_MAX,
>                                                     crash_size, CRASH_ALIGN);
> 
> where high=true and CRASH_ADDR_HIGH_MAX on 64-bit is MAXMEM:
> 
> # define CRASH_ADDR_HIGH_MAX    MAXMEM
> 
> The second fallback in the suggested patch does the same:
> 
> +               /*
> +                * crashkernel=X reserve below 4G fails? Try MAXMEM
> +                */
> +               if (!high && !crash_base)
> +                       crash_base = memblock_find_in_range(CRASH_ALIGN,
> +                                               CRASH_ADDR_HIGH_MAX,
> +                                               crash_size, CRASH_ALIGN);
> 
> and yet I get back that falling back to "high" if the first allocation
> doesn't succeed is not something we should do by default because of
> reasons. But this patch *practically* *does* it.


Is your objection only to the second fallback of allocating
memory above >= 4GB?   Or are you objecting to allocating from
(896 .. 4GB) as well?

Falling back to allocating < 4GB probably satisfes most of the cases
where the original allocation fails.

thanks

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
