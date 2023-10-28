Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6E9C27C47
	for <kexec@archiver.kernel.org>; Sat, 28 Oct 2023 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1X/gyS6ayLTZ//lXx/pybit9NYbUBSQk0ipx3kbfeo8=; b=a73uALOn1A0fTA
	kb9P594lGNOzz5cGLU2zAMgyj22zFfdEcf6YGiTxpc3wOOksW74cEFQfETe1n68N5evQJsPBqannE
	ynePsUIqaFb8NRMgv9ddvPzke8sOAz+z2YrOyTQ+YL22Q87W6OSRWDvW5VLSaBqWzjVnWCR5PZ1GC
	m49iwK8Nz4MvaQaS8FGx9dcZuufo2MB0iAGWPHxAZ+BeTVNwSfqXTJ1b6g53XBEF2oSLJ3B3Wkw3C
	29V0BTOV0IsWVm5nljtaTOuv+BfIgyS08umWoVhM5ilbw+8t59z97h8HYzB4W6mQH+KzmNbpNPzhb
	u7phiLaSMEGF3/JLtJ1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwk2x-000XoB-2W;
	Sat, 28 Oct 2023 14:12:15 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwk2u-000Xnc-2E
	for kexec@lists.infradead.org;
	Sat, 28 Oct 2023 14:12:14 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1698502331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWAt/PDpViqk3UG1Vk3j+0hCIjdKt4J31sr7CYkEEWA=;
	b=GNY6kXNByQkJQe/0Dk5K7kRNpz+qZa+bZR68lQGT6vUrL6kSjnnLbImYBXOqP0+ueebAV5
	gsOQnMx6lkcBlUOk5IT2YamImtiO1APlalzZHJb7nCgHJbGRroY5GgrTDgJEgicUztWpYp
	sx/61YRKSiSjjnTSsDQXfheFy+KmeSW5n3Xn9puHFQrJxRgR4rMTXUBSH9i39JW5b5wNeU
	QfgBJBA59dmshNBvyqWdkucR5TF11vFr+1+9PGyQF+8R0Dn+2ul24BKCsRGwvgVf0OH5Yn
	gkJUEjymQKTw+WeNpfZpK0AC6UntzEXXvF1oOc+rX6bU1ajxc2t8qK0QAB5Okg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1698502331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWAt/PDpViqk3UG1Vk3j+0hCIjdKt4J31sr7CYkEEWA=;
	b=NEQPzWuSx4qqzS4AYxdB3fJkAE2b0tT66TOWNyVlzvm+ClVFz5ErrXG/mXZmfIFd/FbOHY
	sNPgaHg8ASI15CBw==
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
Subject: Re: [PATCHv2 02/13] kernel/cpu: Add support for declaring CPU
 offlining not supported
In-Reply-To: <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-3-kirill.shutemov@linux.intel.com>
Date: Sat, 28 Oct 2023 16:12:10 +0200
Message-ID: <87a5s225vp.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231028_071212_938825_BE2DD285 
X-CRM114-Status: UNSURE (   7.14  )
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

On Fri, Oct 20 2023 at 18:12, Kirill A. Shutemov wrote:

Subject: cpu/hotplug: ...

> ACPI MADT doesn't allow to offline CPU after it got woke up.

ACPI MADT is a table ...

This is about the MADT mailbox wakeup method, right?

> Currently offlining hotplug prevented based on the confidential

is prevented

> computing attribute which is set for Intel TDX. But TDX is not
> the only possible user of the wake up method.
>
> Introduce cpu_hotplug_not_supported() that can be called to indicate
> that CPU offlining should be disabled.

Otherwise the changes look good!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
