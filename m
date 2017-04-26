Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3GM3-0003Me-Jb
 for kexec@lists.infradead.org; Wed, 26 Apr 2017 06:23:18 +0000
Received: by mail-wm0-x242.google.com with SMTP id y10so19412210wmh.0
 for <kexec@lists.infradead.org>; Tue, 25 Apr 2017 23:22:51 -0700 (PDT)
Date: Wed, 26 Apr 2017 08:22:47 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] memmap: Parse "Reserved" together with "reserved"
Message-ID: <20170426062247.fbl62xrkrm7tvnga@gmail.com>
References: <20170426005526.27313-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170426005526.27313-1-yinghai@kernel.org>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org


* Yinghai Lu <yinghai@kernel.org> wrote:

> For x86 with recent kernel after
>  commit 640e1b38b0 ("x86/boot/e820: Basic cleanup of e820.c")
> change "reserved" to "Reserved" in /sys firmware memmap and /proc/iomem.
> 
> So here, we add handling for that too.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  kexec/arch/i386/crashdump-x86.c |    2 ++
>  kexec/arch/ia64/kexec-ia64.c    |    2 ++
>  kexec/arch/mips/kexec-mips.c    |    2 ++
>  kexec/firmware_memmap.c         |    2 ++
>  4 files changed, 8 insertions(+)

I'd rather fix the bug I introduced and undo the reserved->Reserved string change 
in e820.c: I didn't realize that it's exposed in sysfs and had quasi-ABI 
consequences for kexec.

Agreed?

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
