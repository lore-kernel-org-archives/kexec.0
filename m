Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ijHcZ-00032h-SL
 for kexec@lists.infradead.org; Mon, 23 Dec 2019 06:55:18 +0000
Received: by mail-qk1-f198.google.com with SMTP id w64so10740001qka.3
 for <kexec@lists.infradead.org>; Sun, 22 Dec 2019 22:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20191218164232.6086-1-msys.mizuma@gmail.com>
In-Reply-To: <20191218164232.6086-1-msys.mizuma@gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 23 Dec 2019 12:25:00 +0530
Message-ID: <CACi5LpMwSvqBOBuKAbjv5DRwAuQ8OJ-s71Yv0rLPp2X+1WHkeg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] arm64: handle "reserved" entries in /proc/iomem
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
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: James Morse <james.morse@arm.com>, Simon Horman <horms@verge.net.au>, kexec mailing list <kexec@lists.infradead.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>

Thanks for the patches Masa,

On Wed, Dec 18, 2019 at 10:13 PM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> In recent arm64 kernels, /proc/iomem has an extended file format like:
>
>  40000000-5871ffff : System RAM
>    41800000-426affff : Kernel code
>    426b0000-42aaffff : reserved
>    42ab0000-42c64fff : Kernel data
>    54400000-583fffff : Crash kernel
>    58590000-585effff : reserved
>    58700000-5871ffff : reserved
>  58720000-58b5ffff : reserved
>  58b60000-5be3ffff : System RAM
>    58b61000-58b61fff : reserved
>
> where "reserved" entries can be an ACPI table, UEFI related code or
> data. They can be corrupted and result in early failure in booting
> a new kernel. As an actual example, LPI pending table and LPI property
> table, which are pointed by a UEFI data, are sometimes destroyed.
>
> They are expected to be preserved across kexec'ing.
>
> Changelog:
>     v3: - Re-based to the latest commit (bd07796).
>         - Added Tested-by tag from Bhupesh and Masayoshi
>         - Added an error handling in case
>           mem_regions_alloc_and_exclude() fails (0002 patch).
>
> AKASHI Takahiro (3):
>   kexec: add variant helper functions for handling memory regions
>   arm64: kexec: allocate memory space avoiding reserved regions
>   arm64: kdump: deal with a lot of resource entries in /proc/iomem
>
>  kexec/arch/arm64/crashdump-arm64.c |  25 ++---
>  kexec/arch/arm64/kexec-arm64.c     | 153 ++++++++++++++++++-----------
>  kexec/mem_regions.c                |  42 ++++++++
>  kexec/mem_regions.h                |   7 ++
>  4 files changed, 153 insertions(+), 74 deletions(-)

The changes look fine to me (the patches already have my Tested-by).

Hi Simon,

Can you please help pick these changes for upstream kexec-tools and
arm64 kexec is broken on few machines in the absence of these changes.
The corresponding linux change (see [0]) has already been accepted in
linux-next tree.

[0]. ab0eb16205b4 ("efi/memreserve: Register reservations as
'reserved' in /proc/iomem")

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
