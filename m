Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C46DCA0FF7
	for <kexec@archiver.kernel.org>; Fri, 29 Aug 2025 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=upbX44d9Fr3vPRtUxzaYuwm6+HZIDckiervymNsWWoY=; b=AcLtVFOo8Y6CmNzXKHdJo/LMBv
	jileysds5pD0eFGZV+km3YbLzENrJT3loU/EwCu/ooTQZY8yduwuzdRErud0McW9bv1lEzNo+uXel
	Ve2411x73J/IWRUk72gqigLvulzrSj8BKwWzkB16aPvNBXkKfgsbeIdIp/r/RCtkUWMa4AF9aEMyF
	K0+Oafc78WBwS6H0ONlzIHDB8Ud96CoOFNQMTviMvKu8Ou1mgt0BBK+54MAxSE10AqdM9awf3C9DV
	K1dt/7ujqSIqnbMmtR1wuG6mJN1if7xyyqjIAYQGMdd8il55s2PClo/ln0GhW8E8LugYhNtzjAEug
	jcyf3+sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urwJT-00000005Jh0-3N5t;
	Fri, 29 Aug 2025 10:26:31 +0000
Received: from out-171.mta1.migadu.com ([2001:41d0:203:375::ab])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urvHN-000000057Vk-2N2m
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 09:20:18 +0000
Message-ID: <7afb2722-e818-4e20-86f0-f6f126edd814@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756459213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=upbX44d9Fr3vPRtUxzaYuwm6+HZIDckiervymNsWWoY=;
	b=JDQRWNDSCSPghe77uDRx0QLQqwV70kaWrSLoizx+qEkpGdFtXrosc5j/i9MekSG4r1HaQj
	vEMtD2C2bXzN/IAgQE/fzUBXp/IF1evoB4PVfUPbnvpQ/QoxaEkvTI2SczHTYnWDK5EQ7y
	AltPtI9tfysZDkTZhADaP1fAP63kwAo=
Date: Fri, 29 Aug 2025 17:19:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] Fix and improve the LoongArch implementation
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>,
 Youling Tang <tangyouling@kylinos.cn>
References: <20250829091040.35827-1-youling.tang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <20250829091040.35827-1-youling.tang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_022017_758830_B4E4DB97 
X-CRM114-Status: UNSURE (   8.48  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

My oversight, email and Singed-off-by error will be updated to
"Youling Tang <tangyouling@kylinos.cn>" in the next version.

Youling.
On 2025/8/29 17:10, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
>
> - Fix and improve the LoongArch implementation.
> - Fixed the handling of crashkernel parameters when using --reuse-cmdline.
>
> Youling Tang (7):
>    kexec: Handle removal of multiple 'crashkernel' parameters
>    LoongArch: Fix comments
>    LoongArch: Terminate the cmdline string using '\0'
>    LoongArch: Enforce relocatable kernel check for crash dump
>    LoongArch: Change initrd allocation to top-down
>    LoongArch: Fix the use of loongarch_image_header in ELF format
>    LoongArch: Add pe_hdr->machine check for pei format images
>
>   kexec/arch/loongarch/image-header.h        |  5 ++-
>   kexec/arch/loongarch/kexec-elf-loongarch.c | 44 ++++++++++++++++++----
>   kexec/arch/loongarch/kexec-loongarch.c     |  4 +-
>   kexec/arch/loongarch/kexec-pei-loongarch.c | 24 +++++++++++-
>   kexec/kexec.c                              |  6 +++
>   5 files changed, 70 insertions(+), 13 deletions(-)
>

