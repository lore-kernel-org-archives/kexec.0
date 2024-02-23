Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FECC5478C
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rlNIMagPX44iWfZDmhf/pFLHwdhqweCQ+c5HVNJZ5OM=; b=pEhtBkXi0ddOE2
	pkFK2vN4CnesG+kB9GUOF9+twNwXIF9tZAn9uuCgJ1WnoKOFH457QSW7kwFgW6/0w+P8heyNmgm6h
	m35Z0Qqy10SThsREYi+gqkoWtk4N0+Fn9B+cn/o87KbHtgnowYPABbV7RpzOX7GnXR+XzyaOalpVP
	MgZyYCkqX9ITFlfKT7kf3GtJiv+/lmx+/rjDduYeoBR1XAyZTA6tRed4HVJA3PSia6F5P7/Er5+BV
	OFkIQoHcGWEkHczoIBSOt/Ql6i2CWNDG54wwOrmHlZMDThjTRPcEZ7q31lIZQp0jSGTfTSqWnLyf5
	Td4bvlmr6zWwp3IreH5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSmg-00000008ugx-0w4a;
	Fri, 23 Feb 2024 10:28:10 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSlS-00000008uDz-1egP
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 10:27:33 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj+c+z0QQUx5LZDDvpBGXmu7oB3+rGMorguEN/YL7Wk=;
	b=IKYZ2AI4bvKLy/sS5aIpSZ8CRBJ/Jfmo6Ol8+942g7pqPZIBzVOhKmgHw+CGuqf2E7Lzo4
	zgmkkqe8bnmI+s04OV5U6Wz3UvVq2BJ7v2bWlMtRxMLEBSGwXauh6C4Y/oSHe7HZ6cdZim
	Hixfjs+7Zl4tGPcODF7UMnRjbkJ1RqnICoMniYA2d4iVLAxuBdAHbNn1y6MH5WZae69ql8
	L2Ww4a3DeOOgdtHBc+Re0+dPOhNljA1FZlMelOYZdczVa+B700oxbXCnUPaUTnXM51Yab6
	PfN0wIKGvC6nPfAWgAl0Xe52jeukQrdntphGe2YL6xjt0DuGOae5Ycp41mV66Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj+c+z0QQUx5LZDDvpBGXmu7oB3+rGMorguEN/YL7Wk=;
	b=rUaZd31hVYdpyiWcibb+qKArRGWOQggoYnF9LYPkfghbBc+YFSS1n0Qc3uviJD1OloQhjj
	28b9Uksre55OI+CQ==
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
Subject: Re: [PATCHv7 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
In-Reply-To: <20240212104448.2589568-15-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-15-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:26:40 +0100
Message-ID: <87sf1jcw7z.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_022647_198106_E9A2497E 
X-CRM114-Status: UNSURE (   7.08  )
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

> If the helper is defined, it is called instead of halt() to stop the CPU
> at the end of stop_this_cpu() and on crash CPU shutdown.
>
> ACPI MADT will use it to hand over the CPU to BIOS in order to be able
> to wake it up again after kexec.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
