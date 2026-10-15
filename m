Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECD2CC6B3A
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p/L6vStTTkLKkbTFW53DI+bTesyu/E9Cvyn6tkFsfkM=; b=Kb9h9jOb1xlHyAvzoYJzDl1qXI
	0Dsiv3CP+bqzftWrjZMgCmnNcPUe8frDy39W5lYw0wiyPUXzVaCZBptXln0DlS4bVhWeWuTu3gI+B
	WIVvln/fLgQLCRoVfaHZFndVFeN8NNEfqCNYFq0N0myTG5PE9tegbtSzBlbiB9aNNXa2wqzLoK9Z0
	WnLkRRA6Q27+3gKjCqACJhNQE+aIJVg+yklu87gFKKV9Q6W+Z0Fi8c/6g6EWf5K6xUaGSEvGSnhTt
	tnXmRzi2GecveTECAqGIQAcsRFv21Q8RX5VUFB7I/D98ND41dPkYnj4K0fJHDWfUPqI//vwoFhot8
	Uyds3myQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHOI6-00000000pmZ-2A8m;
	Thu, 15 Oct 2026 16:26:50 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHOI2-00000000pl3-2P66
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 16:26:49 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so6286285a12.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 09:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792081605; cv=none;
        d=google.com; s=arc-20260327;
        b=PVZm+KAle2IgrrVT0ztDBnxY7gCbudn8UJNsbyC01gcKNVkBcZW+wIvNCxIOKE8J5V
         R0lcgP9iQBBY7T9+rzWGih4egCvApi3aR/RmWm1bN7pBWJvBrTckYLF/fo3kIbmwnhXY
         hVg+2yp0gfi4m1Lg8EwMl4xxPh24FkAA0oJnkPQY8YAFjGwP5mDrv33s0ddXqJgxDu60
         B/LSpFIxI/KflGicSco9gxBbUsYuaamHCa4ifLwvQqbuEtOb/w/vjI43fK6ufZWCBphq
         qPVyLLtcQxBn3eIhb/dDaSkAJIJ7sePfq3QZRHioczgCHg+8ngu0FyvdJ2sMKbyQzkmM
         ++Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p/L6vStTTkLKkbTFW53DI+bTesyu/E9Cvyn6tkFsfkM=;
        fh=9tdezYOwrz74e52O6nm3kIGbo6kDFJdA2pqu4EZ1+Pw=;
        b=H9C5axOk/lyFzPZjp2T6RSxc2N/hJIVOLBG94bVDrGjafaoNjiuTMnyrTsJqgfhtkZ
         Yds3Wn8NzcAXnvc+7AA5hV87AP96FLsUz3pKiSWEPSiPs8oFkk5pib6DuWax4ODF4mL0
         y/EEqqd1M4ork0aAU5DsMdd/WQUIduolGWr1ZFPivRfDuOteNMXUEfgWoK5ydcFT4hZj
         HsIMgY5nBUhyzVxawkmUvxcWulq+xtxQTQb95Fx1hG9i3cDeTV41/VVBEGGJqVstkAXP
         Wz5g3soB9aChkPcZitC/UmxGw++xIwsJSVLvjPCwxHOGIPXlin58heErgcQd3TW+2neI
         t5nw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792081605; x=1792686405; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p/L6vStTTkLKkbTFW53DI+bTesyu/E9Cvyn6tkFsfkM=;
        b=eNTkiEaVFJItGXd2IJRTnC4a+ERwnbEzJUEk4rQyTVj/lZ2wg+gek5OHvPl/ERGcuV
         NnhCzhddO2v+HATJP0ogKYRYY7Aq+wnhRjp5nyDzXdMTwrrnvR/OP34VMjiQHT8DJXeR
         gFzqxlfadSWdHzza6TzsY2k/IjrvnYaGoq7x5733Hve7sRSqixjzBviHdG8p0iScXrVH
         S/rDfiGIxN3SUBbPMvNtEzSO3rsSmu2KOxKfNG0Vqa9Wkj+tmcVdSok89XYfU+sLpnZX
         KJheEdwrUh8o0Zs2QPk2Mkwru3whMuzr2u8M7s79pvKgkHLS5JNjExOzmzLzhdiJB7dJ
         8KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792081605; x=1792686405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p/L6vStTTkLKkbTFW53DI+bTesyu/E9Cvyn6tkFsfkM=;
        b=MAAD+O4V7jsLwfgnUl9jTnFpjfnf7Tu/qo1XDCCcF1JR3BHvFYq7PU0Cn0NbRd+QtN
         yKxSoahJTZKt326tO+aXmGWNBFLD5479owhhw3qUmA4aWu4YSzbgbNnZ8NFzNlAW8ZbH
         F8EVlwv+H0wMAYsdDLOMcekxGMKBEnM4TwJVZ7RfrQx6zzArvq1GlY29YiwZq5Y7yBv9
         GMzK4QU1/4tRB3ydA5GaVO/a4eVqfffOA409u5NP/CkIS0qZ78KqS1YQZcW9R1A+m/HK
         wSXtV5BhNVVTgmdr0yMk2LcsJBDgA2hNqmGp5Wix5jyeCZz37GbtbrvGgw41G9hvuefx
         FSYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNXEA8lMyMQ3XOkj45r5by9mIE6uZrj7djlDx1JLbRKWs93t1BwBu5+mIfSfECnUZVPl0i7A==@lists.infradead.org
X-Gm-Message-State: AFq9FYL1AoIJ4xzhpzE6+vG9mlogiN+bCqZUPX1TsC2/YnBIsdFHIWpR
	Fasl1fs6C2Ri3h8hbgMv7ixMsP0JUjIFTB35RSzsiQcENTjII/WYU4EnVgDJlKI2Z7FjJ/G9YQp
	vPo1rY9GewE/YUuJJ1O+LnJn3UoJW378YvWyJsg92gg==
X-Gm-Gg: AYBFou3/rkK06Arp5L7hao+ex0U4GQ0+FZLHSdIX4RCgxCSt8/g6cZx4ihj4s1Ed+FU
	8HkkqQ1gZp963Tj2Lwu4I6JZE9TdAo8X344D3Cll6Hyef9nXnjrkx0rsYhoXRhBoRe2VEiwCebB
	/Z9wZ7fAAe1si0AR0Bizi1n9b+9yYVcK9ybcAYk/zOpLU2YHccg1/YcBIY8SNg9LfSgO/hDJHBI
	D/1ZBeVofeTQI7K6wzbxbkl8Y0rohEkpVEbp34jCn7TuGGpdeVWdGpTTaqqWt76JP/mFog5RxVl
	x1Qsx6LScPOBxxhyoBbdoCWQNrM6/KlLmz3wahwJI6RxBj9i34SgcurYVeYDv7OPskYnbyXzaNA
	Ft/megy3dHQ==
X-Received: by 2002:a05:6402:46d2:b0:6b1:c265:a5ad with SMTP id
 4fb4d7f45d1cf-6b1e0afc7a4mr7410229a12.32.1792081604585; Thu, 15 Oct 2026
 09:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-3-pasha.tatashin@soleen.com> <sashiko-outbox-173092@kernel.org>
In-Reply-To: <sashiko-outbox-173092@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 15 Oct 2026 12:26:07 -0400
X-Gm-Features: AclHuK_yCJGAu6GoKfWJckPHB9PC9igV5tqeg2m4wPW2Hc_SYuuZdKBt7njfNgY
Message-ID: <CA+CK2bCCWkP+P6iv9BpJeMB_V0PppeaNcg6TeNzZtu_TtLJLxw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] x86/smp: Remove unnecessary WBINVD from mwait_play_dead()
To: sashiko-reviews@lists.linux.dev
Cc: kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, 
	nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, 
	kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, 
	thorsten.blum@linux.dev, tony.luck@intel.com, david@kernel.org, 
	mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, 
	ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, 
	mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org, 
	peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, 
	dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, 
	gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, 
	liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com, 
	bsegall@google.com, hannes@cmpxchg.org, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_092646_749655_9484653E 
X-CRM114-Status: GOOD (  28.61  )
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

On Thu, Oct 15, 2026 at 11:44=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] x86/smp: memory corruption during suspend if package offline=
d at runtime
> - [High] x86/smp: offline CPUs miss wbinvd_on_all_cpus() flush causing da=
ta corruption
> --
>
> commit 2579aa1d01a44c8d96bb166fd2ce0dff4493a42a
> Author: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> x86/smp: Remove unnecessary WBINVD from mwait_play_dead()
>
> The commit aims to avoid time-consuming WBINVDs during runtime CPU offlin=
ing
> by only executing it when cpuhp_tasks_frozen is set (i.e. system sleep).
>
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index ba01a9e919b78..60a781dac9991 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> [ ... ]
> > @@ -1426,15 +1422,21 @@ void __noreturn mwait_play_dead(unsigned int ea=
x_hint)
> >       md->status =3D CPUDEAD_MWAIT_WAIT;
> >       md->control =3D CPUDEAD_MWAIT_WAIT;
> >
> > -     wbinvd();
> > +     /*
> > +      * MWAIT C-states keep the caches coherent, so runtime CPU offlin=
e
> > +      * does not need to flush them. System sleep, however, may remove
> > +      * power from this package's caches while all of its CPUs are
> > +      * offline, and the flush done by the boot CPU before entering th=
e
> > +      * sleep state only covers the boot CPU's own package.
> > +      */
> > +     if (cpuhp_tasks_frozen)
> > +             wbinvd();
>
> [Severity: Critical]
> Could this result in memory corruption during a system suspend if an enti=
re
> package is offlined at runtime prior to the suspend?
>
> If a package is fully offlined at runtime (so cpuhp_tasks_frozen is false=
),
> its CPUs enter MWAIT with dirty caches. If the system later suspends,
> freeze_secondary_cpus() skips CPUs that are already offline:
>
> kernel/cpu.c:freeze_secondary_cpus() {
>         ...
>         for (cpu =3D nr_cpu_ids - 1; cpu >=3D 0; cpu--) {
>                 if (!cpu_online(cpu) || cpu =3D=3D primary)
>                         continue;
>         ...
> }
>
> Because these CPUs are skipped, they never awaken to check cpuhp_tasks_fr=
ozen
> and perform the flush. Since the sleep-entry cache flush on the boot CPU
> only covers its own package, won't the dirty cache lines of the un-flushe=
d,
> offlined package be permanently lost when power is removed?

I am not sure if this is actually feasible; nevertheless, I can add
wbinvd() when the the last CPU in the package (CPU that shares the
last level cache), enters mwait_play_dead(). That said, also my LLM
tells me that even:

> > +     if (cpuhp_tasks_frozen)
> > +             wbinvd();

that I have is not needed because:

1. Multi-socket x86 servers (where a non-boot package exists) do not
support ACPI S3 suspend-to-RAM.
2. When all cores of a package enter deep MWAIT (C6), hardware flushes
L1/L2 to the LLC on core C6 entry, and the package's power management
unit (PCU) flushes the LLC before removing LLC power in deep package
C-states (PC6+).

>
> [Severity: High]
> Does skipping the flush during runtime offline break the system-wide cach=
e
> flush guarantees of wbinvd_on_all_cpus()?
>
> If a package is completely offlined at runtime and retains dirty cache li=
nes
> in its LLC, wbinvd_on_all_cpus() will miss them entirely because it only
> targets online CPUs:
>
> arch/x86/lib/cache-smp.c:wbinvd_on_all_cpus() {
>         on_each_cpu(__wbinvd, NULL, 1);
> }
>
> If a system-wide non-coherent operation is later triggered (such as mappi=
ng
> memory as Uncacheable or persisting PMEM), the missing flush could lead t=
o
> data corruption or Machine Check Exceptions from dirty line evictions.
>
> Furthermore, during Kexec, offline CPUs are kicked out of MWAIT:
>
> arch/x86/kernel/smpboot.c:smp_kick_mwait_play_dead() {
>         ...
>         for_each_cpu_andnot(cpu, cpu_present_mask, cpu_online_mask) {
>                 ...
>                 WRITE_ONCE(md->control, newstate);
>         ...
> }
>
> Will this cause the offlined CPUs to carry unflushed dirty cache lines in=
to
> the new kernel's execution context?

Regarding carrying cachelines through kexec that Sashiko mentioned, my
LLM also says it does not make sense (and I agree with it):

1. Even before our patch, when smp_kick_mwait_play_dead() wakes an
offline CPU out of __mwait(), that CPU immediately writes to memory
(WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT)=E2=80=94dirtying its cache=
!)
and enters while (1) native_halt(); (smpboot.c:1461-1463) without
executing wbinvd().
2. Even more obviously, all CPUs that are online when kexec runs are
stopped via native_stop_other_cpus() =E2=86=92 stop_this_cpu(), which simpl=
y
executes native_halt() in a loop without wbinvd().

Pasha

>
> >
> >       while (1) {
> >               /*
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015153331.18=
72641-1-pasha.tatashin@soleen.com?part=3D2

