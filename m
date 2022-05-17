From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Date: Tue, 17 May 2022 13:28:44 +0530
Subject: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
In-Reply-To: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
Message-ID: <1652773499.wq57us3gto.naveen@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Naveen N. Rao wrote:
> kexec_load_purgatory() can fail for many reasons - there is no need to
> print an error when encountering unsupported relocations.
> 
> This solves a build issue on powerpc with binutils v2.36 and newer [1].
> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [2], binutils started dropping section symbols that it thought
> were unused.  This isn't an issue in general, but with kexec_file.c, gcc
> is placing kexec_arch_apply_relocations[_add] into a separate
> .text.unlikely section and the section symbol ".text.unlikely" is being
> dropped. Due to this, recordmcount is unable to find a non-weak symbol
> in .text.unlikely to generate a relocation record against. Dropping
> pr_err() calls results in these functions being left in .text section,
> enabling recordmcount to emit a proper relocation record.
> 
> [1] https://github.com/linuxppc/issues/issues/388
> [2] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)

Eric,
Any comments on this? There have been many reports of build breakages 
due to this.

FWIW, there have been similar fixes in the past:
- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/init/initramfs.c?id=55d5b7dd6451b58489ce384282ca5a4a289eb8d5
- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/elfcore.h?id=6e7b64b9dd6d96537d816ea07ec26b7dedd397b9


- Naveen


