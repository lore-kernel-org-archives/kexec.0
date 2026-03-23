Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABBFD39418
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R5jIawgYWsUZf+zva/5Ugy+eZOQoWT60xSBcueOhzu4=; b=mu8FPWQ3yXfnSAkCrq5oPY/dny
	cfElje/R7RJ9k2BW6oZDE56lTEBt/lHxP1wwY3VH3bb2jsMFyWSiwF+gieemeaxZlhb5ddR4aD59D
	f5XeXisUHOQddcPbffAVSYMClVuz44TmEBatruQbn++/rKQr3tH9/+yOnykPM2UOfs+EKEVVSTDKg
	esRN2oqp/lcPfI11a6nX5iwxGOx0kQeSsDBSBtg2pr0swMpqp33KNwllvMIqzIbtEMzZVKldWarXI
	5I0y1iqptdYiD3TsB+36R9AepJ2f3J38X5LxAm1Y2cyMfur21vqvZj1+wXWfoP0RJMPpnjpCkfPr0
	QuGlg9cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFj-000000003pL-1zQ4;
	Thu, 02 Apr 2026 12:34:27 +0000
Received: from canpmsgout09.his.huawei.com ([113.46.200.224])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4Upb-0000000Ftcq-3uow;
	Mon, 23 Mar 2026 02:15:53 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=R5jIawgYWsUZf+zva/5Ugy+eZOQoWT60xSBcueOhzu4=;
	b=y3Xbkkm33OuzIVeOTkvy3KpKEPcdf2aDbqAe3Lg6LRtI41eVGLOzLzEHaXMCw85OESY1/4bI2
	bPphRkVD2M+iRz/lb01qPoNmCTKGtBzHctxQ/gkE4GpAhkYl12sCafXE+ut9iIm15PjCGESUiss
	J6rjzuriAJCkMeqt9jfnwnw=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4ffGnw4XfYz1cytY;
	Mon, 23 Mar 2026 10:09:40 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id F0BC0402AB;
	Mon, 23 Mar 2026 10:15:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Mar 2026 10:15:39 +0800
Message-ID: <e666d76c-cd76-306e-a6c2-232c6815271b@huawei.com>
Date: Mon, 23 Mar 2026 10:15:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <dapeng1.mi@linux.intel.com>, <kees@kernel.org>,
	<paulmck@kernel.org>, <lirongqing@baidu.com>, <fvdl@google.com>,
	<rppt@kernel.org>, <ardb@kernel.org>, <leitao@debian.org>,
	<sourabhjain@linux.ibm.com>, <jbohac@suse.cz>, <cfsworks@gmail.com>,
	<osandov@fb.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
	<songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
	<samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
	<fuqiang.wang@easystack.cn>, <brgerst@gmail.com>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
 <ce99a024-f910-cd83-c60a-28e60db318d3@huawei.com>
 <20260322185853.e8e43c346ed98a0ef0544948@linux-foundation.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260322185853.e8e43c346ed98a0ef0544948@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_191552_169184_9EDE2A04 
X-CRM114-Status: UNSURE (   8.89  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:23 -0700
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



On 2026/3/23 9:58, Andrew Morton wrote:
> On Mon, 23 Mar 2026 09:44:21 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> If there are no other review comments, I'd like to ask if this is ready
>> to be merged.
> 
> This patchset predates the introduction of the Sashiko AI review, and
> that thing is proving very good at finding issues.

That would be good to use this tool to find the low-level issues.

> 
> So can you please update the changelog footers for thus-far-received
> acks/reviews and then resend?

Sure.

> 
> Thanks.
> 
> 
> 

