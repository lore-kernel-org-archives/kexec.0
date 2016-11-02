Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c1rvH-0002WE-CZ
 for kexec@lists.infradead.org; Wed, 02 Nov 2016 09:33:32 +0000
Received: by mail-qk0-f174.google.com with SMTP id q130so11056029qke.1
 for <kexec@lists.infradead.org>; Wed, 02 Nov 2016 02:33:11 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] (kexec-tools) arm64: add kdump support
References: <20161102044111.11779-1-takahiro.akashi@linaro.org>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <3a50383c-bf6d-9587-6580-35c44f50c61a@redhat.com>
Date: Wed, 2 Nov 2016 15:03:05 +0530
MIME-Version: 1.0
In-Reply-To: <20161102044111.11779-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, horms@verge.net.au
Cc: geoff@infradead.org, kexec@lists.infradead.org

Hi Simon/Akashi,

I tested this patch set with mustang and seattle platform. They work fine.

So for the series:
Tested-by: Pratyush Anand <panand@redhat.com>

Just a comment for 2/9

> -    unsigned long long stext_sym_addr = get_kernel_stext_sym();
> +    unsigned long long stext_sym_addr = get_kernel_sym("stext");

Sorry, This had to be get_kernel_sym("_stext").

May be I can resend only  patch 2/9 by keeping intact the message-id.

~Pratyush

On Wednesday 02 November 2016 10:11 AM, AKASHI Takahiro wrote:
> My kernel patches of kdump suport on arm64 are currently under reviews.
>
> This patchset is synced with them (v27 [1]) and provides necessary changes
> for kexec-tools. It can be applied on top of kexec-tools master branch.
>
> [1] T.B.D.
>
> Changes for v4:
>  - rebased on the master branch (including Geoff's v6)
>  - revive "linux,usable-memory-range" DT property (from v2), dropping
>    use of "reserved-memory" nodes introduced in v3 (patch #8)
>  - extend the semantics of kexec_iomem_for_each_line() per Pratyush
>    (patch #1)
>
> Changes for v3:
>  - rebased on Geoff's v5
>  - fix a value of estimated PHYS_OFFSET
>  - add a kernel code/data segment because they now reside out of linear
>    mapping due to KASLR introduction
>  - remove "linux,usable-memory-range" dependency, instead using
>    "reserved-memory" node
>  - add -mem-min/-mem-max support
>
> Changes for v2:
>  - trim a temoprary buffer in setup_2nd_dtb()
>  - add patch#6("kexec: generalize and rename get_kernel_stext_sym()")
>  - update patch#7 from Pratyush
>    (re-worked by akashi)
>
> AKASHI Takahiro (7):
>   kexec: exntend the semantics of kexec_iomem_for_each_line
>   arm64: identify PHYS_OFFSET correctly
>   arm64: kdump: identify memory regions
>   arm64: kdump: add elf core header segment
>   arm64: kdump: set up kernel image segment
>   arm64: kdump: set up other segments
>   arm64: kdump: add DT properties to crash dump kernel's dtb
>
> Pratyush Anand (2):
>   kexec: generalize and rename get_kernel_stext_sym()
>   arm64: kdump: Add support for binary image files
>
>  kexec/Makefile                       |   1 +
>  kexec/arch/arm/crashdump-arm.c       |  40 +------
>  kexec/arch/arm64/Makefile            |   2 +
>  kexec/arch/arm64/crashdump-arm64.c   | 219 ++++++++++++++++++++++++++++++++++-
>  kexec/arch/arm64/crashdump-arm64.h   |  18 ++-
>  kexec/arch/arm64/iomem.h             |  10 ++
>  kexec/arch/arm64/kexec-arm64.c       | 118 ++++++++++++++++---
>  kexec/arch/arm64/kexec-elf-arm64.c   |  25 +++-
>  kexec/arch/arm64/kexec-image-arm64.c |  12 ++
>  kexec/arch/i386/crashdump-x86.c      |  29 -----
>  kexec/kexec-iomem.c                  |  15 ++-
>  kexec/kexec.h                        |   2 +
>  kexec/symbols.c                      |  41 +++++++
>  13 files changed, 437 insertions(+), 95 deletions(-)
>  create mode 100644 kexec/arch/arm64/iomem.h
>  create mode 100644 kexec/symbols.c
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
