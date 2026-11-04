Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC3606D80C
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IFP/PAO2;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gbIfVlux
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=76+aUQcUn4RSh9/vkGb8GrJJ6hK0vTzaCEd5JGs9ODc=; b=IFP/PAO2MXvMtDFxcOH2zuYeHK
	7lBjkMgSdhVw5IduwL3yQGgBEvLf7cA+LRCpgC7HmLVd+0l7aQ/NdVCWCMHGR5Y/5jV4jSGt46uDu
	sa+1cak7i286YBDszAkzKppMzftn91xGE2gzGPQeMukhrw4hvHyfmCmclKoiarNJviojAHxpNAOfX
	BJmCWZx13gBYA4K39XGaya7owJU9dIZVgL0nT9q7V8Czr+4KF6xqNQwIN/KlSiVpboEka9vqn9KQ4
	Ypjqs1o0ed4CJIFmQQ4iZsABg79CLPC1Rkc4Ag6mKEolPkbD67vN5nBTbRmbE9WaTmZh43gE4FeEv
	a9UNdVqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjgr-00000007Ahx-2RKn;
	Wed, 04 Nov 2026 22:42:45 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjgp-00000007AhW-0U8m
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:42:44 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8a064fac8cbso970405b3a.1
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793832162; x=1794436962; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76+aUQcUn4RSh9/vkGb8GrJJ6hK0vTzaCEd5JGs9ODc=;
        b=gbIfVlux8JEIQXi/ngiMAOXEexZiRk8ska4IAetXOi6xwJV9kIqA9mXRkOnHSwQygW
         6l7mDP4riZEGj2og4sXrqzzVXjxa/sYJlUJCp3kSkz+T+1a2yIykkauNQqSjgPJXUOrN
         WFXJinyXRsTN3qguYSXzFwpnaUfiH/1GzQgn7lXojMC7ujEChsN0NW1VIZorDphUmFgb
         HGFGGaPypcCKYt7ApdoySKVaieXno/Q3Izsqe4VymKTqu2nc+m94VNkyj8q48Mgf/Q7o
         3+GoXWtQmxN2jJHLB5SuyDxHToGdKHhs8+DYhwU2/zh3wVXXs9ExqiKmE1XUu16REi+1
         mGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832162; x=1794436962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76+aUQcUn4RSh9/vkGb8GrJJ6hK0vTzaCEd5JGs9ODc=;
        b=kQiHtVREuBp8tTdrVnLOLteNL+e8yMDUatt54ROw//cFB/X8LNCXAvzhEFK9aDKz8h
         X931KntVFi+ji8ReypVtbW+CZtTW4K3VazbY4qEEotjPzFR+Xjfbgc905Qgc2Nlxn/8x
         XMDpEfaN6HzjT2ijPYU0Z7GLnf1gtaBiXtQDSzQvyZWezdubR4kRqXumJRaFOggkyrdE
         DSMiHchIKF/P64kBkcMdUaaW+lFESRBnBJc2gLkR2eZlCcn6LjjkNkJ8c8x4Ok5+TPpV
         jVTlaVSMIKk8QLw1fZE+RWUfV8wNsxm+A3xoeOiyp3rAl9big3p4Cvm/Ri0hDSuJ3jaW
         qwNQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8qGM6L/zIBfVFUCLly/dw54YD4lLsflaiE/KyyoLM+srWUcGa82DUWx+KOUBArKbQR2F4Xg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+PlYR9oSuCEkoQnmDYsAx7Cd8cHcVTlKoVLcqcyRdXekaqLLXh
	DvLzY/uksLAhs7wV7FLOscvUXRUGehxnMH8cAm8YNEMJBbKESzYQn5x9Iw93KwYU3w==
X-Gm-Gg: AYBFou2ALxTRrbJASTBw08hkguKuQ+cUQmhzfbqLlSd6wcQEfGJQgd51CxWkGEr+VTW
	sF3LvMjUf06IxhbziBTXUj3WZw7tugufbQeXkz5O+MXc6gBkXl2EGzviIYC90FvXZdNjM/KfWKL
	2qlo50NCqBtKSVSNqOtys8bzLUYyij0PbzwFhGf0/j9dJ+dV4YRdlKCRXK6OikmxbX+ztugsLUE
	aZrCJL4cd597h1yU1hI5kSN6hihIzhVq6BFGi2o2JxCn1wQT0Hmjv3Esr/puENwXLqcbME9o3O/
	DQXdBEdT+JezQztNGWCmmNiPspKMb9rTXBsRq3YcCVbEOWimM5iR/CRgWKxfShruM//4c+KIOcP
	CP7ftRmqItyHupsiwPDOXnvYMo1pN9p61qNmKLDwyT81kPvgU8SS3ApEjyUyL3iA6pVubuAxcwq
	GxaMBRRulCaCCVkgavkDqRs7PBL29+3Dijvxw6FPu5yFdmmqlrNEQq2LBA8QCDOytioUxLkzUei
	cpdd5IUbEz0tMCuj2/Vc/9W5L98KXTXHqDnStGIO7v8a0aqi7wyMxPc/hhYXi6LdtWzsFE+NBaR
	vfhK5vCpxiN3H9oO0GWlXU1aMOtsRgf5gTXFEGkjyW7P08udIlu8Cszv+aTr4FQg
X-Received: by 2002:a05:6a00:32c5:b0:878:34d7:697c with SMTP id d2e1a72fcca58-8a9bf811624mr14694461b3a.42.1793832161677;
        Wed, 04 Nov 2026 14:42:41 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b1209b473dsm1079338b3a.36.2026.11.04.14.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:42:39 -0800 (PST)
Date: Wed, 4 Nov 2026 22:42:35 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 10/10] selftests/liveupdate: Add a test for preserving
 tmpfs files
Message-ID: <auu02-iDbVaEL-4v@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-11-dmatlack@google.com>
 <2vxz1p90jzx4.fsf@kernel.org>
 <auuJM8c-bE43NP54@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auuJM8c-bE43NP54@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_144243_169516_095B15E1 
X-CRM114-Status: GOOD (  22.22  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-04 02:37 PM, Pasha Tatashin wrote:
> On 11-04 17:59, Pratyush Yadav wrote:
> > On Tue, Nov 03 2026, David Matlack wrote:
> > [...]
> > 
> > Umm, no way I am reading all this...
> > 
> > LLMs are great at generating tests, and I'm not saying there is no value
> > in this. It is just that this massive code dump is unreviewable by
> > humans. It is also unfair to the human reviewer because it took many
> > orders of magnitude less effort to _write_ them with an LLM.
> > 
> > What do you all reckon we should do about this? Trust the LLM to get the
> > testing right? Do we give up human maintenance of tests entirely? Do we
> > do fault injection to test the tests themselves?
> > 
> > Or do we make the tests smaller and more human reviewable?
> 
> We need good test coverage, but I believe we can break this patch down 
> into smaller changes where tested features are incrementally added.

Agreed that it needs to be easier to review, but I'd like to keep the
coverage. Here's what I have in mind for v4:

 - Move the preserve-side checks that don't need a kexec into
   liveupdate.c, like Pasha suggested in his earlier reply: which files
   can be preserved (permissions, read-only and append-only files), the
   frozen size while preserved, and unpreserve. Those then run with the
   regular kselftests instead of only in vmtest.sh.

 - Split the rest of luo_tmpfs into several smaller commits that add the
   tested features incrementally, e.g. one for the test infrastructure
   and basic retrieve, one for the open() flags and creation checks, and
   one for block accounting. That makes the series longer, but each
   commit is a few hundred lines and can be reviewed on its own.

It will still be long, but I think having the test coverage is worth it.

Does that sound reasonable?

