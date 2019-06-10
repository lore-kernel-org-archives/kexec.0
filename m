Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1haHjV-0005jF-Lt
 for kexec@lists.infradead.org; Mon, 10 Jun 2019 10:40:59 +0000
Received: by mail-pf1-f193.google.com with SMTP id i189so5058286pfg.10
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2019 03:40:57 -0700 (PDT)
Subject: Re: [PATCH v2 00/12] 52-bit kernel + user VAs
References: <20190528161026.13193-1-steve.capper@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <762411c4-1148-a10e-2a79-d2c9e38bc46e@redhat.com>
Date: Mon, 10 Jun 2019 16:10:50 +0530
MIME-Version: 1.0
In-Reply-To: <20190528161026.13193-1-steve.capper@arm.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Steve Capper <steve.capper@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: crecklin@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Steve,

Thanks for the v2. I still did not get much time to go through this in 
deep and have a go with the same on LVA supporting prototype platforms 
or old CPUs (which don't support ARMv8.2 LVA/LPA extensions) I have. May 
be I will give this a quick check on the same in a day or two.

On 05/28/2019 09:40 PM, Steve Capper wrote:
> This patch series adds support for 52-bit kernel VAs using some of the
> machinery already introduced by the 52-bit userspace VA code in 5.0.
> 
> As 52-bit virtual address support is an optional hardware feature,
> software support for 52-bit kernel VAs needs to be deduced at early boot
> time. If HW support is not available, the kernel falls back to 48-bit.
> 
> A significant proportion of this series focuses on "de-constifying"
> VA_BITS related constants.
> 
> In order to allow for a KASAN shadow that changes size at boot time, one
> must fix the KASAN_SHADOW_END for both 48 & 52-bit VAs and "grow" the
> start address. Also, it is highly desirable to maintain the same
> function addresses in the kernel .text between VA sizes. Both of these
> requirements necessitate us to flip the kernel address space halves s.t.
> the direct linear map occupies the lower addresses.
> 
> In V2 of this series (apologies for the long delay from V1), the major
> change is that PAGE_OFFSET is retained as a constant. This allows for
> much faster virt_to_page computations. This is achieved by expanding the
> size of the VMEMMAP region to accommodate a disjoint 52-bit/48-bit
> direct linear map. This has been found to work well in my testing, but I
> would appreciate any feedback on this if it needs changing. To aid with
> git bisect, this logic is broken down into a few smaller patches.
> 
> As far as I'm aware, there are two outstanding issues with this series
> that need to be resolved:
>   1) Is the code patching for ttbr1_offset safe? I need to analyse this
>      a little more,
>   2) How can this memory map be advertised to kdump tools/documentation?
>      I was planning on getting the kernel VA structure agreed on, then I
>      would add the relevant exports/documentation.


Indeed, in the absence of corresponding changes to the Documentation 
section,
it is hard to visualize the changes being made in the memory map.

Also I would suggest that we note in the patchset itself (may be the git 
log) that kdump tools (or even crash for that matter) will be broken 
with this patchset - to prevent kernel bugs being reported.

BTW, James and I are already discussing more coherent methods (see [0]) 
to manage this exporting of information to user-land (so to that we can 
save ourselves from requiring to export new variables in the vmcoreinfo 
in case we have similar changes to the virtual/physical address spaces 
in future).

I will work on and send a patchset addressing the same shortly.

[0]. http://lists.infradead.org/pipermail/kexec/2019-June/023105.html

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
