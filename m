Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF45CAC5B0
	for <kexec@archiver.kernel.org>; Mon, 29 Sep 2025 09:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3CD+eBafczqgm0Gtmyhxw8Dw+UwjHOZ8ZlVxf/MU5Q8=; b=KrUYTUDZLWx/2xJNdVLzCGW9E0
	zNu03InMe34dAorytA5FR47ZtDmAlHL0WVf08VtfMtx8Dj7l6b/3tWukgdvL8SZmfE6EegGz3YMq9
	3QquFg8baXGEFw+Vw/ySrYFukpPfz73pfkxHRbpeOgQoeDAsynRDg4OadNyCv+SRInG34fDYhTQ+o
	30zguOK0V2MRb+y/r5TFwk995NeXfMVCzTHhX5otZiNnhJhDwD29QuvuGu38pkH7TFzKphTPonaSr
	afx6EV4vLuWWefYFdnu3ZXLDaAjaUmgK5kPIih5jTfNDeSAFi1MvcvuUnre0C8PM1wP2yFyC7iyx9
	NmEKqafg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3AXT-0000000233K-0B6f;
	Mon, 29 Sep 2025 09:51:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3AWw-0000000231v-206E
	for kexec@lists.infradead.org;
	Mon, 29 Sep 2025 09:50:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D4D3B6239B;
	Mon, 29 Sep 2025 09:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90074C4CEF4;
	Mon, 29 Sep 2025 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759139449;
	bh=eyBG5MipCA+vWYuokK+3nM8AXjrHBF4dU5WWoKoSoRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGXyBxj1IXrklk73E9Zl9mZp6ibI2GHQoSe2v4oaEO/2ateb/JgHwLsof46wzu1lF
	 2SdvSLQO2v7VOkI2aVkWANqQzV6A4fofk1aQDctmGm/3oALy04iCy1MLaNKHB9DBAs
	 YQ5m8qnHpqw09C8mlmzBlPRF8Vj+LVhBqQjxXuXGcHzNCTW9MYwogFXKSzy04wPph2
	 d8ed5MniEP43anoSRaqLj508mo87QLQFZ4bKZeOYW+vhLfTZu52IcHcmFPYeJwvbOF
	 6WIIoOEAVaLDHtYSbwxTmymv578MuOwYz8HH3+48z8HNFQUnjR//2OueSlPMp5oR7m
	 UbF9C8xi7XBRw==
Date: Mon, 29 Sep 2025 10:50:46 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Askar Safin <safinaskar@zohomail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	kexec@lists.infradead.org
Subject: Re: [PATCH v4 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
Message-ID: <aNpWdp8jCMYaRYqh@horms.kernel.org>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
 <a28436ba-e040-42cf-82e5-52ff5cb144ce@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28436ba-e040-42cf-82e5-52ff5cb144ce@arm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Sep 26, 2025 at 04:09:17PM -0500, Jeremy Linton wrote:
> Hi,
> 
> 
> First, thanks for fixing this!
> 
> So, I've been trying to find a failure beyond the printouts being wrong for
> the past couple days, and largely failed to duplicate a functional issue.
> 
> That said, this does fix a couple printouts I checked on 32-bit 686 debian
> 12. Generally I think the code is ok as well and have reviewed it but i'm
> going to withhold the review by tag because I still think the commit
> messages could use some cleanup.
> 
> 
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks, and sorry to everyone for the extended delay on this one.

I've applied these patches for inclusion in the next release.

- kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=2842172e1405
- kexec/arch/i386/kexec-x86-common.c: remove duplicate <stdio.h>
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=c343815e7e0a
- util_lib/elf_info.c: fix typo: prink -> printk
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=b7b2a13547a0
- kexec/arch/i386/x86-linux-setup.c: replace %d with %u
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=9c12e71d712a
- kexec/kexec-elf-exec.c: Replace %lux with %lx
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=c837f1971fab
- Fix printf string specifiers, otherwise kexec doesn't work on my laptop
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=288e352ed7c8

