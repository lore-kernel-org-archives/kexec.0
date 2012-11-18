Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZyQG-00017D-B6
 for kexec@lists.infradead.org; Sun, 18 Nov 2012 06:32:06 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so355856bkc.36
 for <kexec@lists.infradead.org>; Sat, 17 Nov 2012 22:32:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <871ufrqw3d.fsf@xmission.com>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
 <1353107067-14564-4-git-send-email-yinghai@kernel.org>
 <87haoo21mw.fsf@xmission.com>
 <CAE9FiQU=tW51h_NL+_AGQMDhNRM1dBCTW1FJVe6vpQYVQEzY=Q@mail.gmail.com>
 <87fw48zldz.fsf@xmission.com>
 <CAE9FiQVX8xnAGGkPtR0BA1iYbQi5fXY2+P3pW=d-tX8fpWibnw@mail.gmail.com>
 <CAE9FiQXNDEPw6WhfgYspqZsy+VVrPoA7M4kKo+5N95=22WBpkQ@mail.gmail.com>
 <50A86563.30303@zytor.com> <876253sej9.fsf@xmission.com>
 <CAE9FiQVfRHpoBoUyZssfE32wv7j3fD2skRL4UFXP=FBq7rrE1w@mail.gmail.com>
 <878v9zqyfh.fsf@xmission.com>
 <CAE9FiQV=6qeBgzd3ekBRXh1jfv+_-s_UuQqRyMAYwK5E=S55fA@mail.gmail.com>
 <CAE9FiQX7MsAaD4TaDv5gisuA5PNa9AmhDk54AjpzEzp4D_+aDg@mail.gmail.com>
 <CAE9FiQWm=6yas4dRfbc+qLC7yEhbdt+pnRMwAYSQ1jjk5qOvBw@mail.gmail.com>
 <871ufrqw3d.fsf@xmission.com>
Date: Sat, 17 Nov 2012 22:32:00 -0800
Message-ID: <CAE9FiQX9uneOpSZsG2jZKcBsYmTgBVHPSgeHuMfMMnqVJxApKA@mail.gmail.com>
Subject: Re: [PATCH 3/8] add mem64_min/max control
From: Yinghai Lu <yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sat, Nov 17, 2012 at 10:11 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Yinghai Lu <yinghai@kernel.org> writes:
>
>> On Sat, Nov 17, 2012 at 9:39 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Sat, Nov 17, 2012 at 9:35 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> On Sat, Nov 17, 2012 at 9:20 PM, Eric W. Biederman
>>>> <ebiederm@xmission.com> wrote:
>>>>> Yinghai Lu <yinghai@kernel.org> writes:
>>>>>>
>>>>>> there is lots of R_X86_64_32 and R_X86_64_32S for 64bit purgatory.
>>>>>>
>>>>>> those come from global variables...could kill some by converting them static...
>>>>>>
>>>>>> but still have some global string or ro data....
>>>>>>
>>>>>> build one big file include all .S ?
>>>>>
>>>>> For R_x86_64_32 and R_x86_64_32S the problem is that the instructions
>>>>> are using absolute 32bit addresses.
>>>>>
>>>>> It is probably overkill but we should be able to solve this with
>>>>> by adding "-mcmodel=large" to the build of purgatory.
>>>>
>>>> it kill some...
>>>>
>>>> still have left.... looks they from .S
>>>>
>>>> yhlu@linux-siqj:~/xx/xx/utils/kexec-tools> readelf --relocs
>>>> purgatory/purgatory.ro | grep R_X86_64_32
>>>> 0000000005e9  00020000000b R_X86_64_32S      0000000000000000 .rodata + c0
>>>
>>> looks like .S did not get that -mcmodel=large applied..
>>
>> so -mcmodel=large only work with .c, but does not have effects on .S ?
>
> Yes it -mcmodel=large is about which instructions you generate.  The
> instructions used determine the relocates.
>
> Just for playing with it the following patch modifies things so
> purgatory is 64bit clean.
>
> I don't know yet what to do with the 32bit and 16bit assembly.
>
> Eric
>
>
> diff --git a/purgatory/Makefile b/purgatory/Makefile
> index ee1679c..e39adec 100644
> --- a/purgatory/Makefile
> +++ b/purgatory/Makefile
> @@ -64,6 +64,7 @@ $(PURGATORY): $(PURGATORY_OBJS)
>         $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
>
>  #      $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
> +       $(STRIP) --strip-debug $@
>
>  echo::
>         @echo "PURGATORY_SRCS $(PURGATORY_SRCS)"
> diff --git a/purgatory/arch/x86_64/Makefile b/purgatory/arch/x86_64/Makefile
> index 22b4228..2a768c6 100644
> --- a/purgatory/arch/x86_64/Makefile
> +++ b/purgatory/arch/x86_64/Makefile
> @@ -2,7 +2,7 @@
>  # Purgatory x86_64
>  #
>
> -x86_64_PURGATORY_SRCS_native = purgatory/arch/x86_64/entry64-32.S
> +#x86_64_PURGATORY_SRCS_native = purgatory/arch/x86_64/entry64-32.S
>  x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/entry64.S
>  x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/setup-x86_64.S
>  x86_64_PURGATORY_SRCS_native += purgatory/arch/x86_64/stack.S
> @@ -16,9 +16,11 @@ dist += purgatory/arch/x86_64/Makefile $(x86_64_PURGATORY_SRCS_native)       \
>         purgatory/arch/x86_64/purgatory-x86_64.h
>
>  # Don't add sources in i386/ to dist, as i386/Makefile adds them
> -x86_64_PURGATORY_SRCS +=  purgatory/arch/i386/entry32-16.S
> -x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
> +#x86_64_PURGATORY_SRCS +=  purgatory/arch/i386/entry32-16.S
> +#x86_64_PURGATORY_SRCS += purgatory/arch/i386/entry32-16-debug.S
>  x86_64_PURGATORY_SRCS += purgatory/arch/i386/crashdump_backup.c
>  x86_64_PURGATORY_SRCS += purgatory/arch/i386/console-x86.c
>  x86_64_PURGATORY_SRCS += purgatory/arch/i386/vga.c
>  x86_64_PURGATORY_SRCS += purgatory/arch/i386/pic.c
> +
> +x86_64_PURGATORY_EXTRA_CFLAGS = -mcmodel=large
> diff --git a/purgatory/arch/x86_64/entry64.S b/purgatory/arch/x86_64/entry64.S
> index 666023c..e3223b7 100644
> --- a/purgatory/arch/x86_64/entry64.S
> +++ b/purgatory/arch/x86_64/entry64.S
> @@ -37,9 +37,10 @@ entry64:
>         movl    %eax, %fs
>         movl    %eax, %gs
>
> -       movq    $stack_init, %rsp
> +       leaq    stack_init(%rip), %rsp
>         pushq   $0x10 /* CS */
> -       pushq   $new_cs_exit
> +       leaq    new_cs_exit(%rip), %rax
> +       pushq   %rax
>         lretq
>  new_cs_exit:
>
> diff --git a/purgatory/arch/x86_64/setup-x86_64.S b/purgatory/arch/x86_64/setup-x86_64.S
> index 74997fa..95572d8 100644
> --- a/purgatory/arch/x86_64/setup-x86_64.S
> +++ b/purgatory/arch/x86_64/setup-x86_64.S
> @@ -42,10 +42,10 @@ purgatory_start:
>         /* In 64bit mode the code segment is meaningless */
>
>         movq    0(%rsp), %rax
> -       movq    %rax, jump_back_entry
> +       movq    %rax, jump_back_entry(%rip)
>
>         /* Setup a stack */
> -       movq    $lstack_end, %rsp
> +       leaq    lstack_end(%rip), %rsp
>
>         /* Call the C code */
>         call purgatory
>

Great. it works. Thanks a lot for your patch...

10:~/k # sh kk
bzImage is relocatable
code64_start_offset: 0x200
add_buffer: base:19fff7000 size:70a0
sym: sha256_update info: 12 other: 00 shndx: 1 value: 4382 size: 158
sym: sha256_update value: 19fffb382 addr: 19fff7004
R_X86_64_64
sym: sha256_starts info: 12 other: 00 shndx: 1 value: bac size: 79
sym: sha256_starts value: 19fff7bac addr: 19fff700e
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 8 value: 20 size: 100
sym: sha256_regions value: 19fffc120 addr: 19fff701a
R_X86_64_64
sym: sha256_regions info: 11 other: 00 shndx: 8 value: 20 size: 100
sym: sha256_regions value: 19fffc020 addr: 19fff7026
R_X86_64_64
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 44da size: 34b
sym: sha256_finish value: 19fffb4da addr: 19fff705a
R_X86_64_64
sym: sha256_digest info: 11 other: 00 shndx: 8 value: 0 size: 20
sym: sha256_digest value: 19fffc000 addr: 19fff706b
R_X86_64_64
sym:     memcmp info: 12 other: 00 shndx: 1 value: 5a7 size: 24
sym: memcmp value: 19fff75a7 addr: 19fff707a
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb910 addr: 19fff7092
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4c7 size: a0
sym: printf value: 19fff74c7 addr: 19fff709e
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb930 addr: 19fff70ab
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb940 addr: 19fff70c4
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4c7 size: a0
sym: printf value: 19fff74c7 addr: 19fff70ce
R_X86_64_64
sym: sha256_digest info: 11 other: 00 shndx: 8 value: 0 size: 20
sym: sha256_digest value: 19fffc000 addr: 19fff70e3
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb946 addr: 19fff70ed
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb948 addr: 19fff70fb
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb940 addr: 19fff7113
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4c7 size: a0
sym: printf value: 19fff74c7 addr: 19fff7125
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb946 addr: 19fff712f
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb958 addr: 19fff7152
R_X86_64_64
sym:     printf info: 12 other: 00 shndx: 1 value: 4c7 size: a0
sym: printf value: 19fff74c7 addr: 19fff715e
R_X86_64_64
sym: setup_arch info: 12 other: 00 shndx: 1 value: 6a4 size: 3a
sym: setup_arch value: 19fff76a4 addr: 19fff716b
R_X86_64_64
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: 150
sym: verify_sha256_digest value: 19fff7000 addr: 19fff7177
R_X86_64_64
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value:
716 size: 3c
sym: post_verification_setup_arch value: 19fff7716 addr: 19fff718a
R_X86_64_64
sym:    putchar info: 12 other: 00 shndx: 1 value: 83d size: 13e
sym: putchar value: 19fff783d addr: 19fff71a0
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb96a addr: 19fff72e6
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 194 size: 29d
sym: vsprintf value: 19fff7194 addr: 19fff74b5
R_X86_64_64
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 194 size: 29d
sym: vsprintf value: 19fff7194 addr: 19fff7555
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb8bc addr: 19fff75d3
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb8ec addr: 19fff75e9
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb82c addr: 19fff75fc
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb834 addr: 19fff7603
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb83c addr: 19fff760a
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb844 addr: 19fff7611
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb84c addr: 19fff7618
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb854 addr: 19fff761f
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb85c addr: 19fff7626
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb864 addr: 19fff762d
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb86c addr: 19fff7634
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb874 addr: 19fff763b
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb87c addr: 19fff7642
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb884 addr: 19fff7649
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb88c addr: 19fff7650
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb894 addr: 19fff7657
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb89c addr: 19fff765e
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb8a4 addr: 19fff7665
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb8ac addr: 19fff766b
R_X86_64_PC32
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb8ec addr: 19fff7673
R_X86_64_PC32
sym: jump_back_entry info: 11 other: 00 shndx: 8 value: 2008 size: 8
sym: jump_back_entry value: 19fffe004 addr: 19fff768d
R_X86_64_PC32
sym:       .bss info: 03 other: 00 shndx: 9 value: 0 size: 0
sym: .bss value: 19ffffffc addr: 19fff7694
R_X86_64_PC32
sym:  purgatory info: 12 other: 00 shndx: 1 value: 150 size: 44
sym: purgatory value: 19fff714c addr: 19fff7699
R_X86_64_PC32
sym:    entry64 info: 10 other: 00 shndx: 1 value: 5d0 size: 0
sym: entry64 value: 19fff75cc addr: 19fff769e
R_X86_64_PC32
sym:  reset_vga info: 11 other: 00 shndx: 8 value: 2012 size: 1
sym: reset_vga value: 19fffe012 addr: 19fff76a6
R_X86_64_64
sym: x86_reset_vga info: 12 other: 00 shndx: 1 value: 97c size: 1fb
sym: x86_reset_vga value: 19fff797c addr: 19fff76b6
R_X86_64_64
sym: legacy_pic info: 11 other: 00 shndx: 8 value: 2011 size: 1
sym: legacy_pic value: 19fffe011 addr: 19fff76c2
R_X86_64_64
sym: x86_setup_legacy_pic info: 12 other: 00 shndx: 1 value: b78 size: 31
sym: x86_setup_legacy_pic value: 19fff7b78 addr: 19fff76d2
R_X86_64_64
sym: cmdline_end info: 11 other: 00 shndx: 8 value: 2000 size: 8
sym: cmdline_end value: 19fffe000 addr: 19fff76e0
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 8 value: 2008 size: 8
sym: jump_back_entry value: 19fffe008 addr: 19fff76f2
R_X86_64_64
sym: .rodata.str1.1 info: 03 other: 00 shndx: 5 value: 0 size: 0
sym: .rodata.str1.1 value: 19fffb97b addr: 19fff76fc
R_X86_64_64
sym:    sprintf info: 12 other: 00 shndx: 1 value: 431 size: 96
sym: sprintf value: 19fff7431 addr: 19fff7709
R_X86_64_64
sym: panic_kernel info: 11 other: 00 shndx: 8 value: 2010 size: 1
sym: panic_kernel value: 19fffe010 addr: 19fff7718
R_X86_64_64
sym: crashdump_backup_memory info: 12 other: 00 shndx: 1 value: 754 size: 3e
sym: crashdump_backup_memory value: 19fff7754 addr: 19fff7729
R_X86_64_64
sym: jump_back_entry info: 11 other: 00 shndx: 8 value: 2008 size: 8
sym: jump_back_entry value: 19fffe008 addr: 19fff7735
R_X86_64_64
sym: x86_setup_jump_back_entry info: 12 other: 00 shndx: 1 value: 6de size: 38
sym: x86_setup_jump_back_entry value: 19fff76de addr: 19fff7746
R_X86_64_64
sym: backup_src_start info: 11 other: 00 shndx: 8 value: 2020 size: 8
sym: backup_src_start value: 19fffe020 addr: 19fff7756
R_X86_64_64
sym: backup_src_size info: 11 other: 00 shndx: 8 value: 2018 size: 8
sym: backup_src_size value: 19fffe018 addr: 19fff7763
R_X86_64_64
sym: backup_start info: 11 other: 00 shndx: 8 value: 2028 size: 8
sym: backup_start value: 19fffe028 addr: 19fff7775
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 58f size: 18
sym: memcpy value: 19fff758f addr: 19fff7787
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe040 addr: 19fff7796
R_X86_64_64
sym: serial_base info: 11 other: 00 shndx: 8 value: 2034 size: 2
sym: serial_base value: 19fffe034 addr: 19fff77a5
R_X86_64_64
sym: serial_baud info: 11 other: 00 shndx: 8 value: 2030 size: 4
sym: serial_baud value: 19fffe030 addr: 19fff77dd
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe040 addr: 19fff7810
R_X86_64_64
sym: serial_base info: 11 other: 00 shndx: 8 value: 2034 size: 2
sym: serial_base value: 19fffe034 addr: 19fff781a
R_X86_64_64
sym: console_vga info: 11 other: 00 shndx: 8 value: 2037 size: 1
sym: console_vga value: 19fffe037 addr: 19fff783f
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe038 addr: 19fff7855
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe038 addr: 19fff78c2
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe03c addr: 19fff78d2
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe038 addr: 19fff78db
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe038 addr: 19fff78ee
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe03c addr: 19fff78fa
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe03c addr: 19fff791d
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe03c addr: 19fff7931
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe038 addr: 19fff793d
R_X86_64_64
sym: console_serial info: 11 other: 00 shndx: 8 value: 2036 size: 1
sym: console_serial value: 19fffe036 addr: 19fff7947
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7794 addr: 19fff7960
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7794 addr: 19fff796e
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 58f size: 18
sym: memcpy value: 19fff758f addr: 19fffb43b
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 1 value: c25 size: 375d
sym: sha256_process value: 19fff7c25 addr: 19fffb459
R_X86_64_64
sym: sha256_process info: 12 other: 00 shndx: 1 value: c25 size: 375d
sym: sha256_process value: 19fff7c25 addr: 19fffb48d
R_X86_64_64
sym:     memcpy info: 12 other: 00 shndx: 1 value: 58f size: 18
sym: memcpy value: 19fff758f addr: 19fffb4cb
R_X86_64_64
sym:      .data info: 03 other: 00 shndx: 8 value: 0 size: 0
sym: .data value: 19fffe060 addr: 19fffb587
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 4382 size: 158
sym: sha256_update value: 19fffb382 addr: 19fffb594
R_X86_64_64
sym: sha256_update info: 12 other: 00 shndx: 1 value: 4382 size: 158
sym: sha256_update value: 19fffb382 addr: 19fffb5b3
R_X86_64_64
sym:    entry32 info: 10 other: 00 shndx: 0 value: 0 size: 0
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb8c0 addr: 19fffb8c2
R_X86_64_64
sym:    .rodata info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata value: 19fffb8f0 addr: 19fffb8f2
R_X86_64_64
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7000 addr: 19fffb9b8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7150 addr: 19fffb9f4
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7194 addr: 19fffba28
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7431 addr: 19fffba74
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff74c7 addr: 19fffba90
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7568 addr: 19fffbac8
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff757b addr: 19fffbadc
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff758f addr: 19fffbaf0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff75a7 addr: 19fffbb04
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff76a4 addr: 19fffbb30
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff76de addr: 19fffbb50
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7716 addr: 19fffbb64
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7754 addr: 19fffbba0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7794 addr: 19fffbbd0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff783d addr: 19fffbbe4
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff797c addr: 19fffbc20
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7b78 addr: 19fffbc50
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7bac addr: 19fffbc80
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fff7c25 addr: 19fffbca0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fffb382 addr: 19fffbcc0
R_X86_64_PC32
sym:      .text info: 03 other: 00 shndx: 1 value: 0 size: 0
sym: .text value: 19fffb4da addr: 19fffbce0
R_X86_64_PC32
Loaded purgatory at addr 0x19fff7000
add_buffer: base:19fff1000 size:44e0
Loaded setup data and command line at 0x19fff1000
add_buffer: base:180000000 size:917d50
Loaded 64bit kernel at 0x180000000
initrd_addr_max is 0x7fffffff
add_buffer: base:19d983000 size:266c368
Loaded initrd at 0x19d983000 size 0x266c368
cmd_line_ptr: 19fff5400
EDD raw data has length 30
Added 0 EDD MBR entries and 1 EDD entries.
10:~/k # kexec -e -d
[   56.119441] i2c i2c-0: shutdown
[   56.120652] psmouse serio1: shutdown
[   56.122606] atkbd serio0: shutdown
[   56.123847] i8042 i8042: shutdown
[   56.127562] sd 0:0:0:0: shutdown
[   56.129017] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   56.132681] pcspkr pcspkr: shutdown
[   56.133676] pnp 00:07: shutdown
[   56.134365] serial 00:06: shutdown
[   56.135158] pnp 00:05: shutdown
[   56.135918] pnp 00:04: shutdown
[   56.136838] i8042 aux 00:03: shutdown
[   56.138296] i8042 kbd 00:02: shutdown
[   56.139159] rtc_cmos 00:01: shutdown
[   56.140057] pnp 00:00: shutdown
[   56.141511] e1000 0000:00:03.0: shutdown
[   56.193472] pci 0000:00:02.0: shutdown
[   56.194498] piix4_smbus 0000:00:01.3: shutdown
[   56.195575] ata_piix 0000:00:01.1: shutdown
[   56.196684] pci 0000:00:01.0: shutdown
[   56.198051] pci 0000:00:00.0: shutdown
[   56.199296] PM: Calling mce_syscore_shutdown+0x0/0x50
[   56.200626] PM: Calling i8259A_shutdown+0x0/0x20
[   56.202037] Starting new kernel
early console in decompress_kernel
decompress_kernel:
  input: [0x18194a62e-0x18225a8a5], output: 0x180000000, heap:
[0x182261d40-0x182269d3f]

Decompressing Linux... xz... Parsing ELF... done.
Booting the kernel.
[    0.000000]    real_mode_data :      phys 000000019fff1000
[    0.000000]    real_mode_data :      virt ffff88019fff1000
[    0.000000]       boot_params : init virt ffffffff82e4d760
[    0.000000]       boot_params :      phys 0000000181e4d760
[    0.000000]       boot_params :      virt ffff880181e4d760
[    0.000000] boot_command_line : init virt ffffffff82d35000
[    0.000000] boot_command_line :      phys 0000000181d35000
[    0.000000] boot_command_line :      virt ffff880181d35000
[    0.000000] Kernel Layout:
[    0.000000]   .text: [0x180000000-0x18111d5ec]
[    0.000000] .rodata: [0x18111f000-0x181954fff]
[    0.000000]   .data: [0x181955000-0x181b0faff]
[    0.000000]   .init: [0x181b11000-0x181e38fff]
[    0.000000]    .bss: [0x181e47000-0x182bbafff]
[    0.000000]    .brk: [0x182bbb000-0x182bdffff]
[    0.000000] memblock_reserve: [0x180000000-0x182bbafff] TEXT DATA BSS
[    0.000000] memblock_reserve: [0x0009fc00-0x000fffff] * BIOS reserved
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.7.0-rc6-yh-00043-g5616ffd-dirty
(yhlu@linux-siqj.site) (gcc version 4.6.2 (SUSE Linux) ) #656 SMP Sat
Nov 17 17:25:49 PST 2012
[    0.000000] memblock_reserve: [0x19d983000-0x19ffeffff] RAMDISK
[    0.000000] Command line: initcall_debug pci=routeirq debug
i8042.debug=1 apic=debug lpfc.lpfc_use_msi=2 ramdisk_size=262144
root=/dev/ram0 rw ip=dhcp console=uart8250,io,0x3f8,115200n8
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
