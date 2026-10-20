Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3872606A31D
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZJrl2DEq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcvXoDzo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jGOjQkp5UPWqrBjqLOWLwe3QJCJgQPlac2zzWkh+ag8=; b=ZJrl2DEqTSqBgA43I5lLOlad7O
	Ml7UIDaigp7+jPMK/MUH/tkfUCb5JdnxU9IMgzw/TgANzvLDAqe+tSrRto390qOOiMImX0qQ8QdHX
	/hJ9I7PCfF0e88aQM6PnpUeojkWenVIx6OVxGLWupFIGr/IUltX+fXAPx3TtmHjhst+smDeAcbyM8
	cp5cKYF6PirHrlk0lV71fYrMagZDUaSof3YAJpGeYVkTtTTJN3PrRDJX9bpZDelfg8dT5+lp7LP+x
	I/BCz72uEWSClVxpFV3TQb5Yk78/SqyUe0LnH2NfA1Q/GU6AUKmY5xqdrV0m/BuB2u2lBId3s/MRn
	8fZ4NlpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySR-00000008bQ3-0quG;
	Tue, 20 Oct 2026 01:16:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySQ-00000008bOm-2FkX
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 01:16:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F12EB40C13;
	Tue, 20 Oct 2026 01:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359971F000C4;
	Tue, 20 Oct 2026 01:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792458961;
	bh=jGOjQkp5UPWqrBjqLOWLwe3QJCJgQPlac2zzWkh+ag8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gcvXoDzoCkU0QueRlnrG4nX3LPL+JQIya2CuFYz8cbHyPIKeKaTJULAFdNfLG2a1A
	 ac5jC67cN7Qv+k8uqHjTv/W5f7jh3KsQ/zUbOfl0TDCyv9wuWEhLO/KYk0ms7Nj2pg
	 mGGVjFA/CKUdZtoyZZ/AXwczfQaoKM8Nev3M5ZUnknjA0kI2IXkmDZjWTGu1F2mYDJ
	 9kQv/mVpHnwGNiDBcXLpynyY6GdAQfXICLOjY7y1nh1hnS9tsxoJQZ8wFaCl4XJZNI
	 yQTZJ+NDwNGUPIo18J7r64DRSrHyOwDhsvubT1oc7jA9bZ5JNqMm8OZWCD77ECDsrz
	 euMO1u/KFD4mg==
Message-ID: <sashiko-outbox-178408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] sched/topology: Avoid redundant percpu
 allocations and bitmap walks in build_sched_domains()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, jpoimboe@kernel.org, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, blum@kernel.org, longman@redhat.com, bsegall@google.com
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261019011446.834487-8-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
 <20261019011446.834487-8-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:15:58 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched/topology: sched_update_llc_bytes() reuses llc_bytes outsid=
e cpus
--

commit d95533f0e2e71e5e08ee625a1ea2afb7ecbe1b86
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

sched/topology: Avoid redundant percpu allocations and bitmap walks in buil=
d_sched_domains()

This commit optimizes build_sched_domains() during CPU hotplug by tracking
uncovered CPUs during sched_group construction, reusing temporary per-CPU
pointer arrays across rebuilds, initializing sd->span_weight in sd_init(),
and reusing the first LLC sibling's computed llc_bytes in alloc_sd_llc()
and sched_update_llc_bytes().

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b5dec7f486b5c..33210fd9dc2c6 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -917,9 +917,15 @@ static bool alloc_sd_llc(const struct cpumask *cpu_m=
ap,
>  			top_llc =3D parent;
> =20
>  		if (top_llc->flags & SD_SHARE_LLC) {
> +			int first =3D cpumask_first(sched_domain_span(top_llc));
> +
>  			sd->llc_max =3D max_lid + 1;
>  			sd->llc_counts =3D p;
> -			sd->llc_bytes =3D get_effective_llc_bytes(i, top_llc);
> +			/* All CPUs in top_llc share the same LLC size and weight. */
> +			if (first < i)
> +				sd->llc_bytes =3D (*per_cpu_ptr(d->sd, first))->llc_bytes;
> +			else
> +				sd->llc_bytes =3D get_effective_llc_bytes(i, top_llc);
>  		} else {
>  			/* avoid memory leak */
>  			kfree(p);
> @@ -1018,12 +1024,20 @@ void sched_update_llc_bytes(const struct cpumask =
*cpus)
>  	 * own LLC domain to scale its share of the physical cache.
>  	 */
>  	for_each_cpu(i, cpus) {
> +		int first;
> +
>  		sdp =3D rcu_dereference_sched_domain(per_cpu(sd_llc, i));
>  		if (!sdp)
>  			continue;
> =20
>  		sd =3D rcu_dereference_sched_domain(cpu_rq(i)->sd);
> -		if (sd)
> +		if (!sd)
> +			continue;
> +
> +		first =3D cpumask_first(sched_domain_span(sdp));
> +		if (first < i)
> +			sd->llc_bytes =3D rcu_dereference_sched_domain(cpu_rq(first)->sd)->ll=
c_bytes;
> +		else
>  			sd->llc_bytes =3D get_effective_llc_bytes(i, sdp);
>  	}

[Severity: Medium]
Can sched_update_llc_bytes() and alloc_sd_llc() copy an un-updated or
mismatched llc_bytes value when the topmost SD_SHARE_LLC domain spans
multiple cacheinfo LLC leaves?

When cacheinfo_cpu_online() or cacheinfo_cpu_pre_down() calls
sched_update_llc_bytes(cpus), cpus is a single cacheinfo leaf's
&llc->shared_cpu_map, whereas sdp (and top_llc in alloc_sd_llc()) is the
highest sched_domain with SD_SHARE_LLC, whose span comes from
cpu_coregroup_mask().

On topologies where cpu_coregroup_mask() is wider than the cacheinfo LLC
leaf's shared_cpu_map, sched_domain_span(sdp) spans multiple physical
cacheinfo LLCs:

1. On ARM64/RISC-V systems with clusters and per-core L2 caches (no shared
   L3), cpu_coregroup_mask() in drivers/base/arch_topology.c extends the MC
   domain to cluster_sibling:

   if (IS_ENABLED(CONFIG_SCHED_CLUSTER) &&
       cpumask_subset(core_mask, &cpu_topology[cpu].cluster_sibling))
           core_mask =3D &cpu_topology[cpu].cluster_sibling;

2. On AMD/Hygon x86 systems without an L3 cache, legacy_set_llc() in
   arch/x86/kernel/cpu/topology_amd.c sets llc_id to the die ID while
   get_cpu_cacheinfo_llc() returns the per-core L2 cache leaf:

   /* If none of the parsers set LLC ID then use the die ID for it. */
   if (tscan->c->topo.llc_id =3D=3D BAD_APICID)
           tscan->c->topo.llc_id =3D apicid >> tscan->dom_shifts[TOPO_CORE_=
DOMAIN];

When sched_update_llc_bytes(cpus) is invoked for any core other than the
first core in sdp, first =3D cpumask_first(sched_domain_span(sdp)) is not in
cpus, so cpu_rq(first)->sd->llc_bytes is not updated by the
for_each_cpu(i, cpus) loop. Because first < i holds for every CPU i in cpus,
get_effective_llc_bytes() is skipped and sd->llc_bytes copies the un-updated
value from cpu_rq(first)->sd.

Similarly, in alloc_sd_llc(), copying (*per_cpu_ptr(d->sd, first))->llc_byt=
es
across all CPUs in top_llc reuses the first CPU's L2 cache calculation even
when other cores in top_llc have different cacheinfo shared_cpu_map weights
(for example, partially online SMT siblings) or cache sizes, which can cause
exceed_llc_capacity() in kernel/sched/fair.c to use the wrong capacity.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019011446.8344=
87-1-pasha.tatashin@soleen.com?part=3D7

