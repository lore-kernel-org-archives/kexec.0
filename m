Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A14FF8860
	for <kexec@archiver.kernel.org>; Mon, 27 Apr 2026 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1u/gaQ+oVmmKaoGhJfA0lv+PgPfetH5Z+BotMjq1x2M=; b=EsQo97KaR+agXVsyRF3/L8yTHV
	Rfwpi9MC/thkzNo+18vXHsFSG65qAzSQXjB3QkALGIRyzDBIzEl4zFB+LpVpZBwLOtsWJy7vYWFbv
	Jv1h0wS22f6dCXkxb9KMv5ODYbWBNK1QFQ6uoaWj60xqKoS7LD7pjUutgXfYAHo5BPfnEfp0l453v
	nx1ikO600IyLidUQcM0beqe40pf/C7kTjmF2FadCH4ASAVsBIUbtXUWztbc1C70Ko5ySKOqvX1qUM
	uuS9K2ZmA8gZhGYv9kB9F0Jw7FBYIIsHAYLSzkJ6FnKI1p0hY3LI7WdH7Dw+9KtvfuHauV60oQRCH
	qsfiAPIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHOIJ-0000000HFGS-3Gmi;
	Mon, 27 Apr 2026 15:54:49 +0000
Received: from canpmsgout04.his.huawei.com ([113.46.200.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8acY-00000001ma8-25YZ;
	Fri, 03 Apr 2026 09:15:20 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1u/gaQ+oVmmKaoGhJfA0lv+PgPfetH5Z+BotMjq1x2M=;
	b=Ng5I2f7+M26BlWo+f15W4F3KICwNL5iu3h39vY8J/Yh43OjddzRD1MsWnEf25APCV36pJ7jaV
	E+dS9RuezRSZ5OUSyATrJYym/oMSq0Q/fgtStWYYumuP16zq8mKRFCRw0duIgZtaeNEb1yxvcFU
	83ODrCmyuPyUV05deMYPVP0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fnCZW0jdKz1prlD;
	Fri,  3 Apr 2026 17:08:51 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id E56E540571;
	Fri,  3 Apr 2026 17:15:04 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Apr 2026 17:15:01 +0800
Message-ID: <c5ee66fe-ecc4-2eb4-4b58-44f7d292d221@huawei.com>
Date: Fri, 3 Apr 2026 17:14:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA
 reservation
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<robh@kernel.org>, <saravanak@kernel.org>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<rdunlap@infradead.org>, <peterz@infradead.org>,
	<pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
	<leitao@debian.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
	<cfsworks@gmail.com>, <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
	<ritesh.list@gmail.com>, <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
	<fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
	<takahiro.akashi@linaro.org>, <james.morse@arm.com>, <lizhengyu3@huawei.com>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
 <20260402113137.GAac5Tmc5b7SL98KdY@fat_crate.local>
 <c6eb858c-5275-6fdc-b6e9-bd6d4b169e05@huawei.com>
 <20260402133644.GBac5w7OYl9MwvVxY_@fat_crate.local>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260402133644.GBac5w7OYl9MwvVxY_@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_021519_032017_44E21560 
X-CRM114-Status: UNSURE (   6.12  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:54:43 -0700
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



On 2026/4/2 21:36, Borislav Petkov wrote:
> On Thu, Apr 02, 2026 at 07:47:53PM +0800, Jinjie Ruan wrote:
>> Thank you for the reminder and for your patience. I apologize for the
>> frequent updates; I am becoming more familiar with the community's
>> workflow.
> 
> Yap, and you can use that time while waiting to learn about it:

Thanks for the pointer! I'm using the wait time to dive into the process
docs. Definitely a lot to learn about the workflow, but I'm getting there.

> 
> Documentation/process/
> 

