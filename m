Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4803FCC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXQdQN28wcdVUkdvxW8UODhEXR6EdJT02IMDcewrXA4=; b=0YB3bCLo9Hou+mvb8sOtVq5fBA
	O/FYs0+bhmvFnJe/llpM48d124/mnFQfhkEbqESG0NjUIv2dGDQlW4i1UuoPEihK5+YsQXLa309hm
	7W/dkLXpk26kZep6PtPIfUScHKJU3bi3AGCc8FMB/35pqYLZddNyskBYgQEyWSgUHREZS3wiDQA7O
	GnT7gOk5qtJYw7utoSHfTUxXq4Js096q6SOgE0virLMU+33B2CRDKka9TA+qZya7DHNeKayw8qFLr
	aFm7nGOKAPC9qN9bKnYQGh4q7k98pWmhKu8Hq7YMhhdtppy+0PnkH5eq6dOWxCzNN29kLrunik0qh
	2tcgydxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNjn-00000000cRz-2qiC;
	Thu, 15 Oct 2026 15:51:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNjk-00000000cR4-2w5m
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:51:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BBD7460120;
	Thu, 15 Oct 2026 15:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0221F000C4;
	Thu, 15 Oct 2026 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792079479;
	bh=QXQdQN28wcdVUkdvxW8UODhEXR6EdJT02IMDcewrXA4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EjJRuOOIY77/5qgZ8wQzs1wtDZu2EQW0/VU/6vRIcHFsr49DA8yF3sf/lgb3NpM5x
	 mvKq7tp89uGgmZ6MF5ZxlyANZcYfCVE3OPrDX7391QzUUpsEQjwuOB9iVa1OZaeI0+
	 t/nrhnK6EUifOenP12pByT5YplZRglPND+Q+mFzK2Ospu/fkws9tmIKkVaypyaOmt6
	 SCfIXm/GLUBre86rGN/EaQOWumaKR49lvONF9Em5NG3iiIRiPGWApj12WX8R1v0ckM
	 SC2sq6FoAbSrKD1N9BEUaPvFDBEalsKu0JooAFiHRPxM88h3DfGH3mHlIlbegxPCaj
	 RcGCia77qfxgQ==
Message-ID: <sashiko-outbox-173105@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/8] sched/topology: Avoid redundant percpu
 allocations and bitmap walks in build_sched_domains()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261015153331.1872641-8-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-8-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:51:17 +0000
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

> During CPU hotplug, build_sched_domains() is invoked on every CPU
> activation and deactivation. Profiling build_sched_domains() on a
> 480-CPU Intel Xeon 6985P-C and a 512-CPU AMD EPYC 9B45 shows several
> sources of avoidable O(N^2) and O(N) work per step:
>=20
> 1. build_sched_groups() and build_overlap_sched_groups() iterate over
>    every bit of sched_domain_span(sd) via for_each_cpu_wrap(i, span, cpu)
>    and check cpumask_test_cpu(i, covered) one CPU at a time, even after
>    entire child groups (e.g., 120-CPU NUMA nodes) have been added to
>    covered. Instead, track the remaining uncovered CPUs
>    (cpumask_copy(uncovered, span)), clear each built group's span with
>    cpumask_andnot(), and advance directly to the next uncovered CPU.
>=20
> 2. __visit_domain_allocation_hell() and __free_domain_allocs() allocate
>    and free 3 * nr_levels + 2 temporary per-CPU pointer arrays via
> [ ... ]
>   Total:     4.30 s ->  3.46 s (-19.5%)
>   build_sched_domains() (cpu511 offline / online):
>     6.55 ms -> 3.04 ms (-53.7%) / 5.28 ms -> 3.20 ms (-39.4%)
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015153331.1872=
641-1-pasha.tatashin@soleen.com?part=3D7


