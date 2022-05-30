From: Palmer Dabbelt <palmer@rivosinc.com>
Date: Mon, 30 May 2022 11:58:16 -0700 (PDT)
Subject: [PATCH] RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add]
In-Reply-To: <20220530074202.pydmbbgvbtaugw5j@pengutronix.de>
Message-ID: <mhng-5872aea0-6f64-4685-8f8d-fdeb42e4c972@palmer-mbp2014>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, 30 May 2022 00:42:02 PDT (-0700), u.kleine-koenig at pengutronix.de wrote:
> Without this change arch/riscv/kernel/elf_kexec.c fails to compile once
> commit 233c1e6c319c ("kexec_file: drop weak attribute from
> arch_kexec_apply_relocations[_add]") is also contained in the tree.
> This currently happens in next-20220527.
>
> Prepare the RISC-V similar to the s390 adaption done in 233c1e6c319c.
> This is safe to do on top of the riscv change even without the change to
> arch_kexec_apply_relocations.
>
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Looks-good-to: liaochang (A) <liaochang1@huawei.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>
> On Mon, May 30, 2022 at 09:43:26AM +0800, liaochang (A) wrote:
>> > I can confirm that doing
>> > 
>> > diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
>> > index 206217b23301..eee260e8ab30 100644
>> > --- a/arch/riscv/include/asm/kexec.h
>> > +++ b/arch/riscv/include/asm/kexec.h
>> > @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>> >  
>> >  #ifdef CONFIG_KEXEC_FILE
>> >  extern const struct kexec_file_ops elf_kexec_ops;
>> > +
>> > +struct purgatory_info;
>> > +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>> > +				     Elf_Shdr *section,
>> > +				     const Elf_Shdr *relsec,
>> > +				     const Elf_Shdr *symtab);
>> > +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>> >  #endif
>> >  
>> >  #endif
>> 
>> LGTM, you could send a fixup patch to riscv, thanks.
>> 
>> > 
>> > on top of 838b3e28488f results in a compilable tree. And when merging
>> > 233c1e6c319c into this, it is still building.
>> > 
>> > I'm not enough into kexec (and riscv) to judge if this is sensible, or
>> > create a useful commit log but the obvious way forward is to apply the
>> > above patch to the riscv tree before it hits Linus' tree.
>
> Ok, here comes a patch with a generic commit log. 
>
> @riscv people: If you prefer, squash it into 838b3e28488f.

Sorry, just saw this after I sent my version of the fix.  They're the 
same, but do you mind sending a full-on patch so I can merge it?

>
> Best regards
> Uwe
>
>  arch/riscv/include/asm/kexec.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> index 206217b23301..eee260e8ab30 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>  
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops elf_kexec_ops;
> +
> +struct purgatory_info;
> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> +				     Elf_Shdr *section,
> +				     const Elf_Shdr *relsec,
> +				     const Elf_Shdr *symtab);
> +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>  #endif
>  
>  #endif
>
> base-commit: 838b3e28488f702e2b5477b393f009b2639d2b1a
> -- 
> 2.36.1
>
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

