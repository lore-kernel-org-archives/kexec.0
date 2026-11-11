Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE14606A89A
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dZ7ncOfp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRTKSDiY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=T9XWDjq0ioHgocmsF6DKb1AFT/UmRmoe7A2ABC70YKo=; b=dZ7ncOfpj9UVJD
	hDOefn3YuW/BrhdJH+8S2VyrnzEzw8Dj6SdvkLkHNTIMPMexx1Ra+Lc5bpw8LBePRCp6oUnF3ZyNl
	Gc8hLRslQp1SUKY+y/nSPrXv75zYY+mI7grDMFNqT2G2jD11vzeTZKFbQDBZf4skX4558jUzAKvQ9
	zamzX5/CiGPlCxvPuNz7wEsufNmqEcns/mHDJH6LmW/cn4SU+CrnH+AYcUjiAFMI6vtir8uI1rDyd
	eNdiZQ+C9EEnrLv919KCML5lQbdcY0ZPdDKfd+crfoqUv6M9BcSTfOwOhRYZQ9aHU2utoG3wfJsKn
	+efQPqkTHw0dnUJ3f8nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6Ly-00000006Sya-13sE;
	Wed, 11 Nov 2026 11:18:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6Lw-00000006Sxh-1dxD
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 11:18:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D34936387E;
	Wed, 11 Nov 2026 11:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B3F1F00A06;
	Wed, 11 Nov 2026 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794395935;
	bh=T9XWDjq0ioHgocmsF6DKb1AFT/UmRmoe7A2ABC70YKo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VRTKSDiYZdByh6uiuUNwozMVTYOxfWNlBzOoBemFkGUBxVZpz45UtO87gSOGn3PGX
	 ghEmEWSVdkyuR1G/Gt+0EYjnd6HiUfcZjGAj4nKxgoOD5Z1QRH5y1LVXrpAbxi9aRA
	 NnjsYN4qgZhn0/zCduEaiGp7q3G99X5weN0ql0QsH36+BOyhTzgxpquwaQSaJ8Bj27
	 KSG03IFuB7Jd73YBLWR+keQoU5SqoIyUCCnWoZln8vehx79T0m5j0hCeKsSS6vRSHq
	 vTzGfcRM6onZM2U5/p8a82qZsFabQYEaG+llDxAbK0xygrVvePcXoUVEgLQN3nCwL3
	 yMsFtQ9R7DrZA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/6] liveupdate: luo: serialize sessions via
 per-session publish helper
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 linux-mm@kvack.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
 vipinsh@google.com, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261105050053.3063001-4-pasha.tatashin@soleen.com>
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
 <20261105050053.3063001-4-pasha.tatashin@soleen.com>
Date: Wed, 11 Nov 2026 13:18:40 +0200
Message-Id: <179439592040.425130.1571434550510654411.b4-review@b4>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> With incremental kho_block publication in place, LUO sessions can be
> published into sh->block_set individually as they are committed, rather
> than rebuilding the entire session serialization chain during reboot.
> 
> Currently, luo_session_serialize() resets *sh->sessions_pa and
> serializes all outgoing sessions from scratch in a single pass at reboot
> time.
> 
> Introduce luo_session_publish_one() to append a session's
> luo_session_ser entry via kho_block_set_it_append() and move the session
> onto sh->published_list. Update luo_session_serialize() to freeze all
> remaining unpublished sessions first (rolling back via
> luo_session_unfreeze_one() on failure) and then publish them in a second
> pass.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_session.c | 92 ++++++++++++++++++++++-----------
>  1 file changed, 63 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 6dea359111818..caf0e85081e87 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -103,20 +103,30 @@
>  static DECLARE_RWSEM(luo_session_serialize_rwsem);
>  /**
>   * struct luo_session_header - Header struct for managing LUO sessions.
> - * @count:       The number of sessions currently tracked in the @list.
> + * @count:       The number of sessions currently tracked in the header.
> + * @published_count: The number of outgoing sessions currently published in
> + *                   @block_set.
>   * @list:        The head of the linked list of `struct luo_session` instances.

Add "yet unpublished" to the description?

> + * @published_list:  The head of the linked list of published outgoing
> + *                   sessions, ordered identically to their entries in
> + *                   @block_set.
>   * @rwsem:       A read-write semaphore providing synchronized access to the
>   *               session list and other fields in this structure.
>   * @block_set:   The set of serialization blocks.
> + * @it:          Iterator tracking the next slot in @block_set for outgoing
> + *               session serialization.
>   * @sessions_pa: Points to the location of sessions_pa within struct luo_ser.
>   * @active:      Set to true when first initialized. If previous kernel did not
>   *               send session data, active stays false for incoming.
>   */
>  struct luo_session_header {
>  	long count;
> +	long published_count;
>  	struct list_head list;
> +	struct list_head published_list;
>  	struct rw_semaphore rwsem;
>  	struct kho_block_set block_set;
> +	struct kho_block_set_it it;
>  	u64 *sessions_pa;
>  	bool active;
>  };
> @@ -134,12 +144,14 @@ struct luo_session_global {
>  static struct luo_session_global luo_session_global = {
>  	.incoming = {
>  		.list = LIST_HEAD_INIT(luo_session_global.incoming.list),
> +		.published_list = LIST_HEAD_INIT(luo_session_global.incoming.published_list),
>  		.rwsem = __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
>  		.block_set = KHO_BLOCK_SET_INIT(luo_session_global.incoming.block_set,
>  						sizeof(struct luo_session_ser)),
>  	},
>  	.outgoing = {
>  		.list = LIST_HEAD_INIT(luo_session_global.outgoing.list),
> +		.published_list = LIST_HEAD_INIT(luo_session_global.outgoing.published_list),
>  		.rwsem = __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
>  		.block_set = KHO_BLOCK_SET_INIT(luo_session_global.outgoing.block_set,
>  						sizeof(struct luo_session_ser)),
> @@ -186,6 +198,10 @@ static int luo_session_insert(struct luo_session_header *sh,
>  		if (!strncmp(it->name, session->name, sizeof(it->name)))
>  			return -EEXIST;
>  	}
> +	list_for_each_entry(it, &sh->published_list, list) {
> +		if (!strncmp(it->name, session->name, sizeof(it->name)))
> +			return -EEXIST;
> +	}
>  
>  	/*
>  	 * For outgoing we should make sure there is room in serialization array
> @@ -203,6 +219,42 @@ static int luo_session_insert(struct luo_session_header *sh,
>  	return 0;
>  }
>  
> +static void luo_session_publish_one(struct luo_session *session)
> +{
> +	struct luo_session_header *sh = &luo_session_global.outgoing;
> +	struct luo_session_ser entry = {};
> +
> +	lockdep_assert_held_write(&sh->rwsem);
> +	lockdep_assert_held(&session->mutex);
> +
> +	if (!sh->active || !sh->sessions_pa)
> +		return;
> +
> +	if (!sh->published_count)
> +		kho_block_set_it_init(&sh->it, &sh->block_set);
> +
> +	strscpy(entry.name, session->name, sizeof(entry.name));
> +	entry.file_set_ser.count = session->file_set.count;
> +	entry.file_set_ser.files =
> +		kho_block_set_head_pa(&session->file_set.block_set);
> +
> +	/* This should not fail normally as blocks were pre-allocated */
> +	if (WARN_ON_ONCE(!kho_block_set_it_append(&sh->it, &entry)))
> +		return;
> +
> +	if (!sh->published_count) {
> +		/*
> +		 * Ensure the first block header and entry are visible before
> +		 * publishing sessions_pa to concurrent KHO readers.
> +		 */
> +		smp_store_release(sh->sessions_pa,
> +				  kho_block_set_head_pa(&sh->block_set));
> +	}


> +
> +	list_move_tail(&session->list, &sh->published_list);
> +	sh->published_count++;
> +}
> +
>  static void luo_session_remove(struct luo_session_header *sh,
>  			       struct luo_session *session)
>  {
> @@ -636,50 +688,32 @@ int luo_session_deserialize(void)
>  int luo_session_serialize(void)
>  {
>  	struct luo_session_header *sh = &luo_session_global.outgoing;
> -	struct luo_session *session;
> -	struct kho_block_set_it it;
> +	struct luo_session *session, *tmp;
>  	int err;
>  
>  	down_write(&luo_session_serialize_rwsem);
>  	down_write(&sh->rwsem);
> -	*sh->sessions_pa = 0;
> -
> -	kho_block_set_it_init(&it, &sh->block_set);
>  
>  	list_for_each_entry(session, &sh->list, list) {
> -		struct luo_session_ser *ser = kho_block_set_it_reserve_entry(&it);
> -
> -		/* This should not fail normally as blocks were pre-allocated */
> -		if (WARN_ON_ONCE(!ser)) {
> -			err = -ENOSPC;
> -			goto err_undo;
> -		}
> -
>  		err = luo_session_freeze_one(session);
>  		if (err) {
> -			kho_block_set_it_prev(&it);
> -			goto err_undo;
> +			list_for_each_entry_continue_reverse(session, &sh->list, list)
> +				luo_session_unfreeze_one(session);
> +			goto err_unlock;

Why goto err_ can do this?
I really prefer to avoid error handling inside if (err) blocks whenever
possible.

>  		}
> +	}
>  
> -		strscpy(ser->name, session->name, sizeof(ser->name));
> -		ser->file_set_ser.count = session->file_set.count;
> -		ser->file_set_ser.files =
> -			kho_block_set_head_pa(&session->file_set.block_set);
> +	list_for_each_entry_safe(session, tmp, &sh->list, list) {
> +		mutex_lock(&session->mutex);
> +		luo_session_publish_one(session);

And running a loop of _publish() in _serialize() makes my bikeshedding
argument stronger ;-)

-- 
Sincerely yours,
Mike.


