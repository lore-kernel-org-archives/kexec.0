Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD80C64EC4
	for <kexec@archiver.kernel.org>; Fri, 10 Mar 2023 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7qOQxGgPMld4ClB9ipusFSe/Lf3i6LQUqDR7V8rzSn0=; b=NpQ/oPxwvJZuvbdNg2HwayV9w9
	on8kfEaMIB47GhXFAGFJ9D+PNE49/tN8JnlrxjVGU6lDNQArjil2IJFjBrLwRv7qnGZqNUU6KcR+c
	KKPoR1b/emz0SkHy8DdjD42S+3/B9ZJK66ywrzCunv4L/PsfDn2UplyYG/x7rxQVcrDRZdmYdDn28
	FCvOcS2umik723yHfw7cshUfz05lzmexVdik+icCYtUVkDOSVDWwcQrP8afrEWaqZXK75I3H6E3C8
	xZp/IcDrZBmxgVjVAy799Kcb9MR5mazDVCXH0d54A0APH27ZxEgbNw71IEK/cuMnac/zejJlTO/BR
	ispxWyGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paYZ4-00Dnr2-Vd; Fri, 10 Mar 2023 08:57:27 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paYZ1-00DnmR-Q5
	for kexec@lists.infradead.org; Fri, 10 Mar 2023 08:57:25 +0000
Received: by mail-pf1-x435.google.com with SMTP id c4so3210793pfl.0
        for <kexec@lists.infradead.org>; Fri, 10 Mar 2023 00:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678438640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1VtgZWk+HjXenFKjPpHfn0DN33LLaYk0FmNJWNjz/8=;
        b=B/I2yfr49AEDmOO3dUKOiflWB5RtJAuXC/DJk7jtMBh+UtRe4lfJY66f9dDsSRNkjG
         s64zfOQYmLzGWm7t7mkYoTr9fx93OaTM1/L3DQS4PUXrR/KEqumGMQ/enUgmMU2SUl7F
         nP/tAlESCAMxOSZE1DEwDDaoROEOXTtGVJOdfPx5d9Pwcqiqb7fXV/IMfiNx3bUMWS2V
         wik1CRUzqe/crq/ywwqx1oroJjCNkrTZ6E/5DtpmP7Xtk19Ojd3qh9uZrs5XkQmy0B0C
         tiOqgANXMHxtgd/nRKPLPLMjIraN7GzSaVvzVJB2c0lLw5J5sN/lzBWSSDfl1jYefJHh
         XXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1VtgZWk+HjXenFKjPpHfn0DN33LLaYk0FmNJWNjz/8=;
        b=NSbFYMaLjp9XeLtwPYKv3znNiUl/kgIsFvcxfwOBRifCUcEUJFe7czIp/eNvYjMPsW
         2r038UD/Y76rBecC4/Cx/1qIb3ZUuH+JwwNbljZiQ8psJYChXPcS8d4geLQpucOV5vmH
         OjpGi0EqB8ZqMpI6Z72cdykMg/dfwpcus0etM6Zgi7y81drl58M6SAtD2DXWUWxJCt1n
         peIG5Fi4DFij8tHm8cpoJnODv5FeagfK+qSV5Sk2SUQvZmKmioN5zM93evO/iOgYknJY
         nzC9B+wpGQi5F4dSWTZ5ltAl9u2FHaaTPI2Y4iEl+NFQQFJ+O/qti8qafRuJuK9y3VFn
         gUvw==
X-Gm-Message-State: AO0yUKV9BWvHF4J2fC1a/n/YAGPl81O89bfYSg+PkOEHziCfRMtqRPMr
	W6MnS5p9dCG6G5gZ+wZ1aU3EWuhx9Iinkb7bjyA=
X-Google-Smtp-Source: AK7set+yZha6GiSITCQI2jS/+04CLPiNL6J0wLrKIb2itQreHUPzN+GqaGS24sVC5b2tgEF76HNtcQ==
X-Received: by 2002:a62:6143:0:b0:5a8:bbac:1cf2 with SMTP id v64-20020a626143000000b005a8bbac1cf2mr20558744pfb.1.1678438639683;
        Fri, 10 Mar 2023 00:57:19 -0800 (PST)
Received: from localhost.localdomain ([49.206.47.87])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b005a9bf65b591sm899151pfo.135.2023.03.10.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:57:19 -0800 (PST)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: kernelfans@gmail.com
Cc: akpm@linux-foundation.org,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Date: Fri, 10 Mar 2023 14:27:12 +0530
Message-Id: <20230310085712.31515-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230306030305.15595-1-kernelfans@gmail.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230310_005723_900131_0AF992C7 
X-CRM114-Status: UNSURE (   8.20  )
X-CRM114-Notice: Please train this message.
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
Content-Type: multipart/mixed; boundary="===============1143493068537525229=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============1143493068537525229==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Results from Linaro’s test farm.

> After introducing zboot image, kexec_file can not load and jump to the
> new style image. Hence it demands a method to load the new kernel.

...

This patch set build and boot tested on arm, arm64 and FVP.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: kexec@lists.infradead.org
> To: linux-arm-kernel@lists.infradead.org
> To: linux-kernel@vger.kernel.org

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

links to test results,
 - https://qa-reports.linaro.org/~anders.roxell/linux-mainline-patches/build/lore_kernel_org_linux-arm-kernel_20230306030305_15595-1-kernelfans_gmail_com/?failures_only=false#!#test-results


--
Linaro LKFT
https://lkft.linaro.org


--===============1143493068537525229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1143493068537525229==--
