Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifr0o-0003Bt-0B
 for kexec@lists.infradead.org; Fri, 13 Dec 2019 19:54:07 +0000
Received: by mail-qv1-xf42.google.com with SMTP id t7so239055qve.4
 for <kexec@lists.infradead.org>; Fri, 13 Dec 2019 11:54:05 -0800 (PST)
Date: Fri, 13 Dec 2019 14:53:55 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH v2 0/3] arm64: handle "reserved" entries in /proc/iomem
Message-ID: <20191213195355.kt7gbncsx65wuwpa@gabell>
References: <20190111095946.28070-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111095946.28070-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: kexec@lists.infradead.org, Bhupesh Sharma <bhsharma@redhat.com>, Simon Horman <horms@verge.net.au>, James Morse <james.morse@arm.com>

Hello,

(I'm sorry if I break the mail thread...)

As Bhupesh said at:
http://lists.infradead.org/pipermail/kexec/2019-December/024142.html

Please feel free to add:

	Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
	Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa

On Fri, Jan 11, 2019 at 06:59:43PM +0900, AKASHI Takahiro wrote:
> # @James, @Bhupesh
> # Could you kindly test this patch, please?
> # I'm not quite confident that I correctly merged my patch with,
> # particularly, Bhupesh's recent change.
> 
> In recent arm64 kernels, /proc/iomem has an extended file format like:
>         40000000-5871ffff : System RAM
>           41800000-426affff : Kernel code
>           426b0000-42aaffff : reserved
>           42ab0000-42c64fff : Kernel data
>           54400000-583fffff : Crash kernel
>           58590000-585effff : reserved
>           58700000-5871ffff : reserved
>         58720000-58b5ffff : reserved
>         58b60000-5be3ffff : System RAM
>           58b61000-58b61fff : reserved
>           59a77000-59a77fff : reserved
>         5be40000-5becffff : reserved
>         5bed0000-5bedffff : System RAM
>         5bee0000-5bffffff : reserved
>         5c000000-5fffffff : System RAM
>           5da00000-5e9fffff : reserved
>           5ec00000-5edfffff : reserved
>           5ef6a000-5ef6afff : reserved
>           5ef6b000-5efcafff : reserved
>           5efcd000-5efcffff : reserved
>           5efd0000-5effffff : reserved
>           5f000000-5fffffff : reserved
> 
> where "reserved" entries can be an APCI table, UEFI related code or data,
> and they are expected to be preserved across kexec'ing.
> With this patch[1], kexec/kdump will be allowed to handle them properly.
> 
> [1] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/resv_mem
> 
> AKASHI Takahiro (3):
>   kexec: add variant helper functions for handling memory regions
>   arm64: kexec: allocate memory space avoiding reserved regions
>   arm64: kdump: deal with a lot of resource entries in /proc/iomem
> 
>  kexec/arch/arm64/crashdump-arm64.c |  25 ++---
>  kexec/arch/arm64/kexec-arm64.c     | 146 +++++++++++++++++------------
>  kexec/mem_regions.c                |  42 +++++++++
>  kexec/mem_regions.h                |   7 ++
>  4 files changed, 146 insertions(+), 74 deletions(-)
> 
> -- 
> 2.19.1
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
