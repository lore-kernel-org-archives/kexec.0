Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHJGM-0004sK-Th
 for kexec@lists.infradead.org; Mon, 07 Oct 2019 03:00:44 +0000
Received: by mail-pf1-x444.google.com with SMTP id q12so7679073pff.9
 for <kexec@lists.infradead.org>; Sun, 06 Oct 2019 20:00:41 -0700 (PDT)
Date: Mon, 7 Oct 2019 12:04:38 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 0/3] arm64: kexec_file: add kdump
Message-ID: <20191007030436.GW18778@linaro.org>
References: <20190912060150.10818-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190912060150.10818-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com
Cc: kexec@lists.infradead.org, james.morse@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Reminder.
This patch set is still applicable to v5.4-rc although there is one minor
conflict in a comment; It is trivial and can easily be fixed.

While this patch works on v5.4, we cannot read a generated core dump
file with crash command, even, of the latest v7.2.7. This is due to
a newly added 52-bit address support (and related changes in mm).
The issue, as a nature of kdump, does exist with *legacy*
(non-kexec_file_load-based) kdump, too.
(We will need a kernel patch as well as patches on crash to fix the issue
and some guys have already been working.)

So I'd like to request you to keep reviewing my patch.

Thanks,
-Takahiro Akashi


On Thu, Sep 12, 2019 at 03:01:47PM +0900, AKASHI Takahiro wrote:
> This is the last piece of my kexec_file_load implementation for arm64.
> It is now ready for being merged as some relevant patch to dtc/libfdt[1]
> has finally been integrated in v5.3-rc1.
> (Nothing changed since kexec_file v16[2] except adding Patch#1 and #2.)
> 
> Patch#1 and #2 are preliminary patches for libfdt component.
> Patch#3 is to add kdump support.
> 
> [1] commit 9bb9c6a110ea ("scripts/dtc: Update to upstream version
>     v1.5.0-23-g87963ee20693"), in particular
> 	7fcf8208b8a9 libfdt: add fdt_append_addrrange()
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612641.html
> 
> AKASHI Takahiro (3):
>   libfdt: define UINT32_MAX in libfdt_env.h
>   libfdt: include fdt_addresses.c
>   arm64: kexec_file: add crash dump support
> 
>  arch/arm64/include/asm/kexec.h         |   4 +
>  arch/arm64/kernel/kexec_image.c        |   4 -
>  arch/arm64/kernel/machine_kexec_file.c | 105 ++++++++++++++++++++++++-
>  include/linux/libfdt_env.h             |   3 +
>  lib/Makefile                           |   2 +-
>  lib/fdt_addresses.c                    |   2 +
>  6 files changed, 112 insertions(+), 8 deletions(-)
>  create mode 100644 lib/fdt_addresses.c
> 
> -- 
> 2.21.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
