Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05902C433FE
	for <kexec@archiver.kernel.org>; Tue, 15 Nov 2022 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tsRgX5G0Van4wVKGHeRJMQkj5r3HYJ04NtaHbLi/J4E=; b=pFguDdeObL26M/
	jXn91fZD530vovvYkXR5CemgsbyaavJnyEqr03C9Nm7OjGw208Hnoiunj4OSzbH5FMCI05KpYLteM
	sD+dInACZnAnNXd9Emtjc5ZkOoJFC6RDkRjXo9TRlA+vsRiwYqnFdnX16jriElHtCKP2EM+oIM67U
	E9gD8tPbnGJjhexras5saKqRakluNJoSJqjbinhKhPAToFudEpQbl/FoySNqNwccUNbYpCcNwIqtG
	Qk0gFAEesgWMJYRq2fryVvz4aguH+ybBCwnBhXe5JVxEzVAt3qhZOpPrmhlcWGsinrRHep8c7XZHB
	ZtB4vRUuy0cY0oUs2QHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouw1d-00BSJf-1k; Tue, 15 Nov 2022 13:30:53 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouw1V-00BSGt-MN; Tue, 15 Nov 2022 13:30:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE28D13D5;
	Tue, 15 Nov 2022 05:30:40 -0800 (PST)
Received: from arm.com (C02TF0J2HF1T.cambridge.arm.com [10.1.32.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EE183F73B;
	Tue, 15 Nov 2022 05:30:31 -0800 (PST)
Date: Tue, 15 Nov 2022 13:30:27 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Message-ID: <Y3OUc1N7Kif1pnZv@arm.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20221115115837.GE32523@willie-the-truck>
 <6c1751be-9957-0765-5e68-2eb78adc9a94@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c1751be-9957-0765-5e68-2eb78adc9a94@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_053045_845937_766F71D9 
X-CRM114-Status: GOOD (  11.28  )
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

On Tue, Nov 15, 2022 at 08:18:21PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/11/15 19:58, Will Deacon wrote:
> > On Mon, Jul 11, 2022 at 05:03:17PM +0800, Zhen Lei wrote:
> >> v2 --> v3:
> >> 1. Discard patch 3 in v2, a cleanup patch.
> > 
> > Do you plan to respin this series, addressing the various comments on v3?
> 
> Yes, I haven't figured out where to make DEFAULT_CRASH_KERNEL_LOW_SIZE generic.

Do we need to? I'd just go with something like 128MB, specific to arm64,
and we can increase it later if anyone comes up with a good argument.

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
