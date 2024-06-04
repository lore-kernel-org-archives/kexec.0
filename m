Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F41C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 17:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EK3wT97mL31CoTvczNVLkd83jDmktsYQKjMzGLOocVA=; b=ODys8K19IO7zNo
	hsWqcem8S8sOZvwBzZxMTeZQWM6PyrHn5lNGbw+1I+xT9TBO2Ir9eEZ2X4jt3pD0bXaLX4eOnm+vG
	VfyTvQzcx8lfasU3ixY3/TUqE3cbZHWoOJDnxmob2GvXShdAIQDE7B5DkzVmhVM4W4iD/hXXJkf85
	6z1LKJDTO8mwNTblREQo2FrM734xWaof5AZiHddxR0xOvlkHnv5AUXfYpo9BWeji3f4FblIoIcMey
	1TPe0wU3UhDeBx6GqOvCZRzxJx6ejKrCo9niQNnc0G8ScfHDovaDbwZVLlQn3SSWXZJ+QdqDCRHM5
	kDb9LQwCVz/Qq80/WGwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYQD-00000003Ojy-0yXX;
	Tue, 04 Jun 2024 17:58:09 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEYQA-00000003Oh8-2IPp
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 17:58:08 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 412E240E016E;
	Tue,  4 Jun 2024 17:57:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GcSvWKOLzVkh; Tue,  4 Jun 2024 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717523869; bh=JXZbniqiYmCh6nO8eOuM412v/bVplPF4NQw9IrGcNgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWdLoPL0Geu18Mg09ep22E8CJvmQKeIXM/qeFRd35Ee5DINk9hJ1k1uSdd+ZOYIVO
	 577lBvho2BI8wZgUCZ7BotNPN9ZSqJNOtt11EkNZ2loxtHuj8mbIkJFcl2qWeXJ0CG
	 uyQUAYVCQZTEUTmNrujRy260AyawFlCuPwcjaYet1+adCC00xHv70iET5PgQlYWJDf
	 DL16UmrcR6KGpH7E2N7lvUaxNbpIBQo3jNTJut7Xax9DEXl6iROBaVoTFWeI6C4y++
	 tiZAsXGByTnT2xL5rqqPNd/kvJ58OHLWgFy8HscK8we8+E1mhPhCwHInvpmyzzRJS2
	 Wz/ZBqVfp8zpns6YR83BDw1nG2AHceAXRgUqbdABY32fFb6BCBJGaFYaLz269a/j5B
	 DlKjsKQYNMarJVeLOYyqJLwyBBA17yNQadN9DTU+bf2J2IlDy6XkiNjl8MlbxR6lct
	 qNEHwEcdgyNtRx02O6juN14djEeE3l5mB6c873EcMJ66gTKaXCJVpeSkPe6IAK807h
	 N4tX9FAxP6X6ty3nug+8TCqm9+CkycFBJM7wdSfahJXtGG66JqySNhiMdBDpVeJME0
	 ZMChUXpW3VpwL9K5Y3GjTNasyDugQa60YGhSG0iEFji/ORi5QW3VcERJ8YpRHWCdSn
	 g9SttyT/p/diiD2uywWfVs64=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09B9640E0081;
	Tue,  4 Jun 2024 17:57:22 +0000 (UTC)
Date: Tue, 4 Jun 2024 19:57:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
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
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
Message-ID: <20240604175716.GGZl9VfDwv_JhmzwPH@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <748d3b70-60b4-44e0-bd81-9117f1ab699d@zytor.com>
 <20240604091503.GQZl7bF14qTSAjqUhN@fat_crate.local>
 <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ehttxqgg7zhbgty5m5uxkduj3xf7soonrzfu4rfw7hccqgdydl@afki66pnree5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_105806_752969_8604FC8F 
X-CRM114-Status: UNSURE (   5.64  )
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

On Tue, Jun 04, 2024 at 06:21:27PM +0300, Kirill A. Shutemov wrote:
> What about this?

Yeah, LGTM.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
