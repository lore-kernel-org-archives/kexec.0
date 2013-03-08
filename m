Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-x233.google.com ([2607:f8b0:4001:c03::233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UE1yQ-0006t4-GW
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 18:24:59 +0000
Received: by mail-ie0-f179.google.com with SMTP id k11so2449621iea.24
 for <kexec@lists.infradead.org>; Fri, 08 Mar 2013 10:24:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5139D5A0.6000600@redhat.com>
References: <51397D1D.5030602@redhat.com>
 <1750036321.11235774.1362722613994.JavaMail.root@redhat.com>
 <CAE9FiQUtDcwJkPMPfjur8LQ+u0Hc2J7sbxC=xkcemqRQ1_Gd8g@mail.gmail.com>
 <CAE9FiQU7ccdWCL=t=Zn1w33GHpHk56=JXTcotn-Huq9Wiqu7wg@mail.gmail.com>
 <51399154.5030500@redhat.com>
 <CAE9FiQVPaG5P7mG9HoFzCkaxF62hkU5hEtq_FhdT7n+38aNs9A@mail.gmail.com>
 <51399442.1080609@redhat.com>
 <CAE9FiQWCfnOjOuWKihv1GamgHb4KLrrPEiBTspQMqK7_fBDunw@mail.gmail.com>
 <5139D5A0.6000600@redhat.com>
Date: Fri, 8 Mar 2013 10:24:52 -0800
Message-ID: <CAE9FiQU7RP8zTsm9QMnANf8-a9=QRY9Y6sFdEev7+YWd87NDAw@mail.gmail.com>
Subject: Re: 3.9-rc1: crash kernel panic - not syncing: Can not allocate
 SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer
From: Yinghai Lu <yinghai@kernel.org>
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
To: WANG Chao <chaowang@redhat.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, CAI Qian <caiqian@redhat.com>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@linux.intel.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Mar 8, 2013 at 4:12 AM, WANG Chao <chaowang@redhat.com> wrote:

>> what is 00:02.0 in your system?
> This IOMMU issue is related to https://lkml.org/lkml/2012/11/26/814. We can
> discuss this IOMMU issue in that thread.
> Anyway 00:02.0 is a video card, the box is Ivy Bridge.
> # lspci -s 00:02.0 -v
> 00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor
> Graphics Controller (rev 09) (prog-if 00 [VGA controller])
>         Subsystem: Intel Corporation Device 2211
>         Flags: bus master, fast devsel, latency 0, IRQ 44
>         Memory at afc00000 (64-bit, non-prefetchable) [size=4M]
>         Memory at c0000000 (64-bit, prefetchable) [size=256M]
>         I/O ports at 6000 [size=64]
>         Expansion ROM at <unassigned> [disabled]
>         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>         Capabilities: [d0] Power Management version 2
>         Capabilities: [a4] PCI Advanced Features
>         Kernel driver in use: i915

disable drm for i915 will make your iommu work with dump?

>
>
> Is it expected to intel_iommu=on or crashkernel_low to make 2nd kernel boot in
> 3.9? Back in 3.8, it works just fine w/ only crashkernel param.

Yes, I really do not want to set crashkernel low range like 72M
automatically for all.
that would have the system with proper iommu support lose 72M under 4G
in first kernel.
And can not play allocate and return tricks, as first kernel have no
idea if iommu will work
on second kernel even iommu is working on first kernel.

Better to fix iommu support at first.

For old system that does not have DMAR or kernel does not have IOMMU
support enabled, or
user does not pass intel_iommu=on.
We could set crashkernel low range to 72M automatically.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
