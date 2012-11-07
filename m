Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]
 helo=co1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TW9vn-0000cf-Mw
 for kexec@lists.infradead.org; Wed, 07 Nov 2012 18:00:52 +0000
From: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: [PATCH] ppc/uImage: Find new kernel load_addr if the default
 addr is not available
Date: Wed, 7 Nov 2012 18:00:43 +0000
Message-ID: <70CC66F5C30A414DADDA6973E4CA391A761EE5@039-SN1MPN1-001.039d.mgd.msft.net>
References: <20121107133242.3676.23885.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20121107133242.3676.23885.stgit@suzukikp.in.ibm.com>
Content-Language: en-US
Content-ID: <A00A510715F04A4EBC16607C11AD9B80@mgd.freescale.com>
MIME-Version: 1.0
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, Nov 7, 2012 at 7:36 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrote:
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
>
> If the kernel cannot be loaded at the default load_addr, provided
> by the image, we should try finding a free area using locate_hole().
> This is usually applicable for the CRASH case, where the memory should
> be located in the reserved region.
>
> Without this patch, sometime the kernel fails to load for uImage formatted
> relocatable kernel images.

Without testing, this looks reasonable to me.

-M

>
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Matthew McClintock <msm@freescale.com>
> ---
>  kexec/arch/ppc/kexec-uImage-ppc.c |   21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
> index b5579f0..e55bf94 100644
> --- a/kexec/arch/ppc/kexec-uImage-ppc.c
> +++ b/kexec/arch/ppc/kexec-uImage-ppc.c
> @@ -130,13 +130,22 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
>          * allocated from memtop down towards zero so we should never get too
>          * close to the bss :)
>          */
> -       ret = valid_memory_range(info, load_addr, load_addr + (len + (1 * 1024 * 1024)));
> -       if (!ret) {
> -               printf("Can't add kernel to addr 0x%08x len %ld\n",
> -                               load_addr, len + (1 * 1024 * 1024));
> -               return -1;
> +#define _1MiB  (1 * 1024 * 1024)
> +
> +       /*
> +        * If the provided load_addr cannot be allocated, find a new
> +        * area.
> +        */
> +       if (!valid_memory_range(info, load_addr, load_addr + (len + _1MiB))) {
> +               load_addr = locate_hole(info, len + _1MiB, 0, 0, max_addr, 1);
> +               if (load_addr == ULONG_MAX) {
> +                       printf("Can't allocate memory for kernel of len %ld\n",
> +                                       len + _1MiB);
> +                       return -1;
> +               }
>         }
> -       add_segment(info, buf, len, load_addr, len + (1 * 1024 * 1024));
> +
> +       add_segment(info, buf, len, load_addr, len + _1MiB);
>
>         if (info->kexec_flags & KEXEC_ON_CRASH) {
>                  crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
