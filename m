Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC8EF9D0C9
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5ASkA7Nn7xJnrWaDwgTWKCL5Qaagce9AuQcJVX/rI8=; b=E6Be3DXkTvzw6ZEtcXGHKvnmCl
	JYhoGEhG8K8an7UXb84RKBtxOCW6qjzaHTKPpN6hTtk8optcBio96VkEEq79avCefrLMWnqYAFbQO
	jvS7T/jR2xhmJeBocUJfton6zCGmcmLpMulKGKCmb99O3Uy5DALT1dLpUEMK6+9TV1Z23IWTF6JtW
	rMPhCoKoA/Iis80pD3Xzt7mS9S3B4MgyOLwCkaaqQI/rOuIm6VqGFPAo5e1IUxRZM8N5VIxWH1Uj0
	FRvCdz9HKbQDl63v1ay68dhG1Gl8uTHhvIxoG0F1USEwZu2DxSPiOk+GLi5wh/uJzNsZNXQ9iqDa/
	+JPNIprg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCdRm-0000000HLLG-26RZ;
	Tue, 14 Apr 2026 13:04:54 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCdRj-0000000HLK2-2m6Y
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 13:04:53 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so9446956a12.1
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 06:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776171890; cv=none;
        d=google.com; s=arc-20240605;
        b=jINEIahu58/1lWEXqj5GnnEhhido24KFesQnIVTM7GgF8GmseKybDgV26d5JpXgeP9
         zXKE9URW9RdhocTkpdAu8ETF+LZsmOQlHzzCTVk/XY7aQJKaqYu0aB78pKlGigsGr/Td
         ioPJxCUuWrg+g+bc5XDqa/ACtWtCA/HF71AZg9E3BjwEnPNnPjUr1pOtLnybEBLJ5M7p
         Dydjc8QhjPKLPEuxc4Xfz6b6dyi1XY2hpiSCwzU5wo6R6D16Eucu991xKLETLQqLKQL7
         zxUE1t5Qec/0TPgBXvrD0W9Jz5Qt719SXm6jVGweSzrpSk3Y9l9BPIWXckCjfEqrsVP3
         1Fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B5ASkA7Nn7xJnrWaDwgTWKCL5Qaagce9AuQcJVX/rI8=;
        fh=IQrsI5z0ypQhHZxXeTu8jWbfgzLzutQc5C+LAgvEF3M=;
        b=LWdyVC2OweYamkt6flDCeQDSnkztLHw+T4Gg5vS+XdEsaw+Goo23R3XducHlnVRCtf
         6dN9v+QsMIqidIw27Uv3O4icEgLKt5BSAP2TMUYGxoyplNupi7XF7zUFgWsXQBt1sHF1
         pEPq9BtrdtsEnCOWpOT6bbcxL51nX5YcpRjrkl5dvilDEBFk5DJEHiZIwZii5CdQqXC4
         /I3O7mUWF8VYIZ2tRUqGntCSKA9CISSVWFGvQG4wxE8Ku/mEdaW/SOMOUTClLr0cqRQu
         ZY8k2dD/p4b29j/C5O2ijuKJsXsGwyYzd7LTI+fl72zQLf1Pf+H5UlFVS2TXoMCYXkdq
         5Qtg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776171890; x=1776776690; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5ASkA7Nn7xJnrWaDwgTWKCL5Qaagce9AuQcJVX/rI8=;
        b=XnY/8SWxJDsjc3WKUYOQhx7WFeVNXe/rgfYYkJqr0JNDqQ5C/hIIDEUOLXw9Ywuzqc
         5eADfFx7XHMuRzivtXxQT5PgPhM5wAcdWwfymhgiwM0jNRcCIId9BJ2gjy+9chW2zZJw
         bW3sjSIZnxoPjE7wdKLEpm3Iv00+7cUZIGDScHmXpC12wKVuzonCd85OBTKBfGZvN7MS
         bZIYnQ/G8iY+WVjDnwiI2/xfE/ZPo2Bn/79ZJcOz0CC7d9Qmvh5Y/wTBVcEJqCUzEgKJ
         KLkstG+UkJq10lgZqWFwLzhZShMlXuZhkF3zrhZCR+X2nCyW8zDds3vZkVlUx/3k66cq
         r/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171890; x=1776776690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5ASkA7Nn7xJnrWaDwgTWKCL5Qaagce9AuQcJVX/rI8=;
        b=NIUPN4oPhAsXRvWsFXY+idXWNdNMHHch8NBXmQN2cjgpV105+kag3Z4+eCZ9AbrsyZ
         OSo05iujeOztZEIMgeiMuASToeYSK8UELh3P2gIeNqTLQAVyUmk/rOTn2197VEho4GeC
         x9zf+V/zD33AtPts5M7Hi8Ltjv2lPYM8VJrM/pW+VGNpFAoWaLKrLcNe/MreVJkGprsP
         ac00WIckmHQlhj2lQeULAxxIOaFcB5JSybCpFhqoYn1ZWdrikKad9ghts/5tPtsvy8pC
         H4zRMr8sT3v7kJnuqleVnqcUi6wsDfLfqNslCXgU54R/E5MB33HPnN0Y+MzkqI+w4oky
         xwZA==
X-Forwarded-Encrypted: i=1; AFNElJ/TbygKAfo84QyamRqhrhyHx58BN6/ey18vuNwAEGlE/HK/zpxNeRPdWy3q+CR4NLSHXBVQcQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz52QB2nRN5MhyTGpkpPNHEiTY9ECazA7+YWedcWrCHojXoTMz8
	Yzz/5sZL0vrVwvd0nVFSIDtTGKb3X5KHNnIMlG7jafY0Yn737bzZ84xe7usgxf4S6UYRMQGqZy3
	iQNJJNaTLTMbF3dBW9HxnyeiPH0vLuiLLjqDFUEWlkg==
X-Gm-Gg: AeBDiesEIrDnQwbtzjsgXg2/F1mmlJi2UujFU5DiG7G5eBeR4calclbMSQQbIPog2Jj
	wJuNxGH9ZlmrpdCJ5eCRDuMXhbn5aP5alqrf55GXGXEEdk/a4+jPjCk6qFedtjnfxK71qHn81vV
	ctdz7i14oF+sNIyGjWxOAaFVt7LlTCDSjMNJpv0JKyDzvJAhG/veq45OU9S3+Lm+3G7fLjxfYsc
	IV1D19nhUQQZjClonCxelE7Nov/twEaEiAJy2vlmWBxSMvMw2r4Guj76OLIRg9IA1/fw8MxWqTD
	EzGrGg6ysohP+HofF3E03KUSo20dIWiUFU1pBA==
X-Received: by 2002:a05:6402:4410:b0:66e:68e1:fc18 with SMTP id
 4fb4d7f45d1cf-6707a47f88fmr8238343a12.23.1776171889504; Tue, 14 Apr 2026
 06:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260414121752.1912847-1-pratyush@kernel.org> <20260414121752.1912847-3-pratyush@kernel.org>
In-Reply-To: <20260414121752.1912847-3-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 14 Apr 2026 09:04:12 -0400
X-Gm-Features: AQROBzCKTkocxUqaZGO7GblX5QsCAxwNwtdtbLZl2LSOWRE9D7gkFi-Y8v40LZM
Message-ID: <CA+CK2bCgxsb2W3gJ0ZF+M2D+6jaUemP8HR90SKsHwGi5S5963g@mail.gmail.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: drop include/linux/kho/abi/ from KHO
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_060451_715115_D533E12B 
X-CRM114-Status: GOOD (  13.17  )
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

On Tue, Apr 14, 2026 at 8:18=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> The KHO entry already includes include/linux/kho. Listing its
> subdirectory is redundant.
>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97820188a600..c1e2cefb4493 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14121,7 +14121,6 @@ F:      Documentation/admin-guide/mm/kho.rst
>  F:     Documentation/core-api/kho/*
>  F:     include/linux/kexec_handover.h
>  F:     include/linux/kho/
> -F:     include/linux/kho/abi/
>  F:     kernel/liveupdate/kexec_handover*
>  F:     lib/test_kho.c
>  F:     tools/testing/selftests/kho/
> --
> 2.54.0.rc0.605.g598a273b03-goog
>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

