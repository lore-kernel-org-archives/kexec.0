Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-x22d.google.com ([2607:f8b0:400e:c02::22d])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vr7Yv-00078m-Ik
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 14:48:28 +0000
Received: by mail-pd0-f173.google.com with SMTP id p10so618441pdj.32
 for <kexec@lists.infradead.org>; Thu, 12 Dec 2013 06:48:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <594a3d26aac66e9668edc81d7bfb4e801575514f.1386807069.git.geoff@infradead.org>
References: <cover.1386807069.git.geoff@infradead.org>
 <594a3d26aac66e9668edc81d7bfb4e801575514f.1386807069.git.geoff@infradead.org>
Date: Thu, 12 Dec 2013 15:48:01 +0100
Message-ID: <CAMuHMdUVfY5UO2tZEzSML9Bhx64VobDdyJQwOgfQ5=2wzxbONQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] sh/kexec: Fix kexec build warning
From: Geert Uytterhoeven <geert@linux-m68k.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Paul Mundt <lethal@linux-sh.org>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geoff,

On Thu, Dec 12, 2013 at 1:18 AM, Geoff Levand <geoff@infradead.org> wrote:
> Add a cast to a printk argument to suppress a type mismatch compiler warning.
>
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> ---
>  arch/sh/kernel/machine_kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
> index 9fea49f..b7e65a8 100644
> --- a/arch/sh/kernel/machine_kexec.c
> +++ b/arch/sh/kernel/machine_kexec.c
> @@ -60,7 +60,7 @@ static void kexec_info(struct kimage *image)
>                        i,
>                        (unsigned int)image->segment[i].mem,
>                        (unsigned int)image->segment[i].mem +
> -                                    image->segment[i].memsz,
> +                      (unsigned int)image->segment[i].memsz,
>                        (unsigned int)image->segment[i].memsz);
>         }
>         printk("  start     : 0x%08x\n\n", (unsigned int)image->start);

Wouldn't it be better to remove all casts and correct the printf-style
format specifiers instead?

  - mem and start are unsigned long, hence use "0x%08lx",
  - memsz is size_t, hence use "0x%08zx".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
