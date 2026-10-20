Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0365606A319
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 01:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3oaRtzn5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibnw2b6Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOZ6xK7gPKz+7mr2Ctq9XJ42zWxJ6XJWSknxthBp88M=; b=3oaRtzn5eVaPZMYZNtpDKQMluN
	MRcWeLvX3iRGl1vRGk0XbJk9u4TMQ9eHmdnCxOe4t3MzpXOGAyGtHsaDfXgYwZ/HEKDmxeEY5bNMr
	LfX+zywNJGaQLTLg3JrEQSx83yo1FpxU2qnu9vHn7Pv5poAs5ughsr9wHljHWVNlfCTg2i02eborE
	W3+ts+SpTT9FNgZ12JSm58GT4Qxd55QjyzflhsXMXNQE6n+2lMiEMbTyrpGy/WFIo6NWQc4hTxsc0
	co8OhpTBnh6G49zYRSAuv2bOMLNXPQg7kchn3Xfao2TKu2ZVZ3UslyHDDpoNcLBtC5H1klIYTrvkB
	3xqDlKMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySW-00000008bU4-19dP;
	Tue, 20 Oct 2026 01:16:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIyST-00000008bRZ-0J8C
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 01:16:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C3ED741262;
	Tue, 20 Oct 2026 01:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B881F000C4;
	Tue, 20 Oct 2026 01:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792458964;
	bh=jOZ6xK7gPKz+7mr2Ctq9XJ42zWxJ6XJWSknxthBp88M=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ibnw2b6ZA7nuemzUk6cZUflsY9eR9KsWpFGzsQfYyVkfJsJYvbGyZxSvTDmFl7W89
	 rLRQc8K4a6ObmWafEkfjijW3WYVATjT8m+OOYFuoUNwhSD081wMEQgpAZ8yZwxnZma
	 Gq3PiPpY+X2CX9fUoJSiFPLNLKIRzl17gtUWx2NcK9qwHdp3tXMi5rvHjDVRvBKDkF
	 3/gWsyXQUoUZOh1Q0iQhYso+GpXF0BNYQQhE+Ctkr5+xDcT8UhGlzwnqJrmK7KkLQ0
	 KbNMJ9jjygr4W4KTWBwlQt9ckTGT7MbB3q82csckRE/2Wj/TUCI0dGkEMu0UZVRJiR
	 tWKpJoBNDvaKg==
Message-ID: <sashiko-outbox-178409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] mm/vmstat: Avoid redundant per-CPU
 stat_threshold writes in refresh_zone_stat_thresholds()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, jpoimboe@kernel.org, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, blum@kernel.org, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261019011446.834487-9-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
 <20261019011446.834487-9-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:16:02 +0000
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

> During CPU hotplug, vmstat_cpu_online() and vmstat_cpu_dead() invoke
> refresh_zone_stat_thresholds() on every CPU transition. Currently,
> refresh_zone_stat_thresholds() first zeroes
> per_cpu_nodestats->stat_threshold across all online CPUs and all online
> nodes, and then unconditionally writes per_cpu_zonestats->stat_threshold
> and per_cpu_nodestats->stat_threshold inside the zone loop for every
> populated zone and every online CPU.
>=20
> However, calculate_normal_threshold(zone) only changes when
> fls(num_online_cpus()) changes (at powers of 2) and is clamped at 125
> for large normal zones (>=3D 16 GB) once num_online_cpus() >=3D 64.
> Unconditionally zeroing and rewriting every CPU's per-CPU stat_threshold
> on every hotplug step repeatedly dirties remote per-CPU cachelines with
> identical values (and briefly exposes stat_threshold =3D=3D 0 on live CPU=
s).
>=20
> [ ... ]
>   Total:     3.46 s ->  3.38 s (-2.3%)
>   refresh_zone_stat_thresholds() (cpu511 offline / online):
>     104.6 us -> 50.7 us (-51.6%) / 109.3 us -> 53.5 us (-51.1%)
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019011446.8344=
87-1-pasha.tatashin@soleen.com?part=3D8


