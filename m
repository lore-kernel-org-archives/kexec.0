Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37D606A851
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kygOR00A;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyXQcHM2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=D2FzhDRzTtc/XzcM0zNgPuhyPMJQZQhyp9SQGVRa/yY=; b=kygOR00Arn1dT+
	9NBu3F695w6i88+p+LX9tlDs2BZWwOaFq5K84rZLlvxUAPm2S4FUROCSAzuO8XoIRhhUYqHBlWfg4
	yTDR1zPt1CdJ45e5YcTPwPNFctvQqrGk4QoLa8qhZau+Q26XW/uydbKrRSg8ATeJ+mp5HAR3XeRik
	HVNlpykrjcqlW1y3XTjqr34fz9ZF8PQRk8eWFwGthyeTl/+uSZmSR2Pf9o5UqoBezTmqUh8U9/POP
	kmygsHNgm2eAaJCKkZt2YUksStpkV50cfmT8kN6wvMszpbhQ0IvYZ5LxglFQ2hDhJv3BT3YDbUxUj
	cz6UJqMSw0tU6y75x/BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjFV-000000078QZ-3DUc;
	Wed, 04 Nov 2026 22:14:29 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOjFS-000000078Q6-3wR0
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 22:14:28 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso859732f8f.2
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 14:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830465; x=1794435265; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D2FzhDRzTtc/XzcM0zNgPuhyPMJQZQhyp9SQGVRa/yY=;
        b=tyXQcHM2GvJOkG+yMkj94I3W8ExvqnWTsP/8zeid2X8c9pRLsSIBsZ11bclgz6CSec
         7XmazzD8VyWf99DOpR4Kk4BK5XkFfYPNWfPD9I/oE0gUWWIo207d2YQYmUph9juD+6sz
         UhXBtqfEVggK/dbXZ3cqQNcvXIsSG2cdZGdmDlJT7hW186Rd813ET3zpEz3ZQs7m/0Hy
         wLvPLVtDQ5pu2Cg/c9+mUOT7PomBmLVnMl4lUIqIWUB3l6FEUaopSWKAY1yX+RMn8Drl
         Ot7DJqBKtF4IO9rVy7URc83HAbxB+6K3WzvZxEHNiDcUFfxm2a/0FBrdpcNbZ0JQ1gZN
         vreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830465; x=1794435265;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D2FzhDRzTtc/XzcM0zNgPuhyPMJQZQhyp9SQGVRa/yY=;
        b=OZRCsJ5fJBbSWPli++4hcrhW+ogcOLm8ndW6Crnvqw4P5JPx1NpaOSbDNY7O/C7hfH
         ujgixDuNmkz3B4m8T1wtgW4rMvyFWbLCNphRAcUjLwws52t2BDGSHnE4UiuK6VhyiXKb
         2Uo1gV+ffFCBCMkNkr4yUF/+rtO+Bb44PIt2wHr+sx+RXaEyyXFLA2oUbLORvGAr2rcG
         k1sCuVVL1x+s5J3TnRBwTW3707GddbVLVyUAB69I4s2+KqTcJoa6drs/HbihZwo6dI0z
         YV1OMMsZ4OXUaEEgUHprtBIUYTkzPNSuemGW47iavVOOXMfYWae4qCVnmg9dxbIZU+QU
         DofQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfM7Zz36STH4LKBoVYcrGZB8ly3sn81hxgZoMxOYLlF14yYoQ9xfGTX38J9cCji54dNtasbA==@lists.infradead.org
X-Gm-Message-State: APuU4Z+XMHlNxIyez5M2tLZ7gAMC1Oq7V3brBDJE1MqBbcLF8P0FnPtJ
	xfz1WJlvJmsg/vyyAWrfVdH2/V/bVo+tsV9ujpc0eU3CQgUe7e4Om48o
X-Gm-Gg: AYBFou1b8ahXZfG66g8sbyHoMX9sM0eRxXDhxkfakQEPzfee/U5dsX79SRQaFXtKn4V
	xNafKMspLTKwCjogKRk+pGp2IoC+Ce7J/fQmXWK0k9gfVieceUA7fI/AcvTbZ5PofAh+zyGzfeS
	Pn6jPJDu7A4KZfEbZJ9sooYPQbfydmMkcqH21E7o1XeZp7am5tSxS5AH+HI3+cTj0Dc7kdMmWsE
	XJnkOfyAG2wV2czIcRZzloyVkCs54KEkI7NsxC0gC4WgGw6jm9qpi1s6T4C9fU1kSZHHy82kJ6e
	rLq2nBGNPEEzhdNzMz6XosUm+4QUwMTtpGee+rcuVcRpAYktMIVxxmJBkC6s84Hq1KrATL9EGdU
	8KDeXipoFaIWMVkcQekSYcnwz7zWE/EwBUeoarHtU1jthY/d9wSuxVyt8UlgCzw7OGxzCBrsCBo
	N6HWKHYbLj3QhC3I9c735jB9wN4UoCteEVs7RYyH7T+HVJfwFPfXtY72D828RUTqaT+/QBDpCnu
	6sIJp76N+RHmrS1jBn2nEkX1Z3SlSvW5xFmdiYyP4ZfDtSZ1c1jve19saP6ilhNzc7864bJ163L
	qQP7X1GtPqtPEEYAcCObm56HyCvKBXRNCECV5MUDcnbf
X-Received: by 2002:a05:6000:2c04:b0:48d:f7af:be35 with SMTP id ffacd0b85a97d-48e6e303f44mr39514518f8f.29.1793830464779;
        Wed, 04 Nov 2026 14:14:24 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed552aaesm6405241f8f.40.2026.11.04.14.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:14:23 -0800 (PST)
Message-ID: <ee08889d-4cbf-46e7-b6e5-3cf4fa8cfc6c@gmail.com>
Date: Wed, 4 Nov 2026 23:14:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] kho: walk bootmem areas in address order
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>,
 Kexin Liu <liukexin@kylinos.cn>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org>
 <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-kho-bootmem-sizing-v2-1-b0d1a834780f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_141427_025363_AAA63A4F 
X-CRM114-Status: GOOD (  14.58  )
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 5:50 PM, Mike Rapoport (Microsoft) wrote:
> kexec_add_buffer() users may depend on the order in which memory holes are
> searched. For instance, arm64 places the kernel bottom-up and then
> requires the DTB to be above the kernel.
> 
> kho_walk_bootmem() walks the bootmem areas in the order they were
> reserved, so if the kernel lands in a small area at the top of the memory
> there is no room left for the DTB and kexec fails. For example, on an
> arm64 VM with 2G of RAM and kho_bootmem=8M,64M,64M, the lowmem area is
> reserved first at the top of the memory, the kernel image takes most of
> it and kexec fails with
> 
>   kexec_file(Image): Could not find any suitable kernel location!
> 
> Sort the bootmem areas by address and walk them in ascending order, or in
> descending order for top-down searches, like kexec_walk_resources() does.
> 
> Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a

