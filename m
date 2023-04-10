Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A8DC77B6F
	for <kexec@archiver.kernel.org>; Mon, 10 Apr 2023 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zKPeE/3cM2pV9khIjF2vjGpNhT8c64M9RZj7dYI/SEM=; b=RGnEJZFjiJvQKs
	jWMabe2eFEorkMt6ewCHt+1NSp6zUtKeJbNkpHPl/xUNsJEiQdnsd4bGleJMzH/eU+xTaXEc8EhrB
	0TDMQhkCxBBjmQ5GvHhjfQ8vy9XcoVv4WpSZuZ6A36Ziivgi/Yd1CjnVDVWtZyiwFq9Q+as7h31Cf
	HRSxzVGMPsSYuCzemYBFZGYBoVuASR9cKTlyBUZ0+/mDKfJVGf8CD608mOSnbYjgk+PAwvm0QhFrq
	JGCUwOTDkCw/oXOowfgGh0m93X08drbxbBYWkuHXzEypFEXrPGfEd2s0KB0xve+JkIheceS1jMd09
	BGauV0018ElDPfvAoOPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ploON-00EvYr-20;
	Mon, 10 Apr 2023 10:04:55 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ploOJ-00EvXT-2G;
	Mon, 10 Apr 2023 10:04:53 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pw4HZ2W4Pz17Rv2;
	Mon, 10 Apr 2023 18:01:14 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Apr
 2023 18:02:41 +0800
Message-ID: <6cadc27d-57fc-d71e-8edb-63f26c494ea2@huawei.com>
Date: Mon, 10 Apr 2023 18:02:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v3 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <ZDAG/Re2CbuMFXOg@kernel.org>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZDAG/Re2CbuMFXOg@kernel.org>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_030451_901710_3523EC80 
X-CRM114-Status: UNSURE (   8.87  )
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


On 2023/4/7 20:05, Simon Horman wrote:
> On Fri, Apr 07, 2023 at 06:02:04AM +0800, Chen Jiahao wrote:
>> On riscv, the current crash kernel allocation logic is trying to
>> allocate within 32bit addressible memory region by default, if
>> failed, try to allocate without 4G restriction.
>>
>> In need of saving DMA zone memory while allocating a relatively large
>> crash kernel region, allocating the reserved memory top down in
>> high memory, without overlapping the DMA zone, is a mature solution.
>> Hence this patchset introduces the parameter option crashkernel=X,[high,low].
>>
>> One can reserve the crash kernel from high memory above DMA zone range
>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>> below 4G with "crashkernel=X,low". Besides, there are few rules need
>> to take notice:
>> 1. "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
>>     is specified.
>> 2. "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
>>     and there is enough memory to be allocated under 4G.
>> 3. When allocating crashkernel above 4G and no "crashkernel=X,low" is
>>     specified, a 128M low memory will be allocated automatically for
>>     swiotlb bounce buffer.
>> See Documentation/admin-guide/kernel-parameters.txt for more information.
>>
>> To verify loading the crashkernel, adapted kexec-tools is attached below:
>> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
> Are you planning to submit the kexec-tools patches too?

Yes, but current adaptation is a little informal. I will submit them 
later after further tests.


BR,

Jiahao


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
