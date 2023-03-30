Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4376C761A6
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4S0hV5TM3CoJipXS3BBKrzkPMYQxmygrUiWUG3If1W8=; b=izKm0ewhvkJl0r
	RHPYFPN2Eow6kfrywTY9q+s3aGYqw5wGMMToaotYVEOkcxa6Ek1HmyLwfbYG1kH0xglnOF/NZONAE
	z5sYMi9+ZpuBwbYvqbt8W9lUyZm84g0rVXs3pwswV7q+aQXOVRnNsx7LdPPX7tlrDPQFwtCQjkMbi
	K0MMi9/PxQ857E9Z+ZEmJWm9ATnfkxbN9vgQZdE+37qWEKHw+gM/IyclpsEvQfs6uP72HnMLXbZho
	IvtNmK59+6om+o/3yqKx9OzKqxAoIDuEa8FHsMcIUeX/oQ3+WB4mslB4nUSHP/D7PKBr8xxh7DNuP
	Yrcke4WKBMD4xufFH8Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phu2y-004Ct0-18;
	Thu, 30 Mar 2023 15:18:40 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phu2s-004Crm-16
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 15:18:39 +0000
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE2A81EC0691;
	Thu, 30 Mar 2023 17:18:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1680189509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=Qd5om9gxT9ZJJOv9i3uITg1LtQmZSSw65wvXHgs9mtE=;
	b=hCfQNGx/0JvRA587z1H5a9oPV7u3HC7TMyxb1X8zYxewgoIeJD0dUNQjNrpBySSdVTJi8s
	Z3rfrWu6ADgFLY9yLRS+Qa4d0suBz9/qz0SmT4UhZYX+QgcEkgnUIcC73ZJZPp07iiXcIS
	8E1IhfNkH68AfFV3yYu1FCP6gDbwSYs=
Date: Thu, 30 Mar 2023 17:18:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
	Simon Horman <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
Message-ID: <20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local>
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
 <20230330111523.4b98c8ce@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230330111523.4b98c8ce@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_081834_528759_4D8C0683 
X-CRM114-Status: UNSURE (   8.72  )
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

On Thu, Mar 30, 2023 at 11:15:23AM -0400, Steven Rostedt wrote:
> > Make sure that the .text section is not divided in multiple overlapping
> > sections. This is not supported by kexec_file.

And?

What is the failure scenario? Why are you fixing it? Why do we care?

This is way too laconic.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
