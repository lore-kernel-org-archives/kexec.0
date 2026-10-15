Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BF4CC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w01mLA7JjdUDkI3DZi1bzvEaaLFvWzKGQ/qjo/oxa50=; b=fv4op3qUDewyUYL9xAmA9TFXFA
	D1P4li/eMWOl++Wrj31tGv++nMG1B1SIO8G443fdzhZa5ha+cYIYs+0Ynp5qF+jBEHUovixFvQTmp
	QKmKIYGiw3Wn8K3fJ7gYnXjz9Rd8UVuot3+KQCKLo5t+0NMJEW08Asjg77wi3dd7MiaX53AJBVSh/
	t9cohGF8h3bcfopPDwzbwFCEz1K6gM+j/XVAIj/g2J2cqewJTY2Q2lC5oJsBHg7KrxOd0cNmBwP/9
	iwVqbgNkMwl+fE6NCTVX6oGfLnVCBXo0J/StoTQd4l5ZM9UczaTzMFB+9m6BN/N33rBI4lcJ1r4fs
	r/Nsb5KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNdQ-00000000bSP-2WWi;
	Thu, 15 Oct 2026 15:44:48 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNdP-00000000bS5-11Sz
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:44:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AD4F760120;
	Thu, 15 Oct 2026 15:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD541F000C4;
	Thu, 15 Oct 2026 15:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792079086;
	bh=w01mLA7JjdUDkI3DZi1bzvEaaLFvWzKGQ/qjo/oxa50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ioAsZb8DI+pHPiNPlCKiDEsU/E/orSbwx2CnWSu2JABu7dMRMFn4l+4t1ugKOiSKL
	 qcJRRU//IDbkW3U6iND+su5Ossc4mSbB6upuUUmU55X52gTw4G6a5lQ4jVXzPYh/sb
	 co3jE+zjEPAsIEj+wuvod5MKVoCDY91FryhNR7ivzmj5lhEApLt+xiQrAgCR90ZZdF
	 XF3uV2HoTTBz1H1qaDBoacgra7W0WRtqnwWTSJjF3M8QxpYe5pSKLU1+Bk8JRqozlF
	 b2WKqeYhNCK+g3vyQrpNwCo5G6I7kIDhxl1PmemckJ3+EUtUcxLQ1wy0GiT78zBXti
	 zJouVEQrVjSNg==
Message-ID: <sashiko-outbox-173092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/8] x86/smp: Remove unnecessary WBINVD from
 mwait_play_dead()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
Cc: hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261015153331.1872641-3-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:44:44 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] x86/smp: memory corruption during suspend if package offlined =
at runtime
- [High] x86/smp: offline CPUs miss wbinvd_on_all_cpus() flush causing data=
 corruption
--

commit 2579aa1d01a44c8d96bb166fd2ce0dff4493a42a
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

x86/smp: Remove unnecessary WBINVD from mwait_play_dead()

The commit aims to avoid time-consuming WBINVDs during runtime CPU offlining
by only executing it when cpuhp_tasks_frozen is set (i.e. system sleep).

> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ba01a9e919b78..60a781dac9991 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
[ ... ]
> @@ -1426,15 +1422,21 @@ void __noreturn mwait_play_dead(unsigned int eax_=
hint)
>  	md->status =3D CPUDEAD_MWAIT_WAIT;
>  	md->control =3D CPUDEAD_MWAIT_WAIT;
> =20
> -	wbinvd();
> +	/*
> +	 * MWAIT C-states keep the caches coherent, so runtime CPU offline
> +	 * does not need to flush them. System sleep, however, may remove
> +	 * power from this package's caches while all of its CPUs are
> +	 * offline, and the flush done by the boot CPU before entering the
> +	 * sleep state only covers the boot CPU's own package.
> +	 */
> +	if (cpuhp_tasks_frozen)
> +		wbinvd();

[Severity: Critical]
Could this result in memory corruption during a system suspend if an entire
package is offlined at runtime prior to the suspend?

If a package is fully offlined at runtime (so cpuhp_tasks_frozen is false),
its CPUs enter MWAIT with dirty caches. If the system later suspends,
freeze_secondary_cpus() skips CPUs that are already offline:

kernel/cpu.c:freeze_secondary_cpus() {
	...
	for (cpu =3D nr_cpu_ids - 1; cpu >=3D 0; cpu--) {
		if (!cpu_online(cpu) || cpu =3D=3D primary)
			continue;
	...
}

Because these CPUs are skipped, they never awaken to check cpuhp_tasks_froz=
en
and perform the flush. Since the sleep-entry cache flush on the boot CPU
only covers its own package, won't the dirty cache lines of the un-flushed,
offlined package be permanently lost when power is removed?

[Severity: High]
Does skipping the flush during runtime offline break the system-wide cache
flush guarantees of wbinvd_on_all_cpus()?

If a package is completely offlined at runtime and retains dirty cache lines
in its LLC, wbinvd_on_all_cpus() will miss them entirely because it only
targets online CPUs:

arch/x86/lib/cache-smp.c:wbinvd_on_all_cpus() {
	on_each_cpu(__wbinvd, NULL, 1);
}

If a system-wide non-coherent operation is later triggered (such as mapping
memory as Uncacheable or persisting PMEM), the missing flush could lead to
data corruption or Machine Check Exceptions from dirty line evictions.

Furthermore, during Kexec, offline CPUs are kicked out of MWAIT:

arch/x86/kernel/smpboot.c:smp_kick_mwait_play_dead() {
	...
	for_each_cpu_andnot(cpu, cpu_present_mask, cpu_online_mask) {
		...
		WRITE_ONCE(md->control, newstate);
	...
}

Will this cause the offlined CPUs to carry unflushed dirty cache lines into
the new kernel's execution context?

> =20
>  	while (1) {
>  		/*
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015153331.1872=
641-1-pasha.tatashin@soleen.com?part=3D2

