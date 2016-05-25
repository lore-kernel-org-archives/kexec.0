Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5S7b-0001Xc-IF
 for kexec@lists.infradead.org; Wed, 25 May 2016 06:16:48 +0000
Received: by mail-oi0-f43.google.com with SMTP id b65so63057898oia.1
 for <kexec@lists.infradead.org>; Tue, 24 May 2016 23:16:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXS5-0004h5-Cb@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXS5-0004h5-Cb@e0050434b2927.dyn.arm.linux.org.uk>
Date: Wed, 25 May 2016 11:46:26 +0530
Message-ID: <CAHB_Guq7=qKeK+P_yG_6H7WYwtfEjMkqPD+_wP8h9W425jYTmQ@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 02/32] kdump: fix multiple program header
 entries
From: Pratyush Anand <panand@redhat.com>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> generate_new_headers() forgot to increment the program header pointer
> after adding each program header from the kexec template. Fix it to
> increment it correctly.
>
> Without this, the program headers contain only the last entry, which
> means we will be missing most of the kernel image in the dump.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kdump/kdump.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kdump/kdump.c b/kdump/kdump.c
> index 3247a54..99a1789 100644
> --- a/kdump/kdump.c
> +++ b/kdump/kdump.c
> @@ -192,6 +192,7 @@ static void *generate_new_headers(
>                 }
>                 memcpy(nphdr, &phdr[i], sizeof(*nphdr));
>                 nphdr->p_offset = offset;
> +               nphdr++;
>                 offset += phdr[i].p_filesz;
>         }
>
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
