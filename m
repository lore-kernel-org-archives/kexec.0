Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8501C4345F
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 10:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l2ghwq/qSn+DyLHeWqc4kG4XEYmgB7OV4JJL8J7iqss=; b=03ObSL2EVxZihd
	iGYNGUfuYxjzen29Ga0fkscLfziHRR53hrXVdc4Ks96QoI7H/CZI3L3/cijGsIK2vVLOEn8J4Vrlj
	oSW6ZHClc6J4OMuNUjrm5j2/VRfnvr6No5qAGFXd5PPCds94nuYKqxHa0/G9GL6llmNAz3CKVmODl
	11+YRc8znJpYbf9UBAgTKNSSY4n8mBnLsMcT8sNpOVeZ7tQCvkRYlLrbD7AOB9jcSSEZtEScmnUz8
	GvPODThT3ZP9gz+3xlyENpCNMfYgPp2rkHPYWuLrfRNZhRns6syOkG2fL3yZ0U12bja6pEXntLCsd
	hSn5DyCUS5b0ePCG/OKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzDEI-0000000GoXB-1hah;
	Tue, 23 Apr 2024 10:18:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzDEF-0000000GoWT-0FlA
	for kexec@lists.infradead.org;
	Tue, 23 Apr 2024 10:18:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8665D60BFF;
	Tue, 23 Apr 2024 10:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F82C116B1;
	Tue, 23 Apr 2024 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867502;
	bh=zUIo7yt9FGTZzElFKp+0FoKoI8pBhD4U+1aMFj00R9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLLP4RHOBM/vJvvtpyHdKo2aIUtJ+4sWi5+IInZD4HTxPTjoJbYTCX4FgI7tkn/cf
	 l0O6+68XnE6fxDqfczl7MoGmtdoi8x/HD5J+9YBG2OhQogioMWMVg6PJH2sznvXUed
	 Tuj/awb4upPmwCgVs2BFHQzXPCSU37Hh09+EELL/y7Zf0xkol///hQnd8Ee5rAryj3
	 YV6wDShSNuuXlsXYVu6ZI6LSeCwsp4sD7vifLWVPI5+D8Q/hEh2ossm8E6BcYkP5SN
	 Yx8DbkRTjoJeZMwVZKRB7Tbn3323/ulMOP7IAiAQ8bVn4WbCaHg0AdSdJs1XPyCtIZ
	 VhTBi8Vp70sEw==
Date: Tue, 23 Apr 2024 11:18:18 +0100
From: Simon Horman <horms@kernel.org>
To: chenhaixiang <chenhaixiang3@huawei.com>
Cc: kexec@lists.infradead.org, louhongxiang@huawei.com,
	fangchuangchuang@huawei.com, wangbin224@huawei.com, bhe@redhat.com
Subject: Re: [PATCH] crashdump-x86.c:Add a check for the crash kernel range
 in exclude_region()
Message-ID: <20240423101818.GI42092@kernel.org>
References: <20240321113317.1231648-1-chenhaixiang3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240321113317.1231648-1-chenhaixiang3@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_031823_165465_A51F7C90 
X-CRM114-Status: UNSURE (   7.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Mar 21, 2024 at 07:33:17PM +0800, chenhaixiang wrote:
> In some cases, such as start < mstart < mend < end when exclude_region(),
> this results in crash_memory_range[i].end becoming less than
> crash_memory_range[i].start, leading to incorrect address ranges.
> Adding a range check should be necessary.
> 
> Signed-off-by: chenhaixiang chenhaixiang3@huawei.com

Hi,

Given the discussion at [1] I am assuming this patch should not go in.
Please correct me if I am wrong.

[1] https://lore.kernel.org/all/8606fd02d6de4eb3b7c80e4ce3449458@huawei.com/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
