Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3A606A330
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bLPxm6qs;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgTxz2yg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ThIbPidvBK4i6Csq/pIkivMxZjIx7r0x4v2l4wVxXBw=; b=bLPxm6qsO1hu0x1x+s3qWAmdoL
	/sqOJh9U+7mJJTBJT+RofxvTelA5mTWbxD/Ybt9wmFtmH5iFIHm7aJfZjDsy0Pz3vKuL2RT0wU3oc
	AGvU3d8bJPGMm87Gn4yjZ3/UlPtuKzZT+imY6Ywjuze+OX0vmHclH8EtNLo6c4xE5kPq8gflXQuMf
	cB3ofG9xoBiWv18XiPemaDYCFOrXLGysVTATiCCxgJJ/zrPeDoz2VL7+Zr7vppX9e925NABsFTv8r
	xLoxEGTmHF5RjMWJEMK0YxFTRiDMOCzrLkb/qpe67lQZYBWRLQoUZ1N+pJQcOQ2Z5o2zUkjZmQqKL
	Kmv0EQ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOR3x-00000004Crs-2u7Y;
	Wed, 04 Nov 2026 02:49:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOR3w-00000004Crh-1EEX
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 02:49:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 37DF5602C3;
	Wed,  4 Nov 2026 02:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487AC1F00919;
	Wed,  4 Nov 2026 02:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760558;
	bh=ThIbPidvBK4i6Csq/pIkivMxZjIx7r0x4v2l4wVxXBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgTxz2yghtz136oSvsEgNWxDK1UKzIAz4bUm2ta8Oek1uOr1sjN/JU7idKBzyVbM+
	 gZPRxn2jAkF+uFEoqh/WGp+va2Gtf6j6EdKSSILE1bZDoBc67WVUqbCPTOzXJM1dPI
	 I8d4vThVTyw5reTsH+tPqHvfmLLjhfq51GCcf4IWcOLbErwBixQ8NXjj8bBFxg/YiJ
	 pxZxxSb7c6tC+orl5EReGxSWQrlG/ZQdai7CpK39WuzwQiHes6P5LMASf9bUnYm29D
	 ZD1E/TdusmxaP1yUZxzL9vGf/mZY8uvoRP0HxfI4ybyclYsndU3plwKUFVepNIWafQ
	 gwZoKEMu5YFag==
Message-ID: <sashiko-outbox-196524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/5] panic, sys_info: Fix duplicate and dropped
 all-CPU backtraces in panic
To: "Aaron Tomlin" <atomlin@atomlin.com>, pmladek@suse.com, john.ogness@linutronix.de, rostedt@goodmis.org, senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20261103024453.922373-2-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:49:16 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> When sys_info() was factored out of kernel/panic.c by
> commit b76e89e50fc3 ("panic: generalize panic_print's function to show
> sys info"), __sys_info() gained an unconditional call to
> trigger_all_cpu_backtrace() when SYS_INFO_ALL_BT is set, while
> panic_other_cpus_shutdown() retained its own call to
> panic_trigger_all_cpu_backtrace().
>=20
> This causes two problems during a kernel panic:
>=20
>     1.  vpanic() invokes panic_trigger_all_cpu_backtrace() inside
>         panic_other_cpus_shutdown() before stopping secondary CPUs, and
>         then invokes trigger_all_cpu_backtrace() a second time inside
>         sys_info(panic_print) after secondary CPUs have already been
>         shut down, stalling for up to 10 seconds waiting for offline
>         CPUs to respond to NMIs. Furthermore, if SYS_INFO_ALL_BT is
> [ ... ]
> panic_try_start(), and route SYS_INFO_ALL_BT in __sys_info()
> through panic_trigger_all_cpu_backtrace() on the panicking CPU.
>=20
> Fixes: b76e89e50fc3 ("panic: generalize panic_print's function to show sy=
s info")
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103024453.9223=
73-1-atomlin@atomlin.com?part=3D1


