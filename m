Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIjry-0004Cs-Sf
 for kexec@lists.infradead.org; Thu, 17 Sep 2020 02:42:00 +0000
Subject: Re: [PATCH] kexec-tools: Add some missing free() calls
References: <1599874789-7042-1-git-send-email-tangyouling@loongson.cn>
 <CAFTCetQRyzv6qx2dSsR59qUoL7keiwawjxN_f_f1DrD75PGB7A@mail.gmail.com>
From: Youling Tang <tangyouling@loongson.cn>
Message-ID: <d79d173a-261a-ff5c-f9e9-26fb514d1a88@loongson.cn>
Date: Thu, 17 Sep 2020 10:41:46 +0800
MIME-Version: 1.0
In-Reply-To: <CAFTCetQRyzv6qx2dSsR59qUoL7keiwawjxN_f_f1DrD75PGB7A@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org



On 09/17/2020 04:20 AM, Bhupesh SHARMA wrote:
> Hi Youling,
>
> See some comments inline:
>
> On Sat, Sep 12, 2020 at 7:11 AM Youling Tang <tangyouling@loongson.cn> wrote:
>> Add some missing free() calls.
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>   kexec/arch/i386/crashdump-x86.c    | 22 +++++++++++++++++-----
>>   kexec/arch/mips/crashdump-mips.c   |  5 ++++-
>>   kexec/arch/ppc64/crashdump-ppc64.c |  8 ++++++--
>>   3 files changed, 27 insertions(+), 8 deletions(-)
> First, I think this is a step in the right direction, however, earlier
> also while running 'valgrind' on an x86_64 kexec elf I saw the
> following memory leaks reported:
>
> ==596886== 15,604 bytes in 1 blocks are indirectly lost in loss record 4 of 12
> ==596886==    at 0x483A809: malloc (vg_replace_malloc.c:307)
> ==596886==    by 0x40396D: xmalloc (kexec.c:101)
> ==596886==    by 0x410D35: do_bzImage64_load (kexec-bzImage64.c:182)
> ==596886==    by 0x410D35: bzImage64_load (kexec-bzImage64.c:391)
> ==596886==    by 0x404410: my_load (kexec.c:774)
> ==596886==    by 0x402D2D: main (kexec.c:1605)
>
> ==596886== 15,732 (128 direct, 15,604 indirect) bytes in 1 blocks are
> definitely lost in loss record 5 of 12
> ==596886==    at 0x483CCE8: realloc (vg_replace_malloc.c:834)
> ==596886==    by 0x403FB9: xrealloc (kexec.c:112)
> ==596886==    by 0x403FB9: add_segment_phys_virt (kexec.c:357)
> ==596886==    by 0x40410F: add_buffer_phys_virt (kexec.c:392)
> ==596886==    by 0x404153: add_buffer_virt (kexec.c:401)
> ==596886==    by 0x40CD11: setup_linux_bootloader_parameters_high
> (x86-linux-setup.c:80)
> ==596886==    by 0x410E6A: do_bzImage64_load (kexec-bzImage64.c:214)
> ==596886==    by 0x410E6A: bzImage64_load (kexec-bzImage64.c:391)
> ==596886==    by 0x404410: my_load (kexec.c:774)
> ==596886==    by 0x402D2D: main (kexec.c:1605)
>
> ==596886== 28,896 bytes in 1 blocks are indirectly lost in loss record 7 of 12
> ==596886==    at 0x483A809: malloc (vg_replace_malloc.c:307)
> ==596886==    by 0x40396D: xmalloc (kexec.c:101)
> ==596886==    by 0x406781: elf_rel_load (kexec-elf-rel.c:254)
> ==596886==    by 0x406EEA: elf_rel_build_load (kexec-elf-rel.c:432)
> ==596886==    by 0x410CFE: do_bzImage64_load (kexec-bzImage64.c:173)
> ==596886==    by 0x410CFE: bzImage64_load (kexec-bzImage64.c:391)
> ==596886==    by 0x404410: my_load (kexec.c:774)
> ==596886==    by 0x402D2D: main (kexec.c:1605)
>
> ==596886== 30,048 (1,152 direct, 28,896 indirect) bytes in 1 blocks
> are definitely lost in loss record 8 of 12
> ==596886==    at 0x483A809: malloc (vg_replace_malloc.c:307)
> ==596886==    by 0x40396D: xmalloc (kexec.c:101)
> ==596886==    by 0x405735: build_mem_shdrs (kexec-elf.c:618)
> ==596886==    by 0x405735: build_elf_info (kexec-elf.c:774)
> ==596886==    by 0x406EB9: build_elf_rel_info (kexec-elf-rel.c:142)
> ==596886==    by 0x406EB9: elf_rel_build_load (kexec-elf-rel.c:427)
> ==596886==    by 0x410CFE: do_bzImage64_load (kexec-bzImage64.c:173)
> ==596886==    by 0x410CFE: bzImage64_load (kexec-bzImage64.c:391)
> ==596886==    by 0x404410: my_load (kexec.c:774)
> ==596886==    by 0x402D2D: main (kexec.c:1605)
> ==596886==
>
> Note that there were 12 issues highlighted via valgrind out of which I
> have removed the zlib related issue reports.
>
> You can run 'valgrind' on mips, i386 and ppc64 executables (as shown
> below) to see if all such issues are fixed by your patch:
> $ sudo valgrind --leak-check=full --show-leak-kinds=all
> --track-origins=yes --verbose --log-file=valgrind-out.txt ./kexec -l
> /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`.img
> --reuse-cmdline -d
>
Hi Bhupesh,

Thank you for your advice.
But it fails when installing 'valgrind' tool (arch: mips64),
the compilation error message is as follows:
...
/tmp/ccF1OhPy.s:6605: Error: unrecognized opcode `cfcmsa $4,$1'
/tmp/ccF1OhPy.s:6606: Error: unrecognized opcode `ctcmsa $1,$t0'
/tmp/ccF1OhPy.s:6656: Warning: tried to set unrecognized symbol: msa
/tmp/ccF1OhPy.s:6658: Error: unrecognized opcode `cfcmsa $2,$0'
Makefile:1625: recipe for target 'priv/libvex_mips64_linux_a-guest_mips_helpers.o' failed
make[3]: *** [priv/libvex_mips64_linux_a-guest_mips_helpers.o] Error 1
...

Youling,
Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
