Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1735F588C2
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ZK98ieIRG457WI8zfD0fDHqFblKktpbnpJAvLDPkbM=; b=26A4elUbwej05u20m07N7G/yFT
	UZMN8ovcB+80kwD86VYGC8HD4wOvCS0MfcpAnN8P3CETYz8fk9IoDI4SaWHZ5SVQEPvhixcdpA1b8
	Sgswq9Q1GfajaM7aaKPj7cAP+Mb72dLnjC23zCw33qtWHunMxeI2yJ7yzwD9XptjhmrXmf0HQMmcB
	a+52fq+DjydQ/r7XC6GBRl8wzgdiHus77YF4PD/N8X5EwxD2kLO1MU2Hw4aibqJz80RCxUKtUrkU/
	XZSoBt2HDzHdC30boFRQvStE9dafNoXkYWLcfjb3mb0U1bskOgauDpC3RcxtwKS564G1bPU04YbR+
	Pjzpr8vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEoeC-000000070aF-1RNJ;
	Mon, 20 Apr 2026 13:26:44 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEoe9-000000070Xy-2heh
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 13:26:42 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-8ec9f099fc6so47270985a.0
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776691600; x=1777296400; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZK98ieIRG457WI8zfD0fDHqFblKktpbnpJAvLDPkbM=;
        b=ekbj1zlIELX28dunE8oqjLhgVBNqNL0t50AmZJB612GLrhJH2dZLMG0f5EfMJ3noqi
         ALyDIY7a1fjGFXwWRg6tJ8iEt/chv5T0FNsr9AqwQzp+B9/PnBcC/EzQ08f5qZvz3vrK
         DCmURf0HkrsQgtlJmT1bZbPqZUEKozbrGMJtvyIcXCudNS4kZm9yvrqtVfdrE2ikiuXr
         w8wIXKozFpXRtvbL1CIrQQ7BFMwsBSma98cil4mjKUgb6mgg92rGqpUXHCkacjHXXM1i
         zqcEFlhIke32GIA2Z2jhQEmtz67fbsGsu9BNJ+UalOEYht8yG1V4x0DFwCZvOk18pszT
         T9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776691600; x=1777296400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZK98ieIRG457WI8zfD0fDHqFblKktpbnpJAvLDPkbM=;
        b=qQf9OsUasX2dafT++ZkVbUq93cDt9JpouynvnprPhoJeeMDUEhztFf5sLwmCgmEwos
         fvzUzOdkgsXKo4qJipyWoeavlKK+mi6CMQXmHUyooW4CwWyfPznl06rFeRJPTfP5G9H9
         YAf910o1L23NtzL9iTOksi9jmUtv5moz96vdMBlekWchrmdFuO+0lwR36qpw2IMJSyTp
         dJR707qzJk0hsFtgLkZEsGXw7cm6llezr5Livxkqy7HXoz3j3jzg16H5Hg/vFgdMU8se
         tANU2h6Bc1eJEe4lf9DUIEL1tGMequGGPBN+iPbXqf3NAiZZ939Jk0vr3VKDAwcg/Nrr
         gxmg==
X-Forwarded-Encrypted: i=1; AFNElJ+qQ3HivYKtb5MkPjMK+TX/qyhtAoyVlDKC85emrZDQeNEAp8NONKJAPn8J06wwz0FBz+abag==@lists.infradead.org
X-Gm-Message-State: AOJu0YwwLWW4sVJtxA41W/KaHWVFfMeaevdRsx17ckPSAYDO+trv47Nk
	OUdJyyBJMQDOwOueqlIgUC48GhEw93ZrubetaNzhx3SxuhSHTIhVxHurVg3H7Mmvs+U=
X-Gm-Gg: AeBDievBk2I+uf3y32m1lOBockkOxfIPqK/tCJR+Jx9BFXyYNJx40/MwcxBX6Gb8qQg
	f9Le8eBiwhZdf35ZUYxyxE/wgDaP/3opFl1aac24LrQvPaoicCQa5lp7H45ss3cZINbB0t5MmH3
	FyzJXLxXS1X5iTTLdjMV1y5P2hH6lYdPaVFAIZp6gAJo8B4LQ0Ireoed7CVClwsgJeP1u+5u25j
	Vmkzhpd8eYqntqMfAzY9RsPbY5vH7PqxC4y6tJiu92dZmDAOXjiqsUvRArKPz2FYccGATgJCb1L
	CWbHTsHhaKM0NYa79FAMdqIiNN8C8f8uDdAUztjfEnaLiYPIRzKLDeYhIZi4UiZLuZRrlLrQ0CQ
	zF491necZtxOAajp9dBaclf0eiBqI3ykeiSpsBoPPIc17CMxfycPFFg/Db+7cXVlvZoEhiMNCAR
	p2H7mDKkkUiXlD0kwQ89tfB9HFqiPZIsGSV4An9WBr6C0P/rzhYutj5LQUgSi/
X-Received: by 2002:a05:620a:410c:b0:8cf:c729:a629 with SMTP id af79cd13be357-8e78fc29218mr1998016685a.20.1776691600368;
        Mon, 20 Apr 2026 06:26:40 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb61bc0d7dsm201476385a.24.2026.04.20.06.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:26:39 -0700 (PDT)
Date: Mon, 20 Apr 2026 13:26:38 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH 1/5] liveupdate: Remove limit on the number of sessions
Message-ID: <ttirtg6trmvhuaubix4ufhv2i7vl37n3ef5rgkpxp56nvfvwmt@ehghcskmjqzo>
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
 <20260414200237.444170-2-pasha.tatashin@soleen.com>
 <aeXSEe9Bo-vsSkMH@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeXSEe9Bo-vsSkMH@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_062641_705959_7DEC40DE 
X-CRM114-Status: GOOD (  35.53  )
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

On 04-20 10:13, Mike Rapoport wrote:
> On Tue, Apr 14, 2026 at 08:02:33PM +0000, Pasha Tatashin wrote:
> > Currently, the number of LUO sessions is limited by a fixed number of
> > pre-allocated pages for serialization (16 pages, allowing for ~819
> > sessions).
> > 
> > This limitation is problematic if LUO is used to support things such as
> > systemd file descriptor store, and would be used not just as VM memory
> > but to save other states on the machine.
> > 
> > Remove this limit by transitioning to a linked-block approach for
> > session metadata serialization. Instead of a single contiguous block,
> > session metadata is now stored in a chain of 16-page blocks. Each block
> > starts with a header containing the physical address of the next block
> > and the number of session entries in the current block.
> > 
> > - Bump session ABI version to v3.
> > - Update struct luo_session_header_ser to include a 'next' pointer.
> > - Implement dynamic block allocation in luo_session_insert().
> > - Update setup, serialization, and deserialization logic to traverse
> >   the block chain.
> > - Remove LUO_SESSION_MAX limit.
> > 
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kho/abi/luo.h      |  19 +--
> >  kernel/liveupdate/luo_internal.h |  12 +-
> >  kernel/liveupdate/luo_session.c  | 237 +++++++++++++++++++++++--------
> >  3 files changed, 197 insertions(+), 71 deletions(-)
> 
> ...
> 
> > +/**
> > + * struct luo_session_block - Internal representation of a session serialization block.
> > + * @list: List head for linking blocks in memory.
> > + * @ser:  Pointer to the serialized header in preserved memory.
> > + */
> > +struct luo_session_block {
> > +	struct list_head list;
> > +	struct luo_session_header_ser *ser;
> > +};
> > +
> >  /**
> >   * struct luo_session_header - Header struct for managing LUO sessions.
> >   * @count:      The number of sessions currently tracked in the @list.
> > + * @nblocks:    The number of allocated serialization blocks.
> >   * @list:       The head of the linked list of `struct luo_session` instances.
> >   * @rwsem:      A read-write semaphore providing synchronized access to the
> >   *              session list and other fields in this structure.
> > - * @header_ser: The header data of serialization array.
> > - * @ser:        The serialized session data (an array of
> > - *              `struct luo_session_ser`).
> > + * @blocks:     The list of serialization blocks (struct luo_session_block).
> >   * @active:     Set to true when first initialized. If previous kernel did not
> >   *              send session data, active stays false for incoming.
> >   */
> >  struct luo_session_header {
> >  	long count;
> > +	long nblocks;
> >  	struct list_head list;
> >  	struct rw_semaphore rwsem;
> > -	struct luo_session_header_ser *header_ser;
> > -	struct luo_session_ser *ser;
> > +	struct list_head blocks;
> 
> Don't we need some sort of locking for blocks?

The rwsem right above the blocks field protects it. New blocks are only 
created when luo_session_insert() is called, which takes 
rwsem_write(&sh->rwsem).

For simplicity, once blocks are created, we never free them. This is 
safe given that sessions can only be created by a single privileged 
agent.

> 
> >  	bool active;
> >  };
>   
> > @@ -147,15 +222,6 @@ static int luo_session_insert(struct luo_session_header *sh,
> >  
> >  	guard(rwsem_write)(&sh->rwsem);
> >  
> > -	/*
> > -	 * For outgoing we should make sure there is room in serialization array
> > -	 * for new session.
> > -	 */
> > -	if (sh == &luo_session_global.outgoing) {
> > -		if (sh->count == LUO_SESSION_MAX)
> > -			return -ENOMEM;
> > -	}
> > -
> >  	/*
> >  	 * For small number of sessions this loop won't hurt performance
> >  	 * but if we ever start using a lot of sessions, this might
> 
> For ~8.1 million sessions this comment does not seem valid anymore ;-)

Fair point! However, in all reasonable use cases we expect to have at 
most hundreds of sessions, so this should still be fine. To extend on 
this: the O(N^2) complexity mentioned in the comment is really only a 
problem during restoration, which happens during our performance 
critical blackout time. However, it is used there only for sanity 
checking, if we trust the previous kernel, we can remove this 
duplication check entirely.

Let's keep this sanity check for now. If it ever becomes a performance 
bottleneck, we can remove it during the blackout time and optimize the 
pre-blackout session creation to use an O(log(N)) search by storing them 
in a sorted by name data structure.

> 
> -- 
> Sincerely yours,
> Mike.

