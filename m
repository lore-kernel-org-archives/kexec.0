Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f8OBh-0002cB-Is
 for kexec@lists.infradead.org; Tue, 17 Apr 2018 10:50:15 +0000
Received: by mail-lf0-f47.google.com with SMTP id z130-v6so1081663lff.5
 for <kexec@lists.infradead.org>; Tue, 17 Apr 2018 03:50:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417090113.GA19564@flint.armlinux.org.uk>
References: <CACi5LpOfCDgoaq6YphsqiR_cQGx+z_cTeZ-B=5_Bfm5632fPYQ@mail.gmail.com>
 <20180417090113.GA19564@flint.armlinux.org.uk>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 17 Apr 2018 16:20:00 +0530
Message-ID: <CACi5LpNYx07WCXTYZ0ksDt1zwyEcO+JaAGypfLqC=3o8bHr1aQ@mail.gmail.com>
Subject: Re: kdump in upstream kexec-tools
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
To: Russell King <rmk@armlinux.org.uk>
Cc: khalid.aziz@hp.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Apr 17, 2018 at 2:31 PM, Russell King <rmk@armlinux.org.uk> wrote:
> On Tue, Apr 17, 2018 at 10:20:08AM +0530, Bhupesh Sharma wrote:
>> Hi,
>>
>> I was working on improving documentation/structure of the upstream
>> kexec-tools and I was wondering what is the purpose of the 'kdump'
>> directory inside the kexec-tools.
>>
>> This kdump utility seems to cause confusion with the 'kdump' utility
>> present inside some distributions (for e.g.  '/usr/sbin/kdump' present
>> inside fedora) due to the same naming convention and so we should
>> populate/modify the kdump man page to indicate the same, so as to
>> avoid confusion.
>>
>> Presently here are the contents of this directory:
>>
>> # ls kdump/
>> kdump.8  kdump.c  Makefile
>>
>> - Out of these the kdump man documentation (kdump.8) is just a
>> placeholder as suggested by the man page documentation: "kdump - This
>> is just a placeholder until real man page has been written"
>>
>> - Looking at kdump.c :
>>
>> 1. I understand that this code is mainly used to read a crashdump from
>> memory. One can run the same using:
>>
>> # kdump <start_addr>
>>
>> where start_addr is basically the start address of the core dump
>> (which can also be represented via the 'elfcorehdr' environment
>> variable being passed to the crash kernel which represents the
>> physical address of the start of the ELF header)
>>
>> 2. This tool needs READ_ONLY access to /dev/mem (so we need to set
>> CONFIG_STRICT_DEVMEM configuration option accordingly).
>>
>> 3. The code thereafter reads (via mmap) and verifies the ELF header.
>> Subsequently it reads (via mmap) the program header.
>>
>> 4. Then we collect all the notes and write on STDOUT all the headers
>> and notes found in the crashdump collected from memory.
>>
>> So, as per my understanding even in absence of (more powerful) tools
>> like crash (or gdb), we can still go ahead and read the crashdump from
>> memory and display all the headers and notes present in the same on
>> standard serial out interface using this kdump utility.
>>
>> This is probably a good to have feature for systems which have very
>> simple/minimal rootfs (and I see that a few arm32 systems seem to use
>> the same as well) or are low on memory availability.
>>
>> Now, I wanted to confirm if the 'kdump' utility for reading crashdump
>> collected from memory is still needed (as the last commit is dated
>> back to 2016 and was done for arm32 systems). If yes, I can go ahead
>> and enhance the kdump man page to include the description given above
>> - so that it helps users understand how to run the tool.
>>
>> Please share your opinions.
>
> Firstly, please use:
>
>   git://git.armlinux.org.uk/~rmk/kexec-tools.git
>
> for ARM systems - this has some important fixes that aren't in the
> mainline repository.

Ok. Thanks for the pointer.

> I think the kdump tool is dead.  It only supports the 64-bit ELF
> format, and 32-bit ARM can either be 32-bit ELF or 64-bit ELF format
> coredumps, depending whether LPAE is enabled.  I've asked questions
> about this, and not got anywhere, so I now recommend not using that
> tool.

Sure, so if this is not really needed may be I can send out a patch to
remove the 'kdump/' directory from the upstream 'kexec-tools', as it
causes confusion when compared to similarly named distribution
specific kdump service/utilities.

@Simon - Please share if you see any other use-cases, that depend on
the 'kdump/' utility in the upstream 'kexec-tools'. AFAIK, this tool
is mainly used to obtain an ELF file which contains information about
the PT_NOTE and PT_LOAD segments within the crashdump read from the
memory.

For e.g I use this tool on my arm64 board as follows:

a. Read out the 'elfcorehdr' env variable passed to the crash kernel
and pass the same as an argument to the tool:

Assuming that the 'elfcorehdr' spans the range ->
0xffdf0000-0xffdf13ff, launch the tool as -

# kdump
Cannot find the start of the core dump

# kdump 0xffdf0000 >> output_elf_file

# file output_elf_file
output: ELF 64-bit LSB core file ARM aarch64, version 1 (SYSV)

# readelf -a --wide output_elf_file > read_output_elf_file

# less read_output_elf_file

ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              CORE (Core file)
  Machine:                           AArch64

</snip/> ..

There are no sections to group in this file.

Program Headers:
  Type           Offset   VirtAddr           PhysAddr
FileSiz  MemSiz   Flg Align
  NOTE           0x000740 0x0000000000000000 0x0000000000000000
0x000000 0x000000     0
  LOAD           0x000740 0xffff2472f6ae0000 0x00000008b10e0000
0x18a0000 0x18a0000 RWE 0
  LOAD           0x18a0740 0xffff800000620000 0x0000000000820000
0x2860000 0x2860000 RWE 0
  LOAD           0x4100740 0xffff800002e90000 0x0000000003090000
0x170000 0x170000 RWE 0
  LOAD           0x4270740 0xffff800003210000 0x0000000003410000
0x4030000 0x4030000 RWE 0
  LOAD           0x82a0740 0xffff800007280000 0x0000000007480000
0x120000 0x120000 RWE 0
</snip/> ..

> Have you checked whether objcopy can copy the coredump from
> /proc/vmcore to the filesystem?  That would permit saving of the
> coredump image for later inspection by gdb.

Yes, let me detail the sequence of steps taken when I use the Fedora
distribution specific kdump service and utilities.

When the primary kernel crashes:

1. If the crashkernel is loaded, then the system starts executing the
kdump kernel.

2. When the boot process gets to the point when kdump service is
started, the crashdump core is usually copied out to disk (for e.g.
inside '/var/crash') using 'cp' command from '/proc/vmcore' (please
see <https://github.com/torvalds/linux/blob/master/Documentation/kdump/kdump.txt#L463>):

# cp /proc/vmcore <dump-file>

3. Thereafter the system is rebooted back into the normal kernel.

4. Once back to your normal kernel, one can use the crashdump core
available on hard disk in conjunction with the previously installed
kernel (with debuginfo) to perform postmortem analysis with tools like
gdb/crash.
(please see <https://github.com/torvalds/linux/blob/master/Documentation/kdump/kdump.txt#L472>):

# gdb vmlinux <dump-file>

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
