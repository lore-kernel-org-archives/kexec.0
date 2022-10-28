Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF8DECAAA1
	for <kexec@archiver.kernel.org>; Fri, 28 Oct 2022 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LsSBAysbUImmd0npukUsgk0omxpV4HQFpEb0sIXLSxY=; b=OA/xTcp65BB/ZC
	8X3KxP8Pl5yWD/lBlls+gIL3Y6h+D104OFUDVKCgl9SIkQ/qr0q2aifCx4AiJt3IWPsrbkqM7g3sa
	AWVJFfWGh292gLe5FnPV0AvZtZKTHQd8w4sA3sL6OEuILVnyNwKO5EbbKwCUzJM7Rc0JNYIHQ4d7U
	TPAzm/1drKF379iWBRGuSIG5g7YGQv0lIOp8fPbcoDdaoGiliojnSKGbHQYFXOyHmmAmYrsbJhFtI
	WdbJP/Um3cDYSHQVHT0LvROVSrP/8VCtSDrziswM62u0NHBNTXRClOvFk1lxXjQ36fWmxKz6lIfrt
	pfEttx+Xo+53v6h2B5Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooMCx-00GVoF-1J; Fri, 28 Oct 2022 10:03:23 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooM6S-00GTDf-8j
	for kexec@lists.infradead.org; Fri, 28 Oct 2022 09:56:42 +0000
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id EFCB6200C6;
	Fri, 28 Oct 2022 09:56:00 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 9ED999402F1; Fri, 28 Oct 2022 11:56:00 +0200 (CEST)
Date: Fri, 28 Oct 2022 11:56:00 +0200
From: Simon Horman <horms@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] workflow: update to checkout@v3
Message-ID: <Y1unMM5YByuPHDv7@vergenet.net>
References: <20221021152757.125332-1-horms@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221021152757.125332-1-horms@kernel.org>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_025640_492662_94D68F89 
X-CRM114-Status: UNSURE (   9.89  )
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

On Fri, Oct 21, 2022 at 05:27:57PM +0200, Simon Horman wrote:
> Use to checkout@v3 instead of checkout@v2
> as the latter uses Node.js 12 actions which are deprecated.
> 
> https://github.blog/changelog/2022-09-22-github-actions-all-actions-will-begin-running-on-node16-instead-of-node12/
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Applied

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
