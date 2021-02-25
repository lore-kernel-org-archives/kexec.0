Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFB1f-00035u-Gw
 for kexec@lists.infradead.org; Thu, 25 Feb 2021 07:25:32 +0000
Date: Thu, 25 Feb 2021 15:25:15 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment
 with macro CRASH_ALIGN
Message-ID: <20210225072426.GH3553@MiWiFi-R3L-srv>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
 <20210130071025.65258-2-chenzhou10@huawei.com>
 <20210224141939.GA28965@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210224141939.GA28965@arm.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>, ebiederm@xmission.com
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, rppt@kernel.org, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On 02/24/21 at 02:19pm, Catalin Marinas wrote:
> On Sat, Jan 30, 2021 at 03:10:15PM +0800, Chen Zhou wrote:
> > Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
> > alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
> > function reserve_crashkernel() also used 1M alignment. So just
> > replace hard-coded alignment 1M with macro CRASH_ALIGN.
> [...]
> > @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
> >  	} else {
> >  		unsigned long long start;
> >  
> > -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
> > +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
> >  						  crash_base + crash_size);
> >  		if (start != crash_base) {
> >  			pr_info("crashkernel reservation failed - memory is in use.\n");
> 
> There is a small functional change here for x86. Prior to this patch,
> crash_base passed by the user on the command line is allowed to be 1MB
> aligned. With this patch, such reservation will fail.
> 
> Is the current behaviour a bug in the current x86 code or it does allow
> 1MB-aligned reservations?

Hmm, you are right. Here we should keep 1MB alignment as is because
users specify the address and size, their intention should be respected.
The 1MB alignment for fixed memory region reservation was introduced in
below commit, but it doesn't tell what is Eric's request at that time, I
guess it meant respecting users' specifying.

commit 44280733e71ad15377735b42d8538c109c94d7e3
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Sun Nov 22 17:18:49 2009 -0800

    x86: Change crash kernel to reserve via reserve_early()
    
    use find_e820_area()/reserve_early() instead.
    
    -v2: address Eric's request, to restore original semantics.
         will fail, if the provided address can not be used.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
