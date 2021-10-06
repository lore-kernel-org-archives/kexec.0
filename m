Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mY4og-00Dztc-2p
 for kexec@lists.infradead.org; Wed, 06 Oct 2021 11:10:32 +0000
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A88A03FFE0
 for <kexec@lists.infradead.org>; Wed,  6 Oct 2021 11:10:27 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id
 x5-20020a50f185000000b003db0f796903so2262701edl.18
 for <kexec@lists.infradead.org>; Wed, 06 Oct 2021 04:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
In-Reply-To: <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
From: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date: Wed, 6 Oct 2021 13:10:14 +0200
Message-ID: <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
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
To: Nick Kossifidis <mick@ics.forth.gr>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org, linux-riscv <linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Alexandre ghiti <alex@ghiti.fr>, rppt@kernel.org, geert+renesas@glider.be, Stephano Cetola <scetola@linuxfoundation.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>

Hi Nick,

On Tue, Oct 5, 2021 at 4:07 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> On Tue, Oct 5, 2021 at 2:15 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
> >
> > Hello all,
> >
> > I've uploaded my kexec-tools patches for riscv on github for
> > testing/review before sending them upstream.
> > https://github.com/riscv-collab/kexec-tools/tree/riscv
> >
> > Both kexec and kdump were tested on latest rv64 qemu, using for-next
> > branch with this patch applied:
> > https://patchwork.kernel.org/project/linux-riscv/patch/20211002122026.1451269-1-mick@ics.forth.gr/
> >
>
> I'll test that asap and review your patch too.
>
> Thanks for your time Nick!
>
> Alex
>

So I followed the instructions here:
https://documentation.suse.com/fr-fr/sles/12-SP3/html/SLES-all/cha-tuning-kexec.html#cha-tuning-kexec-basic-usage,
below the output on an Unmatched board using a vmlinux stored on a sd
card:

ubuntu@ubuntu:~$ sudo sbin/kexec -l vmlinux --append="$(cat
/proc/cmdline)" --initrd=/boot/initrd.img
Warning: No cmdline provided, using append string as cmdline
Warning: No dtb provided, using /sys/firmware/fdt
[ 1813.472671] INFO: task kworker/1:0:988 blocked for more than 120 seconds.
[ 1813.478751]       Not tainted 5.15.0-rc1+ #15
[ 1813.483110] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
Could not find a free area of memory of 0x3000 bytes...
locate_hole failed

I used the Ubuntu kernel, so this is pretty large:
-rwxrwxr-x 1 ubuntu ubuntu 277M Oct  5 15:47 vmlinux
-rw-r--r-- 1 root root 98M Sep 21 03:25 /boot/initrd.img

Then if I don't load the initrd (I sometimes have the same warning as
above) I can at least kexec the new kernel but it fails to boot:

ubuntu@ubuntu:~$ sudo ./sbin/kexec -e
Warning: No cmdline or append string provided
Warning: No dtb provided, using /sys/firmware/fdt
[...]
[    0.000000] SBI v0.2 HSM extension detected
[    0.000000] CPU with hartid=0 is not available
[    0.000000] ------------[ cut here ]------------
[    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:107!
[    0.000000] Kernel BUG [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc1+ #15
[    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
[    0.000000] epc : setup_smp+0xcc/0x142
[    0.000000]  ra : setup_smp+0xc4/0x142
[    0.000000] epc : ffffffff80a04080 ra : ffffffff80a04078 sp :
ffffffff81803ec0
[    0.000000]  gp : ffffffff81a23220 tp : ffffffff81810500 t0 :
ffffffff81a3551f
[    0.000000]  t1 : ffffffffffffffff t2 : 0000000000000000 s0 :
ffffffff81803f00
[    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 :
0000000000000000
[    0.000000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 :
0000000000000000
[    0.000000]  a5 : ffffffff80c64500 a6 : 0000000000000004 a7 :
000000000000ff00
[    0.000000]  s2 : 0000000000000005 s3 : 0000000000000000 s4 :
ffffffff8118f9a8
[    0.000000]  s5 : 0000000000000007 s6 : ffffffff80c0b790 s7 :
0000000080000200
[    0.000000]  s8 : 0000000000000fff s9 : 0000000081000200 s10:
0000000000000018
[    0.000000]  s11: 000000000000000b t3 : 0000000000ff0000 t4 :
ffffffffffffffff
[    0.000000]  t5 : ffffffff80c0b7a0 t6 : ffffffff81803bd8
[    0.000000] status: 0000000200000100 badaddr: 0000000000000000
cause: 0000000000000003
[    0.000000] [<ffffffff80a04080>] setup_smp+0xcc/0x142
[    0.000000] [<ffffffff80a03d88>] setup_arch+0x56a/0x590
[    0.000000] [<ffffffff80a00aa2>] start_kernel+0xaa/0xa5c
[    0.000000] random: get_random_bytes called from
oops_exit+0x44/0x70 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

This reliably fails here.

> > Regards,
> > Nick
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
