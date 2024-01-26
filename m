Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C07C47DDF
	for <kexec@archiver.kernel.org>; Fri, 26 Jan 2024 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1rAW9860y57yrbbhcy2Ir1Ri1v4jUPo2AqQNWASjui4=; b=hmcQZJNdI6/h0b
	CdTlOCseDyZukH/MvWYQmQfnZ+Zc7FYtKlP/jDBjYQkuGpcsLKPO+NWSndwb89liQKyUqTOhh269s
	aNP+rq/66PNrwVup3webeMR0rFze1Kl+XUmsmuxdvqEpB9zLuCUvmEmtD4FaqypV0ESKt6qtBdW/e
	1EtSNQy2xR15K2DHCWEiT0iwDKaE/Fol2ChvfDA8aEJK1llSadmTx33uMNHP6cV+ZZSjl+8AzXKmp
	zCWqXXeRR5b7ae/MhaE5B85G4GyaL0eYGk8GW5saZPoikPpRVfum4PSMhvsI1TPqgsWwFlRkGJEEI
	yiAyyUnZ30YqkLvc5c2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTKGw-00000003yQL-2DgM;
	Fri, 26 Jan 2024 11:21:22 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTKGr-00000003yMH-3YQ1
	for kexec@lists.infradead.org;
	Fri, 26 Jan 2024 11:21:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4FD6ECE369E;
	Fri, 26 Jan 2024 11:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0729C433C7;
	Fri, 26 Jan 2024 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706268059;
	bh=YtoISk5aCRteP2uoLibHHtWzyEFd/HJziJP7lH/+VOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7KXsdJln7fa5tUcZpiTIQtM6qBy/x36BnLYjnQBmX9BnZvRzKhn19DD5FNRxC9Fe
	 eF7Cu9R+VPoQ0j78RXENTbwfqh4Dg4KG5w5GEs84xZo+nwU4XTnzuEavgJcB4NLMZG
	 oBnxpF9771iMY9GiPDVZAM9zk113kdNONvh0ce3q1A5piS1OXR85PKy2rDglvmw2YW
	 ROTz1WE4EobnFzJepjDu0LuwOUyCZJD9HkomYMGtOtP+/wWLqJmoRGSdXu8uyp1pgV
	 w2p/yww9C7/t0r4pr/GwJLd5oVU5B+X89ND1vbAszLKkVnrjlxcMacfwOStELzcygt
	 lY2e8qvGuO+3w==
Date: Fri, 26 Jan 2024 11:19:25 +0000
From: Simon Horman <horms@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] kexec: Remove duplicated include in crash_reserve.c
Message-ID: <20240126111925.GD253507@kernel.org>
References: <20240126004449.118407-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240126004449.118407-1-yang.lee@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_032118_419906_9B65792D 
X-CRM114-Status: UNSURE (   7.48  )
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

On Fri, Jan 26, 2024 at 08:44:49AM +0800, Yang Li wrote:
> The header files kexec.h is included twice in crash_reserve.c,
> so one inclusion can be removed.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
