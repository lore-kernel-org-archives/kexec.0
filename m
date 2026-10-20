Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9042606A323
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Sn69km4l;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CD62I+UP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xf7TkZF3OBqfOdq3p0Xj300grOV6/XXUYozCmNJzyro=; b=Sn69km4l77PoqLxC90PfUuS0na
	GFXvDczfrGvCwRGTj60caFlUuQo6TkUd5wf4ydjiMBoUSg8fqRmpz/Q8PvhMtTn4uec/NQWphfDBq
	IutJh6P3IoiXcTq+Xg+QwDJGV10A35mUuCiT3N9O1uYfSgoOYSMTm1DtaHYG4uv515LYFIz8rES7j
	bHcU8Np4iHhchFoK1BvdBtv47Eok6FrSCCzDVOUwUER6T80khgZrHxgNCpwpmVFL3iHflUnOah2vk
	OHo6t7K9xjFdvqhvupcKOL+z4J/9tCkJ20bNwxqbwxoKJ9NdS7KIikUi5uePPffzw4EClUbEwP5+J
	SJMKnSNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJAr0-00000009wmJ-3T38;
	Tue, 20 Oct 2026 14:30:14 +0000
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJAqy-00000009wlp-03iB
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 14:30:13 +0000
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so1252821e0c.1
        for <kexec@lists.infradead.org>; Tue, 20 Oct 2026 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792506610; x=1793111410; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xf7TkZF3OBqfOdq3p0Xj300grOV6/XXUYozCmNJzyro=;
        b=CD62I+UPh0tL5apDcYM3xUwDldo9RClwdh0Kg2LqH0raMmxUpbjQCj5HpKw1rfLvDC
         OPy9rTwFNiFA0aXZUcZPrAOOaxY1qH5FJzhj5fCse/LKSqS1lhNlY6+3Ow0jXUyCZiiJ
         osHEQOofzWuF2iB4Khl1sIF2x6JziNXC22GQhsA9eqNfXXdIQqZEtMpaE6xValk3beWH
         2DSVZTK8Pa1DYD/jOgkG3xME89+qKgpxWAfSG7+N2oFGl5LAJnxZuTGkIhJt+dh/Umbl
         OnP59cG1Vq1uZQUqzfWc6yODsE04SPeLshotnDQHqjVGa0bKS9dsuH+8uUfwiJwIpW2i
         8bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792506610; x=1793111410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xf7TkZF3OBqfOdq3p0Xj300grOV6/XXUYozCmNJzyro=;
        b=tsH4i1WRLyG4KeppPKcCMLsB1ISZ9uX8yEvqezGXu0ADCzxaZgS+o4zyaQVfYMsvXZ
         uSCKe8FSJ+6LlQX8Jga/TGEFcMNltqAIReRxRHwiNeZLWH2zA27SJJBpxEK1Up+Me1l6
         7qTj3XIQ2jFbH/zah0KJiXxfGWuw9jMGy23hVN9BVJxEA+4L7vS+HhgJbNkmwzubkmFQ
         Mhp/m3nCSyySTtYSA1AldLDp+OX137xbWpTBXZhzKQREvKAOcniRpiR4SHpRJCPcLrZR
         wt6Nk0fPNcMPbyBi2RrkhhkppOtOXWcQfLre98x5SxGpBLqlYm7s99HSDMTx3znUsiTT
         wwgg==
X-Forwarded-Encrypted: i=1; AKwUvBx/ooUjmksoYfsKoo9x93prb7Fy5PVmqzHbElRXNqm2GasmL9/QIqSQih2KguxHJNELWHSa4A==@lists.infradead.org
X-Gm-Message-State: AFq9FYJvRrRtR+j+Out+5Xyy9unToXJrNLBnY6f+O1FiKcdnJ+dWzrkr
	gLf6/zHT/WfN8/dryBAJ9Vh8EgXjNZ9Ezt90wg80UsIXgakEgtDnqzDVgJyDm3weMVI=
X-Gm-Gg: AYBFou0ngpbvIBiSRMwOlIs390jh0Gc9PvKN3ITYJQoDI2d3VjqBTlnAwu3I6EbCuga
	Af2p5uvPt2CWCM6kRR7GjJh1YE+7XMRcNOhbb911n8GAwpQ6Y7cVjmvVFqgSs+XG3JT/wdzuHa1
	oGFN2NpO1fFe5LodGaLFNoABdDeBUI7Dg4I9HtmoCs9BT8kHgjQqlq62z6KU62oFdYBx3vqfV46
	7sN6jIQDehMSgP9Xrb+5h/u/qSr5sIN4lMjL1mUY/LBiFNEPFo3bqIm4GYBBcmGQW5g6NSGTGLH
	lP35+Zj8NMwEgofdSIcKB55sX3q5aQ14lAQktrHozQLgBkLMYkeVBvDaZUpaNcXHy6B/Zv3dH7H
	jDT56AE635++oaExlHuwqQ0pkXlKCGU56R0gB2k0zbbd3mVb3PmMQ6BMm8tTXv6qSawo9zP06wm
	E1cDZf/gyztiw+Py6XfnOSsrkpxFAj4HCK+24Uk4tJ44oYSTcHJ5zoBfFP2IKZ3jC2sGgW7GKPG
	ptXaPuOKFOePJ7WRQYiAiEqZ1TWBcGfdZyrfombhInP9u6dD3zbS1gmSxBPKbi67mkagxXpc1s=
X-Received: by 2002:a05:6122:20a4:b0:5ea:cc3c:9449 with SMTP id 71dfb90a1353d-5eacc3c9891mr1844327e0c.19.1792506610182;
        Tue, 20 Oct 2026 07:30:10 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eaca7cc59asm5934172e0c.5.2026.10.20.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:30:09 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:30:08 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com,
	linux-kernel@vger.kernel.org, dmatlack@google.com,
	kexec@lists.infradead.org, graf@amazon.com
Subject: Re: [PATCH v1 1/7] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
Message-ID: <atd68E5_LA9bsfeV@google.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <20261015093816.2438942-2-pasha.tatashin@soleen.com>
 <2vxz8q3shboh.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz8q3shboh.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_073012_095684_3E9CAA6C 
X-CRM114-Status: GOOD (  41.58  )
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-20 13:08, Pratyush Yadav wrote:
> Hi,
> 
> On Thu, Oct 15 2026, Pasha Tatashin wrote:
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
> > @@ -487,8 +488,10 @@ int luo_file_freeze(struct luo_file_set *file_set,
> >  		file_ser->token = luo_file->token;
> >  	}
> >  
> > -	file_set_ser->count = file_set->count;
> > -	file_set_ser->files = kho_block_set_head_pa(&file_set->block_set);
> > +	if (file_set_ser) {
> > +		file_set_ser->count = file_set->count;
> > +		file_set_ser->files = kho_block_set_head_pa(&file_set->block_set);
> > +	}
> >  
> >  	return 0;
> >  
> > @@ -501,7 +504,7 @@ int luo_file_freeze(struct luo_file_set *file_set,
> >  /**
> >   * luo_file_unfreeze - Unfreezes all files in a file_set and clear serialization
> >   * @file_set:     The file_set whose files are to be unfrozen.
> > - * @file_set_ser: Serialized file_set.
> > + * @file_set_ser: Serialized file_set, or %NULL if not serialized yet.
> >   *
> >   * This function rolls back the state of all files in a file_set after the
> >   * freeze phase has begun but must be aborted. It is the counterpart to
> > @@ -512,7 +515,8 @@ int luo_file_freeze(struct luo_file_set *file_set,
> >   * their respective .unfreeze() handler callbacks.
> >   *
> >   * Context: This is called when the live update is aborted during
> > - *          the reboot() syscall, after luo_file_freeze() has been called.
> > + *          the reboot() syscall, after luo_file_freeze() has been called,
> > + *          or when an early-frozen session is released before kexec.
> >   */
> >  void luo_file_unfreeze(struct luo_file_set *file_set,
> >  		       struct luo_file_set_ser *file_set_ser)
> > @@ -521,7 +525,8 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
> >  		return;
> >  
> >  	__luo_file_unfreeze(file_set, NULL);
> > -	memset(file_set_ser, 0, sizeof(*file_set_ser));
> > +	if (file_set_ser)
> > +		memset(file_set_ser, 0, sizeof(*file_set_ser));
> >  }
> >  
> >  /**
> > diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
> > index 64879ffe73781..b42369c3b1f30 100644
> > --- a/kernel/liveupdate/luo_internal.h
> > +++ b/kernel/liveupdate/luo_internal.h
> > @@ -64,6 +64,8 @@ struct luo_file_set {
> >   *              previous kernel) sessions.
> >   * @retrieved:  A boolean flag indicating whether this session has been
> >   *              retrieved by a consumer in the new kernel.
> > + * @frozen:     A boolean flag indicating whether this session has been
> > + *              frozen early from userspace.
> >   * @file_set:   A set of files that belong to this session.
> >   * @mutex:      protects fields in the luo_session.
> >   */
> > @@ -71,6 +73,7 @@ struct luo_session {
> >  	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
> >  	struct list_head list;
> >  	bool retrieved;
> > +	bool frozen;
> >  	struct luo_file_set file_set;
> >  	struct mutex mutex;
> >  };
> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> > index f48e9a4185f97..403906937bc0f 100644
> > --- a/kernel/liveupdate/luo_session.c
> > +++ b/kernel/liveupdate/luo_session.c
> > @@ -34,10 +34,11 @@
> >   * 1.  Creation: A userspace agent calls `luo_session_create()` to create a
> >   *     new, empty session and receives a file descriptor for it.
> >   *
> > - * 2.  Serialization: When the `reboot(LINUX_REBOOT_CMD_KEXEC)` syscall is
> > - *     made, `luo_session_serialize()` is called. It iterates through all
> > - *     active sessions and writes their metadata into a memory area preserved
> > - *     by KHO.
> > + * 2.  Freeze / Serialization: Sessions may be frozen early from userspace
> > + *     via `LIVEUPDATE_SESSION_FREEZE`. When the `reboot(LINUX_REBOOT_CMD_KEXEC)`
> > + *     syscall is made, `luo_session_serialize()` is called to freeze any
> > + *     remaining active sessions and write all session metadata into a memory
> > + *     area preserved by KHO.
> >   *
> >   * 3.  Deserialization (in new kernel): After kexec, `luo_session_deserialize()`
> >   *     runs, reading the serialized data and creating a list of `struct
> > @@ -222,6 +223,10 @@ static void luo_session_unfreeze_one(struct luo_session *session,
> >  				     struct luo_session_ser *ser)
> >  {
> >  	guard(mutex)(&session->mutex);
> > +	if (session->frozen) {
> > +		memset(&ser->file_set_ser, 0, sizeof(ser->file_set_ser));
> > +		return;
> > +	}
> >  	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
> >  }
> >  
> > @@ -229,6 +234,12 @@ static int luo_session_freeze_one(struct luo_session *session,
> >  				  struct luo_session_ser *ser)
> >  {
> >  	guard(mutex)(&session->mutex);
> > +	if (session->frozen) {
> > +		ser->file_set_ser.count = session->file_set.count;
> > +		ser->file_set_ser.files =
> > +			kho_block_set_head_pa(&session->file_set.block_set);
> > +		return 0;
> > +	}
> 
> This is getting messy. If early freeze, then you set the file_set_ser
> here, if late freeze, you set it in luo_file_freeze().
> 
> I think it is better to just set it here, and drop the code from
> luo_file_freeze() entirely.
> 
> Same for unfreeze.
> 
> Maybe also rename the function to make it clear it only runs for
> serialization? The core of serialization is done by luo_file_freeze().

Agreed, that is cleaner. In v2 I dropped struct luo_file_set_ser * from 
luo_file_freeze() and luo_file_unfreeze() completely, and renamed the 
session helpers to luo_session_serialize_one() / 
luo_session_unserialize_one() so all of struct luo_session_ser is 
populated and cleared there.

Pasha

> 
> >  	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
> >  }
> >  
> > @@ -249,8 +260,11 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
> >  		}
> >  		sh = &luo_session_global.incoming;
> >  	} else {
> > -		scoped_guard(mutex, &session->mutex)
> > +		scoped_guard(mutex, &session->mutex) {
> > +			if (session->frozen)
> > +				luo_file_unfreeze(&session->file_set, NULL);
> >  			luo_file_unpreserve_files(&session->file_set);
> > +		}
> >  		sh = &luo_session_global.outgoing;
> >  	}
> >  
> > @@ -267,6 +281,9 @@ static int luo_session_preserve_fd(struct luo_session *session,
> >  	int err;
> >  
> >  	guard(mutex)(&session->mutex);
> > +	if (session->frozen)
> > +		return -EBUSY;
> > +
> >  	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
> >  	if (err)
> >  		return err;
> > @@ -340,11 +357,34 @@ static int luo_session_get_name(struct luo_session *session,
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
> > +	err = luo_file_freeze(&session->file_set, NULL);
> > +	if (err)
> > +		return err;
> > +
> > +	session->frozen = true;
> > +
> > +	return luo_ucmd_respond(ucmd, sizeof(*argp));
> > +}
> > +
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

