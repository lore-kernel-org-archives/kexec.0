Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125A606A881
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=innUeTDa;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=vFfYoBEy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xfBMXtQzr2JQHUojf4ewtSOsAqE+X7FzRw+q2BHepVo=; b=innUeTDa+YSjaIkh6aCckEJdn9
	Bx+yywKST0cT06YSHGjbioqXL/EKBVR5VH3PmB9C8/ygql6+37QBZ7xRuxtViZ3OhtBAo+T0Vylux
	6HrYEz3q1ooZnkSHO1Y176+hGKBgrEIQQVur7Ts8MXyTpGWbzDjsobZC0O6IfNfi9gXIR2F/YYIfN
	12DTWIWnxpxtotAc0GbPKFKV4sup8BWYgAda6xsrgPwcddjRp2rGzKVjfWRrXK13Yq7K3zkGLAOQB
	ppbzpsAJrHrZo1XFW7Azztdac2c5ZfJ3fj280yVnHfLfpzy6D05gPLlw6sROKajd+B7eAKJ+4fvz4
	MzRAzRuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTG8v-00000005EQb-29p4;
	Tue, 17 Nov 2026 10:10:25 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTG8t-00000005EPD-0VOv
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 10:10:24 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-cc758830601so4088932a12.2
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 02:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794910219; x=1795515019; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xfBMXtQzr2JQHUojf4ewtSOsAqE+X7FzRw+q2BHepVo=;
        b=vFfYoBEyxUKXhNbB64PG7itJHW9Fli0P47WORq79ROKNOr1QxJBvkGq/Oxm5c2Gmvd
         9uKnYt7UWv323Url+H37vS1rCbN+v8Z1JHtpkehiJ4E/Xoz1XJBRmwipUPok/e+hOz5z
         d633qIMJUj+CEJkaeEVD7SMrrw/3KF3SfYxi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794910219; x=1795515019;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xfBMXtQzr2JQHUojf4ewtSOsAqE+X7FzRw+q2BHepVo=;
        b=1bCGlk/1QC7nWPc8hjMJ8OpoxA84k1MeugD16hyQ2j3QmFJrs0nXkPPigSYYzYllgK
         EnKvU07fMxOQ9dRaoFJfSLA/Avn6EROAaxbMW30ybkRhBRnqqsIvQRHHWRkU7oNShG2g
         2fvPk0+I0PFz/7H36kgEA18Gme6hisLB44kpR4z5KxCQCjcHqaidtjPY0b+fbVAmNCtD
         4BpnPsKnzXO5MS3dGYmjNYM3XJJS1imDypEmdeqgXfheP2bWT1a0KS8XqJc4RpseEB0g
         2lLQh0fz4PwRxcdIw1VJg53egam8nWo961ZgxziPUoeklSIOzkv/EH1L9CeVmwrMeD0A
         I5jA==
X-Forwarded-Encrypted: i=1; AL+hErE+TIDhoV4M32W6kUupk9U6ZJhjnDV9TwkOoBeYAWZ5B5wnZARInnpm2WvkAH4x8sxVKjIjnw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9Ja/U70I+IfANRxYJXZVUT2Hc1KaFk3y/3jsGXihlvY2VZlC3/
	rYBkeTC19VHc38becNAjvgWkLSb8uZzux0srd2ju/lQ+uz1iTSW4NVofbG/av9xePns=
X-Gm-Gg: AZFdTZdDvjfjmZULQecdazJZ5942iYcRZaSRtImMUGE83r/+smcZKQXmn+YQrED+7WW
	+8nRLU9iUTawxnSpsFY4KaNkLXbhUQMN0tKYX8h+tMiQ1uNtVeW5zY/WVjOolOJvgPfzYl0F2Sz
	BiUpsIkMgquFsDS4KmTM99UI/x6DkLNMrtlki/Kr/PTpUV5DurrqeCU1Ii1qmFEQv7F/0fpFnku
	TTBAS7HjLznSJnK9Jnp3XS05pK0AXdcl9unCwUDooPFNT16A/hYD41IFGt07pP9LQ2VWhRGELRt
	gv6em6Jt/R7L4lVIwElNhxN1U2osWS1tNfub4nRhEonXaqj69GOC6GUXxhQv2uSZlW4eOMfsME4
	YU9t7g77ZQIGl8mvqRaAgLLV/Ej4+irlcCleqtujlXkuzz2DQp4SduRbdq6bm546bhYCj+cunMD
	ipQA6RL7+NhIl0rJgxrIFzj+/ibRsK0SGKYE1yTJzq3Y1M6j9mqbMfREU/qC5P7hHO1sgCSZCVu
	NnllGO8mvtQPJCEX7N71MJT8fWlZNIlRtFkG9PU2sfDMOmwTTZuvNpf52Qftp/8/A+M3fseWDQ8
	UkoJRyfiGGpWrN75rowKap+3UVLTQPIY8zexmrSuJD8EKuVzTy8yBYvDfzkA87Y7kre3s9qHi0c
	zmaJnNWVFxqcn/YTzSUE66rA9RvMjJ9+/Xuv2CmOTQStxhAIvacdjIaFa/7sKBghrHYq38raxDn
	/PdD8p31lYROQi3lKBUgmS+pRfgWYdeCZUBjOj2btcW7Fx+UF6o5vqU6bm7Mx7zVMr
X-Received: by 2002:a17:90a:e7c6:b0:3ac:d79f:8229 with SMTP id 98e67ed59e1d1-3b1b0d55ce6mr13140816a91.61.1794910218659;
        Tue, 17 Nov 2026 02:10:18 -0800 (PST)
Received: from [172.20.0.2] ([172.56.235.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abbad970sm3433447a91.4.2026.11.17.02.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:10:17 -0800 (PST)
Date: Tue, 17 Nov 2026 02:10:14 -0800
From: Chris Down <chris@chrisdown.name>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, Tarun Sahu <tarunsahu@google.com>,
	David Matlack <dmatlack@google.com>, Samiullah Khawaja <skhawaja@google.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] KHO map
In-Reply-To: <20261116134013.1636689-1-pratyush@kernel.org>
References: <20261116134013.1636689-1-pratyush@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <avwoBj5ceKYjcS9G@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_021023_193315_56A1E09C 
X-CRM114-Status: GOOD (  11.36  )
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Pratyush,

Pratyush Yadav writes:
>The main user of the map is memfd. Currently memfd uses a vmalloc buffer
>that has a pair of {index,pfn} to track the folios in the file. That
>uses 16 bytes per page. The KHO map uses only 8 bytes per page with some
>overhead. So for a 1 GiB memfd, it uses roughly half the memory.

That only holds for order-0 folios though. A leaf covers 512 indices, so
a populated memfd needs one leaf page for every 2M of file whatever the
folio size, while the array needs 16 bytes per folio. Per 2M of file,
that works out as:

     folio size   array    map     map/array
     4K (o0)      8K       4K      0.5x
     8K (o1)      4K       4K      1x
     16K (o2)     2K       4K      2x
     64K (o4)     512      4K      8x
     2M (o9)      16       4K      256x

>- Multi-index entry support: currently, while the map is very efficient
>  with 4k folios, it is horribly inefficient with 2M folios. Each folio
>  in the memfd takes up a full page to track. Multi-index entry support
>  can fix this by tracking entries that cover a whole page in the
>  previous level, similar to page tables.

Since patch 5 makes things worse for memfds with large folios, I agree
with Pasha that this needs fixing before memfd switches over. Storing
PMD-sized entries at L1 fixes the 2M case, but mTHP sizes between 4K and
2M would still take a full leaf for every 2M of file. Do you expect
mTHP-backed memfds to be preserved? If so, it's probably worth handling
them in the format before it becomes ABI.

Thanks!

Chris

