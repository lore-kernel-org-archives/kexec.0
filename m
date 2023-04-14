Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26F9C77B72
	for <kexec@archiver.kernel.org>; Fri, 14 Apr 2023 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KoYT9+zXOJmJCj/Aj77Agq9glL8r1pbWMQPjpeY8FBM=; b=iT8N2kBCZwYOb8
	qptVwRSJJIRLVYGbg2v9DNnM4CD6905Uvo0htS7/uQm/9N8bGkoJK25T2WDzL9jZdlWqLK5Ue34Rj
	bgXPqb3Fn2h71EuUz1d1skbe/8B1f7sbOaC33kNkTLEiU6t62L9yN+1jiwNb/PbkG4VmCNuJDfoU4
	vU8wgvbpO7RmH6l2TyMosRvYBRgjmZKkUnRwnIhkLLR1PNRp/zxH1vz7mJmGACFtsIUZM9TCt3WVf
	l6/Q3/AId23Buld2IploXfUPVIKwtiGiFdL080Rf8H2dVxhF/B9JHk1eForZ1UoBLOgSRetTuGE5F
	X8+pg+Gcv3sXFYzf5Kyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnKVQ-009prH-0Z;
	Fri, 14 Apr 2023 14:34:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnKVK-009pqR-39;
	Fri, 14 Apr 2023 14:34:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 793CE6385D;
	Fri, 14 Apr 2023 14:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E683C433D2;
	Fri, 14 Apr 2023 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681482861;
	bh=d0iC7roleDI04oHJIwtWDATxuxnM5ASBnX6PRX+duzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tDqpVX6rIICqZGNhn3rMgK3VZbfqOkWwStqI7SukeZhca0g7UEY0KBY4pkYHechq+
	 D4VVpG047EwsF4tUVcVo9NUQdyqoYI1Ft63c+ZFqRuR1XMavgFb0HTsc1R6N+P6zvk
	 TW4AIUVfYed7fR8bHyNinoFWhx0SWUx21OiyhJyQSVLQHW+6kzP9p43EN5D46hUhcc
	 /F74Ht+k1pGaOBciSviM0+TEYWnBsn/C2q2lSWc3H3fHeq/25xfbfUDCTYhXh0BEbW
	 C4QrLEmYK1ZTzswpX4N9Wo11cHOH4WL2/6ezPivGm4qzJCH1ZezSnM0//LKdEzGFsc
	 mPYrJlfbHE/9g==
Date: Fri, 14 Apr 2023 15:34:16 +0100
From: Will Deacon <will@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <20230414143413.GA27911@willie-the-truck>
References: <20230407022419.19412-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230407022419.19412-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_073423_080750_1B53146E 
X-CRM114-Status: GOOD (  14.05  )
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

Hi,

On Fri, Apr 07, 2023 at 10:24:19AM +0800, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.

[...]

>  arch/arm64/mm/init.c | 44 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 10 deletions(-)

I tried to apply this, but smatch is unhappy with the result:

  | arch/arm64/mm/init.c:153 reserve_crashkernel() error: uninitialized symbol 'search_base'.

I _think_ this is a false positive, but I must say that the control flow
in reserve_crashkernel() is extremely hard to follow so I couldn't be
sure. If the static checker is struggling, then so will humans!

Ideally, this would all be restructured to make it easier to follow,
but in the short term we need something to squash the warning.

Cheers,

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
