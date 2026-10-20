Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D23606A31A
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KQFOTWLR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsPEwVCY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SrYg+4IxYYwBTzHh7PTz0/BsfWinhw4uhwnWLlCjA3c=; b=KQFOTWLRopJhH0U5/9Vqmzev4Z
	yyItaUwrHSj9Z3Tga2h13IsEsYjfmI20GIsfA2GIWFPh/dG92uafaYnC2ATAOpGV8tUFOUkuhkeyM
	jx4xIeLHQAYL0FAOhUT0eryvq/bFaZP0io3C8T4GG4kpbOkN1h27FYIIjfSpoi7FdPS5mW2X8Jcmq
	IYaI82gLcaid/vmy0t3lksKSPe0otIdxq0dFAZzRiU5whFpX/2XGOuwAFlyRyaDvyN6llhnRiTGT+
	idEmVB8TyHrgst8pQc4NN1Xnscz4rVYU1+PHjvROlcUhLHyZ4akZ5gO4m4a0lZhqkPDACa1TUf+Ts
	sGPtKouA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySA-00000008bHQ-2lVK;
	Tue, 20 Oct 2026 01:15:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIyS9-00000008bHJ-33fG
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 01:15:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 644A260098;
	Tue, 20 Oct 2026 01:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CAB1F000C4;
	Tue, 20 Oct 2026 01:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792458944;
	bh=SrYg+4IxYYwBTzHh7PTz0/BsfWinhw4uhwnWLlCjA3c=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XsPEwVCYnNTEG89vLNC+f/KM1ivegM8emhaoX9lGdQ4zqkwSClS7xFVRQ4Lo0BL16
	 Lkce1/tdnIWljMY9rQCxUsg0CixVgBbV3UwUPB3ochiNeSHyuvpzRZSj1Zt6s4GMdY
	 DoR5BneRdAATusGwJvS8hRzLF1agwW17xpN4x+7kkM7E9bbZhEORWKNmG80o5IikmP
	 ZK+SMha/hvBDsd5VGDgaJ7Ukg07spk2dHMXK/Z8LQPBlgrRtPfOLXyCurok0B9cOMf
	 /GxGSDMyvKPp1nQuE4QfQAcB5nOrvu9ypJxZ+x2EPEn6VE9tYoBSX9iRq0NFowLs+s
	 Lx818b2r10Dkg==
Message-ID: <sashiko-outbox-178402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] x86/realmode: Remove unnecessary WBINVD from AP
 startup trampoline
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, jpoimboe@kernel.org, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, blum@kernel.org, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261019011446.834487-2-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
 <20261019011446.834487-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:15:41 +0000
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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019011446.8344=
87-1-pasha.tatashin@soleen.com?part=3D1


