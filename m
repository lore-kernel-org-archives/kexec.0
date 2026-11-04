Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D6606A328
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jgreespD;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=E/BLgQPJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rXti7mY5F0P/rsGwIECfqLmvwSGUaMqT4P5dq57Cx/E=; b=jgreespDQPT/3r
	2itmxp0j6Yl95duXxb9dAnhafxFVomxZH0hOr4fbqaPIYVgPMGHRcB3i5H6gRh++gukapJF8tpRg0
	LSHmfC66tdjZYM31cLSSXqWp836eMuyAaY2GT1VfMJgv/SXThb19SgDQ7gql8MiWXqZQvn+P34Lxu
	YQiXZ3CXpxbFP3JzSKDfHbJ8i2bFA70QTLE48KsndZIZ3OzTASmEbXyLp+9USEZ+oDF77yvLhsb5n
	1eGZ4uXLb0ZXZksqa6C7h1oZakauYo/PeVzm8jeOMXjtQL+SCt7+lIQxVgytS1mznCCkNoQqq6Zmn
	OUqKnZ1rWPLeIvA2u9Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOQbg-0000000491A-3a1p;
	Wed, 04 Nov 2026 02:20:08 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOQbb-0000000490n-2xFs
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 02:20:05 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-5ec6f271883so126166e0c.3
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 18:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793758802; x=1794363602; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rXti7mY5F0P/rsGwIECfqLmvwSGUaMqT4P5dq57Cx/E=;
        b=E/BLgQPJTxKGLfFyurR6u35/VlF14ps82VvAv9xQTsv/I4Texx0L75x47c4yl4GzS0
         YxaemwfVK1hXvG6AYt7l6wGn0pvp0g+eUZ12F9H+z8mgZxNp6t4l7LyIbG0tcXi67jSP
         9ceOGH6MPGnwZk7vfzqxIW+Yu0TIbnOu/I5wpgXAhkmkn7jUoI8PmarcsG/3kVWYIhMA
         ZHzpl9VeZZH1yrpjdUuiOH9L5WJVuv8itx+OWQeInU4mOB2QVFT+aqe1TD3eMm9xrDSZ
         2CRt2DCSJ3For9kRDtW9IGN4f+6KtK0og+sAhLuFa8PgfhFohdkxB+K0sR7NooeeMmcg
         qDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793758802; x=1794363602;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXti7mY5F0P/rsGwIECfqLmvwSGUaMqT4P5dq57Cx/E=;
        b=LiPSD2tk3OmvpAiB0gprWqtlY6D4WBmy+f/Mk9oKZy2Ts1KcY+FCxhBqI/bo22WLys
         N3o2/TddyLc/w0lt52MSutrFw0FRe8z3lCn0/mU3j/ErEbPGFuOI4N/9nxb3KVolTrT/
         L1BJ3dR+z4RiNnKAone2MGvRACecv8zkUvuDaPb0Q9bvOoI2qKk90NcP2FAf+gE00+Tw
         lCm92+iP4+uMoRBoe7HJyxcYj4CavVxu1vix7nht4nHxsZAzx1VP3MzDKtxDUSvV0Rh6
         9NN1Qjemvyn1Lqy4MkkcVEjuGQUO7aeTqVq57MyhIfFOkXOpK6qq7AH9JJMI77Q18ZMs
         +S7A==
X-Forwarded-Encrypted: i=1; AKwUvBzbRGBeOh4hxPbbP3c/m7ZueVovcyUtbCvtDcaTt57mmvXoEO/ieSEXhI9zYrJpUUvi5CDxCg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/rhCpfG8vF8z/J4IunULfY6DbXmCtARPYCoCGOClAYcgVtTJ+X
	Vv0+/8WdEV43yLYXsxGdWE5a627lmhNj5YZUUjCV0hVnaRh3be9aIk+mF43zTXx+SZc=
X-Gm-Gg: AYBFou1Z1y4WNXVlUnCnwId+mraoJUuJxsUryu7FF2dSjlSV6wa54PZa5qAHBMeWbHs
	x+0pZRDFvxnktYAZ0qWUHrIRgPR6W9iB7xLd85TNqZyBLd9Z/imGHrCO+5aeciDLCJ+9+ajBUiA
	bMKHXTOQEEIjUJhh8AcFHXDicXglqHM0gQ0TFsBvRWFA9m7li57/eDxXvhlzLyszOywVWhlG+C+
	RGgCTvwAmWsqD8j4sU2vY95zw4fvr+u5FGN4R7xPH9+2s2YWS3+cIFZF1IYfbrPZrdYPkOrlkJC
	XWkbiV8ezDvDiRv1pp0naScF1gdN+4pdvRte8rPbCUVFzGhkSBeFfoHk1cnQYB26DrnbhNc/4HG
	93AFm6lZPIQOuqa5HhHj5722dZQ6duDytIpmH/9BGjv/G59Rbt8qp+21mIlJT9+YJXXqgNQao2Y
	KhZVr/iCidxJPYPftffh6Q2bpiXcIliZ9Y3ShGSzBW24VWFXeX2KBYdrWeuyhLEXNuyq9g6FgMI
	IdLQ+6qMXTXFxMko32zFnKz0MEStlVPvM1Qeq5npZfq8Ah/tBv7uhOHTWgymPN13dWDuE9sxmKq
	vVZ2Q0F758rOVsKr5vXRuwTSMvjs19ZKqPBPqErSdyjUk2nEUqufBBfSWek2wevw3Z0O/1p3I1q
	3rLVFOt5JuzRCp/4TRC1jwrIsjHPXvvyEc5fE0o4Ctqnq
X-Received: by 2002:a05:6122:130e:b0:5ca:f811:25ac with SMTP id 71dfb90a1353d-5ec6895c285mr6125913e0c.14.1793758802245;
        Tue, 03 Nov 2026 18:20:02 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b6568sm658959e0c.1.2026.11.03.18.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:20:01 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org, pratyush@kernel.org, shuah@kernel.org, 
 George Guo <dongtai.guo@linux.dev>
Cc: guodongtai@kylinos.cn, kexec@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261029090542.13283-1-dongtai.guo@linux.dev>
References: <20261029090542.13283-1-dongtai.guo@linux.dev>
Subject: Re: [PATCH] selftests/liveupdate: Preserve VM workspaces with
 run-vmtests.sh -k
Message-Id: <179375880152.1029434.132459394322366594.b4-ty@b4>
Date: Tue, 03 Nov 2026 21:20:01 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_182003_764252_C0A3F227 
X-CRM114-Status: UNSURE (   5.42  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 18:05:42 +0900, George Guo wrote:
> run-vmtests.sh -k keeps the test output logs, but vmtest.sh still
> removes its workspace and qemu.serial, losing the guest output needed
> to debug failures.
> 
> Forward -k to vmtest.sh when keeping logs and update the help texts to
> match.
> 
> [...]

Applied, thanks!

https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git/log/?h=fixes

[1/1] selftests/liveupdate: Preserve VM workspaces with run-vmtests.sh -k
      commit: 654efa9a6c4c455aca6f034f321c013f5b784157

Best regards,
-- 
Pasha



