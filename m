Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87849C433EF
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 09:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0lGQJYT/rbiObjskaxdtBit4R9GDS3F5CGZ1aXnts+0=; b=3kUoP/5FW2Njic
	H0sPwMbryZvwZxpqSQaK24m3O4qZaU8lA+pUHlTLFWCskTQgUHbohUWF3kcOO5fn+OcdZHsfa1IHd
	bY40ep3yz7eNdTpbPU/+vk1rLKEJcpEn+Nvho5dE0E6HbNl/W319qmJO2cCn5tAeAAnkwB4jp+asW
	R3Io3fIVJdO9V0IVopbvrLGsVtyXzzDKZvbYQzA0UTcBNwI0Ji5D+JOGTBXhcsAAOMzwF+kQcleWp
	42Pww0b58vV54QCpwCPhk6AteP+8rmaJxe2GRFLB4+8cagjFstXQb6BZt9DD1xrdKeizxWY2CAkP7
	hf7eGHfuRagPkmqdU+zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o28Mz-006hmU-DG; Fri, 17 Jun 2022 09:34:25 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o28Mx-006hjX-1O; Fri, 17 Jun 2022 09:34:24 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 1AAE51F9F2;
	Fri, 17 Jun 2022 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655458456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/9jqjrWjBq+e8n5l8yHB+T+IMUuGKVC8FC3ULDVvXU=;
	b=FTPJFKA8FeF9eqe9UAx56v0OCaYJQ98NUpJd/Fyu/841zDYpmp7V+vrQsAaMyJTaLIHpDY
	jW9QIC1yFPElNwZ+OaFngDZ+N+49bTldw4qwJSKasPgVqLc42YFrrwQd8+Us4hOBxatBb+
	0uyd0BqBYJUd6fO4ZwcpZKpnlDzIxvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655458456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/9jqjrWjBq+e8n5l8yHB+T+IMUuGKVC8FC3ULDVvXU=;
	b=EFEK7kcQRPw9Mm0TJwQfiIJswOmHv9RkqbMuwSjmowmKP+lRPUGBTalCTRC2LKzeJOIXfD
	gvMyeDTeYhGX+rCg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id B54492C141;
	Fri, 17 Jun 2022 09:34:15 +0000 (UTC)
Date: Fri, 17 Jun 2022 11:34:14 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>, stable@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/4] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
Message-ID: <20220617093414.GA4660@kitsune.suse.cz>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-4-coxu@redhat.com>
 <e44bb6b11573838417b5d561173c27a1571c94b6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e44bb6b11573838417b5d561173c27a1571c94b6.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_023423_267487_1CFEE4D3 
X-CRM114-Status: GOOD (  23.86  )
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

Hello,

On Thu, Jun 09, 2022 at 07:15:27PM -0400, Mimi Zohar wrote:
> On Thu, 2022-05-12 at 15:01 +0800, Coiby Xu wrote:
> > Currently, a problem faced by arm64 is if a kernel image is signed by a
> > MOK key, loading it via the kexec_file_load() system call would be
> > rejected with the error "Lockdown: kexec: kexec of unsigned images is
> > restricted; see man kernel_lockdown.7".
> > 
> > This happens because image_verify_sig uses only the primary keyring that
> > contains only kernel built-in keys to verify the kexec image.
> 
> From the git history it's clear that .platform keyring was upstreamed
> during the same open window as commit 732b7b93d849 ("arm64: kexec_file:
> add kernel signature verification support").   Loading the MOK keys
> onto the .platform keyring was upstreamed much later.  For this reason,
> commit 732b7b93d849 only used keys on the  .builtin_trusted_keys
> keyring.   This patch is now addressing it and the newly upstreamed
> .machine keyring.
> 
> Only using the .builtin_trusted_keys is the problem statement, which
> should be one of the first lines of the patch description, if not the
> first line.
> 
> > 
> > This patch allows to verify arm64 kernel image signature using not only
> > .builtin_trusted_keys but also .platform and .secondary_trusted_keys
> > keyring.
> 
> Please remember to update this to include the .machine keyring.
> 
> > 
> > Fixes: 732b7b93d849 ("arm64: kexec_file: add kernel signature verification support")
> 
> Since the MOK keys weren't loaded onto the .platform keyring until much
> later, I would not classify this as a fix.

It's definitely a fix

ea93102f32244e3f45c8b26260be77ed0cc1d16c v4.19-rc1 Fix kexec forbidding kernels signed with keys in the secondary keyring to boot
732b7b93d849f8a44886ead563dfb6adec7f4419 v5.0-rc1 arm64: kexec_file: add kernel signature verification support

the arm code does not reflect the preexisting use of the secondary keyring.

278311e417be60f7caef6fcb12bda4da2711ceff v5.1-rc1 kexec, KEYS: Make use of platform keyring for signature

This was added a bit later, indeed.

Cherry-picking the changes one by one to the arm code you can get
separate fixes tag for each change.

Replacing the arm code with the x86 code by code deduplication you get
whatever is the state of the art in the kernel in question. In 5.0 you
get the secondary keyring, and since 5.1 you also get the platform
keyring.

Nonetheless, it's a fix for the arm code which is deficient from the
very start.

Thanks

Michal


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
