Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A359DCD4F54
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CBlQ8YWC6G++d/3lhEyC3dON/LvEOTiPxKNTP2tZq8A=; b=xRJ5zfANrQfDnXDEm1DVqBNaE7
	Cxq1GhchGeayQLipoSgKg4wnxgAmc09H7+wgDmwsqbrDUXRFRDbgc+ToWokei4jzNgNLa9KWpLRuD
	xyLtYTDwmufpAx3gZlFjJjiV5ETsHmDHxWwYRqDMtfZjqhhqwLI6qtzSoMXdswKwUZ8B/uUlot81X
	VwhofSksiJ+Kt06FZWL6b4JIWRNYFiY4pO5vjqC6ZtB8/WS5OKWV+kQcIivxQ0jjMwDwY17zGhKcl
	zLNs5NxW3+ev+Xo5Nz+WiDUBqReKaKhfLjvCUPwkAepmN0MT6xPr38Yt7bkAEbqCEZg3JyBeesDEr
	qsWQqAlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSbbX-00000005q1u-1fnZ;
	Thu, 28 May 2026 14:20:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSbbW-00000005q1o-2DsQ
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 14:20:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FA476022B;
	Thu, 28 May 2026 14:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CAE1F00A3A;
	Thu, 28 May 2026 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978057;
	bh=CBlQ8YWC6G++d/3lhEyC3dON/LvEOTiPxKNTP2tZq8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N/bfUbcocl6fiABWptERDqRVRURKaQSBnzPzig3PL1stejO8XNlIVt2tH9f25rfms
	 FJ9loDyGqnthIZ7kk6zU05DD+XUTBLqOo6wfjbxTSxvviyS4Vp0X8A6js4jkoeQQKO
	 CvOZanmh/pAJWscRCr5G4qHXhSbcOUdN0DYNRIFB6xVrcVdIxGW4EyYYYNLbfhmUw/
	 n4Jc29QYPGa7G7MKNqJaBBKtNgMIq/ldmkxgG1nJ8JUXB89s7mrZ5GzpbFp4w/SiNI
	 edUM/e8RT5eyfykHtfN0vNfZQnE42xOPUn9taNF3Bb/Tfs47I7/HOGGP0xjdZ7VN5H
	 0yAoGhYWYZWUA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  error27@gmail.com,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  rafael.j.wysocki@intel.com,
  piliu@redhat.com,  kexec@lists.infradead.org,  pratyush@kernel.org,
  skhawaja@google.com,  graf@amazon.com,  mario.limonciello@amd.com
Subject: Re: [PATCH v6 3/5] liveupdate: block session mutations during reboot
In-Reply-To: <20260527202737.1345192-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Wed, 27 May 2026 20:27:35 +0000")
References: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
	<20260527202737.1345192-4-pasha.tatashin@soleen.com>
Date: Thu, 28 May 2026 16:20:53 +0200
Message-ID: <2vxzv7c739a2.fsf@kernel.org>
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

On Wed, May 27 2026, Pasha Tatashin wrote:

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
>
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_session.c | 56 +++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 169131642939..c9bdad2e5ae7 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -46,6 +46,38 @@
>   * 4.  Retrieval: A userspace agent in the new kernel can then call
>   *     `luo_session_retrieve()` with a session name to get a new file
>   *     descriptor and access the preserved state.
> + *
> + * Locking:
> + *
> + * The LUO session subsystem uses a three-tier locking hierarchy to ensure thread
> + * safety and prevent deadlocks during concurrent session mutations and kexec
> + * serialization:
> + *
> + * 1. `luo_session_serialize_rwsem` (global rwsem):
> + *    Protects session mutations (creation, retrieval, release, and ioctls)
> + *    against the serialization process during reboot.
> + *
> + *    - Readers: Taken by any path modifying or accessing session state (e.g.,
> + *      `luo_session_create()`, `luo_session_retrieve()`, `luo_session_release()`,
> + *      and `luo_session_ioctl()`).
> + *    - Writer: Taken by the serialization process (`luo_session_serialize()`)
> + *      during reboot. On success, the write lock is held indefinitely to freeze
> + *      the subsystem. On failure, it is released to allow recovery.
> + *
> + * 2. `luo_session_header->rwsem` (per-list rwsem):
> + *    Synchronizes list-level operations for the incoming and outgoing session headers.
> + *
> + *    - Writer: Taken during list mutation operations (inserting or removing a
> + *      session from the list).
> + *    - Reader: Taken when traversing the list (e.g., retrieving a session by name).
> + *
> + * 3. `luo_session->mutex` (per-session mutex):
> + *    Protects the internal state and file sets of an individual session. It is
> + *    acquired during per-session operations such as preserving, retrieving,
> + *    or freezing files.
> + *
> + * Lock Hierarchy:
> + *   `luo_session_serialize_rwsem` -> `luo_session_header->rwsem` -> `luo_session->mutex`
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -75,6 +107,13 @@
>  		sizeof(struct luo_session_header_ser)) /		\
>  		sizeof(struct luo_session_ser))
>  
> +/*
> + * Protects session mutations during serialization. All session mutation
> + * operations must hold the read lock. The serialization process holds the write
> + * lock indefinitely on success to block all concurrent and future mutations.
> + */

Nit: this comment is redundant now. I guess you can remove this when
applying.

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

> +static DECLARE_RWSEM(luo_session_serialize_rwsem);
> +
>  /**
>   * struct luo_session_header - Header struct for managing LUO sessions.
>   * @count:      The number of sessions currently tracked in the @list.
[...]

-- 
Regards,
Pratyush Yadav

