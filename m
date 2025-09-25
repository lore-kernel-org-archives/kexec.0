Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD24CAC5BB
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 19:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=or54vQrDlSCc4oUoPw4bOHl4mIflQax8gxz1ImqODMU=; b=0iRcbcAHw0J8oGjGyjGcZVSZhM
	uiH3BFkMfRZJPFYIk7xcPG9oB2KIVSlX8BzQ+kc5GIjtqE+s8rHvcKJuYlFmQMe9gGeDiajdaAHj2
	+Gu1GSKAUkUxObNL9YGzos87ryCuGmeEnk40X1jzUacL3q+vaXdeZ4+gULePNBITD1jzG16vHnmAJ
	PwlE2/Cyc/PK4FF7JIzIonEg5zfA4TFh9BvEpky/DXO2jX4TFPzw3Hwd3FfKyt81cgk8KFvX3dxQW
	XCkYrWf/mpvIo/hY/CQllTKdMX199MAXBtOCb2KSQ58Pu+07Q5TBlNKtf0JegE+DxLHPjvBdyyEqr
	xfmVRxhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1rtU-0000000CQme-12CA;
	Thu, 25 Sep 2025 19:44:44 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1rtR-0000000CQjU-2Kio
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 19:44:42 +0000
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-425635acc4dso13227955ab.1
        for <kexec@lists.infradead.org>; Thu, 25 Sep 2025 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758829480; x=1759434280; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=or54vQrDlSCc4oUoPw4bOHl4mIflQax8gxz1ImqODMU=;
        b=KwjlbIm8C32yWSdnOik9pv3uX/M4IWaIaZLNJbASlPq5hxFR+5PfPVFPWbEg5Nfbbo
         0NIRiSHOn1LSLIGxB2J8jyF3FFMPTYOEpi7O5/dOZXMIgcVy8o0tCGuGmHZ0PhncQ4Nt
         2tuKjYDlG388adHRgx98n9XkkRCzcOFTLygzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829480; x=1759434280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or54vQrDlSCc4oUoPw4bOHl4mIflQax8gxz1ImqODMU=;
        b=QMC1KiJaZ5zIFTiDC1TGIVewePkagFw1FLvzBQgCnM/dEwl119wyG+x1rs18FRLeGJ
         zY82Y8jlnZLl7OOv9FOxJVi6BtwdIJh+whIQSD4JfaQAD23sflsc5e8m1NfMTiVznYxD
         EwtQC6TGekt2qvMdIGgqSJqPTvpYzXijDLuhf3WDX8/MBQrv5pdUENGT3wF/TfpwHunl
         eFVOHLc6IL3NyO+H/8isFUyEpodrKvp5joO7R83avNw79KCB2m1Z0N2OjJK438oZML6R
         ZuIfRWw8sa4Pu3IkF3m7YsvpmDCo724nW1vlbOoWOAwTZZag3trHymPwLhGI93Obd0oY
         eQIg==
X-Forwarded-Encrypted: i=1; AJvYcCV8/2cE+pwk+axzBKMo326KPGHLrgspSvIKxuduXA0Hm3VX1N0YuEpJNGnQjxNmVBbcBYR1Fg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzsoNw/+1zuoNwFOlIDHtbvVTx4lxSmX4xQmDZu4hSp4E1Vbix8
	v3vG7C5f8/kwt9c+40EZ2B5hInl+Fjh5KySymaEg8tFv+fRoGutYfjr85f1SfTPWnNA=
X-Gm-Gg: ASbGncu+TX7QAiMHGQZXNWzBuUM1sD/iMEztFLwXAQHENBJTR/EZoh78l//6h9u4cS7
	KuRGVMCXLs2coQ15Rx0bEzZErixAUIGyQeFDV/bel1EKs7+0XSLdnJvL3NDb7ZUT0FvXtEpDEuT
	3YgiwKJ2inR7S7IQErtau32ah5DsBzN5bnHUoBHkjQpyxi0H2fjagSaYxmX4hq7o6dHi+WHT44s
	dg5fOrJVW4EQlaHanL/RIVaGyXcWqVs7CaFsNgg1YP/Vq59Rakph1xEOUsIVWDV5BVZAh2k2tEs
	UhOQIB6EASuOMk9nsjDJfjP5rFU+OubySZOaYa4Wxkf+oWXYBFEK3C6+nHcUMF3e3gAf53Dk7YF
	tf42UaWhOWoYM4hdR8na1e8LescRglKlIhk0N3dNEPbf+ww==
X-Google-Smtp-Source: AGHT+IEPVyp7JzGHapxNvv4LYOPSv8tJ+j6O50sbKDaIYjBItoXAtC7pX4vo8bCfw1S4ZxWm8QkoJA==
X-Received: by 2002:a05:6e02:1fe8:b0:424:64c7:ffae with SMTP id e9e14a558f8ab-425955ed735mr80558725ab.12.1758829480118;
        Thu, 25 Sep 2025 12:44:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6ae6ec6esm1116952173.76.2025.09.25.12.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:44:39 -0700 (PDT)
Message-ID: <3fe5d44f-cf33-42b2-bb91-6a4238f83470@linuxfoundation.org>
Date: Thu, 25 Sep 2025 13:44:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/kexec: Ignore selftest binary
To: Sohil Mehta <sohil.mehta@intel.com>, Shuah Khan <shuah@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Cc: Simon Horman <horms@kernel.org>, Dylan Yudaken <dyudaken@gmail.com>,
 Moon Hee Lee <moonhee.lee.ca@gmail.com>,
 Ricardo Canuelo <ricardo.canuelo@collabora.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kexec@lists.infradead.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250919170139.3452889-1-sohil.mehta@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250919170139.3452889-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_124441_609568_2006145E 
X-CRM114-Status: GOOD (  10.48  )
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

On 9/19/25 11:01, Sohil Mehta wrote:
> From: Dylan Yudaken <dyudaken@gmail.com>
> 
> Add a .gitignore for the test case build object.
> 
> Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> The binary creates some noise. The patch to fix that seems to have
> fallen through the cracks. Sending another revision with an expanded Cc
> list.
> 
> v2:
>   - Pick up the review tag
> 
> v1: https://lore.kernel.org/all/20250623232549.3263273-1-dyudaken@gmail.com/
> ---

Applied to linux-kselftest next for Linux 6.18-rc1.

thanks,
-- Shuah

