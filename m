Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF75B606B3AE
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tzzWKP5n;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NMB+Oxk5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ngSI9f0kiDWl+YO8rRXsU2IRSVNvxIMeC8SrK3o9F8Q=; b=tzzWKP5nNbBvFlRrHd+u56Ft6z
	32i8unzrfIL9L41yScIRLzGiZ5LEwkAmovxR2MOFWu2Ze1nE3rdkCjGmQniYrPWNVzlR9uP0iYeG9
	Ud6uUiHeUE4PHEK+xDYlgBNDREAB95o7HQx0eyVVVQ8Ci9HzM+Od1psdnIWOA5IZiIOvA9oC20Z17
	TIXb7wT+4mkC6plbko/A9j5+9JgQ5ocYuU4oN0sg8EVo53kmvYS2qjFBzv2i1S2/xaVEZotw9YhSi
	RIMCnvrAxx0V2oX53H/I83blfSWWy3XrtoR/6Kj6kHU6ceWgnFyz0fDnJCfCydNDxpCRT4cuUEoZ7
	R+mTL68g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjTA-000000079U6-1EYF;
	Wed, 04 Nov 2026 22:28:36 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjT7-000000079Ss-358g
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:28:35 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso876431a91.3
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793831313; x=1794436113; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ngSI9f0kiDWl+YO8rRXsU2IRSVNvxIMeC8SrK3o9F8Q=;
        b=NMB+Oxk5CKalMorthS5Ky0jCfWqGaGq502bh5kmD9L9gEr6t0ibbYZs+ZTCayelAst
         GZYILjh+JY+yMdDuIBwUjx/lcFSKl0eLTY8YCf9W8gk1bpGHB1pGX1H7keeaDG9XYDou
         tirmxofakUfr1W6yzTvwZb5e0CY25SLUcb16IALqrEK0bfv2+cSiBz8P89JKwkmDOvCx
         rMb2ByQI04iKpwDo7lIN/9JqfvgE68s8dXZfram+3McRdjpQkLFXmcDXqWMVjj13QTj6
         GTkc3xmYo/RaoX8wHglVu2txijuD4uhXFBVvXy4xpK/YD+YXLRBuxWf7aoa/GuX+638E
         TKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831313; x=1794436113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngSI9f0kiDWl+YO8rRXsU2IRSVNvxIMeC8SrK3o9F8Q=;
        b=QVWJuBHoApVNXtDotyuG5DvFxYz/JBPR/IgKPj6N9gbcQsV95lksOy8DF6jRhSWfzX
         XELRyHzKqWBpl5xM6srPiPTmzuBaMClFQokBp+DRmU0meBXzmwfWsL6C5Ha+MQ+YS1Xn
         QHzyx7YS/D4Xm41JYul3S49OWN733BZGJ9ztbfdiF4cmbMH6NqM5blPpQylE7UKsyGOe
         leGlrqMfvyT9o+Oti7E3I5XhIynSjFd1ZBRqs3CYJ4/i7hTdhEec8ktrz5C7ACXL5CgC
         e/p3+x30d1nvvqTUkZ5x5dtX6z1SIi9TI4eLpQIws6InWAry2GyB4iM+VT2EPAadoBoe
         +bsA==
X-Gm-Message-State: APuU4Z/dSs/oDBYPnRs0iRsX8YkZ84oiuijQO/UBpgJWwo+Uxwu4/1mT
	ZD4SSZQyoP9buocJGwIRI1E8/KebNZ+t9229wm143GCR8pH7wTBxyuavcvg2U5fP6g==
X-Gm-Gg: AYBFou2K4MDuYbywhDUTXbfvjiFNiWcl8mcUl4y71g+sgpfeJooBQ2kOHiwjW+0nuhx
	ywuvX6oBDZIbnVwDQFnUe22+g1ZERHlQZQ+76vFGkwrgRLfNFh/6Y7Sr8gcX6nHKhA7kuwdwsxm
	U3009YURbncx6uELOhs+r1OL+F+fO6c0/I5RL18/8VX17at9HM5dea5lva4WT1IZgTm6bc5Qeu/
	zXGVYW6NuEJsFDjTNpeXmXNpxMZZpCmRq+pQFcENp5e/HxFlHJDrg9iXuWAFO2JA4Pelp/z2M5S
	WLfp9YLp9eNMGNO8L3vBxzNULKGg1JqSL89FtWoEOFNI9XEj3jy3VcA/QOWd34O5DCPI/t0w7OV
	qd7TcPgBY/8FA+vQAwcVTehW8F4WYPNmKn7sKP7wSQVyXOc2ImA9R/HexuCHLinBUhergOH89pE
	kT4sMuaSKSlcPFwjh6L1X6LRtcKMBcvi8XpgCkoQIj0DAehFZ3UyesR3PePwwaKwirDvGhEwgT6
	KPOffQPh1Leh5WBd3Or3vx6z3fgfc8JS8xHAH71X58tP+D/Uk5wfJAbrQwjvn467R3PLDdV7057
	DKzV8i1Y7275JVcLDhURYK62l/WQi1Sw6ZdsU6i9BsQgg0zQ7jpxj23Wb8OZejo2
X-Received: by 2002:a17:90b:4c04:b0:3ad:8a14:bc73 with SMTP id 98e67ed59e1d1-3ae897b519bmr13057533a91.50.1793831312185;
        Wed, 04 Nov 2026 14:28:32 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31cf4b6sm710454a91.14.2026.11.04.14.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:28:31 -0800 (PST)
Date: Wed, 4 Nov 2026 22:28:27 +0000
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
Subject: Re: [PATCH v3 06/10] mm/shmem_luo: Don't make early retrieve
 failures permanent
Message-ID: <auuxi10mmCQrq-y2@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-7-dmatlack@google.com>
 <2vxzik2ck5dp.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzik2ck5dp.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_142833_800459_F2F07E24 
X-CRM114-Status: GOOD (  24.12  )
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

On 2026-11-04 04:01 PM, Pratyush Yadav wrote:
> On Tue, Nov 03 2026, David Matlack wrote:
> 
> > Mark failures in shmem_luo_retrieve() before it starts restoring the
> > folios as retryable, and return the error without freeing the serialized
> > state. If no retrieve succeeds, finish() frees the preserved folios,
> > like it does for a file that was never retrieved.
> >
> > Nothing has consumed the preserved state before the folios are
> > restored, so the retrieve can be tried again.
> >
> > This also fixes leaking the preserved folios when one of these early
> > steps fails, e.g. because the file has seals that this kernel doesn't
> > support. The retrieve freed the serialized state but not the folios, and
> > finish() then skipped the file because its retrieve had failed. There is
> > no Fixes tag, since the fix relies on args->retryable, which was only
> > added earlier in this series.
> 
> If the seals don't match, the retrieve is not retryable. It will always
> fail.
> 
> I think the only retriable part is memfd_alloc_file(), although even
> that is quite unlikely to fail. But I think that also fits pretty well
> with the most important type of error you want to retry on, which is bad
> arguments. In later patches, you check the argument on
> shmem_luo_create_tmpfs_file() or shmem_luo_create_memfd(), so perhaps
> set retriable in those functions?

When retryable is set, LUO leaves the file unretrieved and finish()
frees the preserved folios. If the seal failure did not set retryable,
finish() would skip the file and the folios would leak.

In v4 I can move the seal checks into shmem_luo_create_memfd() and
shmem_luo_create_tmpfs_file(), since the valid seals differ between the
two, and reword the commit message so it doesn't suggest that a bad seal
can be fixed by retrying.

