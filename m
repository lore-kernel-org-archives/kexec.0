Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FF4C433F5
	for <kexec@archiver.kernel.org>; Sun,  9 Oct 2022 03:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asOiEM8AF9XI+KqUzRAU6PZFOxP+oJAeYri7QfJzQK8=; b=mvugp6wucItJ81nqDms03i3NYP
	OX/jondzoT5W/EbrmWtaScpdfzFZkbFLFjkHLHUiVBIDKpeHZ2slb1gl0LpVBqX1iT727bpqIse/0
	dW6Qs2T5bXD1u018qh1Q3gAw1fLQnZ1jyA6J/Fr5qpigtndrd6EU45IrAucQEo8oT70XgTN0sKy+x
	rSnRrj3IeIQXrhlwe6nl+M7aUMlatX7EW82Jr9ovQLM3SYXGpXTAGbek9db+c33PmCnCiVvB2draw
	s3X1K87TatKYned0jCTDScnSClcD4yTZoyrgTPAoGdtyHmgVWHzXo2HopwmavdBSxgKknHZ5yqblW
	hSNlpANg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohMuK-00EqGk-3p; Sun, 09 Oct 2022 03:23:16 +0000
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohMuC-00EqFi-Fh
	for kexec@lists.infradead.org; Sun, 09 Oct 2022 03:23:10 +0000
Received: from [10.130.0.193] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbWuGPkJj5wspAA--.37080S3;
	Sun, 09 Oct 2022 11:22:47 +0800 (CST)
Subject: Re: [PATCH 0/5] Add LoongArch port support
To: Simon Horman <horms@kernel.org>
References: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
 <Yz2gb5cuoTnX6XhJ@vergenet.net>
Cc: kexec@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>
From: Youling Tang <tangyouling@loongson.cn>
Message-ID: <a242ac4a-eba7-df05-f09b-48391a939d6f@loongson.cn>
Date: Sun, 9 Oct 2022 11:22:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <Yz2gb5cuoTnX6XhJ@vergenet.net>
X-CM-TRANSID: AQAAf8CxbWuGPkJj5wspAA--.37080S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4xWFW3Gry5tFWxZFW8JFb_yoW3GFb_KF
	ZFvF1kCFy3JF12y3WFkryrC34vqa40vF4Fy39rWr17JFn5Cry8Jrs09r9IyF1ftFW8Xrn5
	X39avw4qvr1YgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
	MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU8ZqXJUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221008_202308_962673_78901308 
X-CRM114-Status: GOOD (  14.13  )
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

Hi, Simon

On 10/05/2022 11:19 PM, Simon Horman wrote:
> On Wed, Sep 28, 2022 at 10:28:21AM +0800, Youling Tang wrote:
>> This patch series to support kexec/kdump (only 64bit).
>>
>> Note: Kernel kexec/kdump support patch see link [1]:
>> Link [1]: https://lore.kernel.org/loongarch/711d53ae-197f-3c55-d09d-2f40e6886ad1@loongson.cn/T/#t
>
> Thanks,
>
> in principle this looks good to me.
> But I am wondering if you could provide a patch to .github/workflows/build.yml

The LoongArch architecture is not yet integrated into ubuntu-20.04, and
it may not be possible to build LoongArch directly on that system via
build.yml.

Can we not add LoongArch to build.yml for now when it is not integrated
into ubuntu?

Thanks,
Youling.
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
