Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480E2E677F8
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WuLPZ6pEC44N8PQA8Dlzi2I1F2/tH9gLA0TglM16ckg=; b=nwY4Ap7frcT9kU
	50xn3Y7I3X3diQ0HwYGQn4OWCb132YvARHFbx7EyRy4XSaH/r3m8UWQj0bVOtak6kl80YNYTV8EeT
	WgdlHdddt5+Iili3OPRXhG+ibT5C0AgizpNWVJ+K5In0iXCaxxQr9j431h0V8TTfFZ58HtWQXY+Ei
	952l7D6NDew4yPluv/S6STlIZ6f08kS4Uo3X79MwbVlLmv7y22KdmGils5WzcSY8WawUCWBFAzClu
	4bbiQ1LnyffxVyo21NXBLL3Lwvao0l4OtLZ0Mj6rGU8boG67g1+clyDaxUC5RSom0o6hYcVL4LS9y
	eBi/wkaXnDNZTJEekhlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7By9-00000009Y3e-3c7l;
	Sat, 02 Nov 2024 11:07:01 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7Bxq-00000009Y0F-0wDH
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 11:06:44 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 93B8C40E015E;
	Sat,  2 Nov 2024 11:06:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zVC95o_iZJqe; Sat,  2 Nov 2024 11:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730545594; bh=x5gVCnlDPcjJpvinoTgtzzj3bTuvqlm+qfztO2S0DfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0xL7oy4TjWweC/cUd8U180n7dU8PfIVkEWQvkNW+zPsbqJ67DiR94E3U7pqfWTiA
	 TzKQzSAnRoV+oclVKjZ7aD9x27hUGCj/WV7XWHxaanbkboZ28vVZWeHA/XJjEYoghF
	 BfSB9fbr19WKycHThUmD6UknCaI1ImDgs3cXXtE0DLAlDHtPEYIrErQLPHaDq4thpz
	 84jKJBvl0Bhh4oabkVyZGdZ1OG2ysa1EKN2w3Pcu7jq1VfJ6dd7V+Aivh4dofnJjEy
	 xkK5BoFrY4aDgZN8iSW4ikIxBw2/SPzvDATXhWhp6h8E3OLHXC1cpnCsHq5ko/QNAa
	 Dp53ZHTGDiiIZH5//d3rqHcPhjzDJGC+ByP1s3HtljecTiiZMVIU3WvNbDcju4eXpu
	 Oe0fWvjzfIEDUEluMkvU/h2Ai18GfTuEPZRtrnpFYf94E7QeA3YS3iHG4YFjjzZKsE
	 JLvpqyeOxuEqnBCMCc4SU/TmAW0it9NmWheWpierRXkJQZWuvz/Tz32uUdebY4sirt
	 BSLtozhNKpfKo1SwofXJ11soVsChbg/L1jFZCJWMA+YM5hbzvS2sFYEvnIodzf+boM
	 IldXHFAytgr4zo4+/G37lHnrcS2j82z8yLhvcSLRmvichPqpvv3WMIUVlI7cHp3ewS
	 mbdLHTiK2budTmgrwIewyfjo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B35940E0184;
	Sat,  2 Nov 2024 11:06:25 +0000 (UTC)
Date: Sat, 2 Nov 2024 12:06:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <20241102110618.GAZyYHquhmVJd4yM9O@fat_crate.local>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
 <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_040642_472462_D87D5E74 
X-CRM114-Status: UNSURE (   7.84  )
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

On Sat, Nov 02, 2024 at 08:23:33AM +0800, Baoquan He wrote:
> Yeah, it should be added to stable. Distros may get both SME/IMA set not
> as early as the bug introduced, while anyone doing so in an earlier kernel
> will see the problem.

Ok, I'll take your 2/2 next week and you can then send the cleanup ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
