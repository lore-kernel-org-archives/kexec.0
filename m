Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iA63g-0007BT-TG
 for kexec@lists.infradead.org; Tue, 17 Sep 2019 05:29:50 +0000
Received: by mail-io1-xd42.google.com with SMTP id r26so4569517ioh.8
 for <kexec@lists.infradead.org>; Mon, 16 Sep 2019 22:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <1568256617-14030-1-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1568256617-14030-1-git-send-email-kernelfans@gmail.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 17 Sep 2019 13:29:35 +0800
Message-ID: <CAFgQCTvKpPEP1UywcGcC2Mo4mzzZR+ff7M3L9QN_U+hfk31ijQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/crashkernel: take mem option into account
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>

Cc Kexec list. And keep the original content.

On Thu, Sep 12, 2019 at 10:50 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> 'mem=" option is an easy way to put high pressure on memory during some
> test. Hence in stead of total mem, the effective usable memory size should
> be considered when reserving mem for crashkernel. Otherwise the boot up may
> experience oom issue.
>
> E.g passing
> crashkernel="2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G", and
> mem=5G on a 256G machine.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> To: linuxppc-dev@lists.ozlabs.org
> ---
> v1 -> v2: fix the printk info about the total mem
>  arch/powerpc/kernel/machine_kexec.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index c4ed328..eec96dc 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -114,11 +114,12 @@ void machine_kexec(struct kimage *image)
>
>  void __init reserve_crashkernel(void)
>  {
> -       unsigned long long crash_size, crash_base;
> +       unsigned long long crash_size, crash_base, total_mem_sz;
>         int ret;
>
> +       total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
>         /* use common parsing */
> -       ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +       ret = parse_crashkernel(boot_command_line, total_mem_sz,
>                         &crash_size, &crash_base);
>         if (ret == 0 && crash_size > 0) {
>                 crashk_res.start = crash_base;
> @@ -185,7 +186,7 @@ void __init reserve_crashkernel(void)
>                         "for crashkernel (System RAM: %ldMB)\n",
>                         (unsigned long)(crash_size >> 20),
>                         (unsigned long)(crashk_res.start >> 20),
> -                       (unsigned long)(memblock_phys_mem_size() >> 20));
> +                       (unsigned long)(total_mem_sz >> 20));
>
>         if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
>             memblock_reserve(crashk_res.start, crash_size)) {
> --
> 2.7.5
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
