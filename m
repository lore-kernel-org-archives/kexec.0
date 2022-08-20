Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EC5C28D13
	for <kexec@archiver.kernel.org>; Sat, 20 Aug 2022 02:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PG1DACD/1TOWslD6Dpnrt5C9yT1gh+JPQLiptR0vhx4=; b=hyiMR9XfAi589y
	HsybF2tOPw5WM8gf11eu4aupYF0kL9BFG1zsMsmjO6KfTy8e6TBKcj3Ln/muYiyUd66n8EmtnVVoK
	zBDiLZMSm8u0aEkLYvnEVPwYkviGWKivNCjxhqG1twJhh8G9bTaoJPjNJrmq2VoVMGsyDXztUIzuc
	1r2HpX8WBMT3KafJcf2B5ODj1xsleQHHSH0aDpY5GM4GZMCFZc0LQXzW9F2tnCS+DGJGqzQU0Umz8
	5/9bJQf1OWQlF+6dZgzJk1TGaHcnr4C9MFNp6u/WWsAGtvyACsOQV9Q288EUyowhS30DoCJ9+jL2z
	lnYwW7M14jESwdRNHK9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPE5E-00F06n-Np; Sat, 20 Aug 2022 02:19:32 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPE5A-00F01V-Q8; Sat, 20 Aug 2022 02:19:30 +0000
Received: by mail-ot1-x32a.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso4211674otv.1;
        Fri, 19 Aug 2022 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kq6vfjFZNBDSv1cVPne0kStOBJmXAhYIZ+nQEBFFCrA=;
        b=e42+aHBNR31eV+SvF6JkAdXxPEKnw9sFB7pYNNtquQgM41tC35qhKhNHFhnU9soEM7
         c50TRzKQobfBx0k85Q93IRU3g+e+3ywK36QCZIqDmb3yK/NL0ujHt1a24FtxyKIl/Cxs
         vV325As6WSV/cX6a77aOqVFujfqAZbOvomoziM1GZKcg7f5lFNuuwlUutMOb71gdJJ1f
         EC2989gQtYb5xODiL/Vsj1RM9umZ+oaj7f6ZogwMY6qTUWIXr0ahOAZEEvsRHXUAbqu/
         zOfaCRDQyvKMMRrA9Yk58FQROrYaJ+zQKbAkW63giUQGl63HA3Cu4Okg3a9qoFrmtup7
         /sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kq6vfjFZNBDSv1cVPne0kStOBJmXAhYIZ+nQEBFFCrA=;
        b=waSbdoDwowUb3U14cUu0eEhsGqbPQKMP8AF68RVhL4OoxwjiTZkpAArkP9ObmQXiPy
         b+385hEmUvkezj/U8joWs1pZptnEMXM6fNaKZ1d6VfYr6iMmi79N1HYS1S3CIh2iuxg8
         sfPUkpfiPNFFUHXw7ljRNx4WwF+8pr5V/67QoeC9DzVdcDlZt4Vy3fyviqekfID9WNGc
         APRwTh4gE/mxJeaHsjQdC3cw3RyEdQLxrl9mVo4hLtBp6hUoMWP/UWyajIfiFtr4m4GF
         +4lM1bNv3cXEvQ2Ui5uU/h3NTw3v/9Wa8VjHTHtZPWrDx/FODLvY6fUexbWdHVGVgFAL
         p9hg==
X-Gm-Message-State: ACgBeo1spmLVcsTm86RCcCR3gtn4xnAB4CCq118sReBdvabe8zFl/T22
	OQBWCCGR+MfOP4KfrYDky3eazdfoRm0G0XJE2iw=
X-Google-Smtp-Source: AA6agR705E38AcvqtTJs4JmmU240yY+S5k3XbAT9XgD0Ag5CRBn/kVbJTzeWLT8SNSpEcc1Mx0ayCxhWfRI9xH9vxV8=
X-Received: by 2002:a9d:66cf:0:b0:637:1d30:d72b with SMTP id
 t15-20020a9d66cf000000b006371d30d72bmr3962024otm.35.1660961966755; Fri, 19
 Aug 2022 19:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com> <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
In-Reply-To: <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
From: Yixun Lan <yixun.lan@gmail.com>
Date: Sat, 20 Aug 2022 02:19:15 +0000
Message-ID: <CALecT5gQWn0PRO4Q24b6qkrfVE5OxsCp65TuhWTb30ceK_OJ0A@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc: Nick Kossifidis <mick@ics.forth.gr>, ebiederm@xmission.com, kexec@lists.infradead.org, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Alexandre ghiti <alex@ghiti.fr>, 
	Mike Rapoport <rppt@kernel.org>, geert+renesas@glider.be, 
	Stephano Cetola <scetola@linuxfoundation.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup.patel@wdc.com>, 
	Atish Patra <atish.patra@wdc.com>, Xianting Tian <xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_191928_934664_49553295 
X-CRM114-Status: GOOD (  27.88  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Alexandre, Nick:

On Wed, Oct 6, 2021 at 11:15 AM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> Hi Nick,
>
> On Tue, Oct 5, 2021 at 4:07 PM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > On Tue, Oct 5, 2021 at 2:15 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
> > >
> > > Hello all,
> > >
> > > I've uploaded my kexec-tools patches for riscv on github for
> > > testing/review before sending them upstream.
> > > https://github.com/riscv-collab/kexec-tools/tree/riscv
> > >
> > > Both kexec and kdump were tested on latest rv64 qemu, using for-next
> > > branch with this patch applied:
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20211002122026.1451269-1-mick@ics.forth.gr/
> > >
> >
> > I'll test that asap and review your patch too.
> >
> > Thanks for your time Nick!
> >
> > Alex
> >
>
> So I followed the instructions here:
> https://documentation.suse.com/fr-fr/sles/12-SP3/html/SLES-all/cha-tuning-kexec.html#cha-tuning-kexec-basic-usage,
> below the output on an Unmatched board using a vmlinux stored on a sd
> card:
>
> ubuntu@ubuntu:~$ sudo sbin/kexec -l vmlinux --append="$(cat
> /proc/cmdline)" --initrd=/boot/initrd.img
> Warning: No cmdline provided, using append string as cmdline
> Warning: No dtb provided, using /sys/firmware/fdt
> [ 1813.472671] INFO: task kworker/1:0:988 blocked for more than 120 seconds.
> [ 1813.478751]       Not tainted 5.15.0-rc1+ #15
> [ 1813.483110] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> Could not find a free area of memory of 0x3000 bytes...
> locate_hole failed

I've finally spent some time debugging this, and found the fix:

--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -120,7 +120,7 @@ int load_extra_segments(struct kexec_info *info,
uint64_t kernel_base,
                               initrd_base + initrd_size);

                dbgprintf("Base addr for initrd image: 0x%lX\n", initrd_base);
-               min_usable = initrd_base;
+               max_usable = initrd_base;
        }

the initrd image has been put at end of memory space( from high
address down to low address),
for example, my case here:
  the crash memory: 0x90000000 - 0xA0000000
  and the initrd base: 0x9F78F000

so, the max_usable address need to update
>
> I used the Ubuntu kernel, so this is pretty large:
> -rwxrwxr-x 1 ubuntu ubuntu 277M Oct  5 15:47 vmlinux
> -rw-r--r-- 1 root root 98M Sep 21 03:25 /boot/initrd.img
>
> Then if I don't load the initrd (I sometimes have the same warning as
> above) I can at least kexec the new kernel but it fails to boot:
>
> ubuntu@ubuntu:~$ sudo ./sbin/kexec -e
> Warning: No cmdline or append string provided
> Warning: No dtb provided, using /sys/firmware/fdt
> [...]
> [    0.000000] SBI v0.2 HSM extension detected
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:107!
> [    0.000000] Kernel BUG [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc1+ #15
> [    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
> [    0.000000] epc : setup_smp+0xcc/0x142
> [    0.000000]  ra : setup_smp+0xc4/0x142
> [    0.000000] epc : ffffffff80a04080 ra : ffffffff80a04078 sp :
> ffffffff81803ec0
> [    0.000000]  gp : ffffffff81a23220 tp : ffffffff81810500 t0 :
> ffffffff81a3551f
> [    0.000000]  t1 : ffffffffffffffff t2 : 0000000000000000 s0 :
> ffffffff81803f00
> [    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 :
> 0000000000000000
> [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 :
> 0000000000000000
> [    0.000000]  a5 : ffffffff80c64500 a6 : 0000000000000004 a7 :
> 000000000000ff00
> [    0.000000]  s2 : 0000000000000005 s3 : 0000000000000000 s4 :
> ffffffff8118f9a8
> [    0.000000]  s5 : 0000000000000007 s6 : ffffffff80c0b790 s7 :
> 0000000080000200
> [    0.000000]  s8 : 0000000000000fff s9 : 0000000081000200 s10:
> 0000000000000018
> [    0.000000]  s11: 000000000000000b t3 : 0000000000ff0000 t4 :
> ffffffffffffffff
> [    0.000000]  t5 : ffffffff80c0b7a0 t6 : ffffffff81803bd8
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000
> cause: 0000000000000003
> [    0.000000] [<ffffffff80a04080>] setup_smp+0xcc/0x142
> [    0.000000] [<ffffffff80a03d88>] setup_arch+0x56a/0x590
> [    0.000000] [<ffffffff80a00aa2>] start_kernel+0xaa/0xa5c
> [    0.000000] random: get_random_bytes called from
> oops_exit+0x44/0x70 with crng_init=0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
> the idle task! ]---
>
> This reliably fails here.
>
> > > Regards,
> > > Nick
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
