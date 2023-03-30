Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AA5C761A6
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pqswGNOiBbsDtShq7PxDlbM0ygLFF7UcD2NigW7E8CE=; b=AbmtPJYpvGIRtT
	aOZN/ZooLSQOmjdhc6239CKrngJjZcJ0rjPKCTrnRewvhiSGxfNJKwbRvQsGb3dphxslEAjlhoGIO
	Tz+abibCAbZxyQ3azPY6xwlQmIivszvj+y/4D4ErsrGR2HtZAdfwqVkiN62wfYDj3su2X7WYD+1a4
	muQon6pI5+Vu0H/cJ32XMvaMUzrKnaTOAfBn7eTg0tEq/DhhDXJRzW6a8V110+nG3hF9nuK1TzW4e
	FMlUeiXcT8EBh/7H5w19x7WU2ZYcXBfT9v41kX1DujApskhqj76fvL4AF8VQSy7NovveyjaYS990A
	/kgVX9vlAewNNP0Mqpxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phuhV-004P17-0K;
	Thu, 30 Mar 2023 16:00:33 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phuhS-004OzE-1o
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 16:00:32 +0000
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E3CED1EC0541;
	Thu, 30 Mar 2023 18:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1680192021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=Q8kilb14SjQzoHcX1R+y87jwbUVvcGG7T+P2eazDiAc=;
	b=ZNvc+AAvCr02rOoXnxglXazZ0S2R37KD551rBuZUsqhFQZYyPUquisBd/Kvey+BC3tlD6E
	SGhKx2EEmvvADqGLujXP4ti5FfPsaDJQzbCYyVYRgBjB4yCokXQaiSUgWE8hssiDy8+pWr
	uyEWjIk1TMw8q8YpFA8TdvX7M3jwEwI=
Date: Thu, 30 Mar 2023 18:00:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
	Simon Horman <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
Message-ID: <20230330160017.GEZCWyEXQVQZRBbYif@fat_crate.local>
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
 <20230330111523.4b98c8ce@gandalf.local.home>
 <20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local>
 <20230330113127.3011e021@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230330113127.3011e021@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_090030_761142_72C7B379 
X-CRM114-Status: GOOD (  14.35  )
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

On Thu, Mar 30, 2023 at 11:31:27AM -0400, Steven Rostedt wrote:
> On Thu, 30 Mar 2023 17:18:26 +0200
> Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Thu, Mar 30, 2023 at 11:15:23AM -0400, Steven Rostedt wrote:
> > > > Make sure that the .text section is not divided in multiple overlapping
> > > > sections. This is not supported by kexec_file.  
> > 
> > And?
> > 
> > What is the failure scenario? Why are you fixing it? Why do we care?
> > 
> > This is way too laconic.
> > 
> 
> Yeah, I think the change log in patch 1 needs to be in this patch too,
> which gives better context.

Just read it.

Why did it work with clang version < 16?

+ toolchains ML.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
