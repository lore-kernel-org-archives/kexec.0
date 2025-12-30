Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC528E94120
	for <kexec@archiver.kernel.org>; Tue, 30 Dec 2025 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TKytMjDcx2cEgvRyAJOuwCgpAgUbSodYKmBemClDjaM=; b=PDCOHbA8nF9sTWA4KDXqlyqLWB
	wd8g6UeUmOhi56MPqsTqpM8vo6nOod8CaOpI+Q2el2fvKmsdZvhjCg7N8IQaM0D7PHdKcntejWrEi
	OzeQ+72ILuygW+BnhxRw7xXGWx5I5gp6zKsWktRQhrgC+V8wyNnC/+ec19upjwRf6wdE6KkKjYwoo
	kubTOCA3zowgPYT59AM5iDCge0ncHTgj4Js91NqmMM+Y+FbRdt0Yi2raKyGaGpxTr+TZdCHX7m4rv
	Y74Y/AYKXIJ8cYUa5g+r40oB+OjBteN4x4ivkRId0XvLrbxboI7lBF33ahEFJHK63N+QYiYdyZaJ0
	c0t5gTQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaVRB-00000004bIn-054B;
	Tue, 30 Dec 2025 08:50:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaVR7-00000004bI5-0BQk
	for kexec@lists.infradead.org;
	Tue, 30 Dec 2025 08:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767084635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKytMjDcx2cEgvRyAJOuwCgpAgUbSodYKmBemClDjaM=;
	b=C2LiL2M+EJeHZpFxaZPm0nkqGYDkIgp8IupEgl3c/Dq6YsrarIr/R+JWH9iH2Ik9E9QYVD
	UqQxjdgBaK80eB3kqpsv6M9KYjcBCsjEvCdWEgDgCT/f7yrQUmUuRMIc9JNe8F9klnLD33
	o5sXh84NWWoM1R+6MPRLEVFe4ysT8u0=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-ZTLaQKSFNpiT-yReWebuMQ-1; Tue, 30 Dec 2025 03:50:32 -0500
X-MC-Unique: ZTLaQKSFNpiT-yReWebuMQ-1
X-Mimecast-MFC-AGG-ID: ZTLaQKSFNpiT-yReWebuMQ_1767084631
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-3f509212de4so7303587fac.3
        for <kexec@lists.infradead.org>; Tue, 30 Dec 2025 00:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767084631; x=1767689431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKytMjDcx2cEgvRyAJOuwCgpAgUbSodYKmBemClDjaM=;
        b=UcgYKHjsveIXHUXfubh4IneNK2I8SkM8jXEVjA+RYaRN7AcLk1T88r2KCcrDhBlm8Q
         0UBcfvEuTkRmBsTPxyIB3iyH7mtn2cLQQ9Ln/SMIi2rczdUAHGzFmZTwYZJoNtIruYg5
         0VMa04YxFFYkL3SUEyKr3LzChAG10JYZXEHmZEiacytnAYQc7r9pJF2WKpRDqEqCV43S
         42wlKtJp2mKM9e4w13j77L/JE2RgW86SR1/6ktGz/RnTg/nHndQI7iHKF1m2k1zDB7Di
         f4g8WeYjbP9CiA6khc5VeYW8cnEaBUTdPM36kIIlg0M2tX0CyUimd5c/94fXB/qSWZ8a
         SeMw==
X-Gm-Message-State: AOJu0YwNTtclUllJKx8dOnAX4WIqOQjw7J4hYuSuGW4EeJDurx6ZsEX/
	JOGYRZ0pVRCDO+7gd48xvRsTe9ImWErszAu9CtlykwsBcHqPv0VPQNAQfc/JmnejhbdAmVcLdNU
	p2HKV3ZcyRDtty099Xdxu44i5h+he4ziZPnztpHJBCzI9ugJuvDN8Qt1TPwh75Q==
X-Gm-Gg: AY/fxX4rqy0csr7ywanhPIFdhgLjUfbJE7bQDouesxS0R+qdgvgs0kmoEDfK2cAD+Ug
	MGTrKes2xjHx/WJcTGXDz4PEOJPZfEO/vG3a5WbTG9NczKP3yyoGtve6TwwYrJrW1gqS4Y/D9Rv
	TUfZB7IoOQtcvw6XuBhEXVI9nvo1ejfNxt1LGtUtaZsr5Sy6YdlvcXOmal3r/4o/cudvhWtMe2n
	4EaaIIRCu/F8vvsiZLwS5WCeTwiIeWXbKPnUSHqpqY3AOFRY3druMoMsl+rjxfZ+PjSZkBJnGbp
	67Wid54J7lXIEuVURPagInJl73tNTwDATnTDj4BH/Q6GA4hC7BdOXKbsczdeGZCetwe6rcfP4gx
	z
X-Received: by 2002:a05:6870:7d8a:b0:3e9:35d4:213f with SMTP id 586e51a60fabf-3fda56056b2mr15471534fac.10.1767084631238;
        Tue, 30 Dec 2025 00:50:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMfpvG2CCJxNM6ePOW5CvdhtIiGZOipOUwNDSwmNEEJmtJ5IiPBkGWUWkmOkbvP8RoitQvSQ==
X-Received: by 2002:a05:6870:7d8a:b0:3e9:35d4:213f with SMTP id 586e51a60fabf-3fda56056b2mr15471513fac.10.1767084630711;
        Tue, 30 Dec 2025 00:50:30 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaa92b5basm19742429fac.6.2025.12.30.00.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 00:50:30 -0800 (PST)
Date: Tue, 30 Dec 2025 16:48:14 +0800
From: Coiby Xu <coxu@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <aVIR84RJSv42YEP1@Rk>
References: <20251226141116.1379601-1-coxu@redhat.com>
 <20251227-funky-swallow-from-pluto-910b9d@quoll>
MIME-Version: 1.0
In-Reply-To: <20251227-funky-swallow-from-pluto-910b9d@quoll>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZSm1hYN8_Ad6b1nKBenGWfVFEBIMbqcqBNoGM2-XMW8_1767084631
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251230_005037_145081_5D1B6D24 
X-CRM114-Status: GOOD (  15.70  )
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

Hi Krzysztof,

Thanks for your prompt feedback!

On Sat, Dec 27, 2025 at 02:14:16PM +0100, Krzysztof Kozlowski wrote:
>On Fri, Dec 26, 2025 at 10:11:15PM +0800, Coiby Xu wrote:
>> Based on the CONFIG_CRASH_DM_CRYPT feature, this patch adds
>
>Don't use "this patch". See submitting patches.

I'll use imperative mood in next version, thanks for the reminder!

>
>> LUKS-encrypted device dump target support to ARM64 by addressing two
>> challenges [1],
>
>
>...
>
>> +static void __init early_init_dt_check_for_dmcryptkeys(unsigned long node)
>> +{
>> +	const __be32 *prop;
>> +
>> +	if (!IS_ENABLED(CONFIG_CRASH_DM_CRYPT))
>> +		return;
>> +
>> +	pr_debug("Looking for dmcryptkeys property... ");
>> +
>> +	prop = of_get_flat_dt_prop(node, "linux,dmcryptkeys", NULL);
>
>Where did you document the ABI?

Thanks for raising the concern! I'll send a PR to  
https://github.com/devicetree-org/dt-schema
and include the link in next version.

>
>
>Best regards,
>Krzysztof
>
>

-- 
Best regards,
Coiby


