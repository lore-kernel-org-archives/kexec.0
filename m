Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0994606A31E
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NgoyY1Dp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yuw/Sekv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZVDv/ifhL0pps23IxWAzGyzN5pLImGVnvohaaA3ul8=; b=NgoyY1DpP6NFAyRhA2hja5cJ8C
	AQhw00buINc2UvuOdeJxbH3vWZXOqxjcYL3/f27pcPFc/eGpcK8LWOX6q5L/drUrr2rMalcsA/Ll5
	GwplSIXFUcviWtanS/Ru0ib/xREP/UdKXlCM7ROa8kpHyjnoQrRzfV696agYxTKGX7hllMGBxp4tt
	O+nUIItl3UM77SIKhsYBlFlRSMIZcqGat1qPQuuCXXWDRWxy8syCR533GJISuQ48xuEg+oC5TodrW
	lZ7/udIwz/JBDFGHUfQi3e5TaHsq25/RoQUrh170Qvl2xf4hv6kpXUcBD8dxP2Hfme2R5JrgKROkT
	3OesMEsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTKl-0000000Ba6P-1exG;
	Wed, 21 Oct 2026 10:14:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJTKj-0000000Ba5v-45VU
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 10:14:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 477D3402B5;
	Wed, 21 Oct 2026 10:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066A21F000C9;
	Wed, 21 Oct 2026 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577649;
	bh=LZVDv/ifhL0pps23IxWAzGyzN5pLImGVnvohaaA3ul8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Yuw/SekvpA8wouPa4hXTPQKwya21oUto+gEM/H+kyCUI1ePM0O9xLhf64F1ydeCJG
	 EbLxMGYgsMgA32wr5KFIuEmy+ANcyot2YtVFDubrJRR6/+9bBxaNDGonlxbu7a26Mj
	 5wnShYj59Y0sQTUF8T25Dt4EMpvo2TK3nLPkOTcIH7YcOg8vSMMZrGz6PQTZxZ7L9H
	 vt9LIC9NtJHUdD/Np28olfMhroxRhdWvSQeWSWK4cZmB0fT+hZiPMniZF5vsC3g+kr
	 xHCUCftCuYkI58iO2N8teTFYWBHOFWOzLH6t03tpgXmZSKhoWe63wqTTe7Ejk4nZpj
	 cGz9F3R0PsP4w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,  vipinsh@google.com,
  linux-kernel@vger.kernel.org,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  graf@amazon.com
Subject: Re: [PATCH v2 1/2] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
In-Reply-To: <20261020144710.4154339-2-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 20 Oct 2026 10:47:03 -0400")
References: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
	<20261020144710.4154339-2-pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 12:14:05 +0200
Message-ID: <2vxz4iefgy36.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20 2026, Pasha Tatashin wrote:

> Currently, LUO sessions are frozen automatically only inside the
> reboot(LINUX_REBOOT_CMD_KEXEC) pathway, where luo_session_serialize()
> iterates through all outgoing sessions under global write locks and
> freezes them serially during shutdown. Allowing userspace to decide when
> to freeze a session once it is done with it (and to freeze multiple
> sessions in parallel, since luo_session_freeze() only acquires the
> per-session mutex) avoids postponing this work to kexec shutdown and
> reduces blackout time.
>
> Introduce LIVEUPDATE_SESSION_FREEZE on session file descriptors to freeze
> a session early. The ioctl runs .freeze() across all preserved files in the
> session and serializes their metadata. Once frozen, no additional files can
> be added to the session, and subsequent freeze calls return -EBUSY. Freeze
> is only valid on outgoing sessions and returns -EINVAL on incoming ones.
>
> During kexec, sessions that were already frozen early are skipped, while
> sessions that did not invoke this ioctl auto-freeze as before. If an
> early-frozen session is released before kexec, its files are rolled back
> via .unfreeze() before being unpreserved.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[...]
> @@ -218,18 +219,33 @@ static int luo_session_finish_one(struct luo_session *session)
>  	return luo_file_finish(&session->file_set);
>  }
>  
> -static void luo_session_unfreeze_one(struct luo_session *session,
> -				     struct luo_session_ser *ser)
> +static void luo_session_unserialize_one(struct luo_session *session,
> +					struct luo_session_ser *ser)
>  {
>  	guard(mutex)(&session->mutex);
> -	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
> +	if (!session->frozen)
> +		luo_file_unfreeze(&session->file_set);

"Wait, this looks wrong. If session is not frozen then unfreeze it?
Should be the other way round, right?"

This was my first reaction until I realized that you only unfreeze
_automatically_ frozen sessions. User-frozen sessions stay frozen. Which
makes sense, but is not obvious at all.

Perhaps rename this to session->user_frozen and add a comment here?

With that fixed, feel free to add

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> +	memset(ser, 0, sizeof(*ser));
>  }
>  
> -static int luo_session_freeze_one(struct luo_session *session,
> -				  struct luo_session_ser *ser)
> +static int luo_session_serialize_one(struct luo_session *session,
> +				     struct luo_session_ser *ser)
>  {
> +	int err;
> +
>  	guard(mutex)(&session->mutex);
> -	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
> +	if (!session->frozen) {
> +		err = luo_file_freeze(&session->file_set);
> +		if (err)
> +			return err;
> +	}
> +
> +	strscpy(ser->name, session->name, sizeof(ser->name));
> +	ser->file_set_ser.count = session->file_set.count;
> +	ser->file_set_ser.files =
> +		kho_block_set_head_pa(&session->file_set.block_set);
> +
> +	return 0;
>  }
>  
>  static int luo_session_release(struct inode *inodep, struct file *filep)
[...]
> @@ -267,6 +286,9 @@ static int luo_session_preserve_fd(struct luo_session *session,
>  	int err;
>  
>  	guard(mutex)(&session->mutex);
> +	if (session->frozen)
> +		return -EBUSY;
> +
>  	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
>  	if (err)
>  		return err;
> @@ -340,11 +362,40 @@ static int luo_session_get_name(struct luo_session *session,
>  	return luo_ucmd_respond(ucmd, sizeof(*argp));
>  }
>  
> +static int luo_session_freeze(struct luo_session *session,
> +			      struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_session_freeze *argp = ucmd->cmd;
> +	int err;
> +
> +	if (argp->reserved)
> +		return -EINVAL;
> +
> +	guard(mutex)(&session->mutex);
> +	if (session->frozen)
> +		return -EBUSY;
> +
> +	err = luo_file_freeze(&session->file_set);
> +	if (err)
> +		return err;
> +
> +	err = luo_ucmd_respond(ucmd, sizeof(*argp));
> +	if (err) {
> +		luo_file_unfreeze(&session->file_set);
> +		return err;
> +	}
> +
> +	session->frozen = true;
> +
> +	return 0;
> +}
> +
>  union ucmd_buffer {
>  	struct liveupdate_session_finish finish;
>  	struct liveupdate_session_preserve_fd preserve;
>  	struct liveupdate_session_retrieve_fd retrieve;
>  	struct liveupdate_session_get_name get_name;
> +	struct liveupdate_session_freeze freeze;
>  };
>  
>  /* Type of sessions the ioctl applies to. */
[...]

-- 
Regards,
Pratyush Yadav

