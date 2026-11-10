Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2F606A338
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SK/W4I1o;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JQaDiWU3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h/fDqdjeF2qNLQi3iaEH9vKqxnzXslPVSp3ugOVQ8hM=; b=SK/W4I1oXgmHlLzGIJETffA+wq
	g9GyMzVqCj//g/AC63/4IAUk+/v9X0GRKPAbTnWaRYUdPY27q11hKQtvH8g9uwCaBJL7qQvA+w8jt
	vViZZEC3uQf7qxCuWU36UIycbWdn8d6FDfTEEO+eMJD26Dr2BT9TZPPiouuvtVZB2tcU3lBllzAJV
	yiwFg11OIP56ARLERisDrE0uPcwF/hPFSmEP7ftPENIWbQaGGGCDJX8CypW/Fl3s2eH0K/C1Fgfc5
	X2EVSAvzmBeIQvSeMbJX7lPC60wICgP7seZAEIOQ4+2nXZSswnTxBvgZXl60YYLqRhFRJyoG4NenD
	Jjb20aZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQqbb-00000004naQ-035P;
	Tue, 10 Nov 2026 18:30:03 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQqbY-00000004nZM-4Bhb
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 18:30:02 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2e9f6a16afcso2465ad.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335399; x=1794940199; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h/fDqdjeF2qNLQi3iaEH9vKqxnzXslPVSp3ugOVQ8hM=;
        b=JQaDiWU37C3TG+pBX2udSkmCauGkWwISGda7Ugm3c0/ZyEOW1U2lJla8eeP+xdgtTO
         FQjdFWhM3Tgiv3kYxqD487j3vrnVH8f0XfqZbW8AwXrPxSQpuNJkcG434lQ/BVp1gf9X
         sN38uNCczqQbRM9+qbab8wNAG2K9vCpSnfZOe7t870MzcmCXKgvZofJEK0VZep+moNwj
         mwfOV+wBkUnbbVo6uAl4OLi0Rcl6YeA8Klwg44RX8gTmcTaeqh/Tql7f/lnhmfByEu09
         /EW6bl/Zl2VhgBTWQxMX/InLMZjffWd6deJ0dR0vgiLRxBBnZRrmVlrioftv5d4DefTj
         PrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335399; x=1794940199;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h/fDqdjeF2qNLQi3iaEH9vKqxnzXslPVSp3ugOVQ8hM=;
        b=wmEYfckZsq5NERU2q/0VXPV2yetfs90Fa2U19oYGUFeudgm/lNmjKwOO99qkcJyWre
         EFniS8GHSLaqxgMlUdAHXqtsL2BsNAoTb68ai+76EGQPViAbXnyZbH5FOEEyps3D/SPL
         9E2xk27dI8poOwtWBqNIBFBTDKBeVpQBo/wx4CzBjUaeOpt6JIjfwdrzOhWSQB8ArB9i
         Ahemx0PucA3VzLCFuhn01WwLF64zeWdhfR01+EUpAhVfko2w6e72VWiQb2q6rdtvQ4bK
         G3lRykEIojO8enTvpQCL/tpGqBRQglL9mPOOCHuVJRcatUESCRNqGE8FXoQpxjbilENA
         xLlg==
X-Forwarded-Encrypted: i=1; AL+hErEK/8NDzrQoL7j7ht3zMJ3obFiL6784OiklCDAGy3vkVZkkz0Tpk4IP8NeBjgY9ceCJHUWuwQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z8De7e7iM6y2dI+ZEOSm3K+LI8vHU90PVp+qePQq0oXzWcqyIFx
	ed0N6MRIBhsW71lynawZZR49rJwMmS5hCPNEC3abrR/aGpZEtgu3IYrAnK42uYZPWA==
X-Gm-Gg: AYBFou39UrZY59Fb7FJi8Qm2bzkij/XJQyBxm9wQaHWbcwqNvF9MwNzL8yL0kr48V2s
	WPcn1m9zaXD3NEtjsAtsFefoEvHrELjwtY3hxCtszpUNgivbU7CtH13LeWw7XkWTQBulGyqodbJ
	cQD89AoOhY0IcLAj1JHJBVaULnyQA9qoVoCukn3ML/3wfvM8fzagnodTA+V89565Stq/juf1Pod
	NDQtDesc/T7BPgGrkHOr7ANTPnjpEVM4jC7vpY74Geh4htqbunvZEps1gIwv6nrrd15oD5d7Xrp
	Xk8oZ671WIjUGjfxM7TorzPsgPrbnltndCkL04kKXmJxhHRURyK7mK0g3xQKkOAQRQmcnZM/S7F
	1Qqs5IM1nSGRIc3uCxDLv/MWSYX+H52d90N5D/aU2tVmxObog0rrRMY7QSrHUFwu3XAagNCFtMs
	BlRJzhi40WYABR6QYfxHfpCWWDNhiMgs6nRnVKBR79qfTQd8MJ5yMjDRmqVmtiCd0DfvO1/xUcu
	CFJRRJhveEOFtjuCyVCcmBKA0DH0vsmBQX6qJmkGw8wJNUwWcxG5g9tVc/cd/35MOuD77fEEQj7
	VbgfTp0Zp0iMz7u6drbErHtuTXwE7jdWAWsro6A4kcXhEpFMfWbm6yjfbuyLAobAMBdBhIHt75u
	ylKddvlohlmhHaEVW2V9o22ry9rItweKwqyzSwQsqHSQ=
X-Received: by 2002:a17:902:ce04:b0:2c9:b404:b55 with SMTP id d9443c01a7336-2edb81c27e3mr6143235ad.6.1794335398359;
        Tue, 10 Nov 2026 10:29:58 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6a4013csm12795005ad.1.2026.11.10.10.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:29:57 -0800 (PST)
Date: Tue, 10 Nov 2026 18:29:54 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] liveupdate: luo_file: allow keeping private_data
 from retrieve until finish
Message-ID: <avNilY9saqTlNZNn@google.com>
References: <20261110175855.2437084-1-pratyush@kernel.org>
 <20261110175855.2437084-2-pratyush@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261110175855.2437084-2-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_103001_044601_531DEDED 
X-CRM114-Status: GOOD (  13.36  )
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
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 06:58:52PM +0100, Pratyush Yadav wrote:
>From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
>The private_data field of struct liveupdate_file_op_args lets file
>handlers keep runtime state that is not preserved. It is set by
>.preserve() and passed to the later outgoing callbacks, up to
>.unpreserve(). But in the new kernel, nothing set by .retrieve() is
>kept, and .can_finish() and .finish() always get a NULL private_data.
>
>Handlers might need to keep runtime state from retrieve until finish.
>For example, memfd will need to remember the folios it holds on to
>until finish so it can release them there.
>
>Save the private_data set by a successful .retrieve() in the luo_file,
>and pass it to .can_finish() and .finish(). The handler must free it in
>.finish().
>
>While at it, update a stale comment under struct
>liveupdate_file_op_args. There is no 'data', but there is
>'serialized_data' and 'private_data'. Refer to them instead.
>
>Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>---
> include/linux/liveupdate.h   | 11 +++++++----
> kernel/liveupdate/luo_file.c | 11 ++++++++---
> 2 files changed, 15 insertions(+), 7 deletions(-)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

