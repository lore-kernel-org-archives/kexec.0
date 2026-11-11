Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F38606A321
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GAhhu+FC;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlG6MDWB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LGtA8oHwJxBMbpFS71S5aylj40/O50v1rdQBtx/3tAk=; b=GAhhu+FCpNZthN
	s7lAFMvUzYYcKcLCl9OWuicGMP2upPWBHsvg7ujZmQaSkH45xmcSwrSYUzn61GZp0cDMSVGeY1ZXX
	cFDA7vOKDZDXjSvUUSm5gPFr2IWpRfm08es4VPPrrvLqdIn6sLRJtF3tH9LIQKiXXjTeK9c4wbE/q
	cc4Rx7++1qL5EgqdwJVuK/s6ANtOcHUjYqAFCslC3EYKdJjY9knd+pBjLdjeJfKYP97WBQp2VHw8/
	3Cb+k74MSuLzF8+J6kYbT4OG4BRu4xIhOmpxJWzgDdufYQT4DvNffoIYPs8NVrFz4vQHF/I1gjHyZ
	mYW77LjFcGX/UhRX0Qjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6Lq-00000006Sur-0JIW;
	Wed, 11 Nov 2026 11:18:50 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6Lo-00000006SuM-0oqg
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 11:18:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A177562EC1;
	Wed, 11 Nov 2026 11:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F971F00A07;
	Wed, 11 Nov 2026 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794395927;
	bh=LGtA8oHwJxBMbpFS71S5aylj40/O50v1rdQBtx/3tAk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=hlG6MDWBY3f1BLNyjZYL56zodU/rHV9hZ+npsdSbztWpev2Pr3j7saWo7HrZR9h0g
	 r/F714KjW5XGwjw7RKw9cII9h6AK6haRNUANV5ARKvGJHmqiimNq3j6T9ddmR3V8Hr
	 zVtJJ+FY1hAA7mkWNHYX+EcZEvzkWUGg0rq3wsUcNo5a7gS7CI0wO8o3DXznPVIhil
	 9IvcoeMkIWcxahIopQgSHyi+oklrqZv2T2QU19r4qs9exYAUTwEN+rbLCTpB/pGAeg
	 2RsS9dQGmcstxsPmOv94KVlDlM8arNS0cnTDwJa6FF65R+eIt126qpFl5CaFq98KGc
	 T6HtQw9NEaqQA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 0/6] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 linux-mm@kvack.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
 vipinsh@google.com, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
Date: Wed, 11 Nov 2026 13:18:40 +0200
Message-Id: <179439592040.425130.10808690337075841196.b4-review@b4>
X-Mailer: b4 0.16.1-dev
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> Currently, LUO freezes outgoing sessions only inside the
> reboot(LINUX_REBOOT_CMD_KEXEC) syscall path, serially under global write
> locks, and binds every outgoing session's lifetime strictly to an open
> session FD until reboot.
> 
> On hosts running many workloads (such as VMs or stateful daemons),
> workloads do not all pause simultaneously inside reboot(): they quiesce
> one by one ahead of the host kexec. Userspace needs an explicit
> per-session freeze point to snapshot final file state (.freeze()) as
> each workload pauses -- concurrently across sessions under per-session
> locks -- along with a way to commit a frozen session into KHO so it
> survives closing the session FD.
> 
> This series introduces LIVEUPDATE_SESSION_FREEZE on session FDs:
> 
> 1. Freeze (flags == 0):
>    Freezes all preserved files in the session under the per-session
>    mutex while keeping session lifetime tied to the session FD. The
>    session stays frozen as long as the FD remains open; closing the
>    session FD before reboot (for example, to abort the session or on
>    process exit/crash) runs .unfreeze() and .unpreserve() and reclaims
>    all resources. At kexec time, already-frozen sessions skip the late
>    auto-freeze step and are published into the outgoing KHO subtree.

Let me bikeshed for a moment :)
I'm not fond of "published" terminology. We just moved serialization
from one place to another, why not keep the naming?

-- 
Sincerely yours,
Mike.


