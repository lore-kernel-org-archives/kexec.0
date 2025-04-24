Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B15C369D5
	for <kexec@archiver.kernel.org>; Thu, 24 Apr 2025 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sxcTC4zrBpR1qncz+kMqMgMBNGRT45RQo5+uKnSoHEs=; b=2MihmUegaOhU9aUppJ41InNP8M
	gXfdh7CZkPbHlEnhrTEuKZSbWTp3wn8KKs7VqRebVkgCBX0mJpfwq4+wN2Ampnn9RCvos36EdEr9K
	5VY1rvysCxstN/VteeOKd+x7AJZYZNhoJeN97VK6lpFX4hYx5KgRg6fs5swEsr/MHRHqky41296L3
	yZnm8PaUZ5pJxmku5DjtyaKnnHUWS13jrWs8tgeAh4gs/DNJqBCOey3uol9sWl9M6HTk0U2iH01ur
	8DIt0c0uXrI/aYeFqAjjwy80/cVjHfhUo+yIkzXd0gopUY7ZPjg7CvKsAeWmfetHVSF0bq0STJVvh
	EP8cxNaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u84G6-0000000FQOF-1qwA;
	Thu, 24 Apr 2025 21:37:26 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u835j-0000000FKS6-3Mn7
	for kexec@lists.infradead.org;
	Thu, 24 Apr 2025 20:22:41 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4FB2B40E021A;
	Thu, 24 Apr 2025 20:22:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Rv6bIOhr9WWs; Thu, 24 Apr 2025 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745526154; bh=sxcTC4zrBpR1qncz+kMqMgMBNGRT45RQo5+uKnSoHEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8XUTGEBC/LgTSm7m0LokR/g3E2Ofr15m0i/fwy3aroLLEsHO2nRXw1VymdRKm/tg
	 VahtgGryZgVq9BhjwJQIL4AJmt0RRxZYOFkHpPNEOlP/b/WferumOlm3hNJ4SGlkqZ
	 XCchSfQ6+vWZY6nNYyJa+e3WVp4Pg2m7buDMcgTBrODL/ztQVRo1KPPbV6Po/d0G48
	 a333UNa8sHhll9FlRFKcRlA+YVXsUE67ttpaKEVXXpdmrYvNTHbcWzRjsNHqXrdJc6
	 Yh22NLfR4714Z5vMN0dnmiVUYzBYjftlFoI7Io+DfE4EXO09NQwdXM7m5AkjvBttzx
	 IErIHQzRSxqevB30WCFIXrg35W1boBYnjFUpCMS/CDAtyACkusvsuudUz37ecH/w7V
	 U96CarM52okSUVDEohXIUSyhEFJRk1/lkyiyYFt3f8QW0ugTtmMMqEc2AP63rGLxS+
	 JunZYCWjA6oa027LTZx6MlghodfIu5HUpxwFqsgUDz/RKhGWpPbLbTjpC/hBNBTcHB
	 SLaUsGCeqTVji2DqR8i8Q1TT9AHCSQoAxuDvTMw+w3won3dANByN3HBt0u47Q1LE61
	 oJmAEwIcGLUuRW7N9s9xt4FpHTsxHnzDZj1Wr5tr7tUMper3HZRU54Yz8j7a5eihPK
	 hdfuksRmdQiBsGBegJzpfkVE=
Received: from rn.tnic (unknown [IPv6:2a02:3031:201:2677:b4a0:48b8:e35c:ca37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8B16340E01FF;
	Thu, 24 Apr 2025 20:22:13 +0000 (UTC)
Date: Thu, 24 Apr 2025 22:23:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
	kees@kernel.org, michael.roth@amd.com, nikunj@amd.com,
	seanjc@google.com, ardb@kernel.org, gustavoars@kernel.org,
	sgarzare@redhat.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v2] x86/sev: Fix SNP guest kdump hang/softlockup/panic
Message-ID: <20250424202312.GBaAqdsMkpd-WJg5xB@renoirsky.local>
References: <20250424141536.673522-1-Ashish.Kalra@amd.com>
 <20250424180604.GAaAp9jG7N9YyYeprz@renoirsky.local>
 <2ec2ec0b-0537-4502-948f-4fa725ddbdb2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ec2ec0b-0537-4502-948f-4fa725ddbdb2@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_132239_992736_39404EEA 
X-CRM114-Status: UNSURE (   7.13  )
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

On Thu, Apr 24, 2025 at 02:45:28PM -0500, Kalra, Ashish wrote:
> Both patches have been tested by me and additionally both have been tested
> by Tencent in their development environment, so i would say they have been
> tested fairly well.

Ok, once I queue them after all review feedback has been incorporated,
I'll give you a branch and I'd need you and Tencent folks to run the
final result one more time, please, before I send them upwards.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

