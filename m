Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37063D711CF
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 00:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8PBYCo/QeAIMip4Z0up6tB7usLt9oGChXKSBtDDKtg=; b=y+yZLflgqZuZQYlQctt1WCO/9w
	emNBAEQD1jXWVGexn5D0287UHt+efIUtSFJwtrkhFTmiUU+1TL4y+kHwajGL2y0pWVm6fGOpKsOdC
	yh9+LH3GvQUB9TDg8QwHdq74hj+ncoWBfx+xdNOew+/PsWUW97XUZ31+TKfUDwnkxsCsHRWVxTxGg
	jXH2YRmFawiHyuL2FzrGslj6DL0dMVXgF1ejX4zNNYYnonEzFT9YnBQYUxcuHHa840lsSIk/pkcF7
	hNARELDDcN34aiFgWpMbVZhgnkQI1yd+g1/SAdGhYRg7uDIJZDL55yvZW8IqK5aNx2W9IFUNkJU3t
	HQ40EphA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWOKi-00000009ONK-0Bbd;
	Fri, 19 Dec 2025 00:27:00 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWOKf-00000009OMy-2HcE
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 00:26:58 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso178627a12.1
        for <kexec@lists.infradead.org>; Thu, 18 Dec 2025 16:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766104015; x=1766708815; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8PBYCo/QeAIMip4Z0up6tB7usLt9oGChXKSBtDDKtg=;
        b=AZ7vprxVLC6OnEQKYu1QfrdrbgmVlkG19E5E/H6eAAJzqAruBDs366RVPgd7WzB2sK
         ENpIWxwhusbG6gBRHg0AccXCOEFAwsLg5VUhABbX9JuVwE2uJa/X5iRpWuXekEPqnNLu
         UQfhLd/Wfinm3Yxub9YYMwyLJTF3I9St7b/hgSne/22QwBVP9uBLomZ4lY2peVM9xKP1
         NfLLsUBzay+xyYtnf+CWGjvnJ2xSSs7mjudCwICGmMbd5BgHp9xm+V84gp/n6vsZwjKC
         Mp1T8rILSd4kBduoc19vsG7YEZlgRe6/Hdqhrx1um9ygYR/4rxz8iQsCDaV1izJrJPWO
         wTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766104015; x=1766708815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8PBYCo/QeAIMip4Z0up6tB7usLt9oGChXKSBtDDKtg=;
        b=ngQzUR3iNHEJtpyu3nxppQiLbBDDsloChjUXdaNd+oxqN5hAGOjY5CIWFG+AIhX4UO
         mJwL82gueYsYBchMBs5I02eYd7K5e5JLZPIYxNNeirE+3a09OeuGkalVJwTA+c8ylZeD
         She88mEf/pwWYGz8jWtYoYZ4QHt1pQgYs3tvxJSbeEx1/whVyw3bVsHsMqnxiA69R6+s
         RxlSfLRwrLvMcu8b7Z4FsA+UfdB8yOLiIJ+ookcw6yCU1SCX4HgWTLrkNeWuMo9WEX+D
         8coafJAGpdhXeJSi+SRc+hhf1Bq4/587zZzj6EILSKnCsl1gC84fmStIn4f+mSeF1L1I
         GqvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzbT5ACVZluG3XEV2FLkM6AQCQsmOR7fIgWPp6CsmIwK2BNSaYYAfCfH/R4lZ0c6zFk+DZ/Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyi3zjigWJL3v5WeDbf24fzInPMTUUGSbQc394CPuKomhlIkfTX
	p/iFLglZ69Xy3ByElsxKxLI0TOU/d18GTX1XQ+PAdjElN/ChzODgYkhNnFO9SOlS5s9UsJKTNwP
	2CHp4ZZosGd0KmN2UbxbPxc28K97Jf/6ozW4Nw7Y6pg==
X-Gm-Gg: AY/fxX41xV1jHBkLRHDM6OQqNQlF+o96oHUJbD/RJVdHZqkToXnMW+Bbybtcq4o8eP4
	b4vWjM7I3FGzeWIgqtPqxVaj6kmMV54H2PDZjj7QWUaGWyIUu4331hwTLTkKecYXYYgbalxqQof
	MW1xhYEMaL+dIAK/V9z2uGmznmRA4FszUX2OMztCZW2enejVEiTXTAcX3Wp4VqW1jH/VcDWF3LW
	a1vvUwhOsAdC4tpQOCjm/KGoRBIIkrLEK6VXvHJX+l1UOWCX4ODoLiiU++sFHVADeRX8d3d7LDm
	glMt7Thaq5y+0Oft0H+Hg1GL
X-Google-Smtp-Source: AGHT+IEPpk2oi2/uS7TbsT+Knx1KIm/oHlK+Lp8k6q7ZVbmt0bRrMa3gJwr+kiCunUZsPNtGYNdDFrt9yuYAx2gGA1Q=
X-Received: by 2002:a05:6402:1472:b0:64b:4037:6f60 with SMTP id
 4fb4d7f45d1cf-64b8e937ebcmr1129295a12.7.1766104015597; Thu, 18 Dec 2025
 16:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
 <20251114190002.3311679-12-pasha.tatashin@soleen.com> <20251218215613.GA17304@ranerica-svr.sc.intel.com>
In-Reply-To: <20251218215613.GA17304@ranerica-svr.sc.intel.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 18 Dec 2025 19:26:19 -0500
X-Gm-Features: AQt7F2qk99QOqFiR7y0dRyUrTTpMomXa4XVxcUeP3udd1thYUZ9s9lUscjpp6Z0
Message-ID: <CA+CK2bDucySNG7QqE87bZndgjKH-QCw61romZVExD63S2iM6og@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] kho: Allow kexec load before KHO finalization
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org, 
	jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com, dave@vasilevsky.ca, 
	ebiggers@google.com, graf@amazon.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	ricardo.neri@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_162657_638661_B728BA54 
X-CRM114-Status: GOOD (  30.85  )
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

On Thu, Dec 18, 2025 at 4:49=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Fri, Nov 14, 2025 at 02:00:00PM -0500, Pasha Tatashin wrote:
> > Currently, kho_fill_kimage() checks kho_out.finalized and returns
> > early if KHO is not yet finalized. This enforces a strict ordering wher=
e
> > userspace must finalize KHO *before* loading the kexec image.
> >
> > This is restrictive, as standard workflows often involve loading the
> > target kernel early in the lifecycle and finalizing the state (FDT)
> > only immediately before the reboot.
> >
> > Since the KHO FDT resides at a physical address allocated during boot
> > (kho_init), its location is stable. We can attach this stable address
> > to the kimage regardless of whether the content has been finalized yet.
> >
> > Relax the check to only require kho_enable, allowing kexec_file_load
> > to proceed at any time.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 461d96084c12..4596e67de832 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -1550,7 +1550,7 @@ int kho_fill_kimage(struct kimage *image)
> >       int err =3D 0;
> >       struct kexec_buf scratch;
> >
> > -     if (!kho_out.finalized)
> > +     if (!kho_enable)
> >               return 0;
>
> Hi Pasha,
>
> Using v6.19-rc1 (which has this changeset) and with:
>
> CONFIG_KEXEC_HANDOVER=3Dy
> CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=3Dy
> CONFIG_LIVEUPDATE=3Dn (i.e., nobody calling kho_finalize())
> no reserve_mem=3D entries in the kernel command line
>
> I omit doing
>
> echo 1 > /sys/kernel/debug/kho/out/finalize
>
> before doing
>
> kexec -l <kernel> --initrd=3D<initrd> --commandline=3D"$(cat /proc/cmdlin=
e)"
> kexec -e

Hi Ricardo,

Thank you for reporting this bug. I created a fix here:
https://lore.kernel.org/lkml/20251219002355.3323896-1-pasha.tatashin@soleen=
.com

Please let me know if it works.

Thanks,
Pasha

>
> After the kexec reboot, I see endless warnings about list corruption [1]
> and from _text_poke() [2] (see below).
>
> The post-kexec kernel finds KHO data but it obviously is empty because
> nobody was using it.
>
> I was expecting that KHO would handle this use case gracefully. What if a
> distro does not finalize KHO before kexec and are no in-kernel users?
>
> Am I missing anything?
>
> Thanks and BR,
> Ricardo
>
> [1]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/lib/list_debug.c?h=3Dv6.19-rc1#n56
> [2]. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/arch/x86/kernel/alternative.c?h=3Dv6.19-rc1#n2506
>
> [   10.730845] ------------[ cut here ]------------
> [   10.734848] list_del corruption, ffffd143c1330008->next is LIST_POISON=
1 (dead000000000100)
> [   10.742846] WARNING: lib/list_debug.c:56 at __list_del_entry_valid_or_=
report+0x91/0x110, CPU#12: swapper/0/1
> [   10.750845] Modules linked in:
> [   10.754845] CPU: 12 UID: 0 PID: 1 Comm: swapper/0 Tainted: G S  B   W =
          6.19.0-rc1-ranerica-vanilla #1440 PREEMPT(voluntary)
> [   10.766845] Tainted: [S]=3DCPU_OUT_OF_SPEC, [B]=3DBAD_PAGE, [W]=3DWARN
> [   10.786846] RIP: 0010:__list_del_entry_valid_or_report+0x97/0x110
> [   10.790845] Code: eb e2 48 8d 3d 9a 0a 5a 01 48 89 de 67 48 0f b9 3a 3=
1 c0 eb cf 4c 89 e7 e8 b6 d9 b8 ff 48 8d 3d 8f 0a 5a 01 4c 89 e2 48 89 de <=
67> 48 0f b9 3a 31 c0 eb b1 4c 89 ef e8 98 d9 b8 ff 48 8d 3d 81 0a
> [   10.810845] RSP: 0000:ffff960b000b3c20 EFLAGS: 00010046
> [   10.814845] RAX: 0000000000000011 RBX: ffffd143c1330008 RCX: 000000000=
0000000
> [   10.822845] RDX: dead000000000100 RSI: ffffd143c1330008 RDI: ffffffffa=
11c0cb0
> [   10.830845] RBP: ffff960b000b3c38 R08: 0000000000000000 R09: 000000000=
0000003
> [   10.838845] R10: ffff960b000b3a80 R11: ffffffffa0f470e8 R12: dead00000=
0000100
> [   10.842862] R13: dead000000000122 R14: ffffd143c1338000 R15: 000000000=
0000004
> [   10.850845] FS:  0000000000000000(0000) GS:ffff8af4bc88d000(0000) knlG=
S:0000000000000000
> [   10.858861] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   10.866845] CR2: 0000000000000000 CR3: 0000000428c3a001 CR4: 000000000=
0370ef0
> [   10.870845] Call Trace:
> [   10.874845]  <TASK>
> [   10.878845]  __free_one_page+0x2b5/0x840
> [   10.882845]  free_pcppages_bulk+0x1cd/0x2f0
> [   10.886845]  free_frozen_page_commit.isra.0+0x219/0x460
> [   10.890845]  __free_frozen_pages+0x37b/0x700
> [   10.894845]  ___free_pages+0xa0/0xb0
> [   10.898845]  __free_pages+0x10/0x20
> [   10.902845]  init_cma_reserved_pageblock+0x4f/0x90
> [   10.906845]  kho_init+0x1ef/0x250
> [   10.910845]  ? __pfx_kho_init+0x10/0x10
> [   10.914845]  do_one_initcall+0x6a/0x3c0
> [   10.918845]  kernel_init_freeable+0x1c8/0x3b0
> [   10.922845]  ? __pfx_kernel_init+0x10/0x10
> [   10.926845]  kernel_init+0x1a/0x1c0
> [   10.930857]  ret_from_fork+0x256/0x2e0
> [   10.934845]  ? __pfx_kernel_init+0x10/0x10
> [   10.938845]  ret_from_fork_asm+0x1a/0x30
> [   10.942844]  </TASK>
> [   10.942846] irq event stamp: 926677
> [   10.946845] hardirqs last  enabled at (926677): [<ffffffffa04064d2>] d=
ump_stack_lvl+0xb2/0xe0
> [   10.954845] hardirqs last disabled at (926676): [<ffffffffa0406475>] d=
ump_stack_lvl+0x55/0xe0
> [   10.962845] softirqs last  enabled at (926576): [<ffffffff9f4b6383>] _=
_irq_exit_rcu+0xc3/0x120
> [   10.970850] softirqs last disabled at (926571): [<ffffffff9f4b6383>] _=
_irq_exit_rcu+0xc3/0x120
> [   10.982845] ---[ end trace 0000000000000000 ]---
> [   10.986845]  non-paged memory
> [   10.986845] ------------[ cut here ]------------
>
> [   49.243722] ------------[ cut here ]------------
> [   49.243723] WARNING: arch/x86/kernel/alternative.c:2506 at __text_poke=
+0x42b/0x470, CPU#20: kworker/20:0/104
> [   49.243725] Modules linked in:
> [   49.243726] CPU: 20 UID: 0 PID: 104 Comm: kworker/20:0 Tainted: G S  B=
   W           6.19.0-rc1-ranerica-vanilla #1440 PREEMPT(voluntary)
> [   49.243728] Tainted: [S]=3DCPU_OUT_OF_SPEC, [B]=3DBAD_PAGE, [W]=3DWARN
> [   49.243730] Workqueue: events intel_pstste_sched_itmt_work_fn
> [   49.243732] RIP: 0010:__text_poke+0x42b/0x470
> [   49.243733] Code: 21 d0 49 09 c0 e9 06 ff ff ff 4c 8b 45 98 4c 2b 05 9=
a db 7f 01 49 c1 e0 06 49 21 d0 e9 ef fe ff ff 0f 0b 0f 0b e9 58 fd ff ff <=
0f> 0b e9 6c fc ff ff e8 89 9a ff 00 e9 07 fe ff ff 0f 0b e9 b2 fe
> [   49.243734] RSP: 0000:ffffae7dc054bbe8 EFLAGS: 00010246
> [   49.243736] RAX: fffffa9c10d9d000 RBX: ffffffff8ed40a4d RCX: fffffa9c0=
0000000
> [   49.243736] RDX: 4000000000000000 RSI: ffffffff8ed40a4d RDI: ffffffff8=
ed40a4d
> [   49.243737] RBP: ffffae7dc054bc58 R08: 0000000000000000 R09: 000000000=
0000001
> [   49.243738] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000001
> [   49.243739] R13: ffffffff8ec43830 R14: 0000000000000a4d R15: 000000000=
0000a4e
> [   49.243740] FS:  0000000000000000(0000) GS:ffff9dc10ca8d000(0000) knlG=
S:0000000000000000
> [   49.243741] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   49.243742] CR2: 0000000000000000 CR3: 000000043803a001 CR4: 000000000=
0370ef0
> [   49.243743] Call Trace:
> [   49.243743]  <TASK>
> [   49.243745]  ? partition_sched_domains+0x15d/0x520
> [   49.243748]  smp_text_poke_batch_finish+0xd5/0x3f0
> [   49.243751]  arch_jump_label_transform_apply+0x1c/0x30
> [   49.243753]  __jump_label_update+0xcf/0x110
> [   49.243757]  jump_label_update+0x134/0x200
> [   49.243760]  __static_key_slow_dec_cpuslocked.part.0+0x5b/0x70
> [   49.243763]  static_key_slow_dec_cpuslocked+0x45/0x80
> [   49.243765]  partition_sched_domains+0x3b7/0x520
> [   49.243768]  ? partition_sched_domains+0x7c/0x520
> [   49.243771]  sched_set_itmt_support+0xe2/0x110
> [   49.243773]  intel_pstste_sched_itmt_work_fn+0xe/0x20
> [   49.243775]  process_one_work+0x238/0x6f0
> [   49.243780]  worker_thread+0x1e8/0x3c0
> [   49.243783]  ? __pfx_worker_thread+0x10/0x10
> [   49.243786]  kthread+0x12e/0x260
> [   49.243788]  ? __pfx_kthread+0x10/0x10
> [   49.243791]  ret_from_fork+0x256/0x2e0
> [   49.243793]  ? __pfx_kthread+0x10/0x10
> [   49.243795]  ret_from_fork_asm+0x1a/0x30
> [   49.243801]  </TASK>
> [   49.243802] irq event stamp: 80
> [   49.243802] hardirqs last  enabled at (79): [<ffffffff8fc513f7>] _raw_=
spin_unlock_irq+0x27/0x60
> [   49.243805] hardirqs last disabled at (80): [<ffffffff8fc45581>] __sch=
edule+0xb31/0x1210
> [   49.243808] softirqs last  enabled at (0): [<ffffffff8eca82fd>] copy_p=
rocess+0xadd/0x21d0
> [   49.243810] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   49.243811] ---[ end trace 0000000000000000 ]---
> [   49.244076] ------------[ cut here ]------------
>
>
>
> >
> >       image->kho.fdt =3D virt_to_phys(kho_out.fdt);
> > --
> > 2.52.0.rc1.455.g30608eb744-goog
> >

