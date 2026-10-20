Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758AC606A319
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1hjLBXP3;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NbsVxKtA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LW2Z/J5kgMKXP1MQQy5oBk/GKxhYgHES/KC5diFwAwA=; b=1hjLBXP36yZWf5wQWS3p3JRmJx
	6uSSTMVsanft4wRscDim/KZHmya5G+JP81qC9yi+MqKcpG7X4GE9u8wSNcCUTsJbMR/NFNi7ZColX
	3GovwuLdSyl5uD93YRzmPNLF64/0i+5aUMlmsSJTitSvvksOgHVOXgECL0Gca/O9kHXh37yfbl1fP
	ZfO/FFLA88LPXURlIynGsPkekYfQk0+1Ll6a9KLdtaVg7Z4pwyTUm9bcEgbBXewwoYJAYZ4IjUx2K
	RpNlmaLhuqsBzugJH7E4jJ6j08A8BhhXqgQjFg1xIczQeV3dhoUChrmdeW8GqWK2sgjQAKbZHJN9e
	3fg5rbMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ5bc-00000009EfS-1Kgd;
	Tue, 20 Oct 2026 08:54:00 +0000
Received: from [113.46.200.226] (helo=canpmsgout11.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ5bU-00000009EXj-12Mh;
	Tue, 20 Oct 2026 08:53:55 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LW2Z/J5kgMKXP1MQQy5oBk/GKxhYgHES/KC5diFwAwA=;
	b=NbsVxKtA29oXvQv/BfIHkDIBuquaJ8mOke66Zav3POdMVfniAavgzeyYLX4KFePFgCEEiAP8V
	LAWFJMvvXYYOUMp0DrjKbjReXkvW9nAjpeYca8UmdFdXPeU0CXN+17VXYoRs37XNl+P0MKp1FNZ
	OM4Cc0ebyyVRcrXWBmTXElY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j85mQ36FBzKm5F;
	Tue, 20 Oct 2026 16:53:26 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 701724058A;
	Tue, 20 Oct 2026 16:53:30 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 16:53:28 +0800
Message-ID: <c1e0217c-d2a8-43e2-8038-984663c08fd7@huawei.com>
Date: Tue, 20 Oct 2026 16:53:27 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] crash: Fix several bugs
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<leitao@debian.org>, <yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>,
	<robh@kernel.org>, <coxu@redhat.com>, <kees@kernel.org>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <zhangtianyang@loongson.cn>,
	<guodongtai@kylinos.cn>, <maqianga@uniontech.com>, <chao.gao@intel.com>,
	<kai.huang@intel.com>, <vishal.l.verma@intel.com>, <seanjc@google.com>,
	<piliu@redhat.com>, <thuth@redhat.com>, <jbouron@amazon.com>,
	<me@linux.beauty>, <mclapinski@google.com>, <graf@amazon.com>,
	<bgwin@google.com>, <hbathini@linux.ibm.com>, <eric.devolder@oracle.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <palmer@rivosinc.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <driver-core@lists.linux.dev>,
	<kexec@lists.infradead.org>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <179248377975.302547.11812783408034710690.b4-review@b4>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <179248377975.302547.11812783408034710690.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_015352_626113_90E74846 
X-CRM114-Status: GOOD (  14.78  )
X-Spam-Score: -1.3 (-)
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/20 16:09, Mike Rapoport 写道:
> Hi Jinjie,
> 
> Sorry for the delay, it's been really busy time for me.

Hi Mike,

Thank you for the feedback, and no problem at all for the delay.

> 
>> As Baoquan and Catalin suggested, this patch set fixes
>> several pre-existing code issues found by Sashiko AI [1][2][3].
>>
>> The major improvements and fixes included in this series are:
>> - Fix several memory leaks for arm64, and similar issues on LoongArch
>> - Fix out-of-bounds write on 32-bit Highmem for x86.
>> - Fix TOCTOU race in crash memory range collection.
> 
> It feels like these are three independent series, maybe with slight
> dependencies because they touch related code, but it's not really a
> single series:

Ok, will split this into three independent patch series.

> 
>> Jinjie Ruan (14):
>>   kexec: Fix CMA segment address translation with non-zero text_offset
>>   kexec: Record allocated CMA pages to fix release size mismatch
>>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>>   arm64: kexec_file: Fix elf_headers memory leak in retry loop
>>   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
>>     loops
>>   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
> 
> The very similar commits for arm64 and LoongArch imply that that we have
> some code duplication that should be addressed regardless of these

Will clean up the duplicated code in generic kexec first, and then fix
the bugs.

> fixes.
> 

-- 
Best regards,
Jinjie


