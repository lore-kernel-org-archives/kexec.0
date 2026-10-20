Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B565C606A319
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qIi+nhl3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUXvDw36
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RS8J52qtbt5ODgVr495qoddqVVw0Sm8CPmkFBES4OcM=; b=qIi+nhl3/zyVSq02g5ERVLQMbZ
	EwQmIEHngRTIxgHUrWko1M+9VVHyAjMjZ2vyUs+SLswe2FYmKVyesXr3TSaneB8N3+128vb/zasBv
	uFJOC3vXl1lbRgBFenK8QXGR+eFWr6Na/EaAtbgKEgMeuFWjkNmbqHlR1VUikT8DqZNgTjL9rvVXl
	hj6UNHayAGT+sf5+REi/BtNdw6MSXIPsy7inbJn7oCEIojruwgyHxpd05RmrIXEsqD9QYCodXw/t0
	3Mbjz5qUMWTQ+G2F6PoluC2B4StSx3vi1ZPtAIEXnTN1LdHR5Lt09H6YXjpipe17Gy4UKWRvP4NLQ
	5eiUAkkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySM-00000008bMi-01Dn;
	Tue, 20 Oct 2026 01:15:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySK-00000008bLC-24in
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 01:15:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E64FF605ED;
	Tue, 20 Oct 2026 01:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723901F000C4;
	Tue, 20 Oct 2026 01:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792458955;
	bh=RS8J52qtbt5ODgVr495qoddqVVw0Sm8CPmkFBES4OcM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aUXvDw36QhplmI8qFeLnXKIdX6gL3p4NdKWC8GS8Y02s2ndaREO9pV2Dq4e3u4iLk
	 h0oRGFG6QhqqksthfbVNULciUZZIOxjYhlwltRPReaSrgSL1A5/+PJqXeD/JaYHP/0
	 tpWcCJDjs8JLlexNrlgfm43loamFm6Rt20XnIswao8iLMI1gVg8Ch1SfYbVV8DeiO1
	 Un8xdl/3ug1IQ3tkaf6fM1KhikU+SdFagUuMV9GH+Lr/GzAmWqTrXdLgLldpG2yTka
	 GLkNsOLdrNaSADNzsxbroy1IImuqGPLLLaS55qj2RfoOE/DLJUIgDhdBGGxIJrYLeE
	 xm0IBLQHC3ixA==
Message-ID: <sashiko-outbox-178406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] sched/topology: Avoid redundant O(N^3) group
 capacity walks and unused allocations in build_sched_domains()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, jpoimboe@kernel.org, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, blum@kernel.org, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261019011446.834487-6-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
 <20261019011446.834487-6-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:15:53 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019011446.8344=
87-1-pasha.tatashin@soleen.com?part=3D5


