Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6BD606A32F
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c55p3QbJ;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3Lj0XuRp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CCGzWBfX1X9cSsHPu2mqWEF8NpNHLDATFqyNNjfsFkw=; b=c55p3QbJ/9+1pZ
	yQnDWPqzCzHxG/VZM5sg0A8DgauRhyjasfpNonHAN3ONtOxREviXCEwoYGtLk1r8wFeeOE3fUOa2L
	0oqv3AKvGYw8dCH3//tLzxtsnuVLm19YHebjfoZWSRiZmWFgpcZNL/9eQH5CoFq7idFWl6Yl7LoCA
	96DW8W48e9en9aKQq+G2Dl+i6Q8E7qdiE+cv3pe+YF4f99LjtvUvBO7UvHNVM6gA8WPU26GYO+zIK
	3T8TCgnXygWmuIXWpwjhYfg/dfx1FultFtjZG5A+U7TAtzh9qUwKC3peQNmNNskivKUbNvoOFZeCv
	g/QRxmVikCw7nnCPzjFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsT4-000000085ox-3JpY;
	Thu, 05 Nov 2026 08:05:06 +0000
Received: from canpmsgout05.his.huawei.com ([113.46.200.220])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOsT0-000000085np-3wjW;
	Thu, 05 Nov 2026 08:05:05 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CCGzWBfX1X9cSsHPu2mqWEF8NpNHLDATFqyNNjfsFkw=;
	b=3Lj0XuRpdOCEztpedA6GSSl5x4O4JddmtxEbTLNoJlR2C54wDBW8jorT/6aOBic8BqPVyewSl
	x8e38gtEwgurpOUkkDhNyzVD/e6X4ayKuii44trLaEH0J0I7w9kRCxr2qDXmrth0z2EzyiGCtdk
	TbamYBpLt/lj+b5ImptgI7A=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jKvx71hllz12LDh;
	Thu,  5 Nov 2026 16:04:59 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D2F8E4057F;
	Thu,  5 Nov 2026 16:04:57 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 16:04:56 +0800
Message-ID: <2db15115-a06a-48ba-86a2-9a343f1e2a2b@huawei.com>
Date: Thu, 5 Nov 2026 16:04:55 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/15] kexec: Fix CMA and elf header leaks and rework
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<thuth@redhat.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<robh@kernel.org>, <sourabhjain@linux.ibm.com>, <kees@kernel.org>,
	<coiby.xu@gmail.com>, <Yeking@red54.com>, <tangyouling@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>,
	<guodongtai@kylinos.cn>, <blum@kernel.org>, <adityag@linux.ibm.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <kai.huang@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <piliu@redhat.com>, <jbouron@amazon.com>,
	<mclapinski@google.com>, <me@linux.beauty>, <graf@amazon.com>,
	<bgwin@google.com>, <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<kexec@lists.infradead.org>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <179380419709.28814.2122135856184991710.b4-review@b4>
 <932cdfda-7030-4829-8b43-062d208450e4@huawei.com>
 <auw1qgmjWko52oS_@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <auw1qgmjWko52oS_@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_000503_323594_E067639E 
X-CRM114-Status: GOOD (  13.48  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/5 15:52, Mike Rapoport 写道:
> On Thu, Nov 05, 2026 at 11:45:39AM +0800, Jinjie Ruan wrote:
>> 在 2026/11/4 22:56, Mike Rapoport 写道:
>>
>>>> Patches 8-10 pass the kbuf fields to crash_prepare_headers() to
>>>> simplfy code.
>>>>
>>>> Patch 11 frees the elf core header from the generic post-load cleanup.
>>>>
>>>> Patches 12-15 add kexec_load_other_segments() and convert the three
>>>> architectures, and arch_kexec_setup_other_segments() builds
>>>> the architecture specific boot parameters (a DTB or a command line).
>>>
>>> I think the refactoring should go before the identical fixes in arch/
>>> code.
>>
>> However, this will cause trouble for the fix patch in the stable round.
> 
> That's right, but since actual fixes anyway require changes to kexec core,
> I think it's better to refactor first. The core than will take care of
> proper freeing in the most cases.

This way, each architecture doesn't have to worry about the issue of
incomplete resource release.

> 
> And since CMA support in kexec is quite new I think the entire set can be
> backported to stable then.

Make sense for me.

> 
> I'm planning to have a closer look at the refactoring Really Soon :) 

Thank you very much! Looking forward to your review.

> 
>> -- 
>> Best regards,
>> Jinjie
>>
> 

-- 
Best regards,
Jinjie


