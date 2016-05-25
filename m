Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5S8g-00028h-Lb
 for kexec@lists.infradead.org; Wed, 25 May 2016 06:17:55 +0000
Received: by mail-oi0-f46.google.com with SMTP id k23so63105297oih.0
 for <kexec@lists.infradead.org>; Tue, 24 May 2016 23:17:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXSF-0004hH-Oo@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSF-0004hH-Oo@e0050434b2927.dyn.arm.linux.org.uk>
Date: Wed, 25 May 2016 11:47:33 +0530
Message-ID: <CAHB_GurQ44ybkxaYJJQeGgnuw=3tKOk7xyB6FTAursMLuZGrJg@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 04/32] kdump: fix kdump mapping
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
> When kdump tries to map the program header, it fails to take account
> of ehdr->e_phoff being an offset from the start of the ELF "file",
> which causes:
>
> Cannot mmap /dev/mem offset: 64 size: 392: Invalid argument
>
> Ensure that we take account of the start address when mapping this.
>
> This fix has been extracted from a larger patch by Vitaly Andrianov
> adding support for Keystone 2.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>
> ---
>  kdump/kdump.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kdump/kdump.c b/kdump/kdump.c
> index 1f5b984..34d2149 100644
> --- a/kdump/kdump.c
> +++ b/kdump/kdump.c
> @@ -284,7 +284,8 @@ int main(int argc, char **argv)
>         }
>
>         /* Get the program header */
> -       phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum), ehdr->e_phoff);
> +       phdr = map_addr(fd, sizeof(*phdr)*(ehdr->e_phnum),
> +                       start_addr + ehdr->e_phoff);

This is fine. But at the same time should n't we also fix the offset
for mmap of memory segments?  For memory segments, offset is
phdr[i].p_offset, and I do not see generate_new_headers() taking care
of start_addr.

>
>         /* Collect up the notes */
>         note_bytes = 0;
> --
> 1.9.1
>

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
