Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2170C4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ddK2QD8DUTFXlhksB7yG6iIfwl3u6elHwfxqO3lYMbo=; b=LNfpqtzrLuvnSO
	HHOhdOQdzmNhtZpva/8WK0cWWW4RpuMoiUz/PtkG3rr/hV/6FKJgQCvN8fBQFqKrGGTfYi0Dv20z8
	get3FEj4UcnsgG+llZqoh+3cIvCFOW+xrkVFhT+OSkatRPHhzCXMiKlJzvj7Sga/H54/x5fDbtuL+
	yRNGYLjpGnXl/URN37A4gBZCHBTYIMwQ4qnLpNAa2aba3xX96TzZu8WvEC9XoQDWu0/52+1OJrYgP
	JRNPhLjEGvyQk1XySRpkjmfSQFIQF1uLqO8U5f+jranvVRdTQppe8BkPpdde+eszYqvU+TXRjSkoq
	8fzFQKi9AzksCSnechJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0NPp-0000000D1Af-0gWh;
	Fri, 26 Apr 2024 15:23:09 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0NPi-0000000D16s-0abA
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 15:23:07 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B82DB40E0247;
	Fri, 26 Apr 2024 15:22:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ILr26VA550-F; Fri, 26 Apr 2024 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714144973; bh=3mhDgo/tsyN7YQ5kOgWo3bYKeZgEWZQZ5JsoONAwiNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFVxfzoVn1whzS3o16EW0SSDPGSm0ye6xQPwH9YMEZBQtXgyi6CmxpOnaaQ+eROYU
	 B4tdGhJtT1F0g1610rBTdxiHayujuPNP4+3yGum9Z6cyoOBSaFzfil/xPMEO6Q0wPY
	 rzBgJDlwplt5E/kNKTu1AXY5C0OLt8e1BdSYKrVhIBAxMfi3c+OsOCwJx4ZZ5lASL+
	 ZZAGjvEiWJ2LKW1WEMET8qdxNVq4Ou10EmhYxPpO/1AAHQkcjOG99lGk0ZV7wrEV4c
	 f2J39ceZh4u3S2lAZnrjGOl12s588Z7coJaqVr7DDP70egbs32Pi5lzu++VAZiWWpE
	 WuVw1KEEuYhYKN2iZ15l0sAI9QwY6Ev2MfoI2n34G2zKX8uUmgqB4Xa3zr4jzbbmvB
	 7DifnQkv/CEypkPozdB9MDhscHNbhbdR40d8kSypNYXHSwzQak/GTGBZgv777cVWTl
	 U63DP0+ENo1vvyDwSF/B3ThYk1fJ/36jMvkSDbPLmRSeMK/xCYZTfaH5Nibr56nl6Q
	 hwu6QW5maWkOlRpm4+YOaHz/Ylla+EQJfP8vNNwvhH5oMSiniP8vG38iCNozyQaH4z
	 SzDPLQbWl5g3ih0iFKltOXmrTC9SsiBfioWfOslsxmSTuq/GJdQm4wE5JmWB6WS8BS
	 wCObVmXzckUjx794BkPh5B/I=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AEB140E0177;
	Fri, 26 Apr 2024 15:22:27 +0000 (UTC)
Date: Fri, 26 Apr 2024 17:22:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <20240426152221.GFZivGrY86svE0RZ00@fat_crate.local>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
 <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
 <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_082302_694061_69B13347 
X-CRM114-Status: UNSURE (   6.23  )
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

On Fri, Apr 26, 2024 at 09:47:02AM -0500, Kalra, Ashish wrote:
> I should have mentioned *chained* guest kexec above instead of nested guest
> kexec.

What is a "chained guest kexec" now?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
