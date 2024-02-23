Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B671C54E49
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/GhXH6GpolXg+nexqOvwJ4L3k2UgGkrlw9LJaGXccVk=; b=O4tS7REhEc9vwp
	nyZi2YDe3K+JpSQ9Evmdq2JEgr4wRjQlcwJ88WelLluRkPTJO95luXaWQOwO0c+QtfmjxPk9UEVrS
	gUbVQByOZhPomdWdYhC7kxxh8o3aXp4DI/U3hwmlGzl0kaI+/2uqkbw+YDlTBEIxEaM414t0TVMuU
	+wkCLsR0DGlw8q51v0/BXXgxVt/41ITrQUB/8ytRPE1JQ9YNj+zMqWhygWiqkGK/YxV5buU3MU421
	v1BF52WXHM6PLM/oyXtJV25Gkf/HLgsbHb7Kxmh2q8mPCtWaINKoKfw+QxtFqchR25le1g7J+Y/x4
	EgL3OwUH9pFO5EfNlukA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSnK-00000008v9S-47Ld;
	Fri, 23 Feb 2024 10:28:43 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSmM-00000008uh3-2crE
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 10:28:17 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hp4iU0RpSl1jOuhbAjRjJHRj3gI5ZJJbentZQvmuQXg=;
	b=q9PLMTgH044LFtrZQc9HnKc59Yqat+K46KNcyas32qsUQ8S8j/2cffl8YX5G/At57XdJzG
	/3aoI9qotr4zTqwQAvGhf9AM2QvqmXdRKyJ6pKxocfuAfJMxaH40ek9lXZLmPk0T1Ge7yo
	ZknvkVUPq5MqKqrJ8rDSjDSvqv8uJrBPfJmMFW0cnLk45KUpNRsY2a69eZgOjVSyYTB/q7
	sdxyL6/TEpdpXHh948cbtRi008CTkLORajfI4IvTAZY/9gFlZScBqATPLKSpBfGWLLhtxh
	1FVIuZgVkkcV9yndjhsmpvURmSuQfjRDKG+k2ieuE7B+RJVzprasjYuIlesq5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hp4iU0RpSl1jOuhbAjRjJHRj3gI5ZJJbentZQvmuQXg=;
	b=J0AapWKPuScDq3KYFaG/2adL+RRKtWu3BD+o4MFF+55cZ+53ALgCIoJ3MD7LoK5Xz/WbiO
	RIOipAnRmn/TRWAg==
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
Subject: Re: [PATCHv7 12/16] x86/acpi: Rename fields in
 acpi_madt_multiproc_wakeup structure
In-Reply-To: <20240212104448.2589568-13-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-13-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:27:40 +0100
Message-ID: <87plwncw6b.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_022754_377464_A14152B2 
X-CRM114-Status: UNSURE (   7.94  )
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

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:
> To prepare for the addition of support for MADT wakeup structure version
> 1, it is necessary to provide more appropriate names for the fields in
> the structure.
>
> The field 'mailbox_version' renamed as 'version'. This field signifies
> the version of the structure and the related protocols, rather than the
> version of the mailbox. This field has not been utilized in the code
> thus far.
>
> The field 'base_address' renamed as 'mailbox_address' to clarify the
> kind of address it represents. In version 1, the structure includes the
> reset vector address. Clear and distinct naming helps to prevent any
> confusion.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
