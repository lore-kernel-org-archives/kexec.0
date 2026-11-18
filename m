Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4203F606A89A
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eNYZMmaj;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Z0hKLUbx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=w3JSCXNwcogBu1PJnd6LhkuPj4w6tsB9fs1YwGA31yI=; b=eNYZMmajM1Oiow
	zMSY8QuWn++LHmAwJmqbynzz9C1YliG4DBCrLGfZrPItrL38yPIgoKHse9pbVCm6yBcJpa8Q6vKIk
	aDnCCqjWYin9B5KZVgrGC0YrZL/W8snJp0amal/WW0HXjsIiiEuWWyq+Is00JKL/twiV3flXNhqly
	dBz7x6iMhqTVtDjubNgKbB9Mmz1fppZmmwEuReGVkPIMVtWgzFeXcvJ7cIsCYYTR6peSwmjHOxq15
	fqVL/0amB5tDthwvdHkxITQLl+zs4y6x9WRsMZUoOjSoEbfvudUPXIgdR6/K6GRXNY6Y9YxWMvCTb
	kfNRJWqx/+AqeZyYCP0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUUS-00000007S6V-47z3;
	Wed, 18 Nov 2026 01:29:36 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUUQ-00000007S5Z-21j6
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 01:29:36 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2eac4936dfdso607025ad.2
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 17:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794965374; x=1795570174; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w3JSCXNwcogBu1PJnd6LhkuPj4w6tsB9fs1YwGA31yI=;
        b=Z0hKLUbxgdxUppp4EepjknuKXC1w0VkarHHVx9pG3pOhOpqjrsZM6cXwnrZD6sVE5r
         WCjNaklinLbTerWQojqUCDK45le/SVrPKdGoAy6AVPM9v8NH/Votg4+QZ4jgZZgur/yx
         GJBJ182YGN1PNmYBV87luZGr6WpW3GOEU7nWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965374; x=1795570174;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3JSCXNwcogBu1PJnd6LhkuPj4w6tsB9fs1YwGA31yI=;
        b=WMNz2xKf58TyzPz0ikOZhi3z9E1uGj3wA9IHsRCRJio6kvnqbH3ExlrUmTSkCW04T0
         d+B7Zfuzpl7gAgufn4nLkILz1UInLOKufvQP2bh0P/ZGnnhfjg5B6q+DtNfiI8Ssmya0
         a3A7xeIudsCPcDmaiabDnIfjeG26sBED213TKVtcvlcx4d4JbqyhJH3/U3i5sq/6DNa/
         LpO1kfyMXhclbxF772ZquFDtRm6YlJoORey7w5JmURtS4FlWI53wSqJiipqzozaqq4xd
         JufEW0rkE0r0G8xaPRZavWikhkMV7o89NSVh3b5/ASpAtnMmU+9INVsM8IEL65RcgSuQ
         qN2Q==
X-Forwarded-Encrypted: i=1; AL+hErH/FOlS/GQAAG8vHvhC4Row31nr0JfxHVgSwtPazbOUFWB/D2BMVWzqzpIUpIsWib3wuSk0aQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z9RC7SEEtCF0DLDLxRH18D044pKs8foEHLWwfKQ1FT4zd4NLNjP
	EyM+PEf2swWYUroYrwxr2m3ru83jn7Lps3lxpvx+FcWtzoLH35OziaZg9zEJTQQvnQ==
X-Gm-Gg: AZFdTZcEJt4RmoT3DEJ/0x1f3b2HczGR7XPsxs9LN9QeD1KVOCDteOOgMpiZTcIcpWY
	duFk4y/29ZN1S3AAwVyD+B/zEtY7n16XPytsGbD7uq3kuvTBp+aqKa4+hlDgYtjE068PBoit8ih
	I8ho7sffm9sC0zL4/EYFBjRGWWaOfwhCX5gIzdFC6t58DNLqXeUNF8EehxLiCMy2L8du3YXxPUN
	AkADlMW6AiZfMh6vCMhGiZhZlZosaSRGAUs43vEPcgiBIEIyCRhuZZK2y3XgkNkfoT6qgKTkZz0
	+uS+UbnJCZZNR5MIKOjVWn0BbETmDMwYVCLrHC5MXnTiyd297Tcl3wD6ouC/pge8e0q1G+efTTg
	ly1nxR7CtQvcB6IEqjMrGMQOnlhfYS98TGAoKPslaYVi75g5HVgfQdw1LjW5agj2YUo11tfPTgP
	GIzufHZMDi/vWL6Mtb0xD75nG6CB0ekhygm9aPEOSmPE9CM3fmnc/tKk1fOIh4c8/hToCxGQ1EF
	fasY2ov2Ts/o9C/6zoeI4CJsBjero71PJ1GqIge+ma7eTxatcCvdaRlAfHT2F9guZy/BMda4ND1
	5pjolG+Xk8HHwuCqIOF9GHxJIXxO0j+oC/sxfsJigJMfMRBbzq5rkEDwsUBqRc9yfdUiTHVWG3X
	6QQnVYWA7rXSD57Zc
X-Received: by 2002:a17:903:3bd0:b0:2ef:eadc:5c98 with SMTP id d9443c01a7336-2eff6f86b0emr15976975ad.0.1794965373725;
        Tue, 17 Nov 2026 17:29:33 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2eff5ed09b4sm4409835ad.9.2026.11.17.17.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 17:29:33 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kexec@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/7] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Tue, 17 Nov 2026 17:29:29 -0800
Message-ID: <20261118012929.290499-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <avwp1ZpVudiT1Gux@gremlin>
References: <20261116230627.3537051-1-jeffxu@chromium.org> <20261116230627.3537051-6-jeffxu@chromium.org> <avwp1ZpVudiT1Gux@gremlin>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_172934_531452_53A83B1A 
X-CRM114-Status: GOOD (  14.29  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 10:21 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> This commit message is just inscrutable. It's like reading Finnegan's Wake :)
> LLMs are obscenely terrible at this stuff unfortunately.
>
> You seem to have rewritten commit messages for the other patches, could you do
> the same for this one? Thanks.
>
> > Link: https://lore.kernel.org/r/20260519-panthor-kasan-v2-1-b7384458f076@gmail.com/ [1]
> > Link: https://lore.kernel.org/r/20260521105148.5497c281@fedora/ [2]
> > Assisted-by: LLM
>
> This tag isn't used any longer! Thanks for acking LLM usage though, we prefer
> you disclose it but in the commit message or the cover letter etc.

Fair point -- looking at patch 5 again, it is way too wordy. I will
rewrite it concisely from scratch for v2, and drop the Assisted-by:
tags (keeping the note in the cover letter).

Thanks for the review!
Jeff

