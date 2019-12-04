Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icbEj-000413-SU
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 20:27:03 +0000
Received: by mail-pf1-f200.google.com with SMTP id d127so311250pfa.7
 for <kexec@lists.infradead.org>; Wed, 04 Dec 2019 12:26:56 -0800 (PST)
Subject: Re: [PATCH v2 0/3] arm64: kexec_file: add kdump
References: <20191114051510.17037-1-takahiro.akashi@linaro.org>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <da0113d3-24b8-6263-b06e-0e58037f292f@redhat.com>
Date: Thu, 5 Dec 2019 01:56:47 +0530
MIME-Version: 1.0
In-Reply-To: <20191114051510.17037-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com
Cc: james.morse@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

Thanks for the patchset.

On 11/14/2019 10:45 AM, AKASHI Takahiro wrote:
> This is the last piece of my kexec_file_load implementation for arm64.
> It is now ready for being merged as some relevant patch to dtc/libfdt[1]
> has finally been integrated in v5.3-rc1.
> (Nothing changed since kexec_file v16[2] except adding Patch#1 and #2.)
> 
> Patch#1 and #2 are preliminary patches for libfdt component.
> Patch#3 is to add kdump support.
> 
> Bhepesh's patch[3] will be required for 52-bit VA support.
> Once this patch is applied, whether or not CONFIG_ARM64_VA_BITS_52 is
> enabled or not, a matching fix on user space side, crash utility,
> will also be needed.
> 
> Anyway, I tested my patch, at least, with the following configuration:
> 1) CONFIG_ARM64_BITS_48=y
> 2) CONFIG_ARM64_BITS_52=y, but vabits_actual=48
> 
> (I don't have any platform to use for
> 3) CONFIG_ARM64_BITS_52=y, and vabits_actual=52)
> 
> [1] commit 9bb9c6a110ea ("scripts/dtc: Update to upstream version
>      v1.5.0-23-g87963ee20693"), in particular
> 	7fcf8208b8a9 libfdt: add fdt_append_addrrange()
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/612641.html
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-November/693411.html
> 
> Changes in v2 (Nov 14, 2019)
> * rebased to v5.4-rc7
> * no functional changes

This looks like a step in the right direction. I have some minor 
nitpicks which I have mentioned in the individual patch reviews.

With those addressed (v2?):

Tested-and-Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks,
Bhupesh

> AKASHI Takahiro (3):
>    libfdt: define UINT32_MAX in libfdt_env.h
>    libfdt: include fdt_addresses.c
>    arm64: kexec_file: add crash dump support
> 
>   arch/arm64/include/asm/kexec.h         |   4 +
>   arch/arm64/kernel/kexec_image.c        |   4 -
>   arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
>   include/linux/libfdt_env.h             |   3 +
>   lib/Makefile                           |   2 +-
>   lib/fdt_addresses.c                    |   2 +
>   6 files changed, 112 insertions(+), 9 deletions(-)
>   create mode 100644 lib/fdt_addresses.c
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
