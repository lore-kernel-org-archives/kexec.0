Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DE8D78318
	for <kexec@archiver.kernel.org>; Mon,  2 Dec 2024 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fprn1Bo1S4B9rxA6vRF4RN22TjR80E1ZGAoPZH62AJ0=; b=T+A92tQQmCIz6Nee9t5ZonEBSJ
	edTikCfA4jn7kW9JgAELDCERY0fhOmvUjABTsIfNIl3LE5RG+HXQbV79OxdWduR4Ox328ras9zZXD
	/d/tmmvSX+Rdl5mPFxjr+qGoEJbBIuZPbmfrHof8t1esCzrD0dJORsgjKdqfB3iEmxpMeIf7oRt8t
	kmifLgt8pxn4Y+Bdn0xLoOZGkME3no7G81TaPQwFx3uTqeLogWsvJz4sClgnmVVT2gQLIgL5DFX2w
	AhAccusIPqzFDC43S//EHOEC8WBd94BYTd2rOmbUX4mCnRvEn/VY5AUZYUuOjmZkvedi2Tgg39z0N
	BrPqY3WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI674-00000006AsA-16Ja;
	Mon, 02 Dec 2024 13:05:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI672-00000006Ar8-15ba
	for kexec@lists.infradead.org;
	Mon, 02 Dec 2024 13:05:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 577905C1110;
	Mon,  2 Dec 2024 13:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B1EC4CED1;
	Mon,  2 Dec 2024 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733144715;
	bh=XpgX0srmdTe/626mDvb/kGxbeiBmfAW9NiBCRaMCNEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNZf4oFXJZfJYd8FZX3LkohPit5wUjANaRNe1ypsmGzvoyEH4GwwD6uhOgjzw4zP9
	 w0CvE1ua4T8QC8RmpLtOciDPNiZwRSHBg3AX08rNZqHX76h+EQpT6ttlgkIo2Hhigk
	 oFfELDHskbtwEV9Lr0niiNweW3qjICeG1m67+dE0vbSn2g0mD510/bfhkOJZAfJOsr
	 S0yHY/7PAp0sDQN9M3mgp5YZXlAERYs+p0xT49au9LvS7giMQjiKk0ilsdqMVLb0F2
	 +iUohZsxFL++yqI0V/zfOh/b2XJZjqzZteqR1+vm8uf4xyvPgEliiCEb5KR0evHodP
	 EmIAPwMpYv3nA==
Date: Mon, 2 Dec 2024 13:05:12 +0000
From: Simon Horman <horms@kernel.org>
To: McLaughlin Amy <amy.mclaughlin@hubersuhner.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: Bug report - GZ magic check always fails in uImage_gz_load
Message-ID: <20241202130512.GA3737@kernel.org>
References: <DB8P193MB0710307EC147427C3B14E24383222@DB8P193MB0710.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8P193MB0710307EC147427C3B14E24383222@DB8P193MB0710.EURP193.PROD.OUTLOOK.COM>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_050516_335231_A036D412 
X-CRM114-Status: GOOD (  13.33  )
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

On Thu, Nov 21, 2024 at 02:24:47PM +0000, McLaughlin Amy wrote:
> I tried adding -Wextra to Kexec's makefile, while compiling some work by a colleague that built on the kexec source. It spotted the following:
> 
> ```
> kexec/kexec-uImage.c: In function 'uImage_gz_load':
> kexec/kexec-uImage.c:160:31: warning: comparison is always true due to limited range of data type [-Wtype-limits]
>   160 |  if (buf[0] != 0x1f || buf[1] != 0x8b) {
>       |                               ^~
> ```
> 
> With buf being an array of signed char, buf[1] cannot equal 0x8b without a cast, meaning that this function will always return -1 early on. Maybe representing it as an array of uint8_t/unsigned char would have been a better idea?

Hi Amy,

Yes, I agree that seems wrong and that your proposed solution sounds good.

But I do wonder if this code has been exercised. Since as you point out,
it always returns early. I'm guessing no-one is using gzipped uImages.
So perhaps we could consider a more radical approach of removing support
for those images?

In any case, could you consider sending a patch to fix the problem
you've found?

