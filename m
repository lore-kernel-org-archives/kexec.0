Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244EECD5BAC
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9zFYHAmIgNm/7flQVgpj3X9/gjkem6kk5Xx6XIMJjAY=; b=Tmeu3C8E9oH4Dhyr0i4I3eFe17
	0gC1Ib9Ofb0yG0CKjafQ+juYwv178fDCneTRWuhqk4/SowcxkNOfm5UMwKMtnOzenRiI13dGRmivy
	VoCj1LvpibQF9P4LWA0vbIk15xKUfJ6X8D55F6STWouO+Gyjkphjjz0IBQwH2XWMictnHby2xFaHh
	OyoY2Uvudg3naBI5+sR0tCrpzrRdbS9O4qvukXlwZ42TD/PBMqXUJI/ZF3eW1fTCZETXWMOq/h/4x
	JubedTRfQv0bxfA+sEMpJu1TQouSWKPbsw7cniVU3Cnk4G+huR95/EjWfoO3KSllwckyk5pR6Mltb
	5LbDJbQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ5Gn-00000008Ii6-0VQr;
	Thu, 21 May 2026 15:25:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ5Gh-00000008IhC-0usD
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 15:25:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A27BE41E51;
	Thu, 21 May 2026 15:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7077D1F000E9;
	Thu, 21 May 2026 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377102;
	bh=9zFYHAmIgNm/7flQVgpj3X9/gjkem6kk5Xx6XIMJjAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=k2vo3dMmsz1YrhHDDleGFlDK7u+xaENxpBPvl+fBKKW1aznTAtkUIgXdz9LtYBh7N
	 gnn2sIQzXh1kx1bfJOKZN3QkLk6P7BkiOGJ59+ljgxiys7EaUeibrLPiMaJW/azwxh
	 jKynHj4P7RiLbkAuSFoU/x9weZ824wHRAcEALqketQdiKivd4tA5wTYDikW500Wsaw
	 lbopkDmFTMVfY54DUQfoZhbKH8e2gKZ09+LEFiegf7x0s1pbBsTYMcCsCT+bUev42H
	 EKwDBrnSCtDpZqj4GuHN/a+8nFWDjMjPnFFii+PHzNaTZHyzF/vOcfcVsHpPxEZRuW
	 J0K++RD2/ucXQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org,  linux-mm@kvack.org,
  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] liveupdate: document systemd support
In-Reply-To: <20260519152957.548119-1-luca.boccassi@gmail.com> (luca
	boccassi's message of "Tue, 19 May 2026 16:28:39 +0100")
References: <20260519152957.548119-1-luca.boccassi@gmail.com>
Date: Thu, 21 May 2026 17:25:00 +0200
Message-ID: <2vxzbje8944z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_082503_277320_6197F03D 
X-CRM114-Status: UNSURE (   8.37  )
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

On Tue, May 19 2026, luca.boccassi@gmail.com wrote:

> From: Luca Boccassi <luca.boccassi@gmail.com>
>
> systemd v261 will add native support for LUO via the file descriptor
> store mechanism. Add a brief paragraph in the LUO userspace documentation
> page to inform users.
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

But of course, we should only apply this once systemd v261 is released.

> ---
> NOTE: the external links will mention LUO after the next release is
>       published, which should happen within ~4 weeks
>

-- 
Regards,
Pratyush Yadav

