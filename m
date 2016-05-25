Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5S7u-0001b7-AN
 for kexec@lists.infradead.org; Wed, 25 May 2016 06:17:07 +0000
Received: by mail-oi0-f52.google.com with SMTP id k23so63083243oih.0
 for <kexec@lists.infradead.org>; Tue, 24 May 2016 23:16:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXSA-0004hB-Ix@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSA-0004hB-Ix@e0050434b2927.dyn.arm.linux.org.uk>
Date: Wed, 25 May 2016 11:46:45 +0530
Message-ID: <CAHB_GuqS=z-v=r_1MOn4PgNf-Dzz=RQp=cJ_Ysc7xB8gg7mmmA@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 03/32] kdump: actually write out the memory
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
> Actually write out the memory rather than writing the notes a second
> time.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kdump/kdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kdump/kdump.c b/kdump/kdump.c
> index 99a1789..1f5b984 100644
> --- a/kdump/kdump.c
> +++ b/kdump/kdump.c
> @@ -300,7 +300,7 @@ int main(int argc, char **argv)
>         for(i = 0; i < ehdr->e_phnum; i++) {
>                 unsigned long long offset, size;
>                 size_t wsize;
> -               if (phdr[i].p_type != PT_NOTE) {
> +               if (phdr[i].p_type == PT_NOTE) {
>                         continue;
>                 }
>                 offset = phdr[i].p_offset;
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
