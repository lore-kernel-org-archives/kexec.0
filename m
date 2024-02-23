Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90466C54E49
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 10:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9bBgehU1EeoiKIe4sSE37BMtOONF5QpctYX2h4OYkm4=; b=4dzmuEZe+e80kK
	uqu8Ji/YnhwA5q+ngI3WzkemCAcFOIMClG3FGUbnKtkpGkV3bcpB3OxT6jbY9n/+9N0TMx0FhEngR
	BF7vHA+q0IRT9ro+R8XBCSpWpQicC1hBV+DsYgUd2y/3j1QX8Ijs9utg1syFoXdTat+syfKlzAlrb
	UfU2A5y6g1ssttUsFByV9++BZ2wEWBo4i32OyUs0w/EbDQrRI/+WOsyRhxjDo5TbsysFv97yURgXA
	8aU6pWmJFlHrhoaHXzzS42Mj7/GPO0SfqiaQdI9Y78f3WHxJCh8ufjkYmPZCg9OCDOerlDBkmY1Co
	1q0xo/RP3+V1ytJcIJVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdStN-00000008xm9-0Kmk;
	Fri, 23 Feb 2024 10:34:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSrR-00000008wKP-0R4n
	for kexec@bombadil.infradead.org;
	Fri, 23 Feb 2024 10:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=scx2slDA6raFbarOjI7wCrLGdncqbOB4vubtWKq6aZU=; b=hSjNIB9TWCUDHTRU3dpV9p7cai
	Nowq0/jeB7JaeHPygKTFwXiINT4WB3K6aFZhuf90kkguJ49becS7vBeYKt2+zwFE5VYZ10F+zFOne
	Ma940QboDGnw/9duU7zIPOBHCx61ZtLdg2u26Ft2IaqIh7VJLpQH5DcUn/Y8F7KbXPXWEfSkT6+7h
	Evrse7f/1TgA3bmqumUTLmxuKe9mLu9Y9l2WHSc0JtpHGkDDM9rzDdOQsggOck0MWKeZAbC60QtOD
	5cN/HIJdC/pWEsp2sRkddyCZd47SRAyFJddZhh6QxEZy/0n5LWCLIu1L+GcUms7NzRvuKdLf6efhT
	Ub3FL6tA==;
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSrN-00000006goy-3Ecu
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 10:32:56 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scx2slDA6raFbarOjI7wCrLGdncqbOB4vubtWKq6aZU=;
	b=SAPlVbfYJusFcTHUsvYNNSl7IoawH6vWI32ukKpKsp7eoyzC7p1S5rFZaDIfhunhn7ocVL
	AF0fs70iwnESFpcz99WEFvwv6Hq+Ewm30xd96xzvXu3XO0i9BtGo2oKjHI4gS4rBW7Gry6
	LnCN6aQGDU5c53H/Yxoqz1kMYVWIL77egW8s3MWIqqiURmvUYS5jU805chMwuvd66Pc43Y
	SoMaNEzYsCAWgnf0P2PERuWhDbytSOyjbGETHtx1SLo3M7rD5u/RCMGrXtsEqfHy5YWFU3
	zLT2hK6ts4K+aB4tIiWTxGk7usazJGXVpLqX+aWcBBJ69lL3oH/4CzYwc0PPDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scx2slDA6raFbarOjI7wCrLGdncqbOB4vubtWKq6aZU=;
	b=vLiRuSlZTUbRNf1jQ/DaF+z0E180UBrDwqKpedbgUVTXLEXpDK8VaIaAbQWMNRB+URJdm2
	WZTFCcxidJXdSmAA==
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
Subject: Re: [PATCHv7 01/16] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
In-Reply-To: <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:32:45 +0100
Message-ID: <87edd3cvxu.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_103254_319384_0E024295 
X-CRM114-Status: UNSURE (   6.55  )
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
> In order to prepare for the expansion of support for the ACPI MADT
> wakeup method, move the relevant code into a separate file.
>
> Introduce a new configuration option to clearly indicate dependencies
> without the use of ifdefs.
>
> There have been no functional changes.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
