Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB28CC4167B
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 19:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RKyKrVUKvKu2BOOWvXA2F5gdeKTZZEs2PugWNGBBv0E=; b=qgEbjt251Sevcd
	/VpjtUnex+uVWMAJMB+OFoeyl/1FpjbwYOcMyxlRyqXURxcQOfC7kYFiGVAhBY9N5W1jYjYW4eCTK
	ZG3BPqCKZcFDEbn5RRv1EBZt9nf4sTt5pmaxKIzdzkmXaLvR4WTwRNKUj8Pe2qOMWBGtiGtjLG2ii
	+zgMSI9ZTrazM/cS/BJVgRPx7SS+ypN/HQoOD0OSA124g7iniGCHw+rnsByLaRvV8syTElhExm4/b
	xmxZux9Bk4da9mh9rM8nXSWOLFxzNERKx2SgGq1QCvFGJSNvktEg1vAjDVF6Xdy54NnP7OosslWic
	2i71SxX80a1FZHHtwGNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEE65-004NTR-14;
	Fri, 15 Dec 2023 19:43:45 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEE62-004NSI-2z
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 19:43:44 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702669421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnR64pgj00xG9grPwYFHOKVlCFbwaYrlZk02qWdUZAA=;
	b=kgt0xfRmhuK8TFd05T85uIRNK0k2JRjRCjaQ5z/Ynj6fRkvdzDCU60BpE78ztG8qtJPw0E
	oqD3osiwAhgN0R5HtEWRSBVsKDDSmIUEJvhlgXI8GX6+G5TsLKF/wIABGB6P+VCUrfNwnl
	NGc0TMmHaH+cEYBuo+GTXZIhzZDzaOHhE8A6/6VVfdyL5ZlndNg6jiGNQTLQUz9g++xaKM
	ms1ld4fO896dqZ17MvHpEDWHQtI7DAahZu/mJbkBJPp2kXBxYWSE96R2gLiHXoVq0NLe3l
	XevrclGGyloxxGJicNFfSthEtx0pjxOOwK2zJxB8XvFQTj66/gkHJQKwQay9YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702669421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnR64pgj00xG9grPwYFHOKVlCFbwaYrlZk02qWdUZAA=;
	b=P32Og1DmZ1Z/uHGJhunDvtNWzAOc6U+npMq5bLtuC9qSl43CbbT2ftcqvsdATqzzTVXumr
	laWogWSR3N6HyIBg==
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
Subject: Re: [PATCHv4 04/14] cpu/hotplug, x86/acpi: Disable CPU offlining
 for ACPI MADT wakeup
In-Reply-To: <20231205004510.27164-5-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-5-kirill.shutemov@linux.intel.com>
Date: Fri, 15 Dec 2023 20:43:41 +0100
Message-ID: <87fs03metu.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_114343_130790_BFE03ED9 
X-CRM114-Status: UNSURE (   4.09  )
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

On Tue, Dec 05 2023 at 03:45, Kirill A. Shutemov wrote:

> ACPI MADT doesn't allow to offline CPU after it got woke up.
>
> Currently hotplug prevented based on the confidential computing

Currently CPU hotplug is prevented...

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
