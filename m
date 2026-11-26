Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153C606A6AE
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3NeLqmEp;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FjpZnLRN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5XMVDmbH25df5MhEApmqQitq30RsFa91wwEAJ21DK2s=; b=3NeLqmEpn7SwCiUnCYWCrrpZ7Z
	fprylxAUoJV2YvGYuxxeF4LVlwx8kudU5ylcN2uGMIm9lbLWZtdAy68OwFZs2Z99P4RwAUU3dhGTu
	Uo18mD5Vo6TyNWp46hvtEXawv8gtg3+TUqIuxyUDCpgc5UwxhRV9VDClavzdVHDl15keqfsOyrSSE
	B6fH46ywThTA8kc4mcgXxgjGNTLl2jIF6iObiKxQ7f2r5qBx/Bd/xbKcnsv7dVz0a7ljq2aAvrXOa
	2kvBaMHONfo8ozJEGNEC6dff/92ovhnbU5xGW9LSkXsJf/lDjKG2rX6nE5QDDnpUx+YWFjOkz4ca7
	CVUm/DkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWUjA-0000000CN6A-02Uq;
	Thu, 26 Nov 2026 08:21:12 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWUj7-0000000CN4f-1l3D
	for kexec@lists.infradead.org;
	Thu, 26 Nov 2026 08:21:10 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-491971ac844so5972265f8f.2
        for <kexec@lists.infradead.org>; Thu, 26 Nov 2026 00:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795681267; x=1796286067; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5XMVDmbH25df5MhEApmqQitq30RsFa91wwEAJ21DK2s=;
        b=FjpZnLRNs7cnhNw4LPIlEc+8jE++1WCz2LyziT3PaoaYD4LZhdwOPe5mQeBsi3rspQ
         MSaCdAXXKLQNvv05DUyK8QDHDirh/eEA+oYFLsr8FC6WdY63hiAyjUnoE4xHyqB22aZ0
         ReXalMLGfmEavMa0uRkI1+9/UZo66H704nSCgSnJxuK4yhKMjF7cr7fT6u4KLypKFAgL
         eYLlJLda4yhx2goqmYbY96u8PJPFqVie8jUzAd5rqnE8HnsJJCb8rt5pOUtYqIPbl5KZ
         wj3QhgUhC9L2vUx07pmSfAX5Y4Zmn0MRqrnN7N+FVAwBS4SSMjqCxb30fGqY2yUFUeo2
         Z1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681267; x=1796286067;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5XMVDmbH25df5MhEApmqQitq30RsFa91wwEAJ21DK2s=;
        b=BTZXreHmfKPzhQbwZ0FF4AoLVa8RMVvvnnoue3/BiccmPSgrVF6kjC6nGctrLCW8sb
         nkJq9KWA7ofxJFTwxYEjxYdQrZFFfA2wX6kof6IlkfYOvgGPIyWuWnFur5MTfRrHb/J3
         o26er3OWa6JlVIaOHFxDusD5LAx+QLRk6B4NIx5NXODwpP5qC+unrt8w00d9JTBOQgF1
         /i6J0pCwsk6BBjZEHPLz1E+yklQ2oQmqydNcw4JVFdr2IsC1O6CWwCm8fxhRi3wLlJd/
         fGK4Euw3JxeD9L+mIzL5WNgGfjbiyKBBiWm4X3Rnt2xwzJpn9gPsKBO1XIly47eAm6iA
         he2Q==
X-Forwarded-Encrypted: i=1; AL+hErFvtttVsrkaP4IKltc8LE5oDHXK9nhHQaGdixI9vRgaBN2HbDy6MKq5MjGI7wSkapHVfh7GvA==@lists.infradead.org
X-Gm-Message-State: APuU4Z8DrbcrEIhHj4ct0lHFMzjKK7vMeZhwUBGwM83SODrYUYdkDPIT
	sYflS/gyK0RvadT89qGewpyg3ZkNoEikpIahvu8Fb6lhxs0PKXk+9SD3AeETJIZTa28=
X-Gm-Gg: AZFdTZc+gE+aYI1jTvdJKBy8jaKk+pBL83yvhGro+Tz89umJzBm4ufIcx6EpB5EA2o0
	kycGBIy/QoNGhRnjgKC3rIYiVndamIPSU4upel4t+aH7zBVS6ooKE8hq7ZWmYyXeHvC0JYP0Daj
	sg6RAmAScx72hqpWYmjI6cy8LMp+35ge0tSZ2Fjl57zDpBcGWdSD1kcjP15+O4bcgjUYkeJZgm6
	QfhIy3WNfmvvGNklqwsxAnidJqVQ5yfbpyjs6j6oAeeK2/aYpiOKMSl6B702QKOCdd2tu9NTaWC
	RqisDBpLJ0S0Uo01iBh5oMv4Rv3onvwtTe1uOOMerwpBqyLghujCzKY2hsMXSmDc3KsjYD6XRiy
	GTc24MURwxs+/wFhHIgPF3C7hNTiJ+fJecNfxyPGhiTcQo/Vq5DErQmOL1MD8BNqO9G9WDWGUfA
	biSxSat/etMTdkqwV1dzp/h485J/LUEd/w8SKlc5WsLLzXERZrfj2dvRRbDa15Q2urFD9TP+vZ+
	zLxwCRpVlnnED8LPWXVMvekL7wBiX6qo6fDvz9Y1mDpvbGBhFDramuMtqJFAnlKGcsH8+zzzL7B
	NrIfpt4mLlJ3JZ6K4wQe5/t+GIvTKLU6aj5Ohr4ONpX2ywNpke++9Ie0XgJW2w==
X-Received: by 2002:a5d:6f08:0:b0:4b7:7b8d:6b20 with SMTP id ffacd0b85a97d-4b77b8d6b73mr12609058f8f.46.1795681266888;
        Thu, 26 Nov 2026 00:21:06 -0800 (PST)
Received: from localhost (109-81-21-11.rct.o2.cz. [109.81.21.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f1b2sm36108136f8f.25.2026.11.26.00.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:21:06 -0800 (PST)
Date: Thu, 26 Nov 2026 09:21:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Mike Rapoport <rppt@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Usama Arif <usama.arif@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Frank van der Linden <fvdl@google.com>,
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, Jiri Bohac <jbohac@suse.cz>,
	kexec@lists.infradead.org
Subject: Re: [PATCH] mm/cma: reject long-term pins of HugeTLB folios
 overlapping crashkernel CMA
Message-ID: <awfr8bnK7PQa6cyD@tiehlicka>
References: <20261125155108.24098-1-ekffu200098@gmail.com>
 <f79014e3-3c81-4b2b-87f6-df0c2d946357@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79014e3-3c81-4b2b-87f6-df0c2d946357@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_002109_473814_42F9E068 
X-CRM114-Status: GOOD (  15.62  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed 25-11-26 23:43:40, David Hildenbrand wrote:
> On 11/25/26 16:51, Sang-Heon Jeon wrote:
> > crashkernel=size,cma uses existing hugetlb_cma memory, so
> > crashk_cma_ranges[] may contain HugeTLB folios. HugeTLB folios allocated
> > from hugetlb_cma can be long-term pinned without being migrated.
> > 
> > After a crash, the crash kernel uses the memory in crashk_cma_ranges[],
> > but a device can still write to a long-term pinned folio.
> > 
> > So reject long-term pins of HugeTLB folios overlapping
> > crashk_cma_ranges[].
> > 
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> > The above scenario is only possible with the two patches below applied.
> > Currently only linux-next, which is targeting v7.5, has both of them.
> > 
> >   "mm/hugetlb: allow crashkernel to reuse hugetlb CMA memory" (kexec-next)
> 
> I think that's a real problem with this thing.
> 
> The solution is not to disallow long-term pinning. :/

Yes, I would tend to agree. While there is a risk of stale writes from
RDMA on long term pinned pages on the crash kernel I would simply advise
admins to not use cma backing for crash kernel on those setups unless
they are willing to live with unreliable dumping.

I can see how reusing hugetlb cmas might be really helpful for
crashkernel as this can consume a lot of memory and you rarely care
about the content in the crash kernel - same as any other userspace
memory.
-- 
Michal Hocko
SUSE Labs

