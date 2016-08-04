Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bV7JL-0003MG-Ev
 for kexec@lists.infradead.org; Thu, 04 Aug 2016 01:19:01 +0000
Received: by mail-pf0-x233.google.com with SMTP id h186so82183952pfg.3
 for <kexec@lists.infradead.org>; Wed, 03 Aug 2016 18:18:38 -0700 (PDT)
Date: Thu, 4 Aug 2016 10:16:04 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH] arm64:kexec: Memstart should not be before the kernel
 start address
Message-ID: <20160804011600.GI7995@linaro.org>
References: <1461708860-23034-1-git-send-email-sgoel@codeaurora.org>
 <1461715120.27026.4.camel@infradead.org>
 <3624bf19-6569-b631-92f9-cc9fc91b40cd@codeaurora.org>
 <1465576876.3105.54.camel@infradead.org>
 <569f36b7-e153-742f-b7fe-c3a1d7b1febc@codeaurora.org>
 <1470079910.16559.49.camel@infradead.org>
 <20160802012551.GF7995@linaro.org>
 <d3e36e72-6975-c0fd-346d-5e7a79ba2e1a@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d3e36e72-6975-c0fd-346d-5e7a79ba2e1a@codeaurora.org>
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
To: "Goel, Sameer" <sgoel@codeaurora.org>
Cc: Geoff Levand <geoff@infradead.org>, timur@codeaurora.org, kexec@lists.infradead.org, rruigrok@codeaurora.org, shankerd@codeaurora.org

On Wed, Aug 03, 2016 at 05:44:30PM -0600, Goel, Sameer wrote:
> Hi,
> I am using vmlinux in this case. Usually the kernel code start is at
> a 2M alignment from the System RAM start address. Since, kexec
> default options were not loading the image at the right address
> (same as the original kernel) and the API used to get iomem listing
> does not differentiate between the reserved and memblock addresses,

In your original email, you said that you cannot place the kernel
at the address 0x0. Is this your problem, isn't it?

If so, you can explicitly specify the start address with "crashkernel=X@Y"
parameter. Or we might better add "mem-min" support as I said.

> I recommended that we look for the Kernel Code segment and round
> this down to get the right start address.
> The above should not impact any current functionality or ignore any
> ram regions when booting the patched kernel.

no need to impose such a unnecessary restriction.

Thanks,
-Takahiro AKASHI

> I will report the patch on V2.
> Thanks,
> Sameer
> 
> 
> On 8/1/2016 7:25 PM, AKASHI Takahiro wrote:
> >On Mon, Aug 01, 2016 at 12:31:50PM -0700, Geoff Levand wrote:
> >>Hi,
> >>
> >>On Fri, 2016-07-29 at 16:58 -0600, Goel, Sameer wrote:
> >>>In our setup we cannot place the kernel starting at 0 address. So, it it
> >>>placed at the first valid aligned address after placing the reserved
> >>>regions in memory.
> >>>
> >>>The code from the change (https://patchwork.kernel.org/patch/8325221/)
> >>>adds the reserved regions to iomem ranges. So, when the kexec tool is
> >>>run it picks up the first reserved region as the start address for
> >>>physical ram. When the kernel is loaded at this address, it fails to boot.
> >>>
> >>>So, I have put in a filter in the code that would pick up the right
> >>>address of the primary kernel after this change was introduced.
> >
> >You're using Image, not vmlinux, right?
> >I don't think that it's a good idea to add this sort of restriction
> >because it is very system-specific.
> >You'd better use "--mem-min=" parameter in your case.
> >(In fact, this option doesn't work on the current arm64 port of kexec-tools,
> >though.)
> >
> >Thanks,
> >-Takahiro AKASHI
> >
> >>>Thanks,
> >>>Sameer
> >>
> >>
> >>Your patch no longer applies.  Please rebase it to my
> >>for-merge-arm64-v2 branch and re-post.
> >>
> >>-Geoff
> >>
> >
> >_______________________________________________
> >kexec mailing list
> >kexec@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/kexec
> >
> 
> -- 
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
