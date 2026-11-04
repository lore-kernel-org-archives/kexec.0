Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62C606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qEvcAasp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oz7RiSVn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cyPYs5GE3f6Czo0ndK7Tq3PgZNjrCLwaE2jdDq8sm3w=; b=qEvcAaspFNS0GyzAg8KG8OnXt4
	tzm8+HAKedEEjEMnerWkPq8FvPM2DqK0ZDCm+ZKq04L/8JoO9WLvXtDHlvzOG7Fwye8eribXFBOQm
	sM5BE/PtCuPGhLi4a+5pQK9UDovVb76mf0K90A1FkTr9eHB+ZzVQ2XaCJaonV4lC9iqRSRrZKHwUh
	OwYw2csf0TiziCjmLijun9WNhpw/Ih2Ek/XaYfYkcTRxROzZZQz7JTi4kmiKhTlOIwsh4aDixFEaq
	iWGmFCDf1xiVK1/Cxh5NZG9CaXnMW3BHXQYF2QKWzrJH6+jsFMBE6QvUvL6QJ+Inqqr9275Zs9F58
	dv0ilHug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOR43-00000004CvV-1acG;
	Wed, 04 Nov 2026 02:49:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOR42-00000004Cuh-0bXr
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 02:49:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C38B443DAA;
	Wed,  4 Nov 2026 02:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2E01F000C1;
	Wed,  4 Nov 2026 02:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760565;
	bh=cyPYs5GE3f6Czo0ndK7Tq3PgZNjrCLwaE2jdDq8sm3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oz7RiSVnh36KuKT5ljpGKrUsxJc5NIUqAX6PZKp96R1qb5/QJgViTqWbzNHuL0mh0
	 OvsaKCCES+33ZZeqKMx4SHe3zpHdLDwKp3MpY8TkbxCp9QKbGGBUo4evouN4INgEgV
	 lig2L9h91qfrGOPy1f6aV0iM4h7ripgVXtWsW22K/onGvEew92Lhhh090Y/IFQC4nU
	 Ve4GNenIg8JGRv3ReutsE5jRfbCVNE0X5q4Eej7NEw2kGmVjYtyUC647slKmVHi/f8
	 I649GQRLle5R3jdboRxYqMSRULHr3p/lVhd35bzPb4vMogma9k83QrxEjiw4wp+bVA
	 20rHp9gU+YbNw==
Message-ID: <sashiko-outbox-196527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/5] printk, tracing: Support console flush
 suppression and tail pinning
To: "Aaron Tomlin" <atomlin@atomlin.com>, pmladek@suse.com, john.ogness@linutronix.de, rostedt@goodmis.org, senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20261103024453.922373-5-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:49:23 +0000
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

> When collecting high-volume diagnostic output into the printk ring
> buffer during a kernel crash prior to kexec, synchronous console
> emission can stall the panicking CPU for tens of seconds on slow serial
> or IPMI Serial-over-LAN links, risking external hardware watchdog
> resets. At the same time, uninhibited ring buffer rotation can wrap and
> overwrite the initial Oops, faulting registers, and primary call trace.
>=20
> Introduce two scoped mechanisms for in-memory crash telemetry
> collection:
>=20
>     1.  Console flush suppression
>=20
>         Provide printk_suppress_console_flush(bool) to clear the console
>         flush mask in printk_get_console_flush_type(), guard legacy
>         record emission and kthread wakeups, and suppress
> [ ... ]
>         record and stop reserving descriptors or consuming trace entries
>         so the primary crash context and remaining trace buffer remain
>         intact.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103024453.9223=
73-1-atomlin@atomlin.com?part=3D4


