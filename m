Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC74CCD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j6GFdPEFS1ddilQxSZcPRZCitfkR5UHzRLzkMsiSlvM=; b=Fa/mekCwOOS+rsllqE6ydq7bFO
	qb5OUzXjESdi9K2HaQv84VwZpHn76+TD/AWKFYZkzOCZWC88y7dFCLYAsUFR/aFHUpNJ0rZVryDLj
	DvdDUpkx7e+LG3ajk9yB9+wXs+VzMfYaEz/hMvbGdrPLpTXpMXDHBDU4HdL6zRrG0FDpuOi5zDzJJ
	6gQewlJxacWHhm7wEMXybbiTTGDJUyHx8EBxkgrDHJEvCfMqTtjA7xrIWlPbAbiIZie3wE4I7Q64/
	+5r831HYHysfGe3am15MRxvmOUc0IsC26Eg+hJmEL2T6yZ29g5jVZHOBoK3I+C/Byc4FI+1Vbh/4R
	frheOovA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0sI-0000000GIxp-2bBO;
	Mon, 18 May 2026 16:31:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0sI-0000000GIxK-00Gr
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 16:31:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5BD6E600CB;
	Mon, 18 May 2026 16:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13C8C2BCC6;
	Mon, 18 May 2026 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121885;
	bh=pJ8LBebLK73jQzMKkLyf4advK34I4By53h0iAorap3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nQ5ZEOpHmIdxwUF3whCwUQGwdWtAzj7kpBubJ/5tUgrVZHyUchg5jaibhxtgk8N0c
	 J/qombQpJSf7C0xq6W7etvIikMU4mCv7EYQ5SkKwNbNn7roCx4zjtyBIRBZ/Apigzl
	 vhIwadfZl6BhTB/w+D3DpdtMwnIOrs3dcX33QKuCd11VZ2p/kA3OElKiV4tb/a/Bog
	 sFQ4yKkbtd6LxQxZpR/jHFCv8wLX8h6HMm86w5mzger4OLyxcotBq+m3glIpzGXAWp
	 b1VsJzkooBZbw84UVAp7yTCImXDbaetVz7YY12ubsZNNXmMLpXygqY8YbGbanAoZJS
	 uvj2+Hax1LIkg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com,  mario.limonciello@amd.com
Subject: Re: [PATCH v5 3/5] liveupdate: block session mutations during reboot
In-Reply-To: <20260518125459.1092373-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 18 May 2026 12:54:57 +0000")
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
	<20260518125459.1092373-4-pasha.tatashin@soleen.com>
Date: Mon, 18 May 2026 18:31:20 +0200
Message-ID: <2vxzo6ic8ysn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, May 18 2026, Pasha Tatashin wrote:

> During the reboot() syscall, user processes may still be running
> concurrently and attempting to mutate sessions (e.g., creating,
> retrieving, or releasing sessions). To prevent this, introduce
> luo_session_serialize_rwsem to synchronize mutations with the
> serialization process.
>
> All session mutation operations (create, retrieve, release, ioctl) take
> the read lock. The serialization process (luo_session_serialize) takes
> the write lock and holds it indefinitely on success. This effectively
> freezes the LUO session subsystem during the transition to the new
> kernel. If serialization fails, the lock is released to allow recovery.

Good idea I think.

But, do we need a new mutex? Can't we use luo_session_header->rwsem?
Session creation and release take the header rwsem at one point anyway,
so perhaps we can just reuse that?

Also, do we need to block incoming sessions? They won't participate in
serialization, so perhaps we can leave those alone, and all the outgoing
sessions get protected by the outgoing session header rwsem?

>
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Regards,
Pratyush Yadav

