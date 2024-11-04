Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04703D132A3
	for <kexec@archiver.kernel.org>; Mon,  4 Nov 2024 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Ak/ZgfNEzQzZSi+tiL1pV0XuRci5KcqQhKOi7WrpAg=; b=rhCNlCw2OZVDqO
	GtbOWioIs4yyj4/pzjcCAbRe59N7GCFcfLJrmssW7DsG98w5TrjP6sU2DggOI4nfcCLGWyzDil8ZM
	LbRv6g+ELSn6HFpE544E1u8RWGG9vEQyhfb2iCUfpIzmq1GHuLcsWJLeOee8b1LfdV6V4Hp+gY6JR
	9kSUI0PhV/NEbuTtnBrsqvPYcI3Qd979IfmOs7XRpMf3W+/Jeb6Fe/pDXSKoMRQ1a1ZaegBXglWCB
	/OfgTpriFZJ0RulktYb64pvnShHMENaW1aIXlm6enYSI5Zg+DxT2mPeysKgEXQKycuk7S6BgC7OQM
	iPTiQXVqbeKybxHwowuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tOx-0000000D9wT-2eFh;
	Mon, 04 Nov 2024 09:29:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tOv-0000000D9vZ-2xxQ
	for kexec@lists.infradead.org;
	Mon, 04 Nov 2024 09:29:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BC4DF5C51B2;
	Mon,  4 Nov 2024 09:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2528EC4AF09;
	Mon,  4 Nov 2024 09:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730712572;
	bh=2JURijHNV+KemUfDU5wkI0i6KLCZZ11iq9Wf/qgx0vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seOuwwpmc4+XPpKRPh1tpDeO8LnLjHrpangCLPXlZRRzeNqYFmL0pmiDQcWr0G66x
	 8KCMIEARpPbteRdARmIfNPih2K469/FERZOGGyXqxy4t4VAKT768coptEcNdLqbPWr
	 6qdveBFDHXJPEzmtW4CQR9VoTwnejzMkItLUhGUqGRrOcZPGPf6I2yFQHkhgK3Ix09
	 Zl5Nct1zDc7clTchxyYD17KcP20a8t20BIX8zwsOmPr2V5arxR7tHEwmADGU2E4fwc
	 vqgHQ6QsWQFurnrJasenjMOhuZZ9EYuYhoz/bdJ2yk4rq7mwL+cgZTRWHpsYHaOyex
	 t2dmRbG97098w==
Date: Mon, 4 Nov 2024 09:29:28 +0000
From: Simon Horman <horms@kernel.org>
To: Chen Haixiang <chenhaixiang3@huawei.com>
Cc: kexec@lists.infradead.org, louhongxiang@huawei.com,
	wangbin224@huawei.com, yangyanchao6@huawei.com
Subject: Re: [PATCH v2] Before adding to usablemem_rgns, check if the memory
 range is already included.
Message-ID: <20241104092928.GR1838431@kernel.org>
References: <20241021120025.1430-1-chenhaixiang3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241021120025.1430-1-chenhaixiang3@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_012933_808406_BB220279 
X-CRM114-Status: UNSURE (   8.88  )
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

On Mon, Oct 21, 2024 at 08:00:25PM +0800, Chen Haixiang wrote:
> When kexec_iomem_for_each_line() reads from /proc/iomem,
> concurrent modifications to /proc/iomem may lead to
> usablemem_rgns recording duplicate Crash kernel segments.
> This can result in the number of retrieved Crash kernel
> segments exceeding CRASH_MAX_RESERVED_RANGES, triggering
> a realloc of the crash_reserved_mem in usablemem_rgns,
> which could crash the process. We should ensure that each
> range added to usablemem_rgns is unique to prevent these issues.
> 
> Reviewed-by: Louhongxiang <louhongxiang@huawei.com>
> Reviewed-by: wangbin <wangbin224@huawei.com>
> Reviewed-by: yangyanchao <yangyanchao6@huawei.com>
> Signed-off-by: chenhaixiang <chenhaixiang3@huawei.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
