Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03760C54C2
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 19:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XVyf+I7T;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=gxkPR8YT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AhauLcYrkNfZ4d386lPMrnU0qCgiFUOVmgX6lCm/lmo=; b=XVyf+I7T36qeyZRl010t4Qg9Kz
	Bdkf/tEl8aXDMigESZcQJLARzHDqtugmjJGpeCsMOmGI8fvunrOQUSmu4/xlwpkcB0acHUrkb50Jt
	lW5Je7vLj5M9w0SancGqBwgchkytVkNKaNjJWuUhh0jaDIMRqcun25SUxXKt118IqURt4o85nRNdf
	TCePuL9DJWvQPtmx0IwkqJawpYlijScCXJoCJEzMRPMUXVF4lHjBKuFXUnEFQUZSYXws8GdppPS6V
	MLJug58tD3PD40dyFPdMlv7qXqkPY8z6bezgTVekTxMjyRn+vdC9Fx3XDYgVrnVjy548ZYFoAWNCp
	ZvRyT8bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgvK-00000006jvA-0oyf;
	Wed, 04 Nov 2026 19:45:30 +0000
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOgvG-00000006js6-3L54
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 19:45:28 +0000
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5eafa528803so391243e0c.1
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793821524; x=1794426324; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AhauLcYrkNfZ4d386lPMrnU0qCgiFUOVmgX6lCm/lmo=;
        b=gxkPR8YTBg6kp7dAeAY7fqihbcbg/jwe+GBMeuotTqS2bgbrqqwHex2zbvaEp7xWng
         7lPoypeNLp0/XwvGuHLkuVmvjF45XMwAYqkEvUqiFl5AYmtkp9YW3DgziGOduFqqJIuU
         dawvxyKqG3OQWgwJA9gvE12v8vKAyg/jRusKdixtXjkmiX6p4yWsjYYBgb3epdbeqmwc
         gPFNMKaaoFfXlQQFn9+cWkeYU/wIp8GNiAVsThHOT1x48wfSdVftJp5Ccc5Og1ms/QzV
         ynEJ1O8wJF871ablyxMSWSHCOAgfKLODoZbY72ajB77mlXzNHRnjJWDZ6BHBNBZ8UIOe
         jH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821524; x=1794426324;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhauLcYrkNfZ4d386lPMrnU0qCgiFUOVmgX6lCm/lmo=;
        b=GtwkGmg/+T13L4+WciAeCoCgTlMuJGuogexVp60szoP2Tsdp/nOMkScfcwSIuYOyW0
         GOyVeOcotk2f7rNUAut8mEKNz93AiP+HZolddzyM5KFXTcCWVPImSFJ8ciHkeoKoYyNU
         w6nts3ZdJcL0IsOL//J/+TndKpNsU7RuSjfzBaUCQlZrdjqLyLkI89oKafZctZnZATwd
         oy22g9levgDt1oESWShV23/eASdAU44FeR421b89hkIRr5az0gPuaAfyvDIlXOgR0LR9
         izL6m/SiLLEtVt47iAoy6qkLJK21R6T/BdVYCT+RIyEO22YbQSMg3G0HktvlsazNqr8a
         PCag==
X-Forwarded-Encrypted: i=1; AKwUvBxLsQ03DQwgSGYYwJjNjMpKVpp6uT0XS0vlfDjuvir/ujmJ/w93a1OgnG06nAI/T7nhMm/rlA==@lists.infradead.org
X-Gm-Message-State: APuU4Z+XQW4AdOmlCVsET/RUtuFP+bF+Q9F/6vU69xh81FW10dFy61QE
	+5fSmMtBCLrZ1BkS1z1EYHmeNaRgFs9Up13v5jWNAPzK+tu1FR+2MSEhzacoA8aJr9w=
X-Gm-Gg: AYBFou2XgDqTCN/YNyQDqGF1MFAyn4Krw+ZVroJ8+PLPUwe/uTI2f3kBEcixGdolGVH
	NY1AqusRJwbb5B+Yrtk0MVx2Sa2fcaxJlTrqbp+7md24cXJcOOVTPj3XHciv82sdoO+/IQHOYO9
	mUdnEViRpVjnACULvp49xIcVeenAF6x+Efn0d7dlpd1T9CiK1xeojCmKUChoGGnmnDu/GxQ379G
	TN0HmsCBmEYMvQroW0ub3zXq1adJGpxstaqRfuUBd0z5AKorekrp9KqF7V290nDC/AEnWpuErfE
	uNi4q0b4NVodCEznWHGzQBq205OUnkCD1O4LMD0P5jXifjARjW88zdxATHavusMCihjGRB6B7NV
	3KTMFcwJLLKlaFs3VeUl9wZ3vNOO9/aXVSVC2YEl/R0TcM4J4j7QTSR21bss6CGzx5xcRxImRP/
	HOPQSTJzTJsGS4FgV0uhgX/m0LrnA2OZs5wez9E6oxqJCOVgd0pHgwYVIEp+o+ICa/QubpBjCPe
	CCQepZWwBaX2gKwOCxUE0nhtt5eBM8koY2KSkwv3C+kGh3tOnqzLGsaA0mGQi7eont34OAGNW4h
	wt1nAbAuIcNcbiS6/Ij0ea/TSs5oCBNAkYSFTv/PGRjFMH5l+84SWIlcbgecNElsorAfPEh6Ni0
	Pdi6bpol8IuCjvn3V7a5LZN71bNoC
X-Received: by 2002:a05:6122:54e:b0:5e5:29f7:489 with SMTP id 71dfb90a1353d-5ec6899f507mr7074700e0c.22.1793821524335;
        Wed, 04 Nov 2026 11:45:24 -0800 (PST)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca889381asm2496927e0c.0.2026.11.04.11.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:23 -0800 (PST)
Date: Wed, 4 Nov 2026 14:45:23 -0500
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 09/10] mm/shmem_luo: Allow retrieving tmpfs files with
 O_RDONLY
Message-ID: <auuJ4msatqzoOrjN@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-10-dmatlack@google.com>
 <2vxz5wyck08d.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz5wyck08d.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_114526_885917_ED53CB16 
X-CRM114-Status: GOOD (  22.17  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11-04 17:52, Pratyush Yadav wrote:
> On Tue, Nov 03 2026, David Matlack wrote:
> 
> > Allow userspace to pass O_RDONLY in struct liveupdate_shmem_retrieve_arg
> > to retrieve a tmpfs file read-only.
> >
> > open() requires write access for O_TMPFILE, so create the file writable
> > like before, then reopen it read-only with dentry_open() using the flags
> > of the writable file, which file_open_root() normalized, and drop the
> > writable file. Like open(), which grants the requested access to a new
> > file regardless of its mode, don't check permission for the read-only
> > open.
> >
> > Retrieving a file read-only allows a restored binary to be executed
> > before the session is finished. LUO keeps the retrieved file open until
> > then, and executing a binary that is open for writing fails with
> > -ETXTBSY. Being able to execute restored binaries right away matters
> > when they are needed to finish restoring the system, e.g. to bring up
> > the services that retrieve and finish the remaining sessions.
> 
> Can't you put all your binaries in a separate session, retrieve it as
> the very first thing, and then finish the session? Then you can execute
> those and retrieve all the other sessions.

This is a good workaround. I am not opposed to this patch for 
completeness of functionality, but if we decide to keep it, perhaps it 
should simply be squashed into an earlier patch. The current diffstat
looks bad, as it mostly deletes code that was introduced earlier in this 
series.

In any case, given Pratyush's suggestion, we could also drop it.

> 
> Why do we need to support this in the kernel?
> 
> Also, please put the motivation as on the top-ish of the commit message,
> and the mechanics later. For example, your second paragraph should
> likely come below this one.
> 
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

-- 
Pasha

