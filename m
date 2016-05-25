Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5SMD-0000Z4-H5
 for kexec@lists.infradead.org; Wed, 25 May 2016 06:31:54 +0000
Received: by mail-oi0-f54.google.com with SMTP id j1so63341745oih.3
 for <kexec@lists.infradead.org>; Tue, 24 May 2016 23:31:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXSf-0004hl-PC@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSf-0004hl-PC@e0050434b2927.dyn.arm.linux.org.uk>
Date: Wed, 25 May 2016 12:01:32 +0530
Message-ID: <CAHB_Guqx-TaVk7_ORbFNxB3HhxvByeu5obFLXPg9UR-axDoyBA@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 09/32] kexec: phys_to_virt() must take
 unsigned long long
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
> crashdump-elf.c passes unsigned long long addresses into phys_to_virt()
> so make phys_to_virt() accept such addresses without truncating them.
> This is important for ARM LPAE systems.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/phys_to_virt.c | 2 +-
>  kexec/crashdump.h             | 2 +-
>  kexec/phys_to_virt.c          | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kexec/arch/arm/phys_to_virt.c b/kexec/arch/arm/phys_to_virt.c
> index bcced52..c2fe2ea 100644
> --- a/kexec/arch/arm/phys_to_virt.c
> +++ b/kexec/arch/arm/phys_to_virt.c
> @@ -14,7 +14,7 @@
>   * http://lists.arm.linux.org.uk/lurker/message/20010723.185051.94ce743c.en.html
>   */
>  unsigned long
> -phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
> +phys_to_virt(struct crash_elf_info *elf_info, unsigned long long paddr)
>  {
>         return paddr + elf_info->page_offset - phys_offset;
>  }
> diff --git a/kexec/crashdump.h b/kexec/crashdump.h
> index 95f1f0c..96219a8 100644
> --- a/kexec/crashdump.h
> +++ b/kexec/crashdump.h
> @@ -55,7 +55,7 @@ int crash_create_elf64_headers(struct kexec_info *info,
>  unsigned long crash_architecture(struct crash_elf_info *elf_info);
>
>  unsigned long phys_to_virt(struct crash_elf_info *elf_info,
> -                          unsigned long paddr);
> +                          unsigned long long paddr);
>
>  unsigned long xen_architecture(struct crash_elf_info *elf_info);
>  int xen_get_nr_phys_cpus(void);
> diff --git a/kexec/phys_to_virt.c b/kexec/phys_to_virt.c
> index 91b6d01..5e8c4e3 100644
> --- a/kexec/phys_to_virt.c
> +++ b/kexec/phys_to_virt.c
> @@ -10,7 +10,7 @@
>   * their own implementation.
>   */
>  unsigned long
> -phys_to_virt(struct crash_elf_info *elf_info, unsigned long paddr)
> +phys_to_virt(struct crash_elf_info *elf_info, unsigned long long paddr)
>  {
>         return paddr + elf_info->page_offset;
>  }
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
