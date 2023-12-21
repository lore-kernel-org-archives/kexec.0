Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D40BC35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nBfu5SOXgyygRTn1KMQrkVr+XTTnb1FGdi48b3B5L8E=; b=XwENcFiVIpeak3
	HDtOZV1ku5aOvuoQSt4nn4BrY3zHJtNt4luCC4Ool2oKLfzxAmN7EnWSencsB2jeZnwH/Gm/iNEe5
	r87x+xE90gZzLHylLLXCakzh10nfl2FYMhId86OUjjmCQnrisMFljNSx7IJtl79N75KDjO9609aml
	3YSHXDOi0pyL4X1D24SmjZ9qPnegnv6DP4yj7NSFJxZh4RsxzJIZ6aAVjJZ/cN983ChXd+4SlJ8Ge
	ahBAm8FSgiw+aJHwtpHlGVDCgYmV69uLaBfBRG6eqQTnEBaB9CkXvMOKTU3ZWUqAS0wBXWbMF0lyX
	iUfr/7SxUpZsgScVSQXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGLrL-003Ufg-2m;
	Thu, 21 Dec 2023 16:25:19 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGLrH-003Uea-2W
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 16:25:16 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-55322dbabf6so1095050a12.0
        for <kexec@lists.infradead.org>; Thu, 21 Dec 2023 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703175910; x=1703780710; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYkF3QxFWZ70PZApTMjd5gYkgcD2vrrBVkS0UAyNySI=;
        b=h+n5MpjQLRvVQV/j1DUylUKZNy6c4YEIuRTGl5bis9oLCEOnxchmGUhFFJshAVEHDE
         sSx4kgUcP2S960FbtEdgw1eY1Opdjm9UJ4LBQvdD0Enb+175mNzEDcbentIzuDwD50vI
         wNiWfxcMLqY+FV7Dgeb+L5YYC0hWj5e0W8kxhzSisgi6qMxdFEFnojYHQ1cCRLaCtkLS
         3x+/+eAiPuTjfx1b/a9JnTY32+6J9gC/811sX78tghXKDYZS+RW4f8hxbNVCnHyyjdbn
         xO9fU083UtlHsRxmRQ3qUZVlfDXlziwG9wVUjzG8IdKSaElLGd14r+KuMTR9k/RVWemg
         R5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703175910; x=1703780710;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYkF3QxFWZ70PZApTMjd5gYkgcD2vrrBVkS0UAyNySI=;
        b=t44/U73LBsPCZSz0CuCkfH+u+s8qRk3i2kFf4CZZJ2rf2CXWyYQJU9B2Eu6xe0nBZN
         iPnGxTYFtJnuP6AVineSZn3IkC5feWiZA1T0qajN1t0rQXvKl0Dt26RFU73C3E+EWJnI
         PNbSYmAvRhkzc+nZdRvGHPJB92HGWI1Hu0Ebgsl4YnPs4Nj3g3GHnb0A/bj1SmkCB9ta
         Mg9SXt8tKXizoBDqlioV0ZWUTQkGEySE2KbIlODe34pWnQoSEVVq3sHElDV/8kDf5RMh
         5af4A/L8MnS4tb+faMTDzPEUSn5sV9SxHkrygXi1wk4/TYnJsz96iR6xd4X5btLqGmNB
         q2yw==
X-Gm-Message-State: AOJu0YwrB1TrWVO0eCTMJ3gvsjIXwYJWSq0K938qckKv6a1VBsc0gNi2
	pTlMs62P/N4s5Z5/XcTe46gMQA==
X-Google-Smtp-Source: AGHT+IGqX6pV3e0WwZ2xsU9I/cBN0tYmnXkMZj5o0U4CevFoaW5gh3XuKhIb3wKLlg/307ZN95MbGg==
X-Received: by 2002:a50:b410:0:b0:553:8e4a:75b1 with SMTP id b16-20020a50b410000000b005538e4a75b1mr2936572edh.32.1703175910690;
        Thu, 21 Dec 2023 08:25:10 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id d12-20020a056402078c00b0055335e89ed8sm1355346edy.30.2023.12.21.08.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 08:25:10 -0800 (PST)
Message-ID: <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
Date: Thu, 21 Dec 2023 17:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump
 module
Content-Language: en-US
To: Ruipeng Qi <ruipengqi7@gmail.com>, catalin.marinas@arm.com,
 will@kernel.org, bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: zalbassam@google.com, dianders@chromium.org, mark.rutland@arm.com,
 lecopzer.chen@mediatek.com, maz@kernel.org, arnd@arndb.de,
 yury.norov@gmail.com, brauner@kernel.org, mcgrof@kernel.org,
 maninder1.s@samsung.com, michael.christie@oracle.com,
 samitolvanen@google.com, linux-arm-kernel@lists.infradead.org,
 qiruipeng@lixiang.com
References: <20231221130930.32634-1-ruipengqi7@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231221130930.32634-1-ruipengqi7@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_082515_820693_4904ED05 
X-CRM114-Status: UNSURE (   4.74  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 21/12/2023 14:09, Ruipeng Qi wrote:
> From: qiruipeng <qiruipeng@lixiang.com>
> 
> Osdump is a new crash dumping solution aiming at specific embedded
> devices within automotive or Industrial.
>  - limited memory.
>  - reboot as soon as possible when system fault.

NAK, sorry, work with Qualcomm minidump series to incorporate all your
needs there.

Best regards,
Krzysztof


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
