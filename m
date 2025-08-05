Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595BFC87FD1
	for <kexec@archiver.kernel.org>; Tue,  5 Aug 2025 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oww3C4AKsnLdYbJzAFvJAD3zxYj928+o+vYQ6f32sRQ=; b=qeZdDZiPzGXB9xwLkfQBrcpnxi
	IF2P4vSmxI8Bw5AQREfE+wcyTuzAwWPs8KIjacOGIyGK4di2SID7MzMyqcgxvXW+24B00x6t/at9e
	DFr2JoeIWg0MHNGtC5nXS9YBsGSRPp5pznk9AvkslItj/aox8ixQ7VTuA2DUPOazj2e0z8V/9OT29
	kiyHT8gqQkvxgraLLjB3mvo0h5EKFun1+QNm80UVcgYrzv820gPtHKPRmjjSG/kh4T7nQ1fiQh08S
	xZbJ1Hlwp4Q0MFpem/UE3xp5EU1lvuiYSxQ0JPLZZ+7vXUtQWpvYHAYY2COFmvmxg72Waz5Ze3gGR
	JNe8XRiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujI5m-0000000Ctex-0PUo;
	Tue, 05 Aug 2025 13:52:38 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujHvM-0000000CsI6-1Lbw
	for kexec@lists.infradead.org;
	Tue, 05 Aug 2025 13:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1754401310; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cclVEPqz+5BPAJhif+qXY5TYPNAx1i82bnmfnm34ZKjKO0diHiU7Frknp/nP6OmZU6ppb7YSxf5loAxNbPCFsliSFHlz530pLU6HEG47wpcbkMwhRf6YKCAtd9ojLaIaMkIf3d4q8QGedf95P7Tds2jxKqPbi0kAgnxNi6YLOLs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754401310; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oww3C4AKsnLdYbJzAFvJAD3zxYj928+o+vYQ6f32sRQ=; 
	b=UwnmEHCjUaTeYeimbnClsjsjvm6EDbVIyn3Y9CQVZHPzhaFPuEDGPvo1X5ym+Onoyhfz/sSGtJRfxm9LCu/NwtW53h/25v0xvfYpYHlYOiDhZuRINQ199Gg9EuD9AchHGSseaz1gWB8kBYUAiIh9uCe+xioZR80XcwDmTvE/mvw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754401310;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=oww3C4AKsnLdYbJzAFvJAD3zxYj928+o+vYQ6f32sRQ=;
	b=WRgB3nclECtV7F+TNnH6k5V0PVDPtRF02MMg4sluv1nJhaOlXNwYQ5mSeGuvinQv
	jKhx3qvOHCyOXq58R1P4tiPorLWKX7R2t8NI0DKqjmoG1qZG4GTOPYbu61w+cFlfK9w
	wZ8K6EOHPr/dSmWAvA6hg9C4dQmZndG6dR2y0fTc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754401303073217.12313831672782; Tue, 5 Aug 2025 06:41:43 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Tue, 5 Aug 2025 06:41:43 -0700 (PDT)
Date: Tue, 05 Aug 2025 17:41:43 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>,
	"Jeremy Linton" <jeremy.linton@arm.com>,
	"kexec" <kexec@lists.infradead.org>
Message-ID: <1987a776a08.d9fe55e19764.4211219700074090609@zohomail.com>
In-Reply-To: <CAHp75VcUmOrfp21gij_-Ysrk5P=smTpfxmZHWgHU+z_VFZzc+w@mail.gmail.com>
References: <20250805124722.11193-1-safinaskar@zohomail.com> <CAHp75VcUmOrfp21gij_-Ysrk5P=smTpfxmZHWgHU+z_VFZzc+w@mail.gmail.com>
Subject: Re: [PATCH] fix printf string specifiers, otherwise kexec doesn't
 work on my laptop
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112279e56be7fae507d480353babe0000137b9cd93dd2874097fb958ad63eea3cc9d3b4e470f288bbd4:zu080112273041933085050a7bfd255e8b0000dbe61324f56b7bb18619c1f74be39a54065fdd6fccecf2a9a8:rf0801122bfb11834dab90c0f226b910ef000036ca16360fbd750d570cc8353a582a92cf2eaffe9dc33ffef3cf0bac25:ZohoMail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_064152_779497_28CC87C4 
X-CRM114-Status: UNSURE (   9.42  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

 ---- On Tue, 05 Aug 2025 17:00:45 +0400  Andy Shevchenko <andy.shevchenko@gmail.com> wrote --- 
 > Thanks for your report and the fix! My comments below.
Andy, thank you for answer! I will write second version of my patch soon.
Also, please look at another my report: https://lore.kernel.org/regressions/9eac81e6-b4ee-4210-84ac-cbf7bf811130@kernel.org/ .
Mario Limonciello said that we need you specially to proceed.

 > > 3. uint64_t a; printf ("%w64x", a);
 > 
 > Haven't heard about it. Which C/POSIX/etc standard is this?
Introduced in C23. https://www.c-language.org/ .
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3220.pdf , 7.23.6.1

 > > * Laptop Dell Precision 7780
Side note: I bought this laptop, because it seems to be the only laptop in the world,
which has ECC memory and in the same time doesn't have nvidia.

--
Askar Safin
https://types.pl/@safinaskar


