Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BACC433EF
	for <kexec@archiver.kernel.org>; Wed,  6 Jul 2022 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o+OYyCY0Iq+lD6pNvwQjcvSooGL0zlxhMocYO/no794=; b=zyk7RfrUjLXJcq
	nkafbtHfOEkF2m1YSkPbb00cvfbep5BQdiKRoK4aQTLqhJZqru4ENSAzfSFL1WDOQTFXnk5KaVgHU
	HmtqXqo2ksKdNVgZY7LMoRY9Uy17EzvpBbi7LcD6S8bhbt+tSsmBHKn4a8PYK5bYrEvci2d+BD1Wn
	CVvph5ylbV5K4IO0UaZeNTufKcdxMIJ9m5fWa1Pdg8+jD5E+svLLq0tZw46XtxVCU9FoAbVzwVyGZ
	PIVY1Ob7QCopMnRGw6ismF03fPQeGIRtMh4bCV8Gjz4SBygiPA1020q1w/ffAnzDNj0D3f+5G7q9O
	D8RulNqO9VnU8NreFJJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o93Vz-009hg5-GL; Wed, 06 Jul 2022 11:48:19 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o93Vw-009hde-6X; Wed, 06 Jul 2022 11:48:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 386CCB81A4C;
	Wed,  6 Jul 2022 11:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9A3C341C0;
	Wed,  6 Jul 2022 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657108093;
	bh=48bioGnGY1JJCCO13fIsPNCPQ93GS2y3jjmFl/TadSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tain4dCIXeFWGWV9v7Ak8geP3KCn+yU9JP6xkUakSFNcSlYji8Y32xtZyVJnXgJH+
	 mPWA0M28GBAztHM7tE2fU2Ben/T6vIXGi1iUcs2pj83iPzmW3phcTmtR4DiLt/Bcmc
	 mYpSym7JuhoD9M3nRBxAEX75DlSMcIukY4WgtmNe7yjJgeRX5KCLg1zUElsIhV57mB
	 jIzPjFCPzSbo5zeoTYa4xe6JbVnUYBoPdFUQH0kQoamrF6Un22v6HR9xSA4i/72Spu
	 LjVkbKFvr+aj1qO14xLQAcz/yGhJasL7xRR/35yGLt7JUwlVI0m67ouJ0DB3cTdcQF
	 SH/OHaXabz6aw==
Date: Wed, 6 Jul 2022 12:48:07 +0100
From: Will Deacon <will@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to
 verify kexec'ed kernel signature
Message-ID: <20220706114806.GB2403@willie-the-truck>
References: <20220704015201.59744-1-coxu@redhat.com>
 <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_044816_417879_2E1596AD 
X-CRM114-Status: GOOD (  22.42  )
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

On Wed, Jul 06, 2022 at 07:35:36AM -0400, Mimi Zohar wrote:
> On Mon, 2022-07-04 at 09:51 +0800, Coiby Xu wrote:
> > Currently when loading a kernel image via the kexec_file_load() system
> > call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
> > .secondary_trusted_keys and .platform keyrings to verify a signature.
> > However, arm64 and s390 can only use the .builtin_trusted_keys and
> > .platform keyring respectively. For example, one resulting problem is
> > kexec'ing a kernel image  would be rejected with the error "Lockdown:
> > kexec: kexec of unsigned images is restricted; see man
> > kernel_lockdown.7".
> > 
> > This patch set enables arm64 and s390 to make use of the same keyrings
> > as x86 to verify the signature kexec'ed kernel image.

[...]

> > For arm64, the tests were done as follows,
> >   1. build 5.19.0-rc2
> >   2. generate keys and add them to .secondary_trusted_keys, MOK, UEFI
> >      db;
> >   3. sign different kernel images with different keys including keys
> >      from .builtin_trusted_key, .secondary_trusted_keys keyring, a UEFI db
> >      key and MOK key
> >   4. Without lockdown, all kernel images can be kexec'ed; with lockdown
> >      enabled, only the kernel image signed by the key from the
> >      .builtin_trusted_key keyring can be kexec'ed
> 
> Just confirming, for arm64, this patch set allows verifying the
> kexec'ed kernel image signature using keys on either the .platform or
> .secondary_trusted_keys keyrings.

It looks like this series is ready to go, but it's not clear who should
pick it up. Eric -- would you be the best person? Otherwise, I'm happy to
take it via the arm64 tree (on its own branch) if that would be helpful.

Thanks,

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
