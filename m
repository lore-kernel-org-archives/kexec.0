Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fgALE-0002pr-8C
 for kexec@lists.infradead.org; Thu, 19 Jul 2018 14:55:42 +0000
Received: by mail-lj1-f193.google.com with SMTP id r13-v6so7966098ljg.10
 for <kexec@lists.infradead.org>; Thu, 19 Jul 2018 07:55:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
References: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
 <d8959ca1-65a1-f59c-bfc4-b048c75add26@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 19 Jul 2018 20:25:27 +0530
Message-ID: <CACi5LpOa-BMRSTShS019DDv7MoxNfpnnsqjwR3z13GZC49NrSA@mail.gmail.com>
Subject: Re: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Will Deacon <will.deacon@arm.com>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi James,

On Thu, Jul 19, 2018 at 5:01 PM, James Morse <james.morse@arm.com> wrote:
> Hi Bhupesh,
>
> On 18/07/18 22:37, Bhupesh Sharma wrote:
>> Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.
>>
>> makedumpfile user-space utility will need fixup to use this KASLR offset
>> to work with cases where we need to find a way to translate symbol
>> address from vmlinux to kernel run time address in case of KASLR boot on
>> arm64.
>
> You need the kernel VA for a symbol. Isn't this what kallsyms is for?
> | root@frikadeller:~# cat /proc/kallsyms | grep swapper_pg_dir
> | ffff5404610d0000 B swapper_pg_dir

Its already used by other archs like x86_64. See
'arch/x86/kernel/machine_kexec_64.c' :

void arch_crash_save_vmcoreinfo(void)
{
    <..snip..>
    vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
                  kaslr_offset());
    <..snip..>
}

Its just that we are enabling this feature for arm64 now that the
KASLR boot cases are more widely seen on arm64 boards (as newer EFI
firmware implementations are available which support EFI_RNG_PROTOCOL
and hence KASLR boot).

And we want existing user-space application(s) to work similarly on
arm64 distributions as they work historically on other archs like
x86_64 (in most cases the user-space user is not even aware, if he is
developing for or using an underlying hardware which is arm64 or
x86_64)

> This is the KASLR address, the vmlinux has:
> | root@frikadeller:~/linux/build_arm64# nm -s vmlinux | grep swapper_pg_dir
> | ffff0000096d0000 B swapper_pg_dir
>
>
> This is in the vmcoreinfo too, so you can work if out from the vmcore too:
> | root@frikadeller:~# dd if=/proc/kcore bs=8K count=1 2>/dev/null | strings |
> | grep swapper_pg_dir
> | SYMBOL(swapper_pg_dir)=ffff5404610d0000
>
>
> I picked swapper_pg_dir, but you could use any of the vmcore:SYMBOL() addresses
> to work out this offset. (you should expect the kernel to rename these symbols
> at a whim).
>

Perhaps you missed what the above makedumpfile command was doing, so
let me summarize again:

The above makedumpfile command is trying to 'split' a vmcore file into
smaller sub dumpfiles on the basis of some filtering rules. These
rules are defined via a .conf file (scrub.conf in my example below).

Lets see what MAKEDUMPFILE(8) documents about the '--split' option:

--split
              Split the dump data to multiple DUMPFILEs in parallel.
If specifying DUMPFILEs on different  storage  devices,  a  device
can share I/O load with other devices and it reduces time for saving
the
dump data. The file size of each DUMPFILE is smaller than the system
memory size which is  divided by the number of DUMPFILEs. This feature
supports only the kdump-compressed format.

So, this use-case expects 'vmlinux' and 'vmcore' as mandatory inputs.

Now, coming back to the use-case:

# makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore
dumpfile_{1,2,3}

Here, 'scrub.conf ' is defined to erase symbols 'jiffies',
'init_task.utime' and 'tsk.utime'

 # cat > scrub.conf << EOF
   [vmlinux]
   erase jiffies
   erase init_task.utime
   for tsk in init_task.tasks.next within task_struct:tasks
       erase tsk.utime
   endfor
   EOF

This is usually used to erase company-confidential or non-important
symbols from a vmcore before handing it over to a debugger (which uses
this vmcore to determine the root-cause of a crash) - as there can be
some sensitive symbols which a reporter may not want the debugger to
read.

So, in this use case both vmlinux (which contains the symbols) and
vmcore are mandatory inputs and we cannot kallsyms. as it breaks the
existing user-space use-cases and the .conf file can be user-defined
(and hence he can pick any symbol/functions which might not even be
present in 'kallsyms'). So no we cannot use 'kallsyms' here.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
