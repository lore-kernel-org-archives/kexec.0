Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2284BEB64DD
	for <kexec@archiver.kernel.org>; Tue,  1 Aug 2023 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ccA8ixjcadz1L9dqjTTKAox7Ka7OiAKJiAFdYCoWIgE=; b=dxqqrIqnohFVck
	PfNBGtWa0a9SFNyvkBf0hBl1ae1nWo5Jlvh1AV/qO4md0mWpjuyaQyv0IMQTERJQm4sSMth5zmeBl
	irbmSYo/iGALXXXjKmzhLWkd5NIUc6Tr/zfJz/PH8v2mnQsscnVtijlN12Gwzz7N88/xLiIVqXPhF
	p7ht1SPVBi8U8yNY1Gq9lAe0MeqSuWyr/RBw45DIpOOEWl52yAjN7axbVdYKBl+7u/2iagV7dsqB9
	YvE5noMbgqD+qyx3Cqyjd+0Uwvg0VbrzF0sqsaPn9FEbniDY4l4pfltQQ2jO2vx+0Nw4gBzOC8Po3
	JEkHiWkCMhmH03xETM3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQlxL-001esw-0O;
	Tue, 01 Aug 2023 09:46:19 +0000
Received: from [14.137.139.154] (helo=frasgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQlxI-001es2-0J;
	Tue, 01 Aug 2023 09:46:18 +0000
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFTvl1cGXz9v7bZ;
	Tue,  1 Aug 2023 17:14:43 +0800 (CST)
Received: from [10.81.220.249] (unknown [10.81.220.249])
	by APP1 (Coremail) with SMTP id LxC2BwC3abkK0Mhkbs4ZAA--.15467S2;
	Tue, 01 Aug 2023 10:27:51 +0100 (CET)
Message-ID: <c1b125d6-7031-d0aa-bcaa-8fb3875ac64f@huaweicloud.com>
Date: Tue, 1 Aug 2023 11:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] RISC-V: Fix a few kexec_file_load(2) failures
Content-Language: en-US
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>, Li Huafei <lihuafei1@huawei.com>,
 Liao Chang <liaochang1@huawei.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>, Heiko Stuebner <heiko@sntech.de>,
 Ricardo Ribalda <ribalda@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 Li Zhengyu <lizhengyu3@huawei.com>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>
Cc: Torsten Duwe <duwe@suse.de>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
In-Reply-To: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
X-CM-TRANSID: LxC2BwC3abkK0Mhkbs4ZAA--.15467S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ury7CFyUKw1fWF1ktF45GFg_yoW8Jw4rpr
	WfC3ZrG348G3409r1xtw1Du34fGa17Cw15Jr4qvw1rAr1YvrW5AF1Igw40yFyDGryI93s0
	qryFgr98Zw1kArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7
	UUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_024616_418453_96BECC0A 
X-CRM114-Status: GOOD (  15.17  )
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

Hi,

On 7/26/2023 11:53 AM, Petr Tesarik wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The kexec_file_load(2) syscall does not work at least in some kernel
> builds. For details see the relevant section in this blog post:
> 
> https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html
> 
> This patch series handles an additional relocation types, removes the need
> to implement a Global Offset Table (GOT) for the purgatory and fixes the
> placement of initrd.

It seems there are no objections, but what is the plan here? Take it
into 6.5 as a fix, or let it go through for-next?

Petr T

> Changelog
> =========
> 
> Changes from v1:
> - Replace memcmp() with a for loop.
> - Drop handling of 16-bit add/subtract relocations. They were used only
>   by alternatives in strcmp(), which was referenced only by string.o.
> - Add the initrd placement fix.
> 
> Petr Tesarik (1):
>   riscv/purgatory: do not link with string.o and its dependencies
> 
> Torsten Duwe (2):
>   riscv/kexec: handle R_RISCV_CALL_PLT relocation type
>   riscv/kexec: load initrd high in available memory
> 
>  arch/riscv/kernel/elf_kexec.c    |  3 ++-
>  arch/riscv/purgatory/Makefile    | 26 +-------------------------
>  arch/riscv/purgatory/purgatory.c |  6 ++++--
>  3 files changed, 7 insertions(+), 28 deletions(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
