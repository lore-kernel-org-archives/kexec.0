From: Baoquan He <bhe@redhat.com>
Date: Wed, 18 May 2022 15:49:14 +0800
Subject: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
In-Reply-To: <87v8u3o9tk.fsf@mpe.ellerman.id.au>
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
 <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
 <1652782155.56t7mah8ib.naveen@linux.ibm.com>
 <8735h8b2f1.fsf@email.froward.int.ebiederm.org>
 <87v8u3o9tk.fsf@mpe.ellerman.id.au>
Message-ID: <YoSk+jRjNQtUL50d@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/18/22 at 12:26pm, Michael Ellerman wrote:
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
> > Looking at this the pr_err is absolutely needed.  If an unsupported case
> > winds up in the purgatory blob and the code can't handle it things
> > will fail silently much worse later.
> 
> It won't fail later, it will fail the syscall.
> 
> sys_kexec_file_load()
>   kimage_file_alloc_init()
>     kimage_file_prepare_segments()
>       arch_kexec_kernel_image_load()
>         kexec_image_load_default()
>           image->fops->load()
>             elf64_load()        # powerpc
>             bzImage64_load()    # x86
>               kexec_load_purgatory()
>                 kexec_apply_relocations()
> 
> Which does:
> 
> 	if (relsec->sh_type == SHT_RELA)
> 		ret = arch_kexec_apply_relocations_add(pi, section,
> 						       relsec, symtab);
> 	else if (relsec->sh_type == SHT_REL)
> 		ret = arch_kexec_apply_relocations(pi, section,
> 						   relsec, symtab);
> 	if (ret)
> 		return ret;
> 
> And that error is bubbled all the way back up. So as long as
> arch_kexec_apply_relocations() returns an error the syscall will fail
> back to userspace and there'll be an error message at that level.
> 
> It's true that having nothing printed in dmesg makes it harder to work
> out why the syscall failed. But it's a kernel bug if there are unhandled
> relocations in the kernel-supplied purgatory code, so a user really has
> no way to do anything about the error even if it is printed.
> 
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> >
> >> Baoquan He wrote:
> >>> On 04/25/22 at 11:11pm, Naveen N. Rao wrote:
> >>>> kexec_load_purgatory() can fail for many reasons - there is no need to
> >>>> print an error when encountering unsupported relocations.
> >>>> This solves a build issue on powerpc with binutils v2.36 and newer [1].
> >>>> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> >>>> symbols") [2], binutils started dropping section symbols that it thought
> >>> I am not familiar with binutils, while wondering if this exists in other
> >>> ARCHes except of ppc. Arm64 doesn't have the ARCH override either, do we
> >>> have problem with it?
> >>
> >> I'm not aware of this specific file causing a problem on other architectures -
> >> perhaps the config options differ enough. There are however more reports of
> >> similar issues affecting other architectures with the llvm integrated assembler:
> >> https://github.com/ClangBuiltLinux/linux/issues/981
> >>
> >>>
> >>>> were unused.  This isn't an issue in general, but with kexec_file.c, gcc
> >>>> is placing kexec_arch_apply_relocations[_add] into a separate
> >>>> .text.unlikely section and the section symbol ".text.unlikely" is being
> >>>> dropped. Due to this, recordmcount is unable to find a non-weak symbol
> >>> But arch_kexec_apply_relocations_add is weak symbol on ppc.
> >>
> >> Yes. Note that it is just the section symbol that gets dropped. The section is
> >> still present and will continue to hold the symbols for the functions
> >> themselves.
> >
> > So we have a case where binutils thinks it is doing something useful
> > and our kernel specific tool gets tripped up by it.
> 
> It's not just binutils, the LLVM assembler has the same behavior.
> 
> > Reading the recordmcount code it looks like it is finding any symbol
> > within a section but ignoring weak symbols.  So I suspect the only
> > remaining symbol in the section is __weak and that confuses
> > recordmcount.
> >
> > Does removing the __weak annotation on those functions fix the build
> > error?  If so we can restructure the kexec code to simply not use __weak
> > symbols.
> >
> > Otherwise the fix needs to be in recordmcount or binutils, and we should
> > loop whoever maintains recordmcount in to see what they can do.
> 
> It seems that recordmcount is not really maintained anymore now that x86
> uses objtool?
> 
> There've been several threads about fixing recordmcount, but none of
> them seem to have lead to a solution.
> 
> These weak symbol vs recordmcount problems have been worked around going
> back as far as 2020:

It gives me feeling that llvm or recordmcount should make adjustment,
but not innocent kernel code, if there are a lot of places reported.
I am curious how llvm or recordmcount dev respond to this.

> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/elfcore.h?id=6e7b64b9dd6d96537d816ea07ec26b7dedd397b9
> 
> cheers
> 


