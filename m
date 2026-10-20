Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DE606A319
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MxtG5pS2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onJfwJKb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b0zbPbIVrw8g+L4HtojTXOfkJRf2Y4cPRt8OPTYZy2o=; b=MxtG5pS2NhXVz6xxFtYXMrnLnr
	A6D05oTjuXjIOAygCl4pVQYZHppCPHoRCSxcMmcnpvWmpd0Pfp9EPASl807jyXh/6orrEehkV1RPh
	/puu7T7SVw+h8gtVe8VDtzM/MJ4zNA6HIVom7MxRdWxVmeoYCgh0TWZMHUvdngUNjSTXRBx/p+KeJ
	cf20j17PfZ9CandxnpTGbtxjYOX1CmmELQyKgpogyhKX+r2rAvJuAcDs7lxvNl4+WjxAphD2sx4qM
	7dFqg4GHXvn8xERBB2Akb/tYZ+rLi0rXE1YXX0XUF7ZmvVwN9THItjDicvpY0aYSreso7PdwlHlgS
	3F1VWImA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySG-00000008bJ9-3PH1;
	Tue, 20 Oct 2026 01:15:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySF-00000008bIU-1Szb
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 01:15:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C742600AA;
	Tue, 20 Oct 2026 01:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F751F000C4;
	Tue, 20 Oct 2026 01:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792458950;
	bh=b0zbPbIVrw8g+L4HtojTXOfkJRf2Y4cPRt8OPTYZy2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onJfwJKbHbGdhCCzWjPhUi41SXBY/P3WASN9/ZXkShX3yQcO0ThFM5am6VhHMAKIb
	 ZDoHRkORVfUVoSls68OkttynCoYL3/HqPYDCv4IhQ+dUrgZdCyUYK9vPBZEcccR9jX
	 nwWe4q3ewkgXkAZrtaodf+bIwo1d4LBQ+ZnuJs0rerMC90Yj3wuZYim+Y93mJfP4rp
	 HfQLxLagcrSwRcnn4J79wIW8LdT6Ef3XbNsB//iFuUExuYCTVt8cAgFS1X7SSJp6cM
	 eh22Dv5lIYItT6CyIwvBcR5YoE7jBQru+evLNn+apE3NuNqsLjBrd153OlU8iBRZCe
	 4Z6/GTqUGf07g==
Message-ID: <sashiko-outbox-178404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] x86/mce/intel: Bound cmci_rediscover() to a
 single topology peer
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, jpoimboe@kernel.org, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, blum@kernel.org, longman@redhat.com, bsegall@google.com
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261019011446.834487-4-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
 <20261019011446.834487-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:15:47 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] x86/mce/intel: missing LLC topology level in cmci_clear() peer sel=
ection
- [Medium] x86/mce/intel: cmci_rediscover() leaves shared banks unclaimed o=
n hybrid CPUs
--

commit cb9d97fffee1a97a8d921b6c7ed854215ee3231b
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

x86/mce/intel: Bound cmci_rediscover() to a single topology peer

This commit optimizes CPU offline CMCI bank rediscovery by recording
orphaned banks in cmci_clear(), selecting a single online topology peer,
and probing only that target peer via smp_call_function_single() in
cmci_rediscover() instead of broadcasting to all online CPUs with
on_each_cpu().

> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/in=
tel.c
> index 4655223ba5606..f57718b097d9b 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
[ ... ]
> @@ -346,8 +353,31 @@ void cmci_clear(void)
>  	if (!cmci_supported(&banks))
>  		return;
>  	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
> +	bitmap_zero(cmci_orphaned_banks, MAX_NR_BANKS);
> +	/*
> +	 * A bank is shared by the CPUs of one SMT core, L2 cluster, die or
> +	 * package, and these scopes nest. The first online peer found from
> +	 * the innermost scope outwards is therefore part of every sharing
> +	 * scope that still has an online CPU, so it alone can claim every
> +	 * orphaned bank that is still claimable. If it already owns an index,
> +	 * the instance released here is not shared with it, hence not with
> +	 * any online CPU, and that index can be dropped from the rediscovery.
> +	 */
> +	target =3D cpumask_any_but(topology_sibling_cpumask(cpu), cpu);
> +	if (target >=3D nr_cpu_ids)
> +		target =3D cpumask_any_but(topology_cluster_cpumask(cpu), cpu);
> +	if (target >=3D nr_cpu_ids)
> +		target =3D cpumask_any_but(topology_die_cpumask(cpu), cpu);
> +	if (target >=3D nr_cpu_ids)
> +		target =3D cpumask_any_but(topology_core_cpumask(cpu), cpu);
> +	cmci_orphaned_target =3D target;
>  	for (i =3D 0; i < banks; i++)
>  		__cmci_disable_bank(i);
> +	if (target < nr_cpu_ids)
> +		bitmap_andnot(cmci_orphaned_banks, cmci_orphaned_banks,
> +			      per_cpu(mce_banks_owned, target), MAX_NR_BANKS);

[Severity: High]
Should the outward peer search in cmci_clear() also check
cpu_coregroup_mask(cpu) (or cpu_llc_shared_mask(cpu)) between
topology_cluster_cpumask(cpu) and topology_die_cpumask(cpu)?

In arch/x86/kernel/smpboot.c:set_cpu_sibling_map(), x86 populates
cpu_llc_shared_mask as a distinct topology level between
cpu_l2c_shared_mask (topology_cluster_cpumask) and topology_die_cpumask:

    if ((i =3D=3D cpu) || (has_smt && match_smt(c, o)))
        link_mask(topology_sibling_cpumask, cpu, i);

    if ((i =3D=3D cpu) || (has_mp && match_llc(c, o)))
        link_mask(cpu_llc_shared_mask, cpu, i);

    if ((i =3D=3D cpu) || (has_mp && match_l2c(c, o)))
        link_mask(cpu_l2c_shared_mask, cpu, i);

    if ((i =3D=3D cpu) || (has_mp && match_die(c, o)))
        link_mask(topology_die_cpumask, cpu, i);

On processors where cpu_coregroup_mask(cpu) is narrower than
topology_die_cpumask(cpu) (for example, processors that enumerate tiles via
CPUID leaf 0x1f tile domain or leaf 0x4 L3 cache sharing rather than die
domain, such as Meteor Lake and Arrow Lake where compute tile cores and SoC
tile LP E-cores have distinct llc_id values while sharing die_id, or Xeon
systems in SNC mode), offlining the last online CPU of an L2 cluster while
other CPUs in the same LLC/tile remain online will skip directly to
topology_die_cpumask(cpu).

If cpumask_any_but(topology_die_cpumask(cpu), cpu) picks a target on a
different LLC/tile, could an MCA bank scoped to the offlined CPU's LLC/tile
either be masked out of cmci_orphaned_banks by bitmap_andnot() (because the
remote-tile target owns its own tile's instance of that bank index) or fail
to be claimed by the remote target in cmci_rediscover(), leaving the bank
with CMCI disabled and unpolled while online peers in cpu_coregroup_mask(cp=
u)
are never probed?

> +	else
> +		bitmap_zero(cmci_orphaned_banks, MAX_NR_BANKS);
>  	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
>  }
> =20
> @@ -360,15 +390,38 @@ static void cmci_rediscover_work_func(void *arg)
>  		cmci_discover(banks);
>  }
> =20
> -/* After a CPU went down cycle through all the others and rediscover */
> +/*
> + * After a CPU went down, rediscover orphaned shared banks on a single
> + * topology peer (SMT sibling, L2 cluster peer, die peer, or package pee=
r)
> + * selected in cmci_clear(). Core-private banks whose core is now comple=
tely
> + * offline cannot be claimed by any other core, so probing more than one
> + * peer is redundant.
> + */
>  void cmci_rediscover(void)
>  {
> +	unsigned int target;
> +	unsigned long flags;
> +	bool orphaned;
>  	int banks;
> =20
>  	if (!cmci_supported(&banks))
>  		return;
> =20
> -	on_each_cpu(cmci_rediscover_work_func, NULL, 1);
> +	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
> +	orphaned =3D !bitmap_empty(cmci_orphaned_banks, MAX_NR_BANKS);
> +	target =3D cmci_orphaned_target;
> +	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
> +
> +	if (!orphaned)
> +		return;
> +
> +	if (target < nr_cpu_ids && cpu_online(target))
> +		smp_call_function_single(target, cmci_rediscover_work_func,
> +					 NULL, 1);
> +
> +	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
> +	bitmap_zero(cmci_orphaned_banks, MAX_NR_BANKS);
> +	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
>  }

[Severity: Medium]
Can probing only a single target CPU in cmci_rediscover() leave shared MCA
banks unclaimed on hybrid processors where CPUs on the same die or package
have different MCA bank counts or per-bank CMCI capabilities?

In cmci_rediscover_work_func(), cmci_supported(&banks) re-reads
MSR_IA32_MCG_CAP on the target CPU because CPUs do not necessarily all have
the same bank count:

    /* Recheck banks in case CPUs don't all have the same */
    if (cmci_supported(&banks))
        cmci_discover(banks);

On hybrid systems (such as Alder Lake, Raptor Lake, Meteor Lake, or Arrow
Lake), P-cores and E-cores share topology_die_cpumask(cpu) and
topology_core_cpumask(cpu) while exposing different bank counts or bank
layouts. When the last thread of a P-core goes offline through
mce_cpu_pre_down() -> mce_disable_cpu() -> cmci_clear() and
mce_cpu_dead() -> cmci_rediscover(), cpumask_any_but() on the die or package
mask can select an E-core with a smaller bank count as cmci_orphaned_target
even when another P-core is still online.

When that happens, cmci_discover(banks) on target only iterates up to targe=
t's
bank count, and cmci_rediscover() then unconditionally clears
cmci_orphaned_banks with bitmap_zero() without falling back to other online
CPUs if unclaimed bits remain. Since other CPUs sharing those higher-number=
ed
banks already cleared them from their per-CPU mce_poll_banks bitmaps in
cmci_skip_bank() during initial discovery, wouldn't those shared banks rema=
in
both unowned for CMCI and unpolled?

=D1=82=D0=B8=D1=82=D1=8C=D1=81=D1=8F

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019011446.8344=
87-1-pasha.tatashin@soleen.com?part=3D3

