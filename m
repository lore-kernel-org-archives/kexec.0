Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0C1D5CC9C
	for <kexec@archiver.kernel.org>; Wed, 30 Oct 2024 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bh/02yahiHZhg7mUdAmKXBPaCCYawOhz3WYeVQuUBic=; b=zrEaHaNiKii8ap
	9AMCAoN+Ow6uTGhUKEgGewA0fKnguyXsh8ID/Gs/9+wZRKmyCAhoxyiuxA52p8cLWTHDb5wVutZxG
	WECrG1UNK2aHD4zHhLLmjDrRnLVktkH2sK5a25KIV1JBV0eM9zZSsxsvEwI3S82v2pFnC3HjxNCZy
	Gzm+meIVlhhPQwIEfivd6UESWXA3gaKwjQNz/y0AHG3uoI6hmVZ+G3i/bclUTKFsBLiLYpk5YfurV
	B23XV24558Bh9M6YZb006pzPMh+2eu0TSvcjTMDibvrNgAQLB7drJ6hftOfEf6LdM5Xn9xy+eltJQ
	YcDASiEnN1s0q69KDdQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t67AD-00000000CYQ-04j3;
	Wed, 30 Oct 2024 11:47:01 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t66vH-0000000093M-3PCL
	for kexec@lists.infradead.org;
	Wed, 30 Oct 2024 11:31:37 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 65F5C40E0219;
	Wed, 30 Oct 2024 11:31:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q5LWoPUdiOpA; Wed, 30 Oct 2024 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730287876; bh=/rPgRmjYbXWEjZCU0NovrlZpZ3/iWCSfnrohOhQm1lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvK3Dip+OAWthc7F2h9PuJkdZbkPUoxNC7D5E2k/a87lM7CmqTtH/qSoYruMR0zX1
	 B3FaINjoqTYzIzxLQ9FF2Hy0G07pk5jwq4V7GrVjXnJUDqd87S8n3jVtRTQv1gssXb
	 gcxxyMJXc3E7pVLxIpS58J8nESdEqPYOOGy5RR0SzdJ/cwlYDfhmLjF8h9/QZkwvR0
	 5IvTosJ1s3clX9thvoVeynodC+t+0wbQm6GPk8tPC9g8zTPOj4zFze2MiX5PVApi7j
	 ZnXdjs/SmnWooIkeApWjgz42KnnL5qK6+I0cwerP7aoGX+Lp2CTz9PabXzwfEf/bac
	 4kzT2y3VZPcGs6ooKINQQlO1GqNlvzwjRBgbCzlkrgyxCJwtvwkDLyu8bVGuL4VHL3
	 78SFRDicRzmvJsldIIY4ivs+3V/ct+lU7y6sf7SBfJEuyqhQQx9xFSVASIMAA7OYBN
	 zutThgt8vv1J562z1zo5GBvIUZ9k4e77hp5gYNqtsdxsU0SXrK69ZSZjx/3jduqp4n
	 V0D6qxAa0EPoaXFvorgZ99QLTH9Og4aq/xV+h7iIagmuMpUKRHyfep1rMgiZufxSTG
	 en8szzEjGwxQRWxKqD6lh6O2qfEkn+PoB20708wEywfSdPGJ7fZoLQ4VgT4H7dcxtg
	 WcbcgQu/HW7ITZVy37M7Loz0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D1E240E0191;
	Wed, 30 Oct 2024 11:31:06 +0000 (UTC)
Date: Wed, 30 Oct 2024 12:31:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
	thomas.lendacky@amd.com, dyoung@redhat.com, daniel.kiper@oracle.com,
	noodles@fb.com, lijiang@redhat.com, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <20241030113100.GCZyIY9KgKX2pHK7GV@fat_crate.local>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_043136_010683_F938759E 
X-CRM114-Status: UNSURE (   8.23  )
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

On Tue, Oct 29, 2024 at 06:23:06PM -0700, Andrew Morton wrote:
> So can I suggest a resend please?

Andrew, you can ignore. It is on my radar now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
