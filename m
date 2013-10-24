Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x229.google.com ([2607:f8b0:4001:c03::229])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VZQCp-0002ZG-UJ
 for kexec@lists.infradead.org; Thu, 24 Oct 2013 19:04:28 +0000
Received: by mail-ie0-f169.google.com with SMTP id ar20so4833264iec.28
 for <kexec@lists.infradead.org>; Thu, 24 Oct 2013 12:04:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
References: <1381751200-27376-1-git-send-email-chaowang@redhat.com>
Date: Thu, 24 Oct 2013 12:04:04 -0700
Message-ID: <CAE9FiQWC43b9ptv3=9cth_cPWYaCZ8aCuTdO5is_ESpiFajQTw@mail.gmail.com>
Subject: Re: [PATCH] x86, kdump: crashkernel=X try to reserve below 896M
 first, then try below 4G, then MAXMEM
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: WANG Chao <chaowang@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Jacob Shin <jacob.shin@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Oct 14, 2013 at 4:46 AM, WANG Chao <chaowang@redhat.com> wrote:
> Now crashkernel=X will fail out if there's not enough memory at
> low (below 896M). What makes sense for crashkernel=X would be:
>
>  - First try to reserve X below 896M (for being compatible with old
>    kexec-tools).
>  - If fails, try to reserve X below 4G (swiotlb need to stay below 4G).
>  - If fails, try to reserve X from MAXMEM top down.
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index f0de629..38e6c1f 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -593,6 +593,20 @@ static void __init reserve_crashkernel(void)
>                                         high ? CRASH_KERNEL_ADDR_HIGH_MAX :
>                                                CRASH_KERNEL_ADDR_LOW_MAX,
>                                         crash_size, alignment);
> +               /*
> +                * crashkernel=X reserve below 896M fails? Try below 4G
> +                */
> +               if (!high && !crash_base)
> +                       crash_base = memblock_find_in_range(alignment,
> +                                               (1ULL << 32),
> +                                               crash_size, alignment);

Another problem, it would allocate range in [0,4g) for 32bit,
if the user have crashkernel=512M or plus.

> +               /*
> +                * crashkernel=X reserve below 4G fails? Try MAXMEM
> +                */
> +               if (!high && !crash_base)
> +                       crash_base = memblock_find_in_range(alignment,
> +                                               CRASH_KERNEL_ADDR_HIGH_MAX,
> +                                               crash_size, alignment);
>
>                 if (!crash_base) {
>                         pr_info("crashkernel reservation failed - No suitable area found.\n");


Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
