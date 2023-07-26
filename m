Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2608DC001DE
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KkHwb8/TocbM/tpfXqESg38Ig71WdZsHi/mg3Po0Imo=; b=ax2lPbI4ceP86Y
	eYAJBNqkexlhZY4VylSAOHB+f3Axb7DR9id5cp3Q3DGUC2R1b2gDg0+nM6nyhu89nyYVmFDMKBqxN
	lSYaQMcsia8hYabl2JHDvQ/RAxQ8KQQFb1JHfVMl6D2izQiyGrHcxlKrQKndqYsDlrXnqAxxIjKi1
	81SzLUlhYROLWa+WC0+qD04EUhCkU4GLRmw1v1VCq2X6FCUQBGlvypYvXYWGfnySQiD5Y0SoZau6h
	7EIArb9N/gsfJnTJd/fM8iJhBd51l7b3P+hBn8cWI5+4QJQy3gzOSoVGiISjKDEzAvq+hizpaxU+Q
	s5zrDqKsh2tcSPeziUdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOarP-009joT-1B;
	Wed, 26 Jul 2023 09:31:11 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOarM-009jmx-0c;
	Wed, 26 Jul 2023 09:31:10 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R9pXH4mt8z1GDFR;
	Wed, 26 Jul 2023 17:30:07 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 17:31:00 +0800
Message-ID: <43731b35-c076-6d01-ad83-764fb2e9a8f0@huawei.com>
Date: Wed, 26 Jul 2023 17:30:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v8 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>
CC: Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>
References: <20230725214413.2488159-1-chenjiahao16@huawei.com>
 <20230725-judiciary-auction-ef50be622175@spud>
 <96245a6f-cff1-9f2a-1217-4109d9a19291@huawei.com>
 <20230726-affix-employed-319aada685e7@wendy>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <20230726-affix-employed-319aada685e7@wendy>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_023108_583798_219EE4FC 
X-CRM114-Status: UNSURE (   7.34  )
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


On 2023/7/26 14:45, Conor Dooley wrote:
> On Wed, Jul 26, 2023 at 10:20:00AM +0800, chenjiahao (C) wrote:
>> On 2023/7/26 5:48, Conor Dooley wrote:
>>> Hey,
>>>
>>> Your $subject says -next, but the patch failed to apply to
>>> riscv/for-next. What was the base for this patchset?
>>>
>>> Thanks,
>>> Conor.
>> Hi,
>>
>> My patchset was tested on current linux-next HEAD
>> (commit ID: 1e25dd777248, tag: next-20230725) and
>> it seems all ok.
>> Could you try applying with the base above, or
>> is there any problem with that base?
> There's some difference between linux-next and riscv/for-next that
> prevents the patchwork automation from applying the patches.

Oh, I see. There is definitely a difference, since linux-next applied
a bugfix patch b690e266dae2 ("riscv: mm: fix truncation warning on RV32")
recently, whereas riscv/for-next didn't. I have worked on a wrong base
and thanks for reminding :)

I will rebase onto riscv/for-next and post my v9 pathset soon, please
check over there.

Thanks,
Jiahao


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
