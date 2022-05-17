From: Baoquan He <bhe@redhat.com>
Date: Tue, 17 May 2022 17:25:59 +0800
Subject: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
In-Reply-To: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/25/22 at 11:11pm, Naveen N. Rao wrote:
> kexec_load_purgatory() can fail for many reasons - there is no need to
> print an error when encountering unsupported relocations.
> 
> This solves a build issue on powerpc with binutils v2.36 and newer [1].
> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [2], binutils started dropping section symbols that it thought

I am not familiar with binutils, while wondering if this exists in other
ARCHes except of ppc. Arm64 doesn't have the ARCH override either, do we
have problem with it?

> were unused.  This isn't an issue in general, but with kexec_file.c, gcc
> is placing kexec_arch_apply_relocations[_add] into a separate
> .text.unlikely section and the section symbol ".text.unlikely" is being
> dropped. Due to this, recordmcount is unable to find a non-weak symbol

But arch_kexec_apply_relocations_add is weak symbol on ppc.

> in .text.unlikely to generate a relocation record against. Dropping
> pr_err() calls results in these functions being left in .text section,

Why dropping pr_err() can make arch_kexec_apply_relocations_add put in
.text?

> enabling recordmcount to emit a proper relocation record.
> 
> [1] https://github.com/linuxppc/issues/issues/388
> [2] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b96..55d144c58b5278 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -121,7 +121,6 @@ int __weak
>  arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
>  				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
>  {
> -	pr_err("RELA relocation unsupported.\n");
>  	return -ENOEXEC;
>  }
>  
> @@ -138,7 +137,6 @@ int __weak
>  arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
>  			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
>  {
> -	pr_err("REL relocation unsupported.\n");
>  	return -ENOEXEC;
>  }
>  
> 
> base-commit: 83d8a0d166119de813cad27ae7d61f54f9aea707
> -- 
> 2.35.1
> 


