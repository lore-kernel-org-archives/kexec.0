Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF390D39418
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0BfAq2trtfASNnVxf9HHtrEQCspzeSBvKkdxZfJnW4=; b=udPeRHcxCnxSiwrptO06ivfDmn
	+FS2c1MnvOi/pO2+rpiYRju6BpMn2CzqKMYlXV1J/rvULw/R7rKjMsAGG/X+EILBxaS0lN5PQB34a
	lawr1wTi8Kcw7rlBUks2gUSchxBfS6AAhtJUZ3dNLyoCquChsglVm9ixQN1FehCb8vsqdZa9aRmAW
	7Mtq5vfdTearXNVL4dp7K4kaFmYzjVRG5jJTugipGxpN4v8JdiM+wudgMqalnIQtb2gFeRRb+/Pdc
	Qc2Ss7G2nMreEbDLFHmQWIWioQ+9ntgqx0V5FYGy/emtesojLwoFQj0tlo5YTdJI0ix1FEX5j5HTm
	PkFAGFDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HGS-000000005E3-22vh;
	Thu, 02 Apr 2026 12:35:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8GX9-0000000HXt2-1wd6;
	Thu, 02 Apr 2026 11:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=o0BfAq2trtfASNnVxf9HHtrEQCspzeSBvKkdxZfJnW4=; b=anL2rxKT/d/Psn/8YSU5z4fe5j
	0ASEv8TELKat+QpH0bV2zT4Qak6pV3wyZBecE5x+ahyvUltV/eCIu5PVSjXNvaHUfvQbssp8lavu3
	xSagocHYBbk27jesycTG98UFI7lUzkljDpZtnEVtt1BMBRFBk+jHfGS0yv9XsIJUOVro1gCEkEFCp
	do/ZMGQ4/91hAUtVsmami9IRkgO/fIYEPIeFJ3rScZHlTqsB65rueEOjooBrRUNDRhOoTqrZFBFgh
	tfOi5Hq+mhgBOOnkMdW2c3BizPRxD+vcp0gyg4RYb1nBIi/qQ45lGIG5i81lIptktaG8fZ3wosQ/E
	LrzpAELg==;
Received: from [113.46.200.221] (helo=canpmsgout06.his.huawei.com)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8GX4-00000002MCp-3hRz;
	Thu, 02 Apr 2026 11:48:21 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=o0BfAq2trtfASNnVxf9HHtrEQCspzeSBvKkdxZfJnW4=;
	b=Luc54heStVP+Ks1cf/+9Mie8Lxo+t9KmOQfujBmJXRPKkSvo/HJW2BgtlkbawbWBfCN9tRiOC
	MhfDfIGw5pwHoccffo+jZsj9vgYRqDLMIwGS/b1ztYLuinQEB7Mzu9JGS+etuJoT2GPKebOkefi
	174duOCnXseF0u2OAWDwFu0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fmg1R065LzRhSg;
	Thu,  2 Apr 2026 19:41:47 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 771BE40561;
	Thu,  2 Apr 2026 19:47:57 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Apr 2026 19:47:55 +0800
Message-ID: <c6eb858c-5275-6fdc-b6e9-bd6d4b169e05@huawei.com>
Date: Thu, 2 Apr 2026 19:47:53 +0800
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260402113137.GAac5Tmc5b7SL98KdY@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_124819_565003_DCE2740A 
X-CRM114-Status: GOOD (  12.61  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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



On 2026/4/2 19:31, Borislav Petkov wrote:
> On Thu, Apr 02, 2026 at 03:26:46PM +0800, Jinjie Ruan wrote:
>> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
>> and crashk_cma memory are almost identical across different architectures,
>> This patch set handle them in crash core in a general way, which eliminate
>> a lot of duplication code.
> 
> From: Documentation/process/submitting-patches.rst
> 
> "Don't get discouraged - or impatient
> ------------------------------------
> 
> After you have submitted your change, be patient and wait.  Reviewers are
> busy people and may not get to your patch right away.
> 
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> 						     ^^^^^^^^^^^^^^^^^^^^^
> 
> one week before resubmitting or pinging reviewers - possibly longer during
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> busy times like merge windows."
> 
> You need to be patient and send once a week and not spam people:

Thank you for the reminder and for your patience. I apologize for the
frequent updates; I am becoming more familiar with the community's
workflow. I will follow your advice, limit my follow-ups to once a week,
and avoid resending during busy periods like the merge window. I'll wait
for further feedback before taking the next step.

> 
> Feb 04 Jinjie Ruan ( :1.0K|) [PATCH v3 0/3] arm64/riscv: Add support for crashkernel CMA reservation
> Feb 09 Jinjie Ruan ( :1.5K|) [PATCH v4 0/3] arm64/riscv: Add support for crashkernel CMA reservation
> Feb 12 Jinjie Ruan ( :2.1K|) [PATCH v5 0/4] arm64/riscv: Add support for crashkernel CMA reservation
> Feb 24 Jinjie Ruan ( :2.3K|) [PATCH v6 0/5] arm64/riscv: Add support for crashkernel CMA reservation
> Feb 26 Jinjie Ruan ( :2.5K|) [PATCH v7 0/5] arm64/riscv: Add support for crashkernel CMA reservation
> Mar 02 Jinjie Ruan ( :2.8K|) [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA reservation
> Mar 23 Jinjie Ruan ( :2.9K|) [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA reservation
> Mar 25 Jinjie Ruan ( :3.7K|) [PATCH v10 0/8] arm64/riscv: Add support for crashkernel CMA reservation
> Mar 28 Jinjie Ruan ( :4.3K|) [PATCH v11 00/11] arm64/riscv: Add support for crashkernel CMA reservation
> Apr 02 Jinjie Ruan ( :4.5K|) [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA reservation
> 

