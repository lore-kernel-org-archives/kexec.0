Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AE7C10F16
	for <kexec@archiver.kernel.org>; Mon,  6 May 2024 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nOWGOZ6IUB6Q4WjKqwxS5rtvFuY4AvBW1/bWERKWdE0=; b=lyl0Nn85+FzVSf
	pkeX0OcgTbCT6ql5TfLY2+PXePFo6rz64921mbb2u+BVVhDcVSn1mZvFfFYmrTBGCVkVL3JgUgqym
	RvxpkX48khQdefiPIjK84PxblIR8IjcJh2eM6sTNy3VE8Rs9h4NERDBy+Pm8JKrMf7YnDZ53ePKoV
	WbefUTzvzAlbcIHW35BPKMGMgzS2Wi5xNfGlCbMvVpc5yrwjlqjCRGauYmsLtzk/BOYtAUDxpSLZh
	WWlt9RpKHubqmNT8VapXML7HCmJTKbBDU1fXAs3wJif5hvvYCHaonm+hhbxEVWEBX1Nm23T6f6+nF
	Lcxbi0y3PD/XEKpTBHsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3zE3-00000007deD-2iOS;
	Mon, 06 May 2024 14:21:55 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3zE1-00000007dcF-0kUd
	for kexec@lists.infradead.org;
	Mon, 06 May 2024 14:21:55 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BEB5C40E024D;
	Mon,  6 May 2024 14:21:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UryTxnO-LRmz; Mon,  6 May 2024 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715005303; bh=b+K6cieeRgzZWM9C6IkS52nAd027DkJxG87ZipG8Sho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4Y+fW3QTaJ9FV2dDcBUpEOnzrKcNwfhgwOdIB3xCvhdM4huoa4p2KYMwSN2wNmwD
	 PurLG1CyOa67XmIA7Pxjr2Sq43TnxBriydtwUVv225ZGWLr8aRIerdFKLvNAEki9Ev
	 QXnergGYbpM8+T3qhaX9/x58MrcWwD71J6vQsKEnlV8KncUGgWfSc0z0LVq8pAhSPA
	 jhRvlK1uhx3ePYkx9TN9Pnrto+jT1IMuDnXrJB5nW+PpFqOIWkIya0hHmvBcQghQxV
	 Qpcy4sW0eigQF2LhqQTtyg+uUpaA4mgngA8rRUjITTzYMxjhNPyMZTnIW07xurGum0
	 EFPpsRZXQJUtWe0+C/HGe/nc6XB0yAZPrv1Vs0Sxr+v1BKJWnv/5mnfPlMEOl9DXQZ
	 WNWXaDv0Ykm6m+6/KKSSXAT4xuzr7YY8i3V3fOOhqtSIvR8d2wWumKRJLjDrYNUk2H
	 wsEOEPFJWyHmHsADUmFJY/mHG2hpgpMdKtvSSnaDSQw/dzm+hSfRo6uzIZiqwrD1Y/
	 1hYGDOpptHLNwXDiEYJSWcNV980028nBBUkVgrWNlt8tJcqln08J8EaS98VWRSAywf
	 lyf/szhCvZVMfnyBCbRiPEu/QgL4G3rSTsUsaKzxv/5Ezg78hEYQ1docvNMEYS9P6J
	 FpbHijWXXqLmCFJnbwN3lyRY=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5342240E0187;
	Mon,  6 May 2024 14:21:21 +0000 (UTC)
Date: Mon, 6 May 2024 16:21:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: adrian.hunter@intel.com, ashish.kalra@amd.com, bhe@redhat.com,
	dave.hansen@linux.intel.com, elena.reshetova@intel.com,
	jun.nakajima@intel.com, kai.huang@intel.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, ltao@redhat.com, mingo@redhat.com,
	nik.borisov@suse.com, peterz@infradead.org, rafael@kernel.org,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv10.1 09/18] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Message-ID: <20240506142120.GKZjjnYGMcZkuTLlzG@fat_crate.local>
References: <20240427164747.GCZi0sM6HBCBYtgWqF@fat_crate.local>
 <20240427170634.2397725-1-kirill.shutemov@linux.intel.com>
 <20240502134506.GDZjOY4guvlKH9-73J@fat_crate.local>
 <ch244dd4k5nu5rcryuwqp4pztl4dduhciqunin5drr7a3yls2h@siisliaoc2f6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ch244dd4k5nu5rcryuwqp4pztl4dduhciqunin5drr7a3yls2h@siisliaoc2f6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_072153_384686_4CCAF106 
X-CRM114-Status: UNSURE (   8.48  )
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

On Mon, May 06, 2024 at 04:22:02PM +0300, Kirill A. Shutemov wrote:
> I do. See comment just above enc_kexec_stop_conversion() call.

If you mean this:

        /*
         * Call enc_kexec_stop_conversion() while all CPUs are still active and
         * interrupts are enabled. This will allow all in-flight memory
         * conversions to finish cleanly.
         */
        if (kexec_in_progress)
                x86_platform.guest.enc_kexec_stop_conversion(false);

then no, this is not enough.

I mean this:

/**
 * struct x86_guest - Functions used by misc guest incarnations like SEV, TDX, etc.
 *
 * @enc_status_change_prepare   Notify HV before the encryption status of a range is changed
 * @enc_status_change_finish    Notify HV after the encryption status of a range is changed
 * @enc_tlb_flush_required      Returns true if a TLB flush is needed before changing page encryption status
 * @enc_cache_flush_required    Returns true if a cache flush is needed before changing page encryption status
 * @enc_kexec_begin		Begin the two-step process of stopping
 * 				page conversion... <insert reason why it
 * 				needs to happen this way, blabla>
 * @enc_kexec_finish		...
 */
struct x86_guest {
        int (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
        int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
        bool (*enc_tlb_flush_required)(bool enc);
        bool (*enc_cache_flush_required)(void);
        void (*enc_kexec_begin)(bool crash);
        void (*enc_kexec_finish)(void);

And calling them a _begin and _finish makes a lot more sense to me:
_begin starts the kexec process for encrypted guests and _finish
finishes it.

Just from the names you now know what needs to happen and in which
order.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
