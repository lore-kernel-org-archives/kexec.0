Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hFtnJ-0003Iq-Cn
 for kexec@lists.infradead.org; Mon, 15 Apr 2019 05:04:38 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3F53IQ1122905
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2019 01:04:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rvhgfvug2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2019 01:04:36 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 15 Apr 2019 06:04:34 +0100
Date: Mon, 15 Apr 2019 08:04:18 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] arm64: kdump: support more than one crash kernel
 regions
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-4-chenzhou10@huawei.com>
 <20190410130917.GC17196@rapoport-lnx>
 <137bef2e-8726-fd8f-1cb0-7592074f7870@huawei.com>
 <20190414121058.GC20947@rapoport-lnx>
 <b5206f0c-d711-427e-256a-98b2e30c1ab0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5206f0c-d711-427e-256a-98b2e30c1ab0@huawei.com>
Message-Id: <20190415050417.GB6167@rapoport-lnx>
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
To: Chen Zhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, horms@verge.net.au, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, takahiro.akashi@linaro.org, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, kexec@lists.infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

Hi,

On Mon, Apr 15, 2019 at 10:05:18AM +0800, Chen Zhou wrote:
> Hi Mike,
> 
> On 2019/4/14 20:10, Mike Rapoport wrote:
> >>
> >> solution A: 	phys_addr_t start[INIT_MEMBLOCK_RESERVED_REGIONS * 2];
> >> 		phys_addr_t end[INIT_MEMBLOCK_RESERVED_REGIONS * 2];
> >> start, end is physical addr
> >>
> >> solution B: 	int start_rgn[INIT_MEMBLOCK_REGIONS], end_rgn[INIT_MEMBLOCK_REGIONS];
> >> start_rgn, end_rgn is rgn index		
> >>
> >> Solution B do less remove operations and with no warning comparing to solution A.
> >> I think solution B is better, could you give some suggestions?
> >  
> > Solution B is indeed better that solution A, but I'm still worried by
> > relatively large arrays on stack and the amount of loops :(
> > 
> > The very least we could do is to call memblock_cap_memory_range() to drop
> > the memory before and after the ranges we'd like to keep.
> 
> 1. relatively large arrays
> As my said above, the start_rgn, end_rgn is rgn index, we could use unsigned char type.

Let's stick to int for now

> 2. loops
> Loops always exist, and the solution with fewer loops may be just encapsulated well.

Of course the loops are there, I just hoped we could get rid of the nested
loop and get away with single passes in all the cases.
Apparently it's not the case :(

> Thanks,
> Chen Zhou
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
