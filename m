Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKxs2-0007Aw-LI
 for kexec@lists.infradead.org; Thu, 07 Jul 2016 01:12:51 +0000
Received: by mail-pf0-x231.google.com with SMTP id c2so1139881pfa.2
 for <kexec@lists.infradead.org>; Wed, 06 Jul 2016 18:12:30 -0700 (PDT)
Date: Thu, 7 Jul 2016 10:17:47 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v21 1/8] arm64: kdump: reserve memory for crash dump kernel
Message-ID: <20160707011745.GX20774@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-2-takahiro.akashi@linaro.org>
 <2543175.KeBui093Sr@hactar>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2543175.KeBui093Sr@hactar>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Pratyush Anand <panand@redhat.com>, geoff@infradead.org, catalin.marinas@arm.com, kexec@lists.infradead.org, will.deacon@arm.com, james.morse@arm.com, Mark Salter <msalter@redhat.com>, linux-arm-kernel@lists.infradead.org

On Wed, Jul 06, 2016 at 03:11:45PM -0300, Thiago Jung Bauermann wrote:
> Am Mittwoch, 06 Juli 2016, 16:52:19 schrieb AKASHI Takahiro:
> > On the startup of primary kernel, the memory region used by crash dump
> > kernel must be specified by "crashkernel=" kernel parameter.
> > reserve_crashkernel() will allocate and reserve the region for later use.
> > 
> > User space tools, like kexec-tools, will be able to find that region
> > marked as "Crash kernel" in /proc/iomem.
> 
> On powerpc, userspace tools get everything from the device tree (exposed to 
> userspace in /proc/device-tree/), not /proc/iomem.

I started my kdump patches with arm (not arm64) implementation, and
so /proc/iomem is used for consistency. Since my kexec-tools (for arm64)
have to access /proc/iomem to identify usable memory regions on
*UEFI* systems anyway, I didn't think it was odd.

(Please note that UEFI won't expose memory regions information via
a device tree, but via ACPI table.)

> In the case of the crashkernel reserved region, that information is in 
> /chosen/linux,crashkernel-base and /chosen/linux,crashkernel-size.
> 
> Either way is fine I think. I'm just mentioning this for reference in case 
> you want the ARM implementation to be closer to another arch which is also 
> based on the device tree.

Adding those properties to a device tree is quite easy
(and it won't conflict with /proc/iomem), so I'd like 
to defer to arm64 maintainers.

Thanks,
-Takahiro AKASHI

> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
