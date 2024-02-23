Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066B1C54E49
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FFxx58p13fKtAFVYPOjNyJnNGixuWv3K0axJRVKEPYo=; b=lTVF/vDMH4DH0K
	e0y5/Wqw1tHARsAt8YHxpl76kOzzjVOFaP3w8hbmjNufoSEgqA1Qhh7+qMDKBu+pJjcRL4jq+M8T3
	IvXd7wSWjMNk1+P9kGlHdhU2uwqNg9RuLFAUSaJI/uDWvUpXPY88Vwo/KSyklle+Rb46/03EG23JA
	Y1vWI36zNDBas456OC4zpFtnAiUEahclqCHLsUncPVemDz6FFB72itQgx6sZE5KhN0JqMQnzZIOkh
	WDBQbRrdLqGKtwIHasCi3GESgpzJStrhRCIR13fbJBmmQpetJagnfNkql4suczFcaZc/6g0IApEj9
	yMlVmx8yRJ8CeJJhPUoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdStO-00000008xnE-2uqn;
	Fri, 23 Feb 2024 10:34:58 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdSqo-00000008w4o-0VcJ
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 10:33:27 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7q16l4PLAkeFz1ikN1v3yvWfjtunA/lCaAhbC7l8rwA=;
	b=AyBAuSQuueZQpETiCJOiTooyiUpkTFh1gljVhGKa26m8AbZXz+ClbWeGeysy0ypsiUXzet
	Ll6nbIBClYSjJpACQvIwyIAWTS84Puw82T6tNdb5ONaK8rU49tGiBcuyqblKXuFAg/asxa
	DPsPFgkFOxl4rMM5fJv3vjJSz5+neJ7KqssTAcCqZJSG4bCvNtMfUaTaoHgqPELrJlQBPu
	Sm6ZtqdxDR/JwstEokv/kOGOJDwehY75cV+aHJbiB6yWoHdCBW2MFd8RtLvhEAPHhUCQhW
	GLgbAC/DxuHDjeev1fzufqpWVnz8nO6ctHPvby5FUT/nNnqpdPO9x1tICNZ5vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7q16l4PLAkeFz1ikN1v3yvWfjtunA/lCaAhbC7l8rwA=;
	b=5JE1fxmVy1ywQuyk8s+y5t3/zZxSo1OI/QYoaHGBo/In4Su/6471Yvukp6dRs7zNCT1+c/
	b1ihqri6iF9wzqAg==
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
Subject: Re: [PATCHv7 02/16] x86/apic: Mark acpi_mp_wake_* variables as
 __ro_after_init
In-Reply-To: <20240212104448.2589568-3-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-3-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:31:53 +0100
Message-ID: <87h6hzcvza.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_023218_949529_E7F8146B 
X-CRM114-Status: UNSURE (   4.06  )
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
> acpi_mp_wake_mailbox_paddr and acpi_mp_wake_mailbox initialized once
> during ACPI MADT init and never changed.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
