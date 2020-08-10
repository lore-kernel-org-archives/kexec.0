Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k50qY-0004Fi-3z
 for kexec@lists.infradead.org; Mon, 10 Aug 2020 05:59:48 +0000
Date: Mon, 10 Aug 2020 13:59:20 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
Message-ID: <20200810055920.GA6988@dhcp-128-65.nay.redhat.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
 <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
 <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
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

On 08/10/20 at 11:28am, chenzhou wrote:
> On 2020/8/8 18:02, Dave Young wrote:
> > On 08/01/20 at 09:08pm, Chen Zhou wrote:
> >> Now the behavior of crashkernel=X has been changed, which tries low
> >> allocation in ZONE_DMA, and fall back to high allocation if it fails.
> >>
> >> If requized size X is too large and leads to very little free memory
> >> in ZONE_DMA after low allocation, the system may not work well.
> >> So add a threshold and go for high allocation directly if the required
> >> size is too large. The threshold is set as the half of low memory.
> >>
> >> If crash_base is outside ZONE_DMA, try to allocate at least 256M in
> >> ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
> >> specified size low memory. For non-RPi4 platforms, change ZONE_DMA
> >> memtioned above to ZONE_DMA32.
> >>
> >> So update the Documentation.
> >>
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> ---
> >>  Documentation/admin-guide/kdump/kdump.rst     | 21 ++++++++++++++++---
> >>  .../admin-guide/kernel-parameters.txt         | 11 ++++++++--
> >>  2 files changed, 27 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> >> index 2da65fef2a1c..4b58f97351d5 100644
> >> --- a/Documentation/admin-guide/kdump/kdump.rst
> >> +++ b/Documentation/admin-guide/kdump/kdump.rst
> >> @@ -299,7 +299,15 @@ Boot into System Kernel
> >>     "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
> >>     starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
> >>  
> >> -   On x86 and x86_64, use "crashkernel=64M@16M".
> >> +   On x86 use "crashkernel=64M@16M".
> >> +
> >> +   On x86_64, use "crashkernel=X" to select a region under 4G first, and
> >> +   fall back to reserve region above 4G.
> >> +   We can also use "crashkernel=X,high" to select a region above 4G, which
> >> +   also tries to allocate at least 256M below 4G automatically and
> >> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
> >> +   Use "crashkernel=Y@X" if you really have to reserve memory from specified
> >> +   start address X.
> >>  
> >>     On ppc64, use "crashkernel=128M@32M".
> >>  
> >> @@ -316,8 +324,15 @@ Boot into System Kernel
> >>     kernel will automatically locate the crash kernel image within the
> >>     first 512MB of RAM if X is not given.
> >>  
> >> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> >> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> >> +   On arm64, use "crashkernel=X" to try low allocation in ZONE_DMA, and
> >> +   fall back to high allocation if it fails. And go for high allocation
> >> +   directly if the required size is too large. If crash_base is outside
> >> +   ZONE_DMA, try to allocate at least 256M in ZONE_DMA automatically.
> >> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
> >> +   For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.
> >> +   Use "crashkernel=Y@X" if you really have to reserve memory from
> >> +   specified start address X. Note that the start address of the kernel,
> >> +   X if explicitly specified, must be aligned to 2MiB (0x200000).
> >>  
> >>  Load the Dump-capture Kernel
> >>  ============================
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index fb95fad81c79..d1b6016850d6 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -722,6 +722,10 @@
> >>  			[KNL, x86_64] select a region under 4G first, and
> >>  			fall back to reserve region above 4G when '@offset'
> >>  			hasn't been specified.
> >> +			[KNL, arm64] Try low allocation in ZONE_DMA, fall back
> >> +			to high allocation if it fails when '@offset' hasn't been
> >> +			specified. For non-RPi4 platforms, change ZONE_DMA to
> >> +			ZONE_DMA32.
> >>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
> >>  
> >>  	crashkernel=range1:size1[,range2:size2,...][@offset]
> >> @@ -746,13 +750,16 @@
> >>  			requires at least 64M+32K low memory, also enough extra
> >>  			low memory is needed to make sure DMA buffers for 32-bit
> >>  			devices won't run out. Kernel would try to allocate at
> >> -			at least 256M below 4G automatically.
> >> +			least 256M below 4G automatically.
> >>  			This one let user to specify own low range under 4G
> >>  			for second kernel instead.
> >>  			0: to disable low allocation.
> >>  			It will be ignored when crashkernel=X,high is not used
> >>  			or memory reserved is below 4G.
> >> -
> >> +			[KNL, arm64] range under 4G.
> >> +			This one let user to specify a low range in ZONE_DMA for
> >> +			crash dump kernel. For non-RPi4 platforms, change ZONE_DMA
> >> +			to ZONE_DMA32.
> >>  	cryptomgr.notests
> >>  			[KNL] Disable crypto self-tests
> >>  
> >> -- 
> >> 2.20.1
> >>
> > Hi Chen,
> >
> > Previously I remember we talked about to use similar logic as X86, but I
> > remember you mentioned on some arm64 platform there could be no low
> > memory at all.  Is this not a problem now for the fallback?  Just be
> > curious, thanks for the update, for the common part looks good.
> Hi Dave,
> 
> Did you mean this discuss: https://lkml.org/lkml/2019/12/27/122?
> This is about the different implementation instead of no low memory in arm64.
> 
> On arm64 platform, if there is no low memory, system will boot fail.

James mentioned some systems have no memory below 4G, if I understand it
correctly that means they can boot without low mem.

Anyway I like the new implementation in this series if it is good enough
for arm64 people.

> 
> Thanks,
> Chen Zhou
> >
> > Acked-by: Dave Young <dyoung@redhat.com>
> >
> > Thanks
> > Dave
> >
> >
> > .
> >
> 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
