Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45FAD58CDC
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 06:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3FBFBEMTYlFRGPvcRDz5Q/yZJO0dAkwNN+DQ7KDBemM=; b=FyEzxgv05D5rV7h1lsmBLGsW2K
	RrrkHa7+MMCR3JFXTf/+ZpmuJfm3gjaEvIXPqwDP095ne+bQBTP45lVp/sSpOHqZYyKI+7UOk3/F+
	suggNfQLUj//Y6sG8HnNFivR8NG79tA4p1Yk8RH/xLRU6zK5dOI/Qfq+qBw5z8T+bk2CZMvO4jhQS
	m4rjHd4Zn/CzbGke69qf5c81VEwQJ3K3Cl2pGMYimvCn7M0XO8Xu07SxHaDBCblDdjrlWOUUY4iq8
	Xwevr6TSGWzzp/Mxy5Zfs7tN/LtiDZelSPA5LZfOF6WF6WiDXKDlUVG3lELtZDyySVUf3XSOIOBQB
	sKC3XjkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4YaW-0000000G7Q9-1BPH;
	Mon, 23 Mar 2026 06:16:32 +0000
Received: from mail.loongson.cn ([114.242.206.163])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4YaS-0000000G7Pn-2odc
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 06:16:31 +0000
Received: from loongson.cn (unknown [10.180.13.167])
	by gateway (Coremail) with SMTP id _____8DxccC02sBpKK8dAA--.26148S3;
	Mon, 23 Mar 2026 14:16:20 +0800 (CST)
Received: from [0.0.0.0] (unknown [10.180.13.167])
	by front1 (Coremail) with SMTP id qMiowJBxiuCy2sBpmSNbAA--.39116S2;
	Mon, 23 Mar 2026 14:16:19 +0800 (CST)
Message-ID: <7d602b85-1436-40b7-88f3-7f3eadfb43f7@loongson.cn>
Date: Mon, 23 Mar 2026 14:16:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: Increase MAX_MEMORY_RANGES to 1024
From: Ming Wang <wangming01@loongson.cn>
To: kexec@lists.infradead.org
Cc: horms@kernel.org, loongarch@lists.linux.dev, chenhuacai@kernel.org
References: <20260304011914.880120-1-wangming01@loongson.cn>
Content-Language: en-US
In-Reply-To: <20260304011914.880120-1-wangming01@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxiuCy2sBpmSNbAA--.39116S2
X-CM-SenderInfo: 5zdqwzxlqjiio6or00hjvr0hdfq/1tbiAQEPEmm-hMQJnQABse
X-Coremail-Antispam: 1Uk129KBj93XoWrtr1xuw1xXw4xAr17tF4kKrX_yoW8Jr1xpr
	W7AF1DGrWrWrs7tw1kt39xXwn3G343KF1xWFya9ryxCr4DXr1Iv3WDWrZ8XFWUXw4rKryI
	grn0g34FqFWDXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjx
	CEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAF
	wI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8bTm3UU
	UUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_231629_684822_C7DE5719 
X-CRM114-Status: GOOD (  13.01  )
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

Just a gentle ping.

在 2026/3/4 09:19, Ming Wang 写道:
> On some LoongArch systems, especially multi-socket machines like 3D6000,
> the current limit of MAX_MEMORY_RANGES (64) is too small to accommodate
> all memory range entries in /proc/iomem.
> 
> When the limit is reached, get_memory_ranges() stops parsing, which causes
> kexec to fail with "locate_hole failed" because it cannot correctly identify
> the crash kernel reserved memory or necessary RAM segments.
> 
> Increase MAX_MEMORY_RANGES to 1024 to support systems with complex
> memory layouts.
> 
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> ---
>   kexec/arch/loongarch/kexec-loongarch.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/loongarch/kexec-loongarch.h b/kexec/arch/loongarch/kexec-loongarch.h
> index 2e65eb0..895809c 100644
> --- a/kexec/arch/loongarch/kexec-loongarch.h
> +++ b/kexec/arch/loongarch/kexec-loongarch.h
> @@ -8,7 +8,7 @@
>   #define BOOT_BLOCK_VERSION 17
>   #define BOOT_BLOCK_LAST_COMP_VERSION 16
>   
> -#define MAX_MEMORY_RANGES 64
> +#define MAX_MEMORY_RANGES 1024
>   #define MAX_LINE 160
>   
>   #define CORE_TYPE_ELF64 1


