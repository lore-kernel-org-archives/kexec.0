Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D019C77B7A
	for <kexec@archiver.kernel.org>; Tue,  6 Jun 2023 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:CC:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Kn4n62a09l2Mw09adrC4m/66zb5BGd/AuRjnAyiH2/A=; b=35dpIDFZLGYsoYkKWEyiLeqVg7
	RlQk+ytVPneXbgL8geJSH5lJI5GVqx43dJP2GrKaA2N++Zkc1+2J4n2DCBsbDW6b7Y/AK0s757WHJ
	ufr/GMnufMMvGY7n+ON5nkMfNgFVf2+SHoYUH7WOgDOWj2RQc1JxqQbqKYoh+chs9QrBKqmxCX05C
	29xzFyjf54IwGYUEKi7RexguIhXiiCRO8uB6MjCz4DZFSEPAJCu3f3GSdqcA5bzJv5/1Ck7xo0xNb
	e4gcNiOeTIvrIO7jvyY1rHCE59BdWYVM0w9YR3JxMQy6f5rScVY6QlDDjtZ+v8xQ/jtCwZv/kEBcZ
	45cCLTAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6VTy-001YDl-1y;
	Tue, 06 Jun 2023 12:08:14 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6VTv-001YBt-0g;
	Tue, 06 Jun 2023 12:08:13 +0000
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qb8J46FtwzqTTr;
	Tue,  6 Jun 2023 20:03:16 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 20:08:03 +0800
Subject: Re: [PATCH v6 2/2] Documentation: add kdump.rst to present
 crashkernel reservation on arm64
To: Baoquan He <bhe@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <horms@kernel.org>,
	<John.p.donnelly@oracle.com>, <kexec@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20230515060259.830662-1-bhe@redhat.com>
 <20230515060259.830662-3-bhe@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1f61248c-c137-708f-5e3f-d035742aed6f@huawei.com>
Date: Tue, 6 Jun 2023 20:08:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230515060259.830662-3-bhe@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_050811_602901_93908860 
X-CRM114-Status: GOOD (  33.73  )
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



On 2023/5/15 14:02, Baoquan He wrote:
> People complained the crashkernel reservation code flow is hard to
> follow, so add this document to explain the background, concepts and
> implementation of crashkernel reservation on arm64. Hope this can help
> people to understand it more easily.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/arm64/kdump.rst | 103 ++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/arm64/kdump.rst
> 
> diff --git a/Documentation/arm64/kdump.rst b/Documentation/arm64/kdump.rst
> new file mode 100644
> index 000000000000..78b22017c490
> --- /dev/null
> +++ b/Documentation/arm64/kdump.rst
> @@ -0,0 +1,103 @@
> +=======================================
> +crashkernel memory reservation on arm64
> +=======================================
> +
> +Author: Baoquan He <bhe@redhat.com>
> +
> +Kdump mechanism is utilized to capture corrupted kernel's vmcore so
> +that people can analyze it to get the root cause of corruption. In
> +order to do that, a preliminarily reserved memory is needed to load
> +in kdump kernel, and switch to kdump kernel to boot up and run if
> +corruption happened.
> +
> +That reserved memory for kdump is adapted to be able to minimally
> +accommodate kdump kernel to boot and run, and user space programs
> +running to do the vmcore collecting.
> +
> +Kernel parameter
> +================
> +Through kernel parameter like below, memory can be reserved
> +accordingly during early stage of 1st kernel's bootup so that
> +continuous large chunk of memomy can be found and reserved. Meanwhile,
> +the need of low memory need be considered if crashkernel is reserved
> +in high memory area.
> +
> +- crashkernel=size@offset
> +- crashkernel=size
> +- crashkernel=size,high crashkernel=size,low
> +
> +Low memory and high memory
> +===============
> +What is low memory and high memory? In kdump reservation, low memory
> +means the memory area under a specific limitation, and it's usually
> +decided by the lowest addressing bits of PCI devices which kdump kernel
> +need rely on to boot up and collect vmcore successfully. Those devices
> +not related to vmcore dumping can be ignored, e.g on x86, those i2c may
> +only be able to access 24bits addressing area, but kdump kernel still
> +take 4G as the limitation because all known devices that kdump kernel
> +cares about have 32bits addressing ability. On arm64, the low memory
> +upper boundary is not fixed, it's 1G on RPi4 platform, while 4G on normal
> +arm64 system. On the special system with CONFIG_ZONE_DMA|DMA32 disabled,
> +the whole system RAM is low memory. Except of low memory, all the rest
> +of system RAM is high memory which kernel and user space programs can
> +require to allocate and use.
> +
> +Implementation
> +==============
> +1)crashkernel=size@offset
> +-------------------------
> +crashkernel memory must be reserved at the user specified region, otherwise
> +fail if already occupied.
> +
> +
> +2) crashkernel=size
> +-------------------
> +crashkernel memory region will be reserved in any available position
> +according to searching order.
> +
> +Firstly, it searches the low memory area for an available region with specified
> +size.
> +
> +Secondly, if searching low memory failed, fallback to search the high memory
> +area with the specified size. Meanwhile, if the reservation in high memory
> +succeeds, a default reservation in low memory will be done, the current default
> +value is 128M which is satisfying the low memory needs, e.g pci device driver
> +initialization.
> +
> +If both the above searching failed, the reservation will fail finally.
> +
> +Note: crashkernel=size is recommended option among crashkernel kernel
> +parameters. With it, user doesn't need to know much about system memory
> +information, just need to specify whatever memory kdump kernel needs to
> +make vmcore dumping succeed.
> +
> +3) crashkernel=size,high crashkernel=size,low
> +--------------------------------------------
> +crashkernel=size,high is an important supplement to crashkernel=size. It
> +allows user to precisely specify how much memory need be allocated from
> +high memory, and how much memory is needed from low memory. On system
> +with large memory, low memory is small and precious since some kernel
> +feature and many devices can only request memory from the area, while
> +requiring a large chunk of continuous memory from high memory area doesn't
> +matter much and can satisfy most of kernel and almost all user space
> +programs' requirement. In such case, only a small part of necessary memory
> +from low memory area can satisfy needs. With it, the 1st kernel's normal
> +running won't be impacted because of limited low memory resource.
> +
> +To reserve memory for crashkernel=size,high, firstly, searching is tried in
> +high memory region. If reservation succeeds, low memory reservaton will be
> +done subsequently.
> +
> +Secondly, if reservation in high memory failed, fallback to search the
> +low memory with the specified size in crsahkernel=,high. If succeeds,
> +everything is fine since no low memory is needed.
> +
> +Notes:
> +- If crashkernel=,low is not specified, the default low memory reservation
> +  will be done automically.
> +
> +- if crashkernel=0,low is specified, means that low memory reservation is
> +  ommited intentionally.

ommited --> omitted

> +
> +3)

This line seems to be deleted.

> +
> 

-- 
Regards,
  Zhen Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
