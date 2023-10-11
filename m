Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7F2CD6E64
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p1uLj4g1Gh6z2i/PdzULSV8bLpZZI2f2DzlNmyDJKzY=; b=epS2uL3b3hgnpP
	KTd851cNZuETZ+4cD8yfMfhBRqr75v3ZZXDrGzS4zDTSshrGRIxEMyboFwro8xrhqjZaQnzeeoVn9
	sPVUReBKO4pxBnsuL1klsodoWo454yCL7csMYJw/50htnFoZQpRjy+x0kaQMszqmmsZzaZMqEC9EI
	p+4h4Dyv6EPu/m+ddmNM6mqHAYSlbCVe3N5NtgSjqFSfKkQb7udjTkQgoNHMHWHEKYi4zdYUWDtvK
	DJ8llviF+FbNtQXct46Qd0HVVR4jNKOL6E1MbDn+hJqaHFkQ8UyXzBWZEpQanrxe1BDecUsCHXWOU
	OQge80qIjdqaCPSNwrKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYyE-00Fvgp-17;
	Wed, 11 Oct 2023 13:09:50 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYyA-00FveP-2B
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 13:09:49 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697029785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ukHBjWe9BEjJdhdsHoBpWRY0IShWSvasiVUT5USEBB0=;
	b=EtPW3gLphi22K401ncNlj+K3wTaYGCDyMJUwYDsNAx8NAPEnKsEOIVG6JGN7LJPnBiAuxY
	erUbjx0uUQHQojZ5YULHBxypqmKxS44DksQWMVkxKLJyyx6440qdwAWicJ+ivMpiCetY8P
	S4U1NwQbAwTKA5pXnNu6hNzi0LYi5khxIskM0vn0ra7QIEPP2OKp0eUwQGrkih912a3MTJ
	q/zs7qmN+klRS9wzeKPVXU+UZPBjGgVKYdBkjFcRT488BTOn83bjD4/XNXV0r2ST/M7+i0
	dN7hIKDcL1b7Jk6Nqhh62Fn78/E262XYAu8IxOAj/ARAm+r3mkPupMtXiiJPfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697029785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ukHBjWe9BEjJdhdsHoBpWRY0IShWSvasiVUT5USEBB0=;
	b=tqca0/uvwz2DGA34PwCnpcObQzD0u+u480E5bj3LsbusevevC0OfpZdCdHvaSoLZTaEbPX
	gt8XUM5WwX0AHADQ==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for
 ACPI MADT wakeup
In-Reply-To: <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
Date: Wed, 11 Oct 2023 15:09:45 +0200
Message-ID: <87fs2hl2zq.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_060946_868441_DB5A1D2A 
X-CRM114-Status: UNSURE (   4.60  )
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

On Thu, Oct 05 2023 at 16:13, Kirill A. Shutemov wrote:
>  
> +	/* Disable CPU onlining/offlining */

That's not what the function does.

> +	cpu_hotplug_not_supported();

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
