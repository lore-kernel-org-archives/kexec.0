Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171B9C83010
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qFzyH/yew3dV61XbvgZ1M6aYGgeGeRVPJ7xsU06mN5k=; b=h4kC6LdgwbuZz+
	/IIoU1Ntesp+LLJb46+uWuulxbF83AVBFdvFI5mceEfldR1I8/Jt3JtX5BEOw7bEP/v+CSk/BeFpt
	9G7p9IC3GydVskO+PW8k/vC+usBps/d904vkds6ioIpPPlQuzGfLaqwXmDW2LiPo7k9QUvs9l4ULp
	K+7nseF6fO5UVXaobYSF48WPHvQRBSv1fBopxJ6X9vn7EJbs7wgOaipmKEOHtHNCFQXnMQr+KcFTL
	FooKzQOhHGaTnZJHmWgojumu7Yg4jFTtefR+HWbpr5UagUuN4Mgbl40EYgdCYrlpaCVoQpFXAfavL
	StBd6h+7MecPTTJdXX4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjafL-00000001BDE-0ApQ;
	Thu, 29 Aug 2024 08:38:03 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjacq-00000001AVj-33sV
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 08:35:30 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 07C2540E01C5;
	Thu, 29 Aug 2024 08:35:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g_I6YJdYLlmn; Thu, 29 Aug 2024 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724920509; bh=CPJhcm4WSc5DpBeeH7qgshS/p1SRpirWBGGJlu0SQk4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cah3Mpc5nSYpGQMyejkNsp95hkl/X+s6B5xBrgHTfPCNNQHp02ZSXOUI3HjjX9DhW
	 vEjexwCY727LS3YMNoK0hQUMyonR7aCZ6D039tIZEc0OGBucSwndlYqbguDZ5gi4V1
	 qhZLMvXyyeZMQu6daP0guN8Y1oKm6wakJjFYxPGOxJLNxtRkK+Z+Ex/igPHquHI7Wj
	 Ddds+DrEZRos0kyn+w1xjqjEOWO/CswZhHip6siwbkvvkLWV5HCiPMzsqyHYzuUJoT
	 L5qAqTd7VSvRgD2Z1lZm5t9usfqnAZaWvE1uVf4Va1N3vBI82FN068qKydf+GuJidM
	 XA1OKDiXNXqX6CU65lFshs7FVcU81qS2symUlsmgah/jJijv/Tf0+WDNXM80jUmtfG
	 Nlfq/D7c6dvsjCzZq6aRE4X0n+UsndkhJQiIm0XIRUG9GGVUW/RgrPl5RQ3h7s4yoL
	 3HIXB4MRZm3S3Yac4tzt6ibF8iW4XM+Ll3t856HohJIhipSd1Bm0aYJr6hm2CmI2vW
	 WVddYO2iPSadIGgueMUoLwBneHPNBouJQPv+xtq6+hv0CCXnB9obYO8ytEQsrQei75
	 OGA2vtzuB2ZuJwSvSswy6ChUfr7Bf8mfj7ZWYX5nRoa/YrU7DDUXMabC788QCRKSqU
	 s0hrlESh+O3tj6sHBKJoGii4=
Received: from [127.0.0.1] (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51BEC40E016A;
	Thu, 29 Aug 2024 08:34:53 +0000 (UTC)
Date: Thu, 29 Aug 2024 10:34:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com, pbonzini@redhat.com,
 dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
 x86@kernel.org
CC: hpa@zytor.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, thomas.lendacky@amd.com, michael.roth@amd.com,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
User-Agent: K-9 Mail for Android
In-Reply-To: <20240827203804.4989-1-Ashish.Kalra@amd.com>
References: <20240827203804.4989-1-Ashish.Kalra@amd.com>
Message-ID: <87475131-856C-44DC-A27A-84648294F094@alien8.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_013528_941764_F571EC28 
X-CRM114-Status: UNSURE (   7.47  )
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

On August 27, 2024 10:38:04 PM GMT+02:00, Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>From: Ashish Kalra <ashish.kalra@amd.com>
>
>With active SNP VMs, SNP_SHUTDOWN_EX invoked during panic notifiers causes
>crashkernel boot failure with the following signature:

Why would SNP_SHUTDOWN be allowed *at all* if there are active SNP guests and there's potential to lose guest data in the process?!

I don't think you want to be on the receiving end of those customer support calls at your cloud provider...

-- 
Sent from a small device: formatting sucks and brevity is inevitable. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
