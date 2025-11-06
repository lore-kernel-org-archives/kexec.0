Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98B2CCFA13
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 22:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f81U5/79UyOAGW6VXn6pxFacbUSlx5ZrI8Z3RpSpADo=; b=dYRdCUuyl5R6BV48G32qhNydbm
	1IKdrEKc/KhFHXEJd2RIUnoKHnvWozkq6zp/+VjWtComnH/EZoavgMY7Cy/1ODuKznqVoYMIO9H1p
	LwggV/noEM4WaneRxMkSrp/ntE7aLtF52BJeYOWUb+qdycEPVQEORWcIvtsU+sjK1W3NzcO/9t11p
	fVzYdNc0T8y57yxhlsLJaJV+6cBhWihy0JN1CEJqqw5QCUq68Q+56DT1rnNPjfETRuRxoK25dGtt8
	/YPeEfNoAO+YpVGgommnYPh2AZ4lvyxn2qDgqdtv96al8iGUx/yZlW7vK2YYtxya+HC9UtrWPJ6Dp
	mKkKkJuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH8G8-0000000GIfu-1zjt;
	Thu, 06 Nov 2025 22:15:12 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH8G4-0000000GIfM-04m1
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 22:15:09 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so225795a12.0
        for <kexec@lists.infradead.org>; Thu, 06 Nov 2025 14:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762467305; x=1763072105; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f81U5/79UyOAGW6VXn6pxFacbUSlx5ZrI8Z3RpSpADo=;
        b=d3WA0HpDgwgapjuAPq/iQunZGkPcE49164Ma4M6h+BkG0xmjWyAnsvE6OCGUnwXB2m
         ENEQBhkgIjh1kRMb7NN6kd2KRX6ZwQkDDE5t/l7FmlgpHIPa5zF2+5YTM+ofrv4KpM6+
         h1QJH+i8cz88ZMngD91gkzM2LQWNkmvLrEUaVWi+qDYAXimPUu47dhPotJSgwf9y0pHn
         lTnizUXwdXxyKk/em2hET1qhcSaxusePjOEH0hBxKqlRcFud1MYSWXoVXBk13xmsTYaA
         CxXP3WziHBmMXXARfHFgwT+TGReVF35F5S6cONtnuqhIQiryl69ciH0EgnnqpngCyY/D
         IyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467305; x=1763072105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f81U5/79UyOAGW6VXn6pxFacbUSlx5ZrI8Z3RpSpADo=;
        b=k9po3JbS62hBy+BIDC/xlG9qKMHyMfGgfh6vqx/tOvRuHfnE3olXy7hoYY+8LYMvxl
         58Grp/oni4gOEEsiqpx27u5xDrgiKzeNKPQH7S7IsTiS1sZe11pSAFWqvS00ZxpNklaY
         brTJzgzjnEa2oYwngrXAhRpdjvdR1aiT4lDCgjTqls/MFJLRJRFH1sOGRMpHYA5d6aed
         EV9Pa0akvYiZueSKnB0R49lXAKZmaEfvQGljeYdMhpA3ci0KpCbSV9UMaTW/u7s9lIr4
         55G9XBBIUBWd3UmItSkULLAadP2rvvOtDPIZY2AZ1fzF9/20d0KN4Cfl0p8J3ghf/mLW
         SuPA==
X-Forwarded-Encrypted: i=1; AJvYcCXkgy6iSCINi4BX3kfRO/nGP28U3rKS1qoM1/1xqXrwCh6GGVlSkD5rSmcsnTzxbrPI5dsjkg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxiO2ei3Mf6gyGLWpMjBUD/tofgJuWE3A4atU6Sv08TfuAkbyN3
	ccbCZ9hJsbC7IT8xMxyY2NfhDHCrHHoWbQuFJqUBMZj5TfQFg3vrefpEtS3J/nwy4yrsHxlzTGB
	SliGfSFwFdtFRUG9rfelz8qrs5dxtW+C0VMYBEOBjbQ==
X-Gm-Gg: ASbGnctnamTpkSGYeYK5dE1SWtzRkrsgj0cAU0huEXMtd/fzz2zNFC9YQmBE4WQXDs2
	GhEZKb86BYpft/jTWAnbJf5W6q7GGLP1I1MKq1uZ8pRXE1UJR8pe23eROeauD4uENvn0Sr3oh3h
	kzhIwgxNXi6QwokeDBnpY5oVY+UyKMCJt2HKHfxebEsvU3tQ3SN/S3vsqr+7WZphHbWYBgGhm88
	3Re+2XYB+Eyu/Fz/EPTKiG32oh/17StJmKQDpZ/NNUmVbASC0o6T1mNIvzGRtnFexOO
X-Google-Smtp-Source: AGHT+IFMNxw/R1yQ2ypKv/nek+CS+Dt0g6lco0tSe4JF0aLBw9GdvNDeY3wOMxlums/5C8vWYWYunbR1HZth+5+nSYU=
X-Received: by 2002:a05:6402:3590:b0:638:74dc:cf78 with SMTP id
 4fb4d7f45d1cf-6413f08ef69mr1005608a12.34.1762467305387; Thu, 06 Nov 2025
 14:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20251101142325.1326536-3-pasha.tatashin@soleen.com>
 <202511061629.e242724-lkp@intel.com> <CA+CK2bCUWuK4fmuz5Us_mS1ByGy5SjaedVEquj1WxN8JUPsJaw@mail.gmail.com>
In-Reply-To: <CA+CK2bCUWuK4fmuz5Us_mS1ByGy5SjaedVEquj1WxN8JUPsJaw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 6 Nov 2025 17:14:28 -0500
X-Gm-Features: AWmQ_bkf90cd7vGfxxwFQfOgh84qLMbCwawCMq5n9jVWpcK7oaXbMt6knSHxPMQ
Message-ID: <CA+CK2bCSv99byZ-mc8bdoqfbp7qZTS9anky6oh=5ptg=MWPgxA@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] kho: drop notifiers
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, 
	linux-kselftest@vger.kernel.org, masahiroy@kernel.org, ojeda@kernel.org, 
	pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org, 
	yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_141508_136875_9C26CC5F 
X-CRM114-Status: GOOD (  23.90  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Nov 6, 2025 at 4:46=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> The bug is in lib/test_kho.c, when KHO is not enabled, it should not
> run KHO commands, there is a function to test that: kho_is_enabled().
> So, KHO is disabled and kho_add_subtree() which calles add debugfs
> entry, and the list is not initialized, because KHO is disabled. The
> fix is:

Sent it as a patch:
https://lore.kernel.org/all/20251106220635.2608494-1-pasha.tatashin@soleen.=
com

>
> diff --git a/lib/test_kho.c b/lib/test_kho.c
> index 025ea251a186..85b60d87a50a 100644
> --- a/lib/test_kho.c
> +++ b/lib/test_kho.c
> @@ -315,6 +315,9 @@ static int __init kho_test_init(void)
>         phys_addr_t fdt_phys;
>         int err;
>
> +       if (!kho_is_enabled())
> +               return 0;
> +
>         err =3D kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
>         if (!err)
>                 return kho_test_restore(fdt_phys);
>
> On Thu, Nov 6, 2025 at 3:41=E2=80=AFAM kernel test robot <oliver.sang@int=
el.com> wrote:
> >
> >
> >
> > Hello,
> >
> > kernel test robot noticed "WARNING:at_kernel/kexec_handover.c:#kho_add_=
subtree" on:
> >
> > commit: e44a700c561d1e892a8d0829d557e221604a7b93 ("[PATCH v9 2/9] kho: =
drop notifiers")
> > url: https://github.com/intel-lab-lkp/linux/commits/Pasha-Tatashin/kho-=
make-debugfs-interface-optional/20251101-222610
> > patch link: https://lore.kernel.org/all/20251101142325.1326536-3-pasha.=
tatashin@soleen.com/
> > patch subject: [PATCH v9 2/9] kho: drop notifiers
> >
> > in testcase: boot
> >
> > config: x86_64-randconfig-001-20251015
> > compiler: gcc-14
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> > +--------------------------------------------------------+------------+=
------------+
> > |                                                        | 93e4b3b2e9 |=
 e44a700c56 |
> > +--------------------------------------------------------+------------+=
------------+
> > | WARNING:at_kernel/kexec_handover.c:#kho_add_subtree    | 0          |=
 8          |
> > | RIP:kho_add_subtree                                    | 0          |=
 8          |
> > +--------------------------------------------------------+------------+=
------------+
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel=
.com
> >
> >
> > [   13.620111][    T1] ------------[ cut here ]------------
> > [   13.620739][    T1] WARNING: CPU: 1 PID: 1 at kernel/kexec_handover.=
c:704 kho_add_subtree (kernel/kexec_handover.c:704)
> > [   13.621665][    T1] Modules linked in:
> > [   13.622090][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted=
 6.18.0-rc3-00211-ge44a700c561d #1 VOLUNTARY
> > [   13.623073][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, =
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [   13.624054][    T1] RIP: 0010:kho_add_subtree (kernel/kexec_handover=
.c:704)
> > [   13.624596][    T1] Code: c7 38 b4 ac 85 31 ed e8 01 1c 00 00 48 c7 =
c7 70 5a ca 86 85 c0 89 c3 40 0f 95 c5 31 c9 31 d2 89 ee e8 37 b5 0a 00 85 =
db 74 02 <0f> 0b b9 01 00 00 00 31 d2 89 ee 48 c7 c7 40 5a ca 86 e8 1c b5 0=
a
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   c7 38 b4 ac 85          xbegin 0xffffffff85acb43d,(bad)
> >    5:   31 ed                   xor    %ebp,%ebp
> >    7:   e8 01 1c 00 00          call   0x1c0d
> >    c:   48 c7 c7 70 5a ca 86    mov    $0xffffffff86ca5a70,%rdi
> >   13:   85 c0                   test   %eax,%eax
> >   15:   89 c3                   mov    %eax,%ebx
> >   17:   40 0f 95 c5             setne  %bpl
> >   1b:   31 c9                   xor    %ecx,%ecx
> >   1d:   31 d2                   xor    %edx,%edx
> >   1f:   89 ee                   mov    %ebp,%esi
> >   21:   e8 37 b5 0a 00          call   0xab55d
> >   26:   85 db                   test   %ebx,%ebx
> >   28:   74 02                   je     0x2c
> >   2a:*  0f 0b                   ud2             <-- trapping instructio=
n
> >   2c:   b9 01 00 00 00          mov    $0x1,%ecx
> >   31:   31 d2                   xor    %edx,%edx
> >   33:   89 ee                   mov    %ebp,%esi
> >   35:   48 c7 c7 40 5a ca 86    mov    $0xffffffff86ca5a40,%rdi
> >   3c:   e8                      .byte 0xe8
> >   3d:   1c b5                   sbb    $0xb5,%al
> >   3f:   0a                      .byte 0xa
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   0f 0b                   ud2
> >    2:   b9 01 00 00 00          mov    $0x1,%ecx
> >    7:   31 d2                   xor    %edx,%edx
> >    9:   89 ee                   mov    %ebp,%esi
> >    b:   48 c7 c7 40 5a ca 86    mov    $0xffffffff86ca5a40,%rdi
> >   12:   e8                      .byte 0xe8
> >   13:   1c b5                   sbb    $0xb5,%al
> >   15:   0a                      .byte 0xa
> > [   13.626370][    T1] RSP: 0018:ffffc9000001fca0 EFLAGS: 00010286
> > [   13.626951][    T1] RAX: dffffc0000000000 RBX: 00000000ffffffff RCX:=
 0000000000000000
> > [   13.627737][    T1] RDX: 1ffffffff0d94b52 RSI: 0000000000000001 RDI:=
 ffffffff86ca5a90
> > [   13.628523][    T1] RBP: 0000000000000001 R08: 0000000000000008 R09:=
 fffffbfff0dfac4c
> > [   13.629330][    T1] R10: 0000000000000000 R11: ffffffff86fd6267 R12:=
 ffff888133ee2000
> > [   13.630101][    T1] R13: ffffffff85acb340 R14: ffff888117a5f988 R15:=
 dffffc0000000000
> > [   13.630869][    T1] FS:  0000000000000000(0000) GS:ffff888426ea0000(=
0000) knlGS:0000000000000000
> > [   13.631727][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > [   13.632370][    T1] CR2: 00007f586df260ac CR3: 00000000054ea000 CR4:=
 00000000000406f0
> > [   13.633154][    T1] Call Trace:
> > [   13.633506][    T1]  <TASK>
> > [   13.633833][    T1]  kho_test_prepare_fdt+0x145/0x180
> > [   13.634446][    T1]  ? kho_test_save_data+0x210/0x210
> > [   13.635097][    T1]  ? csum_partial (lib/checksum.c:123)
> > [   13.635546][    T1]  kho_test_init (lib/test_kho.c:177 lib/test_kho.=
c:284)
> > [   13.636018][    T1]  ? vmalloc_test_init (lib/test_kho.c:271)
> > [   13.636508][    T1]  ? add_device_randomness (drivers/char/random.c:=
944)
> > [   13.637485][    T1]  ? mix_pool_bytes (drivers/char/random.c:944)
> > [   13.637955][    T1]  ? trace_initcall_start (include/trace/events/in=
itcall.h:27 (discriminator 3))
> > [   13.638498][    T1]  ? vmalloc_test_init (lib/test_kho.c:271)
> > [   13.638989][    T1]  do_one_initcall (init/main.c:1284)
> > [   13.639477][    T1]  ? trace_initcall_start (init/main.c:1274)
> > [   13.639998][    T1]  ? parse_one (kernel/params.c:143)
> > [   13.640455][    T1]  ? kasan_save_track (mm/kasan/common.c:69 (discr=
iminator 1) mm/kasan/common.c:78 (discriminator 1))
> > [   13.640948][    T1]  ? __kmalloc_noprof (mm/slub.c:5659)
> > [   13.641465][    T1]  do_initcalls (init/main.c:1344 (discriminator 3=
) init/main.c:1361 (discriminator 3))
> > [   13.641924][    T1]  kernel_init_freeable (init/main.c:1595)
> > [   13.642441][    T1]  ? rest_init (init/main.c:1475)
> > [   13.642891][    T1]  kernel_init (init/main.c:1485)
> > [   13.643345][    T1]  ? rest_init (init/main.c:1475)
> > [   13.643788][    T1]  ret_from_fork (arch/x86/kernel/process.c:164)
> > [   13.644256][    T1]  ? rest_init (init/main.c:1475)
> > [   13.644703][    T1]  ret_from_fork_asm (arch/x86/entry/entry_64.S:25=
5)
> > [   13.645213][    T1]  </TASK>
> > [   13.645540][    T1] irq event stamp: 132025
> > [   13.645971][    T1] hardirqs last  enabled at (132035): __up_console=
_sem (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:10=
9 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:345)
> > [   13.646887][    T1] hardirqs last disabled at (132046): __up_console=
_sem (kernel/printk/printk.c:343 (discriminator 3))
> > [   13.648253][    T1] softirqs last  enabled at (131286): handle_softi=
rqs (kernel/softirq.c:469 (discriminator 1) kernel/softirq.c:650 (discrimin=
ator 1))
> > [   13.649690][    T1] softirqs last disabled at (131281): __irq_exit_r=
cu (kernel/softirq.c:496 kernel/softirq.c:723)
> > [   13.651128][    T1] ---[ end trace 0000000000000000 ]---
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20251106/202511061629.e242724-l=
kp@intel.com
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >

