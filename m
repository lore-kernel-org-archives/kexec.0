Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB001606B38E
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YKZoYMRt;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BHrQJosl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=45IHMvHuNfQHmQp3e/l7ZQyBPSv/bWU1s+/SnIhe5+k=; b=YKZoYMRtIxqbl5kwe948hAIBGJ
	x72mCTzSb+bYiZSkdd6KsecEQ57skaofUfGsvnnhW8PbttWH0QOlQsjjI2He+FNayDplbD3o6GOCH
	y7Coo7YlE1zy58hbNtNL199ozbCulwyO1coutcHhXDhyXnEX3KsQLlfmNbWyCLnW/1IQ3KqGzlHB2
	xmf5UrLcXmG4Hgz6DaVfQ73TOkGfGfBHbk0ZKs41l4t9WfpnOULdpg44U8mZYanaGKzwPTGA6xCQO
	YsrrMeWLQVt7lo1TLHsHnFS0/5VKN84YFEPlyfqFnblIo0Z7xtw+zs0zzbOODcZ5ZBlbZbfF/GF1P
	XdoK4oNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjV4-000000079cm-2eHy;
	Wed, 04 Nov 2026 22:30:34 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjV2-000000079cB-1rDg
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:30:33 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so538419a12.0
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793831431; x=1794436231; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=45IHMvHuNfQHmQp3e/l7ZQyBPSv/bWU1s+/SnIhe5+k=;
        b=BHrQJoslA3mI59MnnEuKXtCmeEKpGfseZuI0pcpKOMhXGxZCnnH7/UKu3qhJ3KRh9h
         VSBZLNjTsDIiahrc2D5hnlV6F8bfoMYnnEznsn1FsYru0KfrIVfVSwLUA7O67FWijydB
         4muKvroij6YmyLi7LVl2easwPmsDLHfMrA1FhaOZQsF+6OXFuQrpD9NE0IjaJr0od7yC
         yswymfcO4lRPwBVuctmFKyLvwwyZKcsf4oOeSwNHHSMoWiastp4iNAGA7TLRGgs2eUmR
         MvUpnzKfkKktrXFfs0FbdDwooFXAXi0zX7OfqwwlKeST04LYCWNN64F8OhUxYM83Rs+B
         rgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831431; x=1794436231;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45IHMvHuNfQHmQp3e/l7ZQyBPSv/bWU1s+/SnIhe5+k=;
        b=qjJ47Eywgr4qPYx9ns5R6eU/P+KFj2WOAf2U8eou+rdIEUc/MO2H4om8o+FPIvf9x8
         CWUaN7H0rX0KuXNP4IcbhxoaDG7L7Paw5DihT2JwWhykfFL1j0uQbTs/JdspHbzr5GlK
         0Vlmn2LXz3Dc1H0u0Xmt67vPjHmPuJJlWlkdnungnOEw+ZPL9CzxFmwoHviaNbSWrbsw
         376VtZmYh2kg6+tBZxn2D/lRJr7TUBYk5LZPS5FXqNa085FMz9lEWdCKPNvBVLX2ptvn
         9HSO8fKi0VfjqLMS+9+Uj00ItaoQ2vswlX7z84OoUFO3+NJvk21QCx02xGnP2M++c/x9
         5dZw==
X-Gm-Message-State: APuU4Z8KiKx7FWQB63Z1a6Qf1a4kCZXcUl9RtDDa2PNZPmGq7irY5YX0
	vGvTkQNXwVxf46wWt+z2AC63DuKTeFc6LRxHiFgh9rsUPuCT+zS3Xw144BaA8bGbxg==
X-Gm-Gg: AYBFou21lCbJvlPDtpsKSS0lhKNSK/+A9VMVzE30xo+98qiWi2xxSdIQltT4HgUGyHB
	YVVjN0o6KcSF/cYMe9PAT33zVLX9uwpfz0pdqsNgBR9pCxIvDsrevaqvUNYbi1Xj1+jdu2FR2WT
	/wgUKGc+nv9Hzp8FzJm29gH4xS7CDMfIL8dacWKlKJ+BAeeVVe+nTf3RS4LLhaxQ+WwVBrrjU26
	QF6dF6r63yr5RocvvML63+BlDkVJJSk/mVrgIPa0/aRgmyQwgRYMtIZcd+S7pr91cSVBI4x6HCT
	1hA139m0iSw5XkMoxDD55QpIMB+KOVv/QXbIoY1UaR7J++6dtdrs3MxOnzUHThrUA0f9vy0TpAc
	QZHUo/5vRMPmC36CPlPvK5VryICo3Y1AmFTPNDQ7wuzxf0btcTNILZiqD52Z9DBPdBoUkfSSCi6
	P2TykQI2BeTlM9PDKl00Tx5dHqZ9RDhH9tH51XqQZd8LCWy+zC+x4Of0PUadPTJBPbXQJYFBs/p
	AOEXNGWqQAZT4yZeh5/cG6N4nMYHxK24FEddGwdYLI3o6UkV1pZQAiXL2S6cVwl3cG3Ix0/t5Bl
	ahLzdNbX7SX1R/h7zYdv3i7cPe69fhCf13D46Dwb/3eCA3fBNhMAzlt3YP0BqymB
X-Received: by 2002:a17:90b:3d8e:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3ae8979a140mr13152373a91.40.1793831430846;
        Wed, 04 Nov 2026 14:30:30 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31638fdsm743618a91.8.2026.11.04.14.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:30:29 -0800 (PST)
Date: Wed, 4 Nov 2026 22:30:26 +0000
From: David Matlack <dmatlack@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 07/10] mm/shmem_luo: Retrieve tmpfs files onto a tmpfs
 mount chosen by userspace
Message-ID: <auuyAseOISaOWwbO@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-8-dmatlack@google.com>
 <2vxzecd0k1dg.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzecd0k1dg.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_143032_488361_1EA87CCE 
X-CRM114-Status: GOOD (  12.39  )
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

On 2026-11-04 05:27 PM, Pratyush Yadav wrote:

> > + * If @flags contains unknown flags or O_PATH, if @mode contains unknown mode
> > + * bits, or if @dirfd is not on a tmpfs mount, the retrieve fails with -EINVAL.
> > + * If the file can't be created, the retrieve fails with the same errors as
> > + * open(). A retrieve that fails before the preserved contents are restored can
> > + * be retried.
> 
> How is userspace supposed to tell if preserved contents were restored?

Through the error code, like Pasha said on patch 3. I'll reword this in
v4 in terms of errors instead of kernel internals: errors from checking
the argument and creating the file, e.g. -EINVAL, -EBADF and the errors
that open() returns, can be retried after fixing the argument. Errors
while restoring the contents, e.g. -ENOMEM, or -ENOSPC when the contents
don't fit on the mount, are permanent, and retrieving the token again
returns the same error.

Thanks for the review. I'll address the rest in v4.

