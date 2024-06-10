Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A96C27C55
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9WV9hlCV2gxywUbgv37MporiyweUSthB9DUMs/V/ut0=; b=fkHBvCLJTf7Upb
	Grg9kCpPd5fQBBae0HM/B5R97vWmD5eUA82lgUczovVNUmrtI0oliQ3s/MxTYxGYEKcfyFt80nd6g
	Vu0j3SHrqV35Q6HDttPoWTXUbT49Vb813GceahymKuMjPyjGxrWsQRWWZepRYjwn3Mlef7Oh+Hj+3
	OVyv+ZtyUKg7u6sEFVb0Sz7Z69Fc++SWC0ICO+q7on5nHYiEYnCMyDrQCfSB/idkctKOxoQDdIMbw
	+Xzc91jf+uY2AL5baHxgx9rC996SLDaq7J99V+Dk34T1YAnGzkqf5aSCgctBeJmZIItDyjf9hHQeo
	9mimVlX+ESMHCVV4N8ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGfGh-00000005CmY-3UNz;
	Mon, 10 Jun 2024 13:41:03 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGfGd-00000005ClO-158u
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 13:41:00 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9026440E0027;
	Mon, 10 Jun 2024 13:40:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BUFwCUSrFD-r; Mon, 10 Jun 2024 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718026853; bh=TKZL5OH/kDVlLa031KsOxyH44GZqkwpf2xf/NrcUB1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAgqE/J7Ok93ksM7RtpCaB8UMngdFS25e57JRb50u3sKy2aXLEYs7ZIJdXRh7770b
	 8tJ38vJJfmF+2lks4s0Kk3L/O+E7DpVBgirqSTwXmN3Cg7h7aT+WJYcRwIREzYTXSA
	 mGbgyz1EAd+LdfCkO2rOre+Yh6CX9BLqgetnFzrQIPY0kIICIb66Q4u09EhKZMSTDG
	 whB4l+lf1iWiRuB9BudtYv0l0x1J3FTCg7jIOIJJzqT5+NNZFZfYj/vbMf/Hry6HfV
	 HLWaqUrB6VrKkNKzVnyQ4pBboypnsi9vczV76jjy92uNm+0gNXz9tI1tm8f4Ke5gJB
	 b1cq0aTjHTOGxqbRJ5L7votIQoLRGdmrLnbyqVRT4NiziZA7kWChfTowkyg1YHQoML
	 JDUghCIg2Uq3ihZyMHw8FccJb4I5I6GjkK5d9RUkEc96pPkoRqgZZkKiPRAGAlbtBc
	 q2BzF8SqutNpMl2dbt6IUyNL09xMU+gAOx8Ye8U6g7A9OzNIgh0BYlG/LHBrg8ZXIG
	 ZKyF/y73C3djtMnu47EvtxsSp+VwqSmHw73qy20s/VpKX2vv85A0fw/gXMJtG9pegE
	 ex9NTXqzBQRFZyChjWvcJGcOPhpsYz+xR0FfBItTSftmPtuGCU4zCERIzXImhReePM
	 BIhyBxa03PlP5oHNxuJxtal8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E4FB40E0081;
	Mon, 10 Jun 2024 13:40:26 +0000 (UTC)
Date: Mon, 10 Jun 2024 15:40:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_064059_479357_E4FFA025 
X-CRM114-Status: GOOD (  12.71  )
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

On Fri, Jun 07, 2024 at 06:14:28PM +0300, Kirill A. Shutemov wrote:
>   I was able to address this issue by switching cpa_lock to a mutex.
>   However, this solution will only work if the callers for set_memory
>   interfaces are not called from an atomic context. I need to verify if
>   this is the case.

Dunno, I'd be nervous about this. Althouth from looking at

   ad5ca55f6bdb ("x86, cpa: srlz cpa(), global flush tlb after splitting big page and before doing cpa")

I don't see how "So that we don't allow any other cpu" can't be done
with a mutex. Perhaps the set_memory* interfaces should be usable in as
many contexts as possible.

Have you run this with lockdep enabled?

> - The function __flush_tlb_all() in kernel_(un)map_pages_in_pgd() must be
>   called with preemption disabled. Once again, I am unsure why this has
>   not caused issues in the EFI case.

It could be because EFI does all that setup on the BSP only before the
others have arrived but I don't remember anymore... It is more than
a decade ago when I did this...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
