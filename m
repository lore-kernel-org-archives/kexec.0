Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2829C46CD2
	for <kexec@archiver.kernel.org>; Sun, 28 Jan 2024 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SNKfr+uMA0Y4b6zz4q0aE8/c8ClD91rjzlOYWBEME9c=; b=gs87QIRk3FE4OV
	TVOcFs7dORaSLAbLVE0tbfIqKqsSkg6DmgrzANwk2yk0nTuKwtm56L27YdODkrdIe42BF10pRTAis
	WBJI6mMnfQtDoqYQHHQRYX1sQH4vEvDpm54H6ufSxyJ5JDwfm/IJER/8IdUXcVFSJIMlBofqMBq18
	MCTDHf5I/C4/AhgJ9tPte6ImcS0G8Uag41lElZn0qeWLFege9deqoRLUExs43wjTD3OzmvQmSQ4U2
	DW0r3qSyUbagELhBgan+Z6VAsehiy3UJIcofoItZXakjT89h306wsWpjpwI3QJUbi7ElddGoxZ2yZ
	NJHLHTLdhQwkMdnM59nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTtyQ-00000008XOk-1qP1;
	Sun, 28 Jan 2024 01:28:38 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTtyN-00000008XNk-09JL;
	Sun, 28 Jan 2024 01:28:36 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso26116695e9.2;
        Sat, 27 Jan 2024 17:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706405311; x=1707010111; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUXUIxIBKb7yXVS8ERVW4fwa4sKRyx0T69mWwoqQkWg=;
        b=RECg+THo0Le+e/2Bx3tVVGcuXDH+LmTokESV6748hAvFMIrhEc9Wq3KERHxklf8y9h
         QOvDqpijESggIXpJgqMRRAiXJAkBJXjR1SOnA60mak8VL6nqMcWNq8jd6n0lDzAIQhbh
         pPGUo5D3rqOBWWBfBf7yTbLAs6S1RhyPXe/i8lFpOhBSQP3Pinf6lUHN2C/a8G7LYSIA
         1XJzxUqGhwZy6PBabLWWbhyMQpfYYZaQSAQzl6o3JG0YgmDsBVO+N2s/6edhO6iJ3jgt
         hmaU4FmuGc81SqcPnFyP7aNdP7gwOG4dIDOgISaOkzRwV7I6cBb3aKIPktiZYSg+YYwn
         +RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706405311; x=1707010111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUXUIxIBKb7yXVS8ERVW4fwa4sKRyx0T69mWwoqQkWg=;
        b=OaVR/hbIREVpIyOFULxHfM7Y1X4dQxx87gnkpIPfytPp1QR6eICYCeunBcdc6i2hVj
         15mQ9w7axAIyZcixb1Nm5b74xZQuL5JmGBqx6c9CXA/Ze+lTdl7KlrOq5a2QyGb5Odli
         7BANNGZiPgLJssML2Ra6H+U0KE3Nmft7OmqJwcA5JGpmznBHvfdddUuvUzaa0C6adVeb
         xXlGcPJFGpCQqpb+DSsnDVMt6+PaKbEbLBxt+hjLEd90mcw9PMpTria5qBizCXyB5GQc
         wBuDeTzPLcEHInvyg+By0AyA10R2ZekIIeJWtjzbwsixMomnAnhX6SwNoav3AMLGPKHi
         DWvw==
X-Gm-Message-State: AOJu0Yw+gCNIQvbsQ2GGsziVGceKyxm/2MCQ/xFvhNkUncCGlujCIqd2
	PQYLO9eYvA4l4oaZhHLC1oQGi+r31MMxuh4v1BG6U4SB7J/JMGaN
X-Google-Smtp-Source: AGHT+IHept3nMUj4LCYzYJiT9LNHHbS9INXuvww5u4glPmCjjXCtKxmvIBnhSwXHbRZoEWgm1HAkmA==
X-Received: by 2002:a05:600c:1396:b0:40e:a569:3555 with SMTP id u22-20020a05600c139600b0040ea5693555mr2037091wmf.35.1706405310998;
        Sat, 27 Jan 2024 17:28:30 -0800 (PST)
Received: from ?IPV6:2001:678:a5c:1204:db7b:6df3:1a86:f66a? (soda.int.kasm.eu. [2001:678:a5c:1204:db7b:6df3:1a86:f66a])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c1d8600b0040ee76ae773sm4537228wms.19.2024.01.27.17.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 17:28:30 -0800 (PST)
Message-ID: <0b14826b-9373-4458-919d-1da2a62d4226@gmail.com>
Date: Sun, 28 Jan 2024 02:28:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3 01/14] kexec: split crashkernel reservation
 code out from crash_core.c
Content-Language: en-US, sv-SE
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, akpm@linux-foundation.org, ebiederm@xmission.com,
 hbathini@linux.ibm.com, piliu@redhat.com, viro@zeniv.linux.org.uk
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-2-bhe@redhat.com>
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240124051254.67105-2-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_172835_118961_FB77F842 
X-CRM114-Status: UNSURE (   8.28  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

On 2024-01-24 06:12, Baoquan He wrote:
> And also add config item CRASH_RESERVE to control its enabling of the
> codes. And update config items which has relationship with crashkernel
> reservation.
> 
> And also change ifdeffery from CONFIG_CRASH_CORE to CONFIG_CRASH_RESERVE
> when those scopes are only crashkernel reservation related.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 502986237cb6..a9243e0948a3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2106,7 +2106,7 @@ config ARCH_SUPPORTS_CRASH_HOTPLUG
>   	def_bool y
>   
>   config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> -	def_bool CRASH_CORE
> +	def_bool CRASH_RESEERVE
>   
>   config PHYSICAL_START
>   	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)

CRASH_RESEERVE is probably a typo and should be CRASH_RESERVE (with the 
former ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION isn't defined in my 
.config and `crashkernel=...` parameter has no effect).

Kind regards,
Klara Modin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
