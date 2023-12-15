Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F33C4167B
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 19:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zCn2qGIbrYmJy85TtenGVRpaJwg3zI0PoFjjsMaePIs=; b=3yHr9ffF+CYSWF
	rlLWVbOevm4WjTlcOEoOQzysj6jvvgTXCHArxc/Ghy41B1qUE90o+BqitPUWI7fiYUYjMaLtNTtwV
	2QFpIORNvglwLPvpkCFwA7PVLRsphAiUL3jCR8aLZazI82cBvSj3Ay1UktiyhWwtYXIF4sy0bxS7L
	DeDzGJoo+txR/QHsC8xp/Hy2YK+yD866w+Omhhl84tmRS4wxkv5Kfshs0WAbblDwExwkc2KCOEPbc
	g6qkmy7TRZAQRHoYt9SRW18d7mHSHRpgkh250fkiFg8reYSfhgzmV+S3zxe0lHGpkrNd9eCtjk3b5
	0u8P0R240k/SXqVw98tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEE59-004NLD-0Y;
	Fri, 15 Dec 2023 19:42:47 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEE56-004NKV-24
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 19:42:45 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702669363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVG4NAqs9+dZcw0p2Y4JWS8E4Fl5VogUKIs4fswV0n0=;
	b=v23INxCzP7f8XjZg1ESoi8+tgmRBXtpGO83HN81UJ4EZRlNmgsOhbu0eGJN0TWm22pkpyS
	vWC/Q8Z838O5BDF3oVul+/tlZqhsQ1iQv1QpNC8YbSz4A62HRTh4M38W5mbMzx/UBZ8NoT
	c1KRX4D0/t0IvDVVE2K8RUCWRqqnLI09F1plpBCfmCJvspVIPpAU7h2pxFYZIdPtt88JKA
	ZAApJAkT+EUx5pAKq4Uk6tLvNQAIvg/G3OnxpkV/VLc63mvFVHKZOOstNP91wSgE0gQWU/
	9jfspKyIjDVB0Jc842EQnnkO+uFXWp204D0pA3DeC2U80yIan5AJWUrMHZOg9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702669363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVG4NAqs9+dZcw0p2Y4JWS8E4Fl5VogUKIs4fswV0n0=;
	b=wnOZiLcVGhXbSAXYZzTmdnQxbG6KkYq7hY2XWQKN3QNM4tg/pQuNbXqGkjkIKnZK71Lv5o
	daNzynO5B9OqgSCw==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, "Huang,
 Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv4 03/14] cpu/hotplug: Add support for declaring CPU
 offlining not supported
In-Reply-To: <20231205004510.27164-4-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-4-kirill.shutemov@linux.intel.com>
Date: Fri, 15 Dec 2023 20:42:42 +0100
Message-ID: <87il4zmevh.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_114244_828034_E7A4D8D5 
X-CRM114-Status: UNSURE (   4.08  )
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

On Tue, Dec 05 2023 at 03:44, Kirill A. Shutemov wrote:
>  
> +static bool cpu_hotplug_offline_disabled;

__ro_after_init?

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
