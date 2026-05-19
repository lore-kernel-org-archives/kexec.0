Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D60CD4F5B
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bDFKloV9wCzA7ym/ab7C+z4oYqNZXRFYLSn9rPO1gY=; b=u4tRm7+c9ZoDztVGbm4cbKihLU
	6EsJSEsOaEq277ZQGJ+k+rD78E5TUTLk2O6T2MScdKAdb8W/LlPeWwpjr/ssJZJnaIuZ8ZYC/10I2
	LrKfvjjxcRJC83t2lb+WAG88f/cPTNl942wsfgdOguIUHD3OETKy2NRVhNzmMjJfiSg51yE86qCdr
	Vovz5drK6IwZxZswinqXFI+IEnnb45tUeTf2rkhIlD0vRqfIxLl5P9YNV2lmwJrW4OD1fMlzsmHzn
	QKHr3CMWuFt0wIBfBmVoH5kvT0Eehg/fvTYuzCgNWIhSmwW3UUxuLh3LYljp/4d8rFYlxxjcXSYGz
	3LJmXqGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPPTg-00000002XUk-3jYL;
	Tue, 19 May 2026 18:47:40 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPPTd-00000002XTy-3QIu
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 18:47:39 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2b46da8c48eso2525ad.1
        for <kexec@lists.infradead.org>; Tue, 19 May 2026 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216457; x=1779821257; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bDFKloV9wCzA7ym/ab7C+z4oYqNZXRFYLSn9rPO1gY=;
        b=sdR7lbS+5GMdKpgRpMe+lHDq49Q5ASeGaN6cY8xj2g4W1COfIN897YonRLkV/t0bPD
         xsi9jLL4CnNVj+KqNcxpqOFyT1N9hBVAAfc6Zqmb3fqw4f7iS0lOK+YuyMIw+7KS9DEt
         vcp5RvFLNSziTXD4kwCnTE3nK1pTDbYPrhEkYGPv41vP8m1YUR2BWjgvc8jNfKwOPIow
         WK1GzZsRZPNaFkTxKaQgzPtmnahRl32xoc7eLNUafYTFs8WLVGisDiYTXvnWJFCbc5Ta
         I5k84EPF5/VFhajIDNqx8vhhnY9+pCKEiUHYeedOtYx2YXBxF7rFI24lE3Ha8u0aISfq
         WnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216457; x=1779821257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bDFKloV9wCzA7ym/ab7C+z4oYqNZXRFYLSn9rPO1gY=;
        b=NslJj7VRsTfBFUysfzkxBkefchak9vsEBzzpgeUAUz1+HcJsymCAY1n28ZYcqPrk12
         cFRvbjJ0F9Qfe2/VW/WHUXiPRqxJhmF4STD2/ZHMROK+J69ZsTf5MHc3JO8JIkaWnLBM
         xJufgtqaEWn6n740K4B37A5bJIrn+PG7P+1B9cfh/U0eqEMQSSaM8fur2uPnjP7j5UJw
         9a83g1cv2S+8fN/ngSW+P9io6g+eIGCngVBlaIj2s17M1JFg7JySo9yLb2n2n0RDa2ED
         ueb5RuHdnOiOl36sZSmOKikwOkBBg/YEDI6fvWRFicAY4kx4NXSXLQ7XZTOZ2h58JMnj
         zCyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8h/qYw5jjVe5aFLkD4Y9zf+DPVfA+AhlKiXVpfaGInQ9zMQBzDIsq3Q+vVzlBFLfD90wVVg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwfQMtahnBWyPSYBqbsJyanOxBRnMkdro0u7Cj92zibMMSxs4Wb
	pIctCTnAjUIGLkMJ9mACRihUSZ03HFxeztaLsMY/zvU6EWoDX2Ez4D4wg/NCMM0yeg==
X-Gm-Gg: Acq92OGvf3lk2HFZ2UdR72EElYIPFOUAmVLGdf6SBoilxAALOD8MUixJY+mh48d6BLs
	/huA/D7MN9DSfpsJAAYKZJcYINqh+BYL30FWQefVbhz6pEv5Ow7LrILcXtZLp7ksk+D/xrKy/9e
	imnlZ5zPuMdcuvsZkLc6BW6J1eh5r5QkVg+qH3k8QrH01lG5BICCjuYHz6wjeU2lwKBHcIZfcDo
	uDGBGMBjwFTSCD7RHBn4Ddp6S32S6Ra1Qfk/1okbLQAxioKtmnghyFL4UO6uliY3i1+esQ6jAu+
	XbmlG6tQ4AxXMN/DqrZmKILFbS7uxr5mslOqOmDCsUqyZxvZZ/bVU7h4M0IXIEAqv9NLZ0ViEFE
	DpHVOnyWAQ24P4CMhYH14UcQ3aOJNSqP19fvZCD7yGJoC/WpXKVew3CsDVX2aXWzjTw+K6333LE
	70CyAJPRK7l049i4Ni5WMFvgTJApBFUNviDUVa7/ISWB9zdwcroh/3+8s1AyldjUF1aGuYUw==
X-Received: by 2002:a17:903:1983:b0:2bd:6dad:3dfc with SMTP id d9443c01a7336-2bdb041156emr6226085ad.26.1779216456323;
        Tue, 19 May 2026 11:47:36 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11ce67sm198205895ad.74.2026.05.19.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:47:35 -0700 (PDT)
Date: Tue, 19 May 2026 18:47:32 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kho: fix order calculation for kho_unpreserve_pages()
Message-ID: <agyvXfrf6aX8LE19@google.com>
References: <20260519133332.2498092-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519133332.2498092-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_114737_859066_7DEF72AB 
X-CRM114-Status: GOOD (  11.97  )
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

On Tue, May 19, 2026 at 03:33:30PM +0200, Pratyush Yadav wrote:
>From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
>Commit 91e74fa8b1bc ("kho: make sure preservations do not span multiple
>NUMA nodes") made sure preservations from kho_preserve_pages() do not
>span multiple NUMA nodes. If they do, the order is reduced and tried
>again.
>
>The same logic was not implemented for kho_unpreserve_pages(). This can
>result in unpreserve calculating a different order than preserve, and
>thus not actually unpreserving the pages.
>
>Fix this by moving the order calculation logic to
>__kho_preserve_pages_order() and use it from both preserve and
>unpreserve paths.
>
>Move __kho_unpreserve() down to avoid having a forward declaration. Its
>users are further down in the file anyway. Also, it results in grouping
>for all the page-level preservation and unpreservation functions. This
>unfortunately makes the diff hard to read, but the main change in
>__kho_unpreserve() is to call __kho_preserve_pages_order() instead of
>open-coding the order calculation.
>
>Fixes: 91e74fa8b1bc ("kho: make sure preservations do not span multiple NUMA nodes")
>Cc: stable@vger.kernel.org
>Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Nice find, sashiko was also complaining about same on my kunit series:
https://sashiko.dev/#/patchset/20260512195135.804833-1-skhawaja%40google.com

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

