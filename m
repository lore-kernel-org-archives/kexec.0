Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kE27V-00010G-0q
 for kexec@lists.infradead.org; Fri, 04 Sep 2020 03:10:34 +0000
Date: Fri, 4 Sep 2020 11:10:14 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v11 3/5] arm64: kdump: reimplement crashkernel=X
Message-ID: <20200904031014.GA11869@dhcp-128-65.nay.redhat.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-4-chenzhou10@huawei.com>
 <20200902170910.GB16673@gaia>
 <f33a0ce6-552e-2f1a-e720-4f7124f15d1e@huawei.com>
 <20200904030424.GA11384@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200904030424.GA11384@dhcp-128-65.nay.redhat.com>
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
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On 09/04/20 at 11:04am, Dave Young wrote:
> On 09/03/20 at 07:26pm, chenzhou wrote:
> > Hi Catalin,
> > 
> > 
> > On 2020/9/3 1:09, Catalin Marinas wrote:
> > > On Sat, Aug 01, 2020 at 09:08:54PM +0800, Chen Zhou wrote:
> > >> There are following issues in arm64 kdump:
> > >> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> > >> will fail when there is no enough low memory.
> > >> 2. If reserving crashkernel above 4G, in this case, crash dump
> > >> kernel will boot failure because there is no low memory available
> > >> for allocation.
> > >> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
> > >> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
> > >> the devices in crash dump kernel need to use ZONE_DMA will alloc
> > >> fail.
> > >>
> > >> To solve these issues, change the behavior of crashkernel=X.
> > >> crashkernel=X tries low allocation in ZONE_DMA, and fall back to
> > >> high allocation if it fails.
> > >>
> > >> If requized size X is too large and leads to very little free memory
> > >> in ZONE_DMA after low allocation, the system may not work normally.
> > >> So add a threshold and go for high allocation directly if the required
> > >> size is too large. The value of threshold is set as the half of
> > >> the low memory.
> > >>
> > >> If crash_base is outside ZONE_DMA, try to allocate at least 256M in
> > >> ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
> > >> specified size low memory.
> > > Except for the threshold to keep zone ZONE_DMA memory,
> > > reserve_crashkernel() looks very close to the x86 version. Shall we try
> > > to make this generic as well? In the first instance, you could avoid the
> > > threshold check if it takes an explicit ",high" option.
> > Ok, i will try to do this.
> > 
> > I look into the function reserve_crashkernel() of x86 and found the start address is
> > CRASH_ALIGN in function memblock_find_in_range(), which is different with arm64.
> > 
> > I don't figure out why is CRASH_ALIGN in x86, is there any specific reason?
> 
> Hmm, took another look at the option CONFIG_PHYSICAL_ALIGN
> config PHYSICAL_ALIGN
>         hex "Alignment value to which kernel should be aligned"
>         default "0x200000"
>         range 0x2000 0x1000000 if X86_32
>         range 0x200000 0x1000000 if X86_64
> 
> According to above, I think the 16M should come from the largest value
> But the default value is 2M,  with smaller value reservation can have
> more chance to succeed.
> 
> It seems we still need arch specific CRASH_ALIGN, but the initial
> version you added the #ifdef for different arches, can you move the
> macro to arch specific headers?

And just keep the x86 align value as is, I can try to change the x86
value later to CONFIG_PHYSICAL_ALIGN, in this way this series can be
cleaner.

> 
> Thanks
> Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
