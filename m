From: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Date: Tue, 17 May 2022 15:49:41 +0530
Subject: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
In-Reply-To: <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
 <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
Message-ID: <1652782155.56t7mah8ib.naveen@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Baoquan He wrote:
> On 04/25/22 at 11:11pm, Naveen N. Rao wrote:
>> kexec_load_purgatory() can fail for many reasons - there is no need to
>> print an error when encountering unsupported relocations.
>> 
>> This solves a build issue on powerpc with binutils v2.36 and newer [1].
>> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>> symbols") [2], binutils started dropping section symbols that it thought
> 
> I am not familiar with binutils, while wondering if this exists in other
> ARCHes except of ppc. Arm64 doesn't have the ARCH override either, do we
> have problem with it?

I'm not aware of this specific file causing a problem on other 
architectures - perhaps the config options differ enough. There are 
however more reports of similar issues affecting other architectures 
with the llvm integrated assembler:
https://github.com/ClangBuiltLinux/linux/issues/981

> 
>> were unused.  This isn't an issue in general, but with kexec_file.c, gcc
>> is placing kexec_arch_apply_relocations[_add] into a separate
>> .text.unlikely section and the section symbol ".text.unlikely" is being
>> dropped. Due to this, recordmcount is unable to find a non-weak symbol
> 
> But arch_kexec_apply_relocations_add is weak symbol on ppc.

Yes. Note that it is just the section symbol that gets dropped. The 
section is still present and will continue to hold the symbols for the 
functions themselves.

> 
>> in .text.unlikely to generate a relocation record against. Dropping
>> pr_err() calls results in these functions being left in .text section,
> 
> Why dropping pr_err() can make arch_kexec_apply_relocations_add put in
> .text?

I'm not actually sure, though Josh suspected that printk() might be 
cold:
http://lkml.kernel.org/r/20210214155147.3owdimqv2lyhu6by at treble


- Naveen


