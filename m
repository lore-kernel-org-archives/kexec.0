Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A63CC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ROXgy3qAmfj5WIiFzt+80uO1jlLnVD/zWgR0Zz0bT8=; b=PzlCkVKMuKMnnrR85uRKg7Slhk
	WB2YpuTk98bFMGCn4EbI2KaJMbtWBN/voA16JM7oGJAGbqvvs/5lHy7+Imt9uyUBtg25aYQUAmQaz
	sFmqKR3eZyGt0Pg21c7wYV2LGUmIJujMn56y5tPF69Bx6ak7GnOIvgP35V1+p1SIdU2bTfVaZDIA1
	24kh8/3OnC6Gp2h/y3uKRf809V7D402cBiOzfij1efQiWo60FL3B2vjtVxMyfmHv+ccLhIlES8D8q
	RKpflIcgBhtUwel1tU8s1GA6qhGow/4aELUlbWDYHyEaveI+gTILoOvIAR2nEwqe9O7hju3CKARLa
	LPkreNAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNcQ-00000000bII-1jU0;
	Thu, 15 Oct 2026 15:43:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNcO-00000000bHf-0xYi
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:43:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A789F43A23;
	Thu, 15 Oct 2026 15:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBE91F000C4;
	Thu, 15 Oct 2026 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792079023;
	bh=8ROXgy3qAmfj5WIiFzt+80uO1jlLnVD/zWgR0Zz0bT8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=R7Ob6j/cRfotoLL/HZtajjEtBs3400y+Lu4LUlL9E7OHcCbwBbbi30zYFiPSytwGH
	 wGT+dBjDOEHkq/GmB81rswgWccVtxpaUreLsatQLoVG5iATU4UOnhrSrHmXsmPPyeJ
	 +oLlsV34/jrPIkiG0V5mu+xszh7jCNuPjWC2Bb/YMIz1BK/Ah5LK3z5PS1lREFkoyS
	 F+atBq+o59sP0F56e4h+oDgMqyo9y6bJOm8iz2ihFLoScl7T6yN9S149bnWAsUsvdp
	 YqxSJ5HiUq+KQGoBRg0pcrcb/0tO9E5c/Iu4+QncmFOKszzBfcR6iRkd4KCYL3sXWZ
	 wEpoJijjOIaIw==
Message-ID: <sashiko-outbox-173090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/8] sched/topology: Avoid redundant O(N^3) group
 capacity walks and unused allocations in build_sched_domains()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261015153331.1872641-6-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:43:40 +0000
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

> During sequential CPU hotplug on large systems, build_sched_domains() is
> invoked for every CPU offline and online step. Two bottlenecks in the
> domain construction path scale poorly with CPU count:
>=20
> 1. On non-overlapping topology levels, all CPUs sharing a domain span
>    share the same circular ring of sched_group instances, and on
>    overlapping NUMA levels, groups with identical spans share
>    sched_group_capacity (sgc). However, init_sched_groups_capacity()
>    walks the entire group ring for every CPU in the domain and repeatedly
>    recomputes group_weight, cores (walking the group cpumask and clearing
>    cpu_smt_mask), and asym_prefer_cpu (O(N^3) bitmap operations per
>    hotplug step). Similarly, init_overlap_sched_group() recomputes
>    build_balance_mask() and cpumask_weight(sg_span) even when the shared
>    sgc was already initialized.
>=20
> [ ... ]
>   Total:     7.66 s ->  5.29 s (-30.9%)
>   build_sched_domains() (cpu511 offline / online):
>     11.69 ms -> 5.61 ms (-52.0%) / 12.24 ms -> 5.84 ms (-52.3%)
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015153331.1872=
641-1-pasha.tatashin@soleen.com?part=3D5


