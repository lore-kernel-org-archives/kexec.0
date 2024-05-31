Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DB3C25B75
	for <kexec@archiver.kernel.org>; Fri, 31 May 2024 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hzYUJlYid9FsvsGYntMW4COHYi/dUjwLtK+SuscYmuk=; b=FQei/WGUYY7HTM
	fM9H7Xq718L6ATs+wR40kg6f2Qf1RuRqM7DQKk0Rgh7AJyXnVVn1eFOHoeA07RhmzeyuiTHV/QjIr
	umxGZDu5Hpy0fQoLPqMhXujmjCrPLDqe+LbtMYy0iEVL+Jhd6gbaQbEw49M/RKDZh1HFuoyReUTd/
	bU+iJjfTKXUFdMYutHsigxMr36GcUEV4BNccxx95Q1B20GQvWPwhjm9iO8ANH21ttGc00HmcSaE5l
	DWKgYqreCgYvFjkgm1ka9ejH2Rued4N92T0Hw3+9R4n5thQCTsKwFBRU/sZZ0vRN+qOiboWDPKu4M
	RSlrkASGoar4W7ASdSDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD6eZ-0000000B5IO-46Qp;
	Fri, 31 May 2024 18:06:59 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD6eW-0000000B5FR-3HXj
	for kexec@lists.infradead.org;
	Fri, 31 May 2024 18:06:59 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EE39040E02B2;
	Fri, 31 May 2024 18:06:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m6MIu8_PAQTt; Fri, 31 May 2024 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717178796; bh=A27r4FWltFYQLEwV274qXhTGvbQe8LtfwbJef5gbm3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxR+oEX2YaMrYOfacRiEJfU04L3Q36UzDdt4OclAKTWGprF3XaaHfqd2kdpUnuJtY
	 UR6zJT7Hu2gg+RU3VJntQmg2tDHvtd6BliJI5+ro0iJYe74T4AoJP1bCA7zjdu9akg
	 L7GAMxdO7bE3FYyjwOAJ0fH3xUoXW3I6wkq3gkAzXc8w6N6205NccyQ/M0fRmmnyXJ
	 jj3nO/s0GyYlKl0Dq889EPpdXJmMhIYuNiG4R3AY32tvhnu9cyBQniz1k2sEOnEcnv
	 myEaiUAc9APw/VOwvFk7ghtryNB2C/zBxjS4lFenHBncAh+cIOdRJ3HJC6xdrRW4BO
	 fl1Mdv4vQdjYcNi9lCW5vaAzhHKte8kyhqRIMKax6gDoKsiVe3uvMG/EfaYeVlvaJZ
	 /Y4sjViJ+7UuWSv0p7RMu29slFoB7h3GaY3iOJQSu6F2lIGb0JHPGJncv4dhPgkL1u
	 FwuXH6HE8oQlpns540LGY2kEPYbx0qpwWb0b+YIh6CN3uNVvRnV4np0d3fA99EZ3m9
	 r7jhw5jXFlW3b4QVVzr1gu6x9LFnfLBXPz/3dhadvh1M6kMToWuQYDrn163BFZFOpc
	 oo9Xa67Z6ESrSd+rmNYcKwbMV59zk0nGZyqBQBghH1dCpFqU6FbHThjGrH4dudhQBD
	 DKs+NDxUxb0GqFLMSbaHN5HU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FA1740E02B7;
	Fri, 31 May 2024 18:06:09 +0000 (UTC)
Date: Fri, 31 May 2024 20:06:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 11/19] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <20240531180602.GIZloRisrPdjLhaVBG@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
 <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <75cb309b-b05c-42a0-a3ca-de08fa1cae59@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <75cb309b-b05c-42a0-a3ca-de08fa1cae59@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_110657_500581_993A840F 
X-CRM114-Status: UNSURE (   8.81  )
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

On Fri, May 31, 2024 at 12:34:49PM -0500, Kalra, Ashish wrote:
> SNP guest kexec patches are based on top of this patch-series and SNP guests
> also need this exclusive mem_enc_lock protection, so CC_ATTR_MEM_ENCRYPT
> makes sense to be used here.

Well, for the future, I'd encourage you to always send an Acked-by: you
or Reviewed-by: you as a reply to such patches so that it is clear that
such a change is desired.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
