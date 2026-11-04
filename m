Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D9606A32E
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BOUalY26;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jb96h4h0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cGl7bC3fWAoAUhJbWEmSTM5Y06Elv8KWXkaBb9P48hA=; b=BOUalY26xE7LvwHwemmlHiz2L1
	6jec+/1/tstkrLyndtdG7MUVFUXpVscFyiUbAOk2dg5byP2BoFJZfQuWcDQLlGBtO0Kb6kKVlf9cx
	CfVR0+iBBQfnZVjTGOSI+1grexxTJ1iaPCsVSrhqTKyfdr4hEyZXNWpkEUtYczHdswuQWUp6Xflfk
	xlpjMwCDwsaj9YxnEo7iU9FfNBweQi8ZlSKK+0KD0cjX0DXWyZrkiLrCigG7cytQ70gve4lsGCa/1
	sfUyZVLvo+BucWbEsVum1/2UcPIiBIGWypn/cSWndR2N2RUYBopgl037yqBaG5G71OYynDCBCvwd4
	aCMy9qkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOR3z-00000004CsV-3Dkn;
	Wed, 04 Nov 2026 02:49:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOR3y-00000004Crr-0KzL
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 02:49:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5DDAF43B2D;
	Wed,  4 Nov 2026 02:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657D51F00919;
	Wed,  4 Nov 2026 02:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760561;
	bh=cGl7bC3fWAoAUhJbWEmSTM5Y06Elv8KWXkaBb9P48hA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jb96h4h0oM3x4HuMId9uj2LqKZoeAZgCuatFL0X+g/wCJ7W3yMOe0X+dGWF5LZ1Bh
	 RJgMrUz3AHHIUC+Z4+HAGKWnlgwAZ9sGm1hChg1XwsbZwTUL/TrZPNINyYw/XIX/ZG
	 G30TzK2SZ8L+TUdKRouOFuOavuK9HgEczJgXAsaU0LjsPd6BEZYiIs9ndCujj6YC3M
	 74rzfop9P769vcC6l+1fnC6yfgQwNV3B8wKFg0bvJLdTiJ6mZxinQL54u8rpdtn6et
	 ThQeKLK7GDRuz9JleE7CZdoIlyEP2yoD0Isb0vVwMAbdqEsQGFhpadeotBCvbBSezs
	 SepM0zq9kLE7w==
Message-ID: <sashiko-outbox-196525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/5] mm/show_mem: Avoid blocking on zone->lock
 during Oops or panic
To: "Aaron Tomlin" <atomlin@atomlin.com>, pmladek@suse.com, john.ogness@linutronix.de, rostedt@goodmis.org, senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103024453.922373-3-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:49:19 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm/show_mem: false lock contention warning in show_free_areas()
--

commit e1c6e11316c0b99b2f700b8251c5ed2b76aad84a
Author: Aaron Tomlin <atomlin@atomlin.com>

mm/show_mem: Avoid blocking on zone->lock during Oops or panic

This commit updates show_free_areas() in mm/show_mem.c to avoid uncondition=
ally calling spin_lock_irqsave() on zone->lock during Oops, panic, or NMI/a=
tomic contexts, skipping zones when acquiring the lock is unsafe or contend=
ed.

> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index b938cbcd774a1..77098077523a9 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -367,10 +367,17 @@ static void show_free_areas(unsigned int filter, co=
nst nodemask_t *nodemask,
>  			continue;
>  		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
>  			continue;
> -		show_node(zone);
> -		printk(KERN_CONT "%s: ", zone->name);
> =20
> -		spin_lock_irqsave(&zone->lock, flags);
> +		if (!can_spin_trylock() || in_nmi() ||
> +		    oops_in_progress || panic_in_progress()) {
> +			if (!can_spin_trylock() ||
> +			    !spin_trylock_irqsave(&zone->lock, flags)) {
> +				pr_warn("zone %s lock contended\n", zone->name);
> +				continue;
> +			}
> +		} else {
> +			spin_lock_irqsave(&zone->lock, flags);
> +		}

[Severity: Medium]
In show_free_areas(), when can_spin_trylock() returns false (such as in NMI=
 or
hardirq context under CONFIG_PREEMPT_RT, or in NMI context under !CONFIG_SM=
P):

mm/internal.h:can_spin_trylock() {
	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
		return false;

	/* On UP, spin_trylock() always succeeds even when it is locked */
	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
		return false;

	return true;
}

the inner !can_spin_trylock() check short-circuits before
spin_trylock_irqsave() is ever called, yet still prints "zone %s lock
contended" for every populated zone even when zone->lock is completely
uncontended.

The commit message also states:

  Check can_spin_trylock() and use spin_trylock_irqsave() when
  !can_spin_trylock(), in_nmi(), oops_in_progress, or panic_in_progress()
  is active

Additionally, because show_node(zone) is moved after spin_unlock_irqrestore=
()
below, skipping a zone here only logs zone->name (for example, Normal or
DMA32) without the NUMA node ID on CONFIG_NUMA systems.

Should the !can_spin_trylock() case avoid claiming that zone->lock is
contended (and match the commit message description), and should the skipped
zone message include the node ID?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103024453.9223=
73-1-atomlin@atomlin.com?part=3D2

