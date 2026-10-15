Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F92CC6B39
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujb0Z5ioqAg4Zn4cbvTgdm83wJX28LssfRz0KwUxVNk=; b=Ez12tFSMFB8+wMs46ytyUPbpJR
	B59zT8hlYMCv7G9AKrO1JXitmfGIdJOYsPitoo8JFZkgWYruyx3adUV+d1GQXpG+yVLPUXoUTwc8f
	G2BHgxtXLA3cvY4N3gBFe+CBVeBXRxTyZEffE9dq4sm+4PxBpFbvO2WyZeFMO17wvLpG8gPVjT8I8
	c4YJc1uwK3iAtriW5cQxI7/XCiHQdZNvt0EKGFRY4k6qmRmnFV6osaLqWq60UcmGsi9TnO4KAf/jb
	HQ0V9jGwnZq6nrKCK/cQ0xZZ7nWsTLNL4fPhJvOH+LTXlVEtk+euDqlCZ0nDKMXhXw6dM+S4oVZo4
	e3ry/HgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNds-00000000bWr-39Uz;
	Thu, 15 Oct 2026 15:45:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNdq-00000000bWe-3gux
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:45:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 50F7460120;
	Thu, 15 Oct 2026 15:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0700A1F000C4;
	Thu, 15 Oct 2026 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792079114;
	bh=ujb0Z5ioqAg4Zn4cbvTgdm83wJX28LssfRz0KwUxVNk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AD8kRNSaAijVrraUk6KcPP9e5O+4n6rZWA/8TdiqiFaZYA6MXQ3lsdHnuxP2hmrfO
	 900j/NC5yY5hosfzTZ7aKPQpfBEnr6TO4dVlJU5FBiOhT8I+SQcRjLcu+6ZMqdrwAw
	 29YIYdOnQow+UXQVo1IvPYREVCGytGuIM/xZi+OtpTqVSoeHao8G+y+ufyUlRr1aa8
	 Tgo0HF4ixfwmjB4BFqCVEXSbIBTLc5hFH0Osy45jMms+YzJ9Hf65yo09+FHSM+jAGE
	 n9pGkjYsHtWsIxE0m1P8V9De8T2I5bDS6QiDSNQDHe+9bo53xVUjOvVf0ZAwB7jnqv
	 EK4g2Mf/L2xxQ==
Message-ID: <sashiko-outbox-173093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/8] x86/cacheinfo, mtrr: Skip stop_machine
 rendezvous in cache_ap_online() when MTRRs match
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261015153331.1872641-5-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:45:11 +0000
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015153331.1872=
641-1-pasha.tatashin@soleen.com?part=3D4


