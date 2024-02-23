Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFB9C54E49
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PCrNXPBDUvXTg3oU+GGjkbZZBbNtE2nJUQ/J4UICjUk=; b=hNAHVVLD3BUqZ1
	cboCQYeE8recZhWIpOsTAnvrqzk1vI2zELGnXk0vVuOOm5R4rD/lOQZKN/7oIuR3ajfBn7KrSESF2
	oPot6O9fySXdMaEjY22V4gqwicSPfsvlfDTaZoWTq1nH/Z6cv70JuDKlM9SfFLJ/9vEGKnqWhVjGV
	0Ej7a7Q7JZXxkLcl2U4Ip+TqLRbIvhtbQeyRrDLPgi9WSZSIjTY3y5oPDZSKLIwZDTobu3yJijOzb
	kEKyww4Y7iShFEHONiysEWLAZ4x5vP1q9SPnXY4fPIw+zAdMfN/hB3QMehtHzVzNJY+oqIK01LLFJ
	DcP/ohtnxTxDbC5uThQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSse-00000008wvf-3Ti9;
	Fri, 23 Feb 2024 10:34:13 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSpn-00000008vvG-0bmU
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 10:31:41 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkLLuHQoX7Qx5Fy5qJpixZOVOxqV9iRWh6D0pLconUY=;
	b=YiVSVT263F5FBqEISJkPVpVsZcbfVYxujjjgmA68+1aW2JPWI88DfN/lemthMtK9Xk+BYk
	MgST4jZJNVsyNLdN4eVZOV+0A5SRkDYOTuZBmumyXO8//S4D7zAoBbMHxmutSMB6IyzpKP
	6cVUOYz1ScR4VuG/JeY+rJdfXl2Qx31iV/xfxnEoxFVON5ouD7AcLPZQ8RKmL+tcbOMWwk
	sLbKA9+9jJ5h22X1l0RdrMHbw8GbGhf3bivax/n/FQMPz/PCwW6apOB3mN6s/QXtukML1X
	yEIrYNmzz4LTBTjEwg+YsGUCkssgiC9EjzW1yV3N8Q6Wd5gEgzTwXYlVsO1PxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkLLuHQoX7Qx5Fy5qJpixZOVOxqV9iRWh6D0pLconUY=;
	b=09ZIG2ZHx8YiIlTpa2V0EoiX45d9E+RxpvYkjsbD254Oww6TUCvu2V8tVDb1bx9jIP0dka
	Sl0WEcqgpr8YkrCg==
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
Subject: Re: [PATCHv7 16/16] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
In-Reply-To: <20240212104448.2589568-17-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-17-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:31:12 +0100
Message-ID: <87jzmvcw0f.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_023115_541608_8269E33E 
X-CRM114-Status: GOOD (  10.82  )
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

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:
> MADT Multiprocessor Wakeup structure version 1 brings support of CPU
> offlining: BIOS provides a reset vector where the CPU has to jump to
> for offlining itself. The new TEST mailbox command can be used to test
> whether the CPU offlined itself which means the BIOS has control over
> the CPU and can online it again via the ACPI MADT wakeup method.
>
> Add CPU offling support for the ACPI MADT wakeup method by implementing
> custom cpu_die(), play_dead() and stop_this_cpu() SMP operations.
>
> CPU offlining makes is possible to hand over secondary CPUs over kexec,
> not limiting the second kernel to a single CPU.
>
> The change conforms to the approved ACPI spec change proposal. See the
> Link.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Link: https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher
> Acked-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
