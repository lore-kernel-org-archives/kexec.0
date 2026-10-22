Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AA9606A31F
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3rpC7Tf4;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=Ri4ujepF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LS+EicQQq2YSXAcv/CHPjd9x8RnM4wjQksgtpzHAKuY=; b=3rpC7Tf48Cc/BFFcJAEeYIsq3s
	JLL6PqeaglmG5jvF8wmd3dRBxWn4ewgQhAvGK0bwK74flXn9bStD8VzRpTbFZicylpJEirdmAuX3u
	nWArtizKnZJlsHYqePzFhCQhn3TlvEFH6GwWugjKx43jBqOYVOcUBSTIk24tE/Xg8rXvKXmG8Q8d2
	YWdW64VHotnaluiy0/cPR27vWfxXlBHMUgHCveb8l2DDUP3vMe4gZ/pfZae/xflMDaEZWEW1PhDNA
	dL97xbD77SCLF5WpvQtWMn2tvrNPxcGf6+Q0+OyI6hkmENW/hDH2CTEnHS5rh069GI/MUmAprn/ns
	xBlrN26A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJhrZ-0000000D9Zj-2LPf;
	Thu, 22 Oct 2026 01:45:01 +0000
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJhrW-0000000D9Z5-3p91
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 01:45:00 +0000
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-98c78660542so876453241.1
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 18:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792633497; x=1793238297; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LS+EicQQq2YSXAcv/CHPjd9x8RnM4wjQksgtpzHAKuY=;
        b=Ri4ujepF/d4XyLG9xgv1EzwGCaQ0uhX9WfCIZCKPdqNgq4tRjh0aqZncKyiYticDmW
         hI5v2BXKvnELigmtgJhMVQI6fKCO28Fy9zpAZneH0wkpEOGAgi8jAson2tNmoU847ofI
         dib2/SsL7dukuPkc+xbdMEYL1kNq2QvyOaqGAKzncLmVpy1OSVyZyQnPoKNv04jzG4TZ
         ik30Fn9PLjNfWpaokHKtWM/7g9V84NJECiIQPo15je6kSDB9nwZsq012LtP+p/ooxU7k
         ejkllOb9Z4d/cyaMgvON9kTeUBzEsmohfwXLSjJBJFG5X4TdNrRc6OCABPTlYqo7EKE0
         EQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792633497; x=1793238297;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LS+EicQQq2YSXAcv/CHPjd9x8RnM4wjQksgtpzHAKuY=;
        b=sFDFfhZmTIArzlVof1qp1Yt6+af+hGo0wafmmpaC1l/dZGfM+ApjuQnkxwKpXiOzTt
         +moZmUUtj17BuWsZ0qhRPCCtfJWJJQ5efzKl7JACCFE03NJMTVxCbe0P27MPDpmyZBzk
         ipd+YuZqd3dMrGCzGJ55WZlLDfObQXmsbxccg+gXptDMeg4OoMOh3zIdHhCN5herJ2Ox
         AH8rHqbD/ogK1kDlJccj++ryPwYXa8ZYUcUGa5eIfxW6fy2TgqXCjt9/n8wRxHASWfma
         buXIzOyMTmLP9biDo7wQ7RkkSgXAHXlQ7a8INotKrfBb7vSka54ERcK+v1rATnsuD7Wk
         FEqA==
X-Forwarded-Encrypted: i=1; AKwUvBx/CmRxKPeYavoW6l9evx+If2qFinBZ/YOVRQU4F/T9DvGDoGrYoj1XqGHiPwBRLcy0+HVMrQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKiAKILMBQzKQECiGPMrCGSwwPHDZmiDg8AnFxyhKVFogAJfn7L
	0Jj3/A6A4Aj+7/QFzFgphh479JsjjcT5kTyP0xJGYGPAtwarcZRwW2iTnF4zZDdW37k=
X-Gm-Gg: AYBFou2J0RjKXKvlk1l1TnXa5jhh/fqxdua+c4cX3shEt9D7N/jg+kkbYkRsYDZk1wy
	wUs3CsvLpHsqYxhS6VDYElLfBmtMgqKLUy2Wf7MoQcfNn0NGFTP3O1UR18YtL+BZ31y2oOm5Yh7
	Qt2U0v+OWT8O5ULvhz3lb7/t9cO4ZAGUPjiInl/sFygbjURwCJP/rWF1iyQc3uSWTcVeSRaTmN9
	aI63gdWoC7lIxZNFWqbj9WFA2bXDYd5TxI8CXe2+o4Pp/nbB/BbNaCFn2WLy6tabDISjp5hUbca
	UGLPZj9RPuU8C0y8ItLAf6jXCumlzGFJfbFygclq7KjqM6oSWL1DiGp5tlOuXTqsubtslO6MT++
	ULHR1Eq2nJwQd8N7BNABb7P3tllkNszXywC/c3VyhC47tPjYyCOMa5ehLo1azCKwyshut2bUpH5
	3gcB35jSz+w3eoMEYEUfeH9Du7BsBWy1VJax59ixFreZXA3TBtBFkggjSaY0+Wg3swoQ/P4rfha
	xV89K3eLCdAyu8wIvw6akzOotl792Urr7zz6frcYTq1yLBkg6AG+9tS/jrb5S60R43QJEt6aYiN
	sj6JXroQOJPCkQ/dR9yeh8BR9uqoVucnIH8YNU19VKeSGgPRj6Sh8xWW3RKTfHuZ1S1qMosziSr
	Xbw==
X-Received: by 2002:a05:6102:418a:b0:7be:25d4:7ff0 with SMTP id ada2fe7eead31-7cc92469ecdmr1660230137.4.1792633497085;
        Wed, 21 Oct 2026 18:44:57 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d104017bsm4933026241.4.2026.10.21.18.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:44:55 -0700 (PDT)
Date: Wed, 21 Oct 2026 21:44:55 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com,
	linux-kernel@vger.kernel.org, dmatlack@google.com,
	kexec@lists.infradead.org, graf@amazon.com
Subject: Re: [PATCH v2 1/2] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
Message-ID: <atlql8V0YcXGRxS3@google.com>
References: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
 <20261020144710.4154339-2-pasha.tatashin@soleen.com>
 <2vxz4iefgy36.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz4iefgy36.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_184459_000231_7C9E81A9 
X-CRM114-Status: GOOD (  26.20  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-21 12:14, Pratyush Yadav wrote:
> On Tue, Oct 20 2026, Pasha Tatashin wrote:
> 
> > Currently, LUO sessions are frozen automatically only inside the
> > reboot(LINUX_REBOOT_CMD_KEXEC) pathway, where luo_session_serialize()
> > iterates through all outgoing sessions under global write locks and
> > freezes them serially during shutdown. Allowing userspace to decide when
> > to freeze a session once it is done with it (and to freeze multiple
> > sessions in parallel, since luo_session_freeze() only acquires the
> > per-session mutex) avoids postponing this work to kexec shutdown and
> > reduces blackout time.
> >
> > Introduce LIVEUPDATE_SESSION_FREEZE on session file descriptors to freeze
> > a session early. The ioctl runs .freeze() across all preserved files in the
> > session and serializes their metadata. Once frozen, no additional files can
> > be added to the session, and subsequent freeze calls return -EBUSY. Freeze
> > is only valid on outgoing sessions and returns -EINVAL on incoming ones.
> >
> > During kexec, sessions that were already frozen early are skipped, while
> > sessions that did not invoke this ioctl auto-freeze as before. If an
> > early-frozen session is released before kexec, its files are rolled back
> > via .unfreeze() before being unpreserved.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> [...]
> > @@ -218,18 +219,33 @@ static int luo_session_finish_one(struct luo_session *session)
> >  	return luo_file_finish(&session->file_set);
> >  }
> >  
> > -static void luo_session_unfreeze_one(struct luo_session *session,
> > -				     struct luo_session_ser *ser)
> > +static void luo_session_unserialize_one(struct luo_session *session,
> > +					struct luo_session_ser *ser)
> >  {
> >  	guard(mutex)(&session->mutex);
> > -	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
> > +	if (!session->frozen)
> > +		luo_file_unfreeze(&session->file_set);
> 
> "Wait, this looks wrong. If session is not frozen then unfreeze it?
> Should be the other way round, right?"
> 
> This was my first reaction until I realized that you only unfreeze
> _automatically_ frozen sessions. User-frozen sessions stay frozen. Which
> makes sense, but is not obvious at all.
> 
> Perhaps rename this to session->user_frozen and add a comment here?
> 
> With that fixed, feel free to add
> 
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thank you, I am going to send out a new version soon.

Pasha

> 
> > +	memset(ser, 0, sizeof(*ser));
> >  }
> >  
> > -static int luo_session_freeze_one(struct luo_session *session,
> > -				  struct luo_session_ser *ser)
> > +static int luo_session_serialize_one(struct luo_session *session,
> > +				     struct luo_session_ser *ser)
> >  {
> > +	int err;
> > +
> >  	guard(mutex)(&session->mutex);
> > -	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
> > +	if (!session->frozen) {
> > +		err = luo_file_freeze(&session->file_set);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	strscpy(ser->name, session->name, sizeof(ser->name));
> > +	ser->file_set_ser.count = session->file_set.count;
> > +	ser->file_set_ser.files =
> > +		kho_block_set_head_pa(&session->file_set.block_set);
> > +
> > +	return 0;
> >  }
> >  
> >  static int luo_session_release(struct inode *inodep, struct file *filep)
> [...]
> > @@ -267,6 +286,9 @@ static int luo_session_preserve_fd(struct luo_session *session,
> >  	int err;
> >  
> >  	guard(mutex)(&session->mutex);
> > +	if (session->frozen)
> > +		return -EBUSY;
> > +
> >  	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
> >  	if (err)
> >  		return err;
> > @@ -340,11 +362,40 @@ static int luo_session_get_name(struct luo_session *session,
> >  	return luo_ucmd_respond(ucmd, sizeof(*argp));
> >  }
> >  
> > +static int luo_session_freeze(struct luo_session *session,
> > +			      struct luo_ucmd *ucmd)
> > +{
> > +	struct liveupdate_session_freeze *argp = ucmd->cmd;
> > +	int err;
> > +
> > +	if (argp->reserved)
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&session->mutex);
> > +	if (session->frozen)
> > +		return -EBUSY;
> > +
> > +	err = luo_file_freeze(&session->file_set);
> > +	if (err)
> > +		return err;
> > +
> > +	err = luo_ucmd_respond(ucmd, sizeof(*argp));
> > +	if (err) {
> > +		luo_file_unfreeze(&session->file_set);
> > +		return err;
> > +	}
> > +
> > +	session->frozen = true;
> > +
> > +	return 0;
> > +}
> > +
> >  union ucmd_buffer {
> >  	struct liveupdate_session_finish finish;
> >  	struct liveupdate_session_preserve_fd preserve;
> >  	struct liveupdate_session_retrieve_fd retrieve;
> >  	struct liveupdate_session_get_name get_name;
> > +	struct liveupdate_session_freeze freeze;
> >  };
> >  
> >  /* Type of sessions the ioctl applies to. */
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

