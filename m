Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00792D15DB7
	for <kexec@archiver.kernel.org>; Wed,  3 Dec 2025 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PfzwkdH40GhCXCduZWdm6RDCveXH20QmVOIxVfwQRkc=; b=TIyx11uQaYpesCKX4B0uqESRfH
	mRSGxKqEy5rk28vpBTHEn73RX4F41EfkXBbOW0MiTsgTf3xXOLuHW7aA4Gk4q7axRmhyyGYULZMyZ
	j9ubvgrc2fybyLS+8QvOM2xruBoYv01xZ2UIHFzSad8Z9oaDbJdChm6mToPsRF1eJlpKdbYHtmdPq
	ht9bAZiN7S3S/RgujRzpZeFVRFz/Xq0N3RUaFxxzAwWGh7nzAzCD3+00LUm7BH/RZzkMJBRUkF94v
	86qens/ZSoNn/CVDflXU7iduscfgjpdBM0es19U8JOKCxI8wnruwKYi4KGiJte7in3wEn3+vdbXzs
	2hstTJFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQqfE-00000006rfE-0yju;
	Wed, 03 Dec 2025 17:29:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQqfD-00000006rf7-1YVv
	for kexec@lists.infradead.org;
	Wed, 03 Dec 2025 17:29:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C0456601E0;
	Wed,  3 Dec 2025 17:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF4AC4CEF5;
	Wed,  3 Dec 2025 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764782954;
	bh=JdoO7DQCu0zDOMybz1AYXz9tYwxMAQRDioRbiByNusk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9xrEjJ/4RpF6JEkmlGEUVS38i8spVD4Zc0kA3gPgev+7fqPFZXzfoXO65RkcMWdC
	 WxqvXjIFOBtl6hNY65Lft7rU34N4dZy/Hlw2zpnn4AbgdvycBQ7dasaz5FFEFSYO7i
	 XQ432fgnP4UcpovRQiLrqPn3uAZApSSDzxEPrlbbFN1p+eo40ePHARqUEYeRvFXi6c
	 fWgOpdNNDQIfs83xgH8dkF0N/rHT9wRYK1jVtEeC4l4WOdhEEnp7TRBBYh+McKEE3l
	 saoWc2fVlPVkRX3UyWwBrhADEkf2TD/aOspbv/MhjOdn3dC6Wted3WDyhi5PNlHsb7
	 X6RUk3UnhIafg==
Date: Wed, 3 Dec 2025 17:29:11 +0000
From: Simon Horman <horms@kernel.org>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: kexec@lists.infradead.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH kexec-tools] ppc64: Fix minor build warnings
Message-ID: <aTBzZwd0SAIWLYfe@horms.kernel.org>
References: <20251202102236.244985-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202102236.244985-1-shivangu@linux.ibm.com>
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

On Tue, Dec 02, 2025 at 03:52:36PM +0530, Shivang Upadhyay wrote:
> ppc64 target compiles warning free now.
> 
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>

Thanks, applied.

- ppc64: Fix minor build warnings
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=1633ed5ee80e

