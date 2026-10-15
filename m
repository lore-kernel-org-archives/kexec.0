Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEEECC6B39
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xfJErzoYwObujgAa/2qQszEg/7aBAMpYNTEs6++lwjo=; b=yp3IklQP0R/MoQYEaOfMJ536az
	S7ZRztfX3jS3di5YK5knqSGnw3dUbyyqn9fDmJZgNF4YpEp8KNDaNuoWUCfq99+ipSaCk+cQ0pK57
	Ru9oX81QtZUiVsBUD5ZJkNo81DU/I4shvdmIcBvBAeDFpv9BjDtIN9Mv+Rot2QaiLpa94MW9YLXak
	3S5qGC97ORWKc1lK9pLKb822siFk62NKnZ8h1FRqm5cUZkmYD11RsQ8cmFN+g2xcBl+YrUHe6KD2T
	zvX/8RtHjfJ/yozJIy8g6V0sREfLo5fKIz4EUF1+tA3DjtKrCStnKUScPvVHr56Dvj15XwuwxXgjX
	eBPTWzWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNaB-00000000av5-27LJ;
	Thu, 15 Oct 2026 15:41:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNaA-00000000auP-1DNz
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:41:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1679460200;
	Thu, 15 Oct 2026 15:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6F01F000C4;
	Thu, 15 Oct 2026 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078884;
	bh=xfJErzoYwObujgAa/2qQszEg/7aBAMpYNTEs6++lwjo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Taa7q0qBqdNXT4iKTUtAbfULekNwY5CfK2ZbWyMcUBReHj+LYJFaT4d3yMtWaUb6M
	 3fSncbyc6au4HKylAkbL/nZL3ld/D1bHwDE0dO9nDD580KnKGw71FGdG2o779YZYlf
	 RG84c2TVVojPHNBIju9Jg7Mjfqzd7ixbHFUtSqqbIO89gu/wrL3RrgQxN0T2xTxcBQ
	 QePuXxGsop/5u+UvhcGX3KNDH9+AyN1Ys7ppPjKwgRctmGDeiLCKdAQC21IDlTGyIN
	 /0BX72GHU3Z/2VR5XEl+yZiHTmzA82IsTA50iaXFEBfRxdkNRhBQhDwup+/65MwDRM
	 uNetcaSInpTYg==
Message-ID: <sashiko-outbox-173086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/8] x86/realmode: Remove unnecessary WBINVD from AP
 startup trampoline
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261015153331.1872641-2-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:41:22 +0000
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

> trampoline_start executes WBINVD in 16-bit real mode before switching to
> protected mode. This WBINVD was originally added in the 1990s for
> Sequent NUMA-Q hardware (as noted by the comment in trampoline_32.S:
> "Needed for NUMA-Q should be harmless for others"), whose cross-quad
> caches came up non-coherent prior to OS initialization. Sequent NUMA-Q
> support (CONFIG_X86_NUMAQ) was removed in commit b5660ba76b41
> ("x86, platforms: Remove NUMAQ").
>=20
> Per the Intel SDM (Vol. 3A, Table 10-1, note 2) and AMD APM, the INIT
> IPI used to wake secondary CPUs preserves cache contents and leaves
> CR0.CD and CR0.NW unchanged (0, as already enabled by firmware or the
> kernel). Neither sev_es_trampoline_start nor trampoline_start64
> executes WBINVD.
>=20
> On modern multi-core processors with large shared last-level caches
> (such as 504 MB shared L3 per socket on Intel Xeon 6985P-C), WBINVD is
> not harmless: each execution flushes and invalidates the entire
> coherence domain's caches and takes ~85-115 ms per CPU while disturbing
> active workloads on online CPUs.
>=20
> Remove the obsolete WBINVD from trampoline_start.
>=20
> 2-socket, 480-CPU Intel Xeon 6985P-C (N=3D479, mean of 10 runs):
>   Offline:  40.40 s -> 40.46 s
>   Online:   65.83 s -> 11.14 s (-83.1%)
>   Total:   106.23 s -> 51.60 s (-51.4%)
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015153331.1872=
641-1-pasha.tatashin@soleen.com?part=3D1


