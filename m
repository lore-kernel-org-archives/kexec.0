Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A29EC43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 07:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1v6W6k2MU5dZ6c3Yzz6iw0lMzjubTnc25U0LLuynrUI=; b=jmjJJW9dHVwSSAeC9Yh1NG8RpH
	my2vU/GqGfCF/C3Lpick3wGDKJ/sytzZGhTEKhDmj/U/7NweOfj7uEGjuV7MR0FIJMVGc0KaEY8AM
	JXNQChjvpU0tGAIGPP0BxiKW0lhiFZUL83cKEZGym8VfOXuIqpozdufWJg2vNqkVjCLV3GSqQU6d6
	xRn1Xr5uLr5S/sYq7ZvHMO4fFzJrJYtJBxqefO9WNjuv8P+onwDM9R1Q3nrThB4g5eKZ1gytZYTbg
	BgFcT3H8hEp2UYmL6X95KcUtZ65fR1OyGlTyWKjEC1mQUZ/l93A41OIwOj32g+4i/pJey54XW8OI3
	Tns0D6HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we6Tc-0000000DuWj-3AZj;
	Mon, 29 Jun 2026 07:32:20 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we6Ta-0000000DuWL-06VJ
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 07:32:19 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8efbafa1bacso6970736d6.1
        for <kexec@lists.infradead.org>; Mon, 29 Jun 2026 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1782718336; x=1783323136; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1v6W6k2MU5dZ6c3Yzz6iw0lMzjubTnc25U0LLuynrUI=;
        b=PqKsc58ZMzDG8R18u3N+QcBI5MAUbtjq/nvS3A20OWxGr4GfFuy823vwmJSXHwolBh
         JXUl1J4JuJ5zEYqvN1X4qg4CYQo/tTuiT5eDZzWV39PNTVrI1WvntwSbDZB8ZBo5VnB8
         l34I6VPR6o5NK+uuJ/mk3CoqIobzzVp/fHme39/JhMpv0RmRivDYy4fAn1VKT/C6ImDL
         BQqCjAo2vhC/ReHBwUhzTX8DYDcFnMMPXvyWqe5oQ/kzk3GK6PuRzAeUQwT0hpq8gm9N
         D8rfxVPi2q+bkjj13wiUvpCz7Eov4DQ0L6O7Y/4KC0XH1mTBLY6z4SHIreD8gUcIrgw/
         pALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782718336; x=1783323136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1v6W6k2MU5dZ6c3Yzz6iw0lMzjubTnc25U0LLuynrUI=;
        b=V3fo3tGJkPR5AOkDIqt4l2WeoYF9hqXo7dxkf0MZTqo3Ckdlv1X4MgWHBsOlxk/90l
         ntXWKfx5rHGV37JXhd5Dk+ifjqGvZWsid+ri6MeInLhD5NyUg6DQ38/CK82jefxKyb4e
         Cirt/7JwbvlDAyOXS3wKTRetZ+innTApfPJRK6H/HGszP1idmgGnXpsSMMXehL4xC96c
         B0Ke8aPFycllJ+s92tDaCcgXNn3vIB5e8OHm9CWDgI+cYkFHUfj8ZJyPJ7cmOY1XheTm
         45Z2dIu5uFrQy4J2oCYq7au0ijfBqMe2dR2oZsn+Q/BPydX9aUW7WCg2sCLYH2cghUsO
         zSNw==
X-Forwarded-Encrypted: i=1; AHgh+RovAxd+qxxLAqO5iOn9G9iq0hMLtOoGFzBr15QKN9qhDK8B+BWVxoy3hc4LbS6Y2Ttn+o2dSg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCuZRqDSCXvG6Wt39U9WTvgVwaCETWQPQheQ4Nn/onAHC/YsA1
	RRIkYfrmIMgb3f6sXzuokAJKvEJuThHn9/UKvYkIE73MzpIlStZ6jP/R0W6KbrO+kTw=
X-Gm-Gg: AfdE7ck61hD5CN5gxKDW9jg0bvukXdgu30au+0ThRZBvTgvaZBpuPWVbATd4fNuDUsI
	PZc0CCWeoUH0gF2XSv4nbnzOvkVjcMd74csd48pCIHliU+yzLhBJtrhGKF2LO6KcgvQz6jdIafH
	yxOqg+Y+fRqezDDFUxxfABGd/w8LZ2toHJXvLQqNCk1UsVlfzb+aQlA6XI7I4gVigl8xCF2dVYD
	KTngDeRnqGiiiOsveWMeMZ+UxESD+gDTm61ZuS0Z++J7T/Vf8rIurBQ9W5b4aRIOHIraUwzZOLO
	rqelofB1CBPqJc/ev1p+zFzmF/f97la8JHLfiKC20RmEizsy8yVlBwj2l83r2XueDq/e4Fbtg54
	pSeWES29rVBkdJG8RgnjLsVRgYvNPte0Gx1IrPLTJmcD0JsUQ3HXZZpo1Y9FY472VHrZPRTL3lJ
	qpOlDCd9isSwQ5ofbWcGfQ5LZJh4dC5D9T4EksHCy1
X-Received: by 2002:a05:6214:6010:b0:8e9:f5de:d5c2 with SMTP id 6a1803df08f44-8e9f5ded9b5mr130841736d6.57.1782718336450;
        Mon, 29 Jun 2026 00:32:16 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef55c2a4c2sm47392796d6.10.2026.06.29.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:32:15 -0700 (PDT)
Date: Mon, 29 Jun 2026 07:32:14 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, "open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add internal APIs for file
 preservation
Message-ID: <akIask9nPTEAhd76@plex>
References: <20260613012521.835490-1-skhawaja@google.com>
 <20260613012521.835490-2-skhawaja@google.com>
 <2vxzwlvljyzs.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzwlvljyzs.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_003218_086038_22AE83D7 
X-CRM114-Status: GOOD (  37.96  )
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

On 06-26 13:57, Pratyush Yadav wrote:
> Hi Sami,
> 
> On Sat, Jun 13 2026, Samiullah Khawaja wrote:
> 
> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > Live update orchestrator file handlers depend on the preservation of
> > other files. To make sure that the dependency is preserved, the file
> > handlers needs to fetch the preservation token of the preserved
> > dependency. Similarly during restore, a file handler wants to fetch the
> > restored file of the dependency.
> >
> > Add APIs that allows fetching token of dependency during preservation,
> > and fetching the restored file dependency during restore.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> 
> We discussed this once already on a call, but I'll write my argument out
> here for everyone else to get a say as well.
> 
> While it isn't obvious, this patch implicitly defines a part of the uAPI
> for live update. This patch says to VMMs (or other live update users)
> that "you can restore dependent files in any order". That is, VMMs
> don't have to restore the files in a topological sort order or
> dependencies, they can do so in any order and the kernel will manage the
> dependencies on its own.

Avoiding a forced dependency ordering is a deliberate design choice in 
LUO, to avoid any kind of circular dependeces: A depends on B, B depends 
on C, and C depends on A.

To achieve this, LUO provides the .can_finish() callback. So, LUO does
two-phase verification:

1. It iterates through all tracked files and invokes .can_finish().
2. Only if *all* files return success does it proceed to invoke .finish().

If a VMM restores a file (such as guest_memfd) but fails to restore its
dependency (such as the VM FD), or attempts to close the session 
prematurely, the .can_finish() check for that file will fail (returning 
-EBUSY), and the entire finish sequence will abort. This guarantees 
kernel-enforced correctness at the session boundary and without forcing 
the VMM to execute restores in a strict sequential order, which anway 
would not make  any sense from kernel side due to circular dependecies 
issue, where topological sort does not exist.

> 
> But on the preservation side, VMMs still do need to follow the
> topological order of dependencies. Because if they don't, the
> liveupdate_get_token_outgoing() call will fail and preservation can't
> proceed.

Actually, preservation can also be performed in an order-independent manner.
While a handler can call liveupdate_get_token_outgoing() during .preserve(),
it can also defer this query until the .freeze() callback. Because .freeze()
is invoked after all files in the session have completed their .preserve() phase,
all dependency tokens are guaranteed to be available, completely eliminating any
topological ordering requirements during the initial preservation calls. It is
up to individual file handler implementations to decide whether they wish to
enforce ordering at .preserve() time or defer it to .freeze().

> In simple words, if file type A depends on file type B, VMMs always need
> to preserve B before A, because A's preservation will try to find B's
> token, and if B is not preserved that will fail. On the _restore_ side
> though, liveupdate_get_file_incoming() implicitly retrieves the file so
> the VMM can restore then in any order.
> 
> I don't like this for a couple reasons. First, this makes the API
> asymmetric. If the VMM needs to manage dependency order during
> preservation anyway, why not do it on retrieve as well?
> 
> Second, the API is easier to misuse. The VMM can restore A but not B,
> and then close the session. It will go on its merry way never knowing it
> did something wrong. For example, guest_memfd depends on its VM FD. With
> this patch, LUO will allow restoring guest_memfd without restoring the
> VM FD. This makes the guest_memfd practically useless. Yes, it is a bug
> in the VMM anyway, but if guest_memfd restore was denied, then it would
> be easier to catch.
> 
> The kernel will keep itself safe in either case, but it will make the
> API harder to misuse. And you can always _relax_ the ordering
> requirement if there is a need in the future, but you can't go the other
> way round.
> 
> So that's my question: do we enforce restore ordering? The code change
> should be relatively simple. You just need to fail if the file is not
> already restored in liveupdate_get_file_incoming().
> 
> In either case, please at least add a piece in the documentation about
> this ordering. We should not leave it implicit.

As explained above, the .can_finish() callback addresses this problem 
and prevents any misuse (such as closing a session with a missing VM FD 
dependency).

That said, I agree that these ordering semantics, deferred verification 
model, and the exact roles of .can_finish() and .freeze() should not 
remain implicit. It makes sense adding details to the documentation to 
clarify this behavior.

Pasha

