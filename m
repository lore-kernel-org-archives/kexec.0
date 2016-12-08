Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cEmQD-0008HO-SB
 for kexec@lists.infradead.org; Thu, 08 Dec 2016 00:18:53 +0000
Subject: Re: [PATCH Makedumpfile 00/10] arm64 cleanup and kaslr support
References: <cover.1477378297.git.panand@redhat.com>
From: "Goel, Sameer" <sgoel@codeaurora.org>
Message-ID: <e1e63aac-8aa0-9042-5594-290ada9b0ded@codeaurora.org>
Date: Wed, 7 Dec 2016 17:18:27 -0700
MIME-Version: 1.0
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>, ats-kumagai@wm.jp.nec.com
Cc: mansip@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org

Works great for 4l 4k pages.

Tested-by: Sameer Goel <sgoel@codeaurora.org>

On 10/25/2016 1:22 AM, Pratyush Anand wrote:
> These patches were lying in my tree for quite some time now. VMCOREINFO
> numbers/symbols used in these patches have been made part of kdump kernel
> patches for last few versions including v26. So, there seems no contention
> on embedding VA_BITS, kimage_voffset and PHYS_OFFSET into vmcore.
>
> These patches cleans up a lot arm64 code and also immunize it with many
> kernel changes. Additionally,it adds 4 level 4K page support and support for
> KASLR enabled kernel.
>
> Azriel Samson (1):
>   arm64: Add support for 4level 4K page translations table
>
> Pratyush Anand (9):
>   arm64: cleanup code, comment, blank space, blank lines etc
>   read_vmcoreinfo_long: Allow to read hex values as well
>   Introduce read_vmcoreinfo_ulong()
>   arm64: use already available PAGESIZE() and PAGESHIFT() macros
>   arm64: fix page_offset definition
>   arm64: fix re-filtering
>   arm64: use value of VA_BITS and PHYS_OFFSET embedded into vmcore
>   arm64: immunize identity mapped address finding w.r.t. kernel changes
>   arm64: fix memory layout as per changes in v4.6 kernel
>
>  arch/arm64.c   | 245 ++++++++++++++++++++++-----------------------------------
>  makedumpfile.c |  46 +++++++++++
>  makedumpfile.h |  28 +++++--
>  3 files changed, 162 insertions(+), 157 deletions(-)
>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
