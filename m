Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7431606B1E3
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AZjG1IH7;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=kxE39H8s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AE6LmlUfD0UD/MlCg2IXWoqx7xIo+3XrxhesZ8DM7Lo=; b=AZjG1IH7B7qGsHTiepq/5TliJq
	zXdd3hd+vl3dtEvsOc6hQgPdLECgwHZGXj1fCdcO+p4+sN+FIliIy8gw2rQfVIfG9hb//Be90c1ol
	fmDZRwlRbP5S722UW84zB2FYgzlKKcnhM9jJaDVbjne7RpnZxRS3PvhXC3uooSSYncxs6jA0B1Lsh
	JPv8PwiZDiFvvRc4hZ9dipVDhUDogUw6FGRfGo98TixgRKqDS1Qx2TDeRPIiBInppORSaYqjvxpKl
	Q09zcykiRKWHWDBm8SrWNCZTQ49XOdWwlsIdN1NFK4xlui7zQVc3AI9l3mwoLtaSYw6aPmuFyqk4T
	9FqZHiuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRmgc-0000000C3z9-3GWJ;
	Fri, 13 Nov 2026 08:31:06 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRmgZ-0000000C3xX-3pDv
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 08:31:05 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-8a07078200fso264975b3a.2
        for <kexec@lists.infradead.org>; Fri, 13 Nov 2026 00:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794558662; x=1795163462; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AE6LmlUfD0UD/MlCg2IXWoqx7xIo+3XrxhesZ8DM7Lo=;
        b=kxE39H8sCcGOHdxs9z0IYrw9S3Y6Xfzbqz1n1Kj44peOECSaVVyhvakcWEy5oe99+7
         sOh8wsqgSE3+Wm2W/tmLOfPU7tIwRKLOoBNd5+lVK9wPhZhzKIR9BagRjXCT2BnAHApb
         1vxeJ42I76J5W9MZ4/vtIrb3C2Dy2ouF8PR68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794558662; x=1795163462;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AE6LmlUfD0UD/MlCg2IXWoqx7xIo+3XrxhesZ8DM7Lo=;
        b=vYMSLYqToqZ+FY/FMv1litVuo0XozYMeuiycyDLST2yIY8tT8SXghjRZ7la9j+mY+O
         ClXl8DTSbQiGNEvHXRvDJKvJ4d4gLyBauCdawEIwA62neyNEEq3/dbB1BlxxhJURYUwx
         4qwUr4tquEL8yHZcS41Gk+emkUAgUUyAbE+bPlTbg4++LXHyfXqiTMXrrvQkI6etMrZr
         3i2dQ3JAFfqTJSavi7DJT1b+rN0/kBqkiJwrZcSwa7PB+Wsip8Rza7cyIrBhf/XTlY9K
         ABLefYkVYg/WWBYtZbVUVsTnOTM/wohVtQfJRpZq3Yn6sHXyAr/IdBbJPKq/TlMvU0T2
         eWHg==
X-Forwarded-Encrypted: i=1; AL+hErHuxkZ6gc9HblACPeyWx7R0HQSLmxFF8tZBtd6npiJlpzDB9OgmNjp8MP9AyHbbbcz1I4jWQA==@lists.infradead.org
X-Gm-Message-State: APuU4Z8x3VVGirkE1YejKpKQ52GMlNIpPWt5xNchNefTO3UUdKLmne6i
	+tXrMA9GP2unWVj8kJO1EoGiCQChkzarrCkfL6/enV/lMMjxGXpc9xrl2+4y0U+tEjk=
X-Gm-Gg: AYBFou3dQvY48MP7hbU5KpRZwuMu05Xif6T5dMF9F6ffhfqqMJwOTES+QcIgV4rN6bI
	fqMSKOXo12xcIAOukRkVkTesUHsotPXyR+itDdjmmymYK17Fu+SHuu/ToT6QvHGPAeJw4uME8DZ
	nJ/R4nj56wFAgQmkbtvQFbIE50YJKqd0hJlZ3DWwmBd/dskeCdxM6PfMU4gNR5UZcZfbiTeFWu1
	LDtQrs/Awf9kLj1ZDIQejTEYY02Pg8mOjIknA9YGJKsU2aiVHb3ZKiTTlmjyZRpMlwfYHED1CE7
	t3DMpPwWWr7FiZhTbz9DWjJ/aRuk/IjtisQ8iH6XcpGoCGOYGEWjRwCRo3ayKeQ8LRqiXZQsKxn
	T/Tx1gsQecjRnLw8PSVjW0dDFIPfwGOiTZI22lPqRfqZgcJR9LfbYvGdakMFeNL4Yfhi8HtUFMG
	VW5f5j+C6maiC9hGMJV0ddWH1BaFsnncnv0wOxdpWO48Ekzf7IqvLl4dNNayuUMq8P+I9JbLujM
	sqMkJNK3skMWZpZoM6knLYhxE6U+NUglSmyiEqYw8cDkn9SReW0Tp1xfR001x9vx7nZEkom2bxd
	0amZ+XftMkPKZILI1lfYEVRpbclWkWpOYSQJ57P+k+QPyyzwvDjSHRFrMDOe6tqmC3onuZ8z2BC
	F9Ub0n9faGlnPl9si8FYTJrpFBPGoR47VTWRHNsDY9U+v7Si+PgqpfVNPqvzgO0exdRwR01S9e+
	QKEewtnIuJrKnyu0nwUZzzYNgaVSmVK6cfr/zj3hvHjfOCmVXtranb5DBefyM=
X-Received: by 2002:a05:6a00:1a8d:b0:89e:a2cc:8263 with SMTP id d2e1a72fcca58-8beb21ce39emr2120292b3a.5.1794558662388;
        Fri, 13 Nov 2026 00:31:02 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcc9basm738703b3a.3.2026.11.13.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:31:01 -0800 (PST)
Date: Fri, 13 Nov 2026 00:30:59 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/9] kho: Make bootmem reservations visible to fleet monitoring
In-Reply-To: <179443886218.2329176.10742245280418377061.b4-review@b4>
References: <cover.1794383544.git.chris@chrisdown.name> <c41c639fc5f453d60a265ba42a233f2ea5b48319.1794383544.git.chris@chrisdown.name> <179443886218.2329176.10742245280418377061.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113003059.056dd036a6546756@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_003103_969267_68F3FFC2 
X-CRM114-Status: GOOD (  16.11  )
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

Hi Pasha,

Pasha Tatashin writes:
>> The reservation varies with the kernel, memory size, NUMA layout and
>> command line. Our fleet collector needs the actual size from each host
>> so we can decide where to enable KHO and catch a kernel release that
>> takes those hosts over their bootmem budget.
>
>HM, that works for cold boot not for live update :-)

Yeah, that's true :-) A kernel we live update into just inherits the areas, so
we'd only see a release change the size once hosts cold boot into it. I'll say
that in the changelog in v2.

>> Today the collector would have to sum kho/out/bootmem_len in debugfs,
>> which isn't a userspace ABI. In /proc/meminfo, free bootmem contributes
>> to CmaFree, but the reservation doesn't contribute to CmaTotal. The cma
>
>Is this a different bug?

I think so, yes. Bootmem pageblocks are MIGRATE_CMA, so their free pages are
counted in NR_FREE_CMA_PAGES, but totalcma_pages only counts the areas that
mm/cma.c knows about.

zone->cma_pages is a separate problem. It only gets bootmem added by
init_cma_reserved_pageblock() in kho_init(), and on a KHO boot we return before
we get there.

I can send patches for those separately if you agree that bootmem should be
counted in both. It wouldn't give us the bootmem size though, because CmaTotal
would still include any other CMA areas.

>I have some concerns about exposing this as a stable API. What if we get
>rid of bootmem or make it resizable? We only recently renamed it from
>scratch to bootmem, and we have been exploring for way to optimize it.
>
>I would keep this exposed under /sys/kernel/debug/kho/bootmem_size for
>now, and not worry about it being stable.

That's fair. I'll move it to /sys/kernel/debug/kho/bootmem_size in v2, and we
can look at sysfs again once bootmem has settled down.

>Keeping it together with the rest of KHO code would be better.

Will do, it'll go in kexec_handover_debugfs.c next to the other bootmem files.

The kho_incoming files in 6/9 are already in kexec_handover.c, but kexec_core.c
still adds the group to /sys/kernel/kexec. Is that ok, or would you rather KHO
set that up itself as well?

Thanks!

Chris

