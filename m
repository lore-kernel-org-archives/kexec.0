Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF5AC79F99
	for <kexec@archiver.kernel.org>; Mon,  7 Sep 2026 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TGJyWqg8b9I8pDWEAS1fAo54dmwDkCp8//1b4QCLnMM=; b=FPl+Kg109Jq65Fh+ZvUnp4sfUC
	siNFbaf1BDnJro2/oK5dOJ2ey4VJYAaKKz36esiUq2kF+nI/tOorcAqKoEXzIbekoRU3ihkNY7Gw4
	LchRedFfNstHyWcTNIB226bMbrQN8CrRPWkLsHWzb8fhSsmUvH9yGRCJ6hWsU6KOzbEMWYL0ZzABJ
	8JrUHYEJQnjCf7TGC1rzzvdmnVnkdMeCVgXlFYm4OYNHdZd+eIlfjr1xmN8zStk4g/NqZ6ymV5hQL
	lHFAXZ6XFVXrP5VH0+dF9GT+fXeFL434pgfLpGeQFmHYHawLlDTrWeYUXOUKA7VkpJ1KXgSi1T+Do
	N7IZ+/rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3gTX-00000007jx4-35Wu;
	Mon, 07 Sep 2026 21:01:59 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3gTV-00000007jwI-2BbA
	for kexec@lists.infradead.org;
	Mon, 07 Sep 2026 21:01:58 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d6ff390a6cso131935ad.1
        for <kexec@lists.infradead.org>; Mon, 07 Sep 2026 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788814914; x=1789419714; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TGJyWqg8b9I8pDWEAS1fAo54dmwDkCp8//1b4QCLnMM=;
        b=UIl8eVTCisPly412x+Q5WKJAFePOwbwRQZ6bGLnv1doTLjW1nYfMztqrEqam2USyXa
         /9LCA7yDVtocwxDT4oEprAzmWk+Mzoh73EhWqPPgSpr3CXXH2L5n5xyJ5j0Vc9OykeZx
         sjvF/ljGaBB5u+hf4RJDtow/y+6osi24N1RSE2rHbXZwlmfJFk9Qnh390Z4GyrNmbkDL
         hLPr7nf0p7Qd25D6jyfN4bvNv0dOgMG5WW0mqkCeaDk2ngYDvTwe9M7RsucPXDV3CV8O
         8qUfBjmbSKh+XjNtjt22N66j3smm2bD7G+vnUKxOSiearbVVeDq6HEFydd3iv8Qb5PGm
         0j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814914; x=1789419714;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGJyWqg8b9I8pDWEAS1fAo54dmwDkCp8//1b4QCLnMM=;
        b=soCbkZuJ1DMseMqgtPM1V0s+0PxDD+qp/IGjndIQnIUwbQ69qlQ5SkMA4ZZ0UK4tJ4
         nJK6fQBmIG69XufdAh1GUes2sZ6aHWUC2cjs0l2o65d/npAqwofzX1FlKCsW57t7rclY
         mlFEE002JQjoOQOMdJyccfB9rdIAbLMLIRJFMTMLdiV8LuFiOV175CpxXrD0CuiHPVJ3
         3xa6RXi7Ju5/xOdlSxr5hwoEIR86wMbW7KGj62n41vZ8OBXQZLHaARRJwaQrqgnXWsVZ
         1wei2sFVBiWflQ8oFXiXdY2peQIGE7On7lta6w3N0C0Kjg/pPYX65W+ZxIH7+ROjmWMl
         UtKQ==
X-Forwarded-Encrypted: i=1; AKwUvByZ5lN2FsNLeF5/fvCYBaXqwoslSUVGEBqrt4pXOAJZBs2CLgw1MNhXdTvPGE1oQGpqwFIUVw==@lists.infradead.org
X-Gm-Message-State: AFuF++ky3mcl60eqRUa+LEqpsOse40zL33xYmZMTyI37W0oESFHHWkGD
	V6MPuL9dMTVKsFKKNr35swYEKvJv3hg/1ZF5x3rR+DTeMMbBvlFRvPrKUaAO9M17W6VtALjVilU
	V2vX07Q==
X-Gm-Gg: AYBFou0c1uXYOmL0BN16U9MyUG5qu9tq0slvctQJu28h2mp9ucDri7mL2vBmn41Z3st
	jHQZ/ikTCopm4k1hx665774Ue2cbPKqpIvjw2INiK9FtD/34zwwXBSRKJ6AhQmvAsAm4mUMRpcK
	jxXvx9CT+zG6oEmMoGLpn1F8JBrVZhcJw4eT4y9fYa0aQLi0mgY323435y4l0C/Y5ZVbKX6KVFP
	rZKTcxx6PIa3YcdQwxx8FBhq+N1qwxhnQABpV2l5fn7nrp4R+uidvO3ZhSCvwgchvHlgU3Y8Iok
	tq6OcNlgDGT4sA3L70owiVJFnsYCxipxn9eFkcnbDUDI1y0ZseeXYxv1QGhwQbswnNugZioWZCg
	xHErc7y/pM8YFn3WOxVwkcMtJ5SmD0tXmYYHGphH9srPyK8qa8TqK8FZsHsp4FkQ3kkIu3GxEyA
	YjNfWUCY3p5+42hVwEynT+zwb6KJutoDO/9qGXfDCTvkIkuXCURYnErUK6dh88uL5IRov9b4xGL
	pMLzAxf3mJQx4PeHla2phstkA5K5e+hWuANAGOf/Lc8yM6H9r+fmpgEeXse2b6SLDp/PA==
X-Received: by 2002:a17:902:e745:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2db7773ef8bmr714085ad.0.1788814913291;
        Mon, 07 Sep 2026 14:01:53 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae92c5d72sm8942409a91.4.2026.09.07.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:01:52 -0700 (PDT)
Date: Mon, 7 Sep 2026 21:01:47 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	David Matlack <dmatlack@google.com>, tarunsahu@google.com, open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, "open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add documentation for
 dependencies
Message-ID: <ap3UCMlxUKU_DFDO@google.com>
References: <20260904220555.589752-1-skhawaja@google.com>
 <20260904220555.589752-2-skhawaja@google.com>
 <178872718104.3691424.15410189304450384708.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <178872718104.3691424.15410189304450384708.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_140157_567333_8D126F3A 
X-CRM114-Status: GOOD (  11.45  )
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

Hi Mike,

On Sun, Sep 06, 2026 at 11:39:41PM +0300, Mike Rapoport wrote:
>Hi Sami,
>
>> Add documentation for dependencies between FDs preserved by File
>> Handlers. This supplements the previously added
>
>Why capital F and H? :)
>
>I think we use "file handler" in the most places.

Ah, force of habit! You are right, it should be lowercased.

Let me send a v2 for this patch with the capitalization fixed. I will
check if I did the same in the source file also.

Thanks,
Sami
>
>-- 
>Sincerely yours,
>Mike.
>

