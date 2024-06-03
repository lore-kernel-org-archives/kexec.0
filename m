Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671C7C25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 08:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EuwNMSfJCIrcJ5F7L4wbhzF8sLPcKArFupl9qhwhrH0=; b=tmP7whqp3/ANvd
	rnQHGE5AELVlAzyrdI+Xc4NHJ5aDxxDZ/lPHwq4X4oXXDj88+FYmCZjQRtAjy6DMWLGeAZp0a/j5p
	zIt+ypXeGdz1ETconS9S5gLt5vwH4bmvsFUGb3/LuqqoeB7XmtnVukCyto1X24RpHyaUZVxH7fcR4
	eqXGxlut+zK1UfLUfT3QcaOes1TUAzpzswrm6lb655sPTDcPZ+oJNBaUGSM3e6z+PY7c+EGZ6cOa5
	kMl7ybn7DQBj9KwpDjAuTVlbOTNaKGlQQ0/0DGR/MaZvT3NIRnurYlcaHtkirDZGjaZ9+ura9y/aO
	zcDdaP1Q7ryCGD7RUhfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE3DW-0000000G4MR-2Gzx;
	Mon, 03 Jun 2024 08:38:58 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE3DR-0000000G4Fz-1R0k
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 08:38:55 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6917840E00C9;
	Mon,  3 Jun 2024 08:38:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4GQLSIrfu4S4; Mon,  3 Jun 2024 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717403909; bh=BG3hb7ew7HGc4e/mugY/JUXZY8h86mXig+erbW8q7XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMOwbPY5ydMRRAo9yxpECji56YyZLc9to2N3M0UH40rL7M1cdzFmhRSKjILeb/fWz
	 VbV4iQlaylyC8P6mER1AzTRdG168qiGA8fQvMdxxJOb8x32A1CsUGl9o3W6XtkeqQI
	 ZnEWE2HfkQbG03MHxJGc7xZAY2uF0mE4W+wKZBZ0sqp1cD2yLXZgHgAcpaO+Vp5si7
	 L3ZGKsSVy8VKnYF5i/fs6EQioBpme9vNMDYRweAg23f+y4DF/zEw7d2WTJDWU/xzEh
	 XdyOXtRcYO6WO7QPWRRYHKtI9kuhynyJCOkO1w8oIaG1Rll96C6pPlqtlQ7F8AIn+d
	 x1vEBlZaVr+v8BtqgNZ/Szv5MbpmnR6TuMwcHeTa2E4i//QHBUgyLAbT0YAqlJy2aF
	 mPSZKtThfqFoDZbR68X1lC8/SVxSo6dQZYw7qV6QK9uMtdor+eDl9rz7b/4JlRss5+
	 xRVpGybmecmE/AzRqaR08oFnnMcL0Z5TUjjiDxiBesVuhioskmFCgt38nZOewuFh4y
	 uF787/CefGr1UqSyHmK507XUU8Id0jRLzV6J5MtgDCaOyuoYp9gX7OS2nxSxTmTWqf
	 G2NZ8cpcmeIUfDFMiFaVVtbk9vVq4YeQ3X92eSp4gptgoYo5t+BwIwRoBql1/r3DRp
	 SzXb5Sa6NZ30gENATXVTzY4w=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5119B40E016E;
	Mon,  3 Jun 2024 08:38:02 +0000 (UTC)
Date: Mon, 3 Jun 2024 10:37:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: adrian.hunter@intel.com, ardb@kernel.org, ashish.kalra@amd.com,
	bhe@redhat.com, dave.hansen@linux.intel.com,
	elena.reshetova@intel.com, haiyangz@microsoft.com, hpa@zytor.com,
	jun.nakajima@intel.com, kai.huang@intel.com,
	kexec@lists.infradead.org, kys@microsoft.com,
	linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ltao@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rafael@kernel.org, rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_013853_867239_FA407F39 
X-CRM114-Status: UNSURE (   7.05  )
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

On Sun, Jun 02, 2024 at 05:23:03PM +0300, Kirill A. Shutemov wrote:
> +			/*
> +			 * The only thing one can do at this point on failure
> +			 * is panic. It is reasonable to proceed.

It makes even less sense now: panic() means "all stops and we die" and
you say it is reasonable to proceed.

I'm confused.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
