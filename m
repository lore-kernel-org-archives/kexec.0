Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5TlT-00042f-Q9
 for kexec@lists.infradead.org; Wed, 25 May 2016 08:02:04 +0000
Received: by mail-oi0-f45.google.com with SMTP id b65so66293860oia.1
 for <kexec@lists.infradead.org>; Wed, 25 May 2016 01:01:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXTB-0004iP-5Y@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTB-0004iP-5Y@e0050434b2927.dyn.arm.linux.org.uk>
Date: Wed, 25 May 2016 13:31:41 +0530
Message-ID: <CAHB_GuqYJV4oLiPCQjHckyfR+B=JqoYXKnU2DqaemNhaApc+9Q@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 15/32] arm: fix get_kernel_stext_sym() to
 close its file
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

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Fix get_kernel_stext_sym() so that it closes its file once it's
> finsihed with it - there's no need to leak file descriptors.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index b523e5f..a390187 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -71,25 +71,34 @@ static unsigned long long get_kernel_stext_sym(void)
>         char sym[128];
>         char line[128];
>         FILE *fp;
> -       unsigned long long vaddr;
> +       unsigned long long vaddr = 0;
>         char type;
>
> -       fp = fopen(kallsyms, "r");      if (!fp) {
> +       fp = fopen(kallsyms, "r");
> +       if (!fp) {
>                 fprintf(stderr, "Cannot open %s\n", kallsyms);
>                 return 0;
>         }
>
>         while(fgets(line, sizeof(line), fp) != NULL) {
> -               if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
> +               unsigned long long addr;
> +
> +               if (sscanf(line, "%Lx %c %s", &addr, &type, sym) != 3)
>                         continue;
> +
>                 if (strcmp(sym, stext) == 0) {
> -                       dbgprintf("kernel symbol %s vaddr = %16llx\n", stext, vaddr);
> -                       return vaddr;
> +                       dbgprintf("kernel symbol %s vaddr = %#llx\n", stext, addr);
> +                       vaddr = addr;
> +                       break;
>                 }
>         }
>
> -       fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
> -       return 0;
> +       fclose(fp);
> +
> +       if (vaddr == 0)
> +               fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
> +
> +       return vaddr;
>  }
>
>  static int get_kernel_page_offset(struct kexec_info *info,
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
