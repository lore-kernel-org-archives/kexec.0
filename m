Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B426C54E49
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4IYo31/vu+89PjkxaRw18BvGJtWOOJ+6McEGmJOYkRY=; b=WAFrv0zoelzb5I
	3UHbW100yqbLTDKHIKUOdtj6C56Lvh6Y1C9qXvtcBFkX/7riGBevaSFkxwuaGGXiLu+Siy+RTFori
	q2eNWIeYaSplGLmc/cLVHLB9umLX0OmJE93SPSoHwr1Mx1w47yAEEpastzZ/+YAiMoeZOGKBL6ON6
	QKoE5mt8VBe3NoeJMbctpwxgRLHXmaZvKq/ig+ZLB+DxMrv2RvzY8NkbYWi9Z38y3dgbuzSGkkYGy
	zErMLkg8oPEDdDozL7dV+lQhscRtw/rtU1QwYOQX99MAlFGFdz8xL38egZhs6YB1mJncoE6wOnzbo
	jBnkGYwwfAKdBJQom1aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSp7-00000008vl0-1gl4;
	Fri, 23 Feb 2024 10:30:33 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSnB-00000008v6w-08OX
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 10:29:43 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rCkSqOHXuNZNZ4qVAhXnw7igAzpOyBDOC7OEqD/cJhc=;
	b=U11EX3Gs7FK3ddaIS5hLCrLHSqX9h8fgsM12+dEprj9QStdLmwDUXgmjR6ptTQ6s+nm5aC
	KQp49Cg6YVxaAjH/FggpkbntKzvEAHfW6bH19BZzDvAuGvdzB+03XUxRqSvmR2KFlIjX7S
	9Gfe8CkA4zwjNMOqiV5srnkr6hVd+9ayY9O3C8Cr80aK7dmjLqlS7hfTJ3Kiz3MKioJmpV
	BVSQrfb1dVuIo4kNHW7DeWpx9slJcF2TTTOtc0uEfH+u41wdotKzFo8PbmsAjdMlivK7zy
	kO1sbtUrK1bWMfz5VVUTE1/DrhsAVFxnaShTHZvnWn6cl1vs9bvbTe9exxnfgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rCkSqOHXuNZNZ4qVAhXnw7igAzpOyBDOC7OEqD/cJhc=;
	b=zbZmICswW00KhN+dV6Wcm66nBj+5YEQ3qEg6CAYuhnU5gj+g/sB9sxUv6UKb+ibV6/Tyl+
	xLqpn93b+a658eBw==
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
Subject: Re: [PATCHv7 13/16] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
In-Reply-To: <20240212104448.2589568-14-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-14-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:28:28 +0100
Message-ID: <87msrrcw4z.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_022833_421681_9B91ED68 
X-CRM114-Status: GOOD (  11.07  )
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
> ACPI MADT doesn't allow to offline a CPU after it was onlined. This
> limits kexec: the second kernel won't be able to use more than one CPU.
>
> To prevent a kexec kernel from onlining secondary CPUs invalidate the
> mailbox address in the ACPI MADT wakeup structure which prevents a
> kexec kernel to use it.
>
> This is safe as the booting kernel has the mailbox address cached
> already and acpi_wakeup_cpu() uses the cached value to bring up the
> secondary CPUs.
>
> Note: This is a Linux specific convention and not covered by the
>       ACPI specification.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
