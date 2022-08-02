Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4834C00144
	for <kexec@archiver.kernel.org>; Tue,  2 Aug 2022 02:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VsVjSvr3hAixiFu0OClKYps+4OvEWg0NrqteI99ngjA=; b=xqPQ59iUz5uiUpfTvL+yRu+6l6
	kVyNg1rvBMc7fiDpCyRdX1kL2ynpqrTE+NUKLoL8c/IS0/CGhGkZrGywa5OA/FgNjuWTxZFH3YeQY
	otv6npsUZgEhgOjHDlDOx3aVmgSYHcktoS0WGXMTcimSB7EIfGk3ghNrmNzrPG7PMG5bprI7o3Iym
	apq7VzKrx2XVNP0eb9tYSXcu4+H87UnHb3aQ4bUz1Aqj/Kp/nRuh39lgaPsTJYmMlc09J3bXQlsIy
	NoLCypkM0ju4yxgKsXS6If1bknKAc1eyg/vTmORfVQIzQFL6lbubp+Z1Ljj/IFtPet9L5d9hu2zNH
	oS5qMLTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIhwf-009wE7-Et; Tue, 02 Aug 2022 02:47:45 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIhwa-009wCY-Mm; Tue, 02 Aug 2022 02:47:43 +0000
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LxfTY0zVPz1M8MB;
	Tue,  2 Aug 2022 10:44:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 10:47:33 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 10:47:32 +0800
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
To: Baoquan He <bhe@redhat.com>
CC: Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou
	<dingguo.cz@antgroup.com>, John Donnelly <John.p.donnelly@oracle.com>, "Dave
 Kleikamp" <dave.kleikamp@oracle.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a80c2b7e-a510-8e45-1f3c-7e2ddf79bc37@huawei.com>
Date: Tue, 2 Aug 2022 10:47:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_194741_154929_42D27EC4 
X-CRM114-Status: GOOD (  22.00  )
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



On 2022/8/1 16:20, Baoquan He wrote:
> Hi Catalin,
> 
> On 07/11/22 at 05:03pm, Zhen Lei wrote:
>> v2 --> v3:
>> 1. Discard patch 3 in v2, a cleanup patch.
>>
>> v1 --> v2:
>> 1. Update the commit message of Patch 1, explicitly indicates that "crashkernel=X,high"
>>    is specified but "crashkernel=Y,low" is not specified.
>> 2. Drop Patch 4-5. Currently, focus on function integrity, performance optimization
>>    will be considered in later versions.
>> 3. Patch 3 is not mandatory, it's just a cleanup now, although it is a must for patch 4-5.
>>    But to avoid subsequent duplication of effort, I'm glad it was accepted.
>>
>>
>> v1:
>> After the basic functions of "support reserving crashkernel above 4G on arm64
>> kdump"(see https://lkml.org/lkml/2022/5/6/428) are implemented, we still have
>> three features to be improved.
>> 1. When crashkernel=X,high is specified but crashkernel=Y,low is not specified,
>>    the default crash low memory size is provided.
>> 2. For crashkernel=X without '@offset', if the low memory fails to be allocated,
>>    fall back to reserve region from high memory(above DMA zones).
>> 3. If crashkernel=X,high is used, page mapping is performed only for the crash
>>    high memory, and block mapping is still used for other linear address spaces.
>>    Compared to the previous version:
>>    (1) For crashkernel=X[@offset], the memory above 4G is not changed to block
>>        mapping, leave it to the next time.
>>    (2) The implementation method is modified. Now the implementation is simpler
>>        and clearer.
> 
> Do you have plan to pick this series so that it can be taken into 5.20
> rc-1~3?

Hi, Catalin:
  Only function reserve_crashkernel() is modified in these two patches. The core
process of the arm64 architecture is not affected. I remember you suggested that
arm64 and x86 share the same kdump code, so these two subfeatures are needed.
Maybe we can lay the foundation first for the people who build the road. Unifying
the external interfaces of kdump on arm64 and x86 does not seem to hurt.


> 
> We have back ported the basic crashkernel=high, low, support into our
> distros and have taken wide testing on arm64 servers, need this patchset
> to back port for more testing. 
> 
> Thanks
> Baoquan
> 
>>
>> Zhen Lei (2):
>>   arm64: kdump: Provide default size when crashkernel=Y,low is not
>>     specified
>>   arm64: kdump: Support crashkernel=X fall back to reserve region above
>>     DMA zones
>>
>>  .../admin-guide/kernel-parameters.txt         | 10 ++-----
>>  arch/arm64/mm/init.c                          | 28 +++++++++++++++++--
>>  2 files changed, 28 insertions(+), 10 deletions(-)
>>
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
