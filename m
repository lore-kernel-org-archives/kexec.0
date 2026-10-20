Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE492606A31A
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i3KJrIqP;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRfeyWXG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=glysEiovDmtsD/XzvZLZOV5WI74UR92HurssUSaQ940=; b=i3KJrIqPgsUYpseOzfZId5vU+4
	DLzu6G96wBt0okMRt7c6bF8YTvJH5e6bnR64+5KNPJQDZDRdAVLo5zA1CBYfJegx4CyJEhlG7B4M3
	0K+YSRmx2o7PvcB69Jw6wFDXVYzGjN3geu9UuvlMgEttLbqN2RKHCtZvzsRR7UvDovVEKHIRd+5Dy
	oT+FIxjMCqVSEMpOB7sY7NDsoW2mUyEHbQ9C2TUGuabF77wX31DqWdMEUd/Bm2QhsNjDrgADY49NS
	5fa/hmykght6G+Jc8ZdL6BSCE41PBPoaC5a2CdtvnkdcfD+iWR786cG+gIZFTgOtkWPQMlm348f1Q
	q777w3cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySI-00000008bKV-3t3D;
	Tue, 20 Oct 2026 01:15:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIySH-00000008bJZ-397x
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 01:15:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 33E5160098;
	Tue, 20 Oct 2026 01:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB88E1F000C4;
	Tue, 20 Oct 2026 01:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792458952;
	bh=glysEiovDmtsD/XzvZLZOV5WI74UR92HurssUSaQ940=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mRfeyWXGlzOBIZ4shiraT919uJkbbegB1UwzsgjJj7sAj3n+v503A1+to15Mn5IvQ
	 AP9k+OIjSBUbOkKY7beI8BMUIC5/cAcHaK3DXlEHqXl5LHOomWYXPxufFVDgnl4SR3
	 wGLcDbi6FlsKkBTAMk1cLRg0t3fhNwcAoAHn/ONMXOsIsXrwCuZFlC6NvMcAfSiCrr
	 aqBDzYfXdT6ucGIG6d76tbOMb/TR/my6qlZz9TFP9h65Q0MI7CkeVexz9QUro777a6
	 5S7GoV/NVvGYYDgdNWSEHF+SF8l6Sl+80qQrYDFPLpkpRvOSAKtdI+tfezfshk9aif
	 D8uToPD8HrzMg==
Message-ID: <sashiko-outbox-178405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] x86/cacheinfo, mtrr: Skip stop_machine
 rendezvous in cache_ap_online() when MTRRs match
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, jpoimboe@kernel.org, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, blum@kernel.org, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261019011446.834487-5-pasha.tatashin@soleen.com>
References: <20261019011446.834487-1-pasha.tatashin@soleen.com>
 <20261019011446.834487-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:15:50 +0000
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

> When a single CPU is brought online at runtime
> (cache_aps_delayed_init =3D=3D false), cache_ap_online() unconditionally
> calls stop_machine_from_inactive_cpu() to rendezvous all online CPUs
> while the incoming AP runs cache_cpu_init() to disable caches
> (CR0.CD =3D 1, plus wbinvd() when X86_FEATURE_SELFSNOOP is not set),
> reprogram MTRRs via mtrr_generic_set_state(), and re-enable caches.
>=20
> During initial boot (cache_aps_init()) and across warm CPU offline/online
> cycles, the AP's hardware MTRR MSRs have already been programmed to match
> the saved mtrr_state. Stopping all online CPUs in stop_machine (and
> flushing caches on the AP) when the AP's MTRRs already match mtrr_state
> is unnecessary.
>=20
> Add mtrr_generic_state_matches() to compare the local CPU's
> MSR_MTRRdefType, variable MTRR ranges, and fixed MTRR ranges against
> [ ... ]
>   Total:     8.45 s ->  7.66 s (-9.3%)
>   cache_ap_online() (cpu511 online):
>     1,354.6 us -> 6.4 us (-99.53%)
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019011446.8344=
87-1-pasha.tatashin@soleen.com?part=3D4


