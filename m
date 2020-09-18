Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ8va-0000r1-Dz
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 05:27:23 +0000
Date: Fri, 18 Sep 2020 13:26:57 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v12 3/9] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel[_low]()
Message-ID: <20200918052657.GA35322@dhcp-128-65.nay.redhat.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-4-chenzhou10@huawei.com>
 <20200918030112.GA3356@dhcp-128-65.nay.redhat.com>
 <d4296985-7296-b5c9-45f3-b03d28bc7bd8@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d4296985-7296-b5c9-45f3-b03d28bc7bd8@huawei.com>
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
To: chenzhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, catalin.marinas@arm.com, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On 09/18/20 at 11:57am, chenzhou wrote:
> Hi Dave,
> 
> 
> On 2020/9/18 11:01, Dave Young wrote:
> > On 09/07/20 at 09:47pm, Chen Zhou wrote:
> >> To make the functions reserve_crashkernel[_low]() as generic,
> >> replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.
> >>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> ---
> >>  arch/x86/kernel/setup.c | 11 ++++++-----
> >>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >> index d7fd90c52dae..71a6a6e7ca5b 100644
> >> --- a/arch/x86/kernel/setup.c
> >> +++ b/arch/x86/kernel/setup.c
> >> @@ -430,7 +430,7 @@ static int __init reserve_crashkernel_low(void)
> >>  	unsigned long total_low_mem;
> >>  	int ret;
> >>  
> >> -	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> >> +	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
> > total_low_mem != CRASH_ADDR_LOW_MAX
> I just replace the magic number with macro, no other change.
> Besides, function memblock_mem_size(limit_pfn) will compute the memory size
> according to the actual system ram.
> 

Ok, it is not obvious in patch this is 64bit only, I'm fine with this
then.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
