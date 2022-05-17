From: Eric W. Biederman <ebiederm@xmission.com>
Date: Tue, 17 May 2022 10:32:18 -0500
Subject: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
In-Reply-To: <1652782155.56t7mah8ib.naveen@linux.ibm.com> (Naveen N. Rao's
 message of "Tue, 17 May 2022 15:49:41 +0530")
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
 <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
 <1652782155.56t7mah8ib.naveen@linux.ibm.com>
Message-ID: <8735h8b2f1.fsf@email.froward.int.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



Looking at this the pr_err is absolutely needed.  If an unsupported case
winds up in the purgatory blob and the code can't handle it things
will fail silently much worse later.  So the proposed patch is
unfortunately the wrong direction.

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Baoquan He wrote:
>> On 04/25/22 at 11:11pm, Naveen N. Rao wrote:
>>> kexec_load_purgatory() can fail for many reasons - there is no need to
>>> print an error when encountering unsupported relocations.
>>> This solves a build issue on powerpc with binutils v2.36 and newer [1].
>>> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
>>> symbols") [2], binutils started dropping section symbols that it thought
>> I am not familiar with binutils, while wondering if this exists in other
>> ARCHes except of ppc. Arm64 doesn't have the ARCH override either, do we
>> have problem with it?
>
> I'm not aware of this specific file causing a problem on other architectures -
> perhaps the config options differ enough. There are however more reports of
> similar issues affecting other architectures with the llvm integrated assembler:
> https://github.com/ClangBuiltLinux/linux/issues/981
>
>> 
>>> were unused.  This isn't an issue in general, but with kexec_file.c, gcc
>>> is placing kexec_arch_apply_relocations[_add] into a separate
>>> .text.unlikely section and the section symbol ".text.unlikely" is being
>>> dropped. Due to this, recordmcount is unable to find a non-weak symbol
>> But arch_kexec_apply_relocations_add is weak symbol on ppc.
>
> Yes. Note that it is just the section symbol that gets dropped. The section is
> still present and will continue to hold the symbols for the functions
> themselves.

So we have a case where binutils thinks it is doing something useful
and our kernel specific tool gets tripped up by it.

Reading the recordmcount code it looks like it is finding any symbol
within a section but ignoring weak symbols.  So I suspect the only
remaining symbol in the section is __weak and that confuses
recordmcount.

Does removing the __weak annotation on those functions fix the build
error?  If so we can restructure the kexec code to simply not use __weak
symbols.

Otherwise the fix needs to be in recordmcount or binutils, and we should
loop whoever maintains recordmcount in to see what they can do.

Eric

