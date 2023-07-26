Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C381C001DE
	for <kexec@archiver.kernel.org>; Wed, 26 Jul 2023 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qa4emrzarwodlyTYpIsK5HcQzR/uWhZyXuKQ5ShW6J4=; b=YC4PU4PVuY1i9t
	3rsbd8Ha1jooN9ap3Do5V4qtaTqEmoqfEwPFk/paq4A5SUNxSIkZYaIvNwKJWpbFJaTV42Rx2/Ac+
	CZ+c3ly197Li8acZKh11p8f8Bf1Q57oS/1u7KAw5vRD1VikoKsGQegJMqRWRbWuV9P8NRDGrbhONx
	1A5M0UvpRbiEnwtkvLoICTbUnNIfxbbRYGRzAfbqaXmpp5anfYZVfauJoUuFAvN52d/bxjtcYJAEZ
	rz34xSkzfVVgfr1hT+py72ITNIF1//YNHK8wXIPJzO1Is432slebUv3VKE2eJ0Z2K4QXR3pO26l3z
	0seg0nH6aZAlzLbj1GRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOU8K-008uaP-0f;
	Wed, 26 Jul 2023 02:20:12 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOU8G-008uYU-1R;
	Wed, 26 Jul 2023 02:20:10 +0000
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R9cx244ClzLnyK;
	Wed, 26 Jul 2023 10:17:26 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 10:20:01 +0800
Message-ID: <96245a6f-cff1-9f2a-1217-4109d9a19291@huawei.com>
Date: Wed, 26 Jul 2023 10:20:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v8 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<conor.dooley@microchip.com>, <guoren@kernel.org>, <heiko@sntech.de>,
	<bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
	<atishp@rivosinc.com>, <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
	<horms@kernel.org>
References: <20230725214413.2488159-1-chenjiahao16@huawei.com>
 <20230725-judiciary-auction-ef50be622175@spud>
From: "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <20230725-judiciary-auction-ef50be622175@spud>
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_192008_668256_9C411DBB 
X-CRM114-Status: UNSURE (   5.58  )
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


On 2023/7/26 5:48, Conor Dooley wrote:
> Hey,
>
> Your $subject says -next, but the patch failed to apply to
> riscv/for-next. What was the base for this patchset?
>
> Thanks,
> Conor.

Hi,

My patchset was tested on current linux-next HEAD
(commit ID: 1e25dd777248, tag: next-20230725) and
it seems all ok.

Could you try applying with the base above, or
is there any problem with that base?

Thanks,
Jiahao


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
