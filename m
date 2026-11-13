Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F80606A31C
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j3KFf94y;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=izbh86xN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=//lKXFbkokNqziUfCV8iUKA3qHrzbho2r1lEbcoPji8=; b=j3KFf94yhVFSO292x6sOoEIlDM
	stXf0pRbQHe6+Tv12MeER0CIxzWeSnQCIYeld+58vxP5nRBAvvpln309Zf0j8lH+VPVvMdvi2TX9K
	gOJ9ye4/HA6BH9QyWpsgnLk6OVsn+hAMm1k39ZsOuqIMv+yyxchJS2jYIQML4nZBRMwX1vsPcVR53
	sUX26kYuPQFWxAG/tNypRfEHPg6VZ55mn0zABDX2iT+0TPPIoSBbKBO06KuHXtHatFHhFjSBLVw7f
	2R8U7NDixTGIuhPulsd3otlrSKk6vjx/MvoGi9VvlKwcBqPu7ubrsQlcj/7VFjla4r0Eg84uryhL5
	9meqnRow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRihU-0000000BdAb-0u1N;
	Fri, 13 Nov 2026 04:15:44 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRihR-0000000BdAB-2LFC
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 04:15:43 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BFA6940E0218;
	Fri, 13 Nov 2026 04:15:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vcZHcrsSL2UQ; Fri, 13 Nov 2026 04:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794543331; bh=//lKXFbkokNqziUfCV8iUKA3qHrzbho2r1lEbcoPji8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izbh86xNYurQZUs33IjsgrdQ2xkFL3P1t8SW9THXglpb6BK8tW6nLxAT8a45WZqgn
	 S1uiV0jybx0yFGxQ3YtpGLsesmd0G3ZWKvF8JoR+GF8g43IUhwfwmYgATAwvL37TVH
	 JnOolI2PLsZjcN2Ql1S/QWjkP7aTXPuZ2/WOiK1+OM3DU2+c7CLMwiCVCimd47o6SR
	 CiURa9JWXhkwYAvSmwpt6j/x8esHS/YDcR5IDi1E0A8WKiN9ccmmVR5qqTurX3UD2U
	 UxhkmDAjFQBmNYWJwEjAZinsRBcp3ppjoObQo3tHjseSRSlDVaRzOylzccN0V9Jc1n
	 WlNWaUAMio2brvmoqSr70rJpA9BNQwW0XZFJ2ayD5SCRF60UaKBabyt9Ag5k5ALLUu
	 77gsVtEfAmvXc9l/dioT4Twd3GJGG/nZT5DAOHULiUiz/KvEcsUKXvct6KCN3cfQfG
	 h/FlsnSVIncOxtqlYcZm/5xuEja47KTVUTX/Y6Ai8SbFhpiSUujff/h7cVdEugn0RN
	 9jJ9Vi0vvs3suLxXh2YYMJJoZ0YN3hI4q/QTyvBFsT+uHWEJ3AsSMG6ovjVYMLtZJw
	 ygGlv/WMrVtebyiYh1GsJF6m/phhVdKhANxRxTM/5v94WD3eNY62mu9gpVvcHP6Pkz
	 1xVdkOdp7ZI+fhFQlCNCDAuw=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0ACE240E0184;
	Fri, 13 Nov 2026 04:15:19 +0000 (UTC)
Date: Thu, 12 Nov 2026 20:15:16 -0800
From: Borislav Petkov <bp@alien8.de>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: jarkko@kernel.org, dave.hansen@linux.intel.com, tglx@kernel.org,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, challvy.tee@gmail.com
Subject: Re: [PATCH v2] x86/crash: Disable SGX in the kdump kernel
Message-ID: <20261113041516.GAavaO1CiqZ3otjh3I@fat_crate.local>
References: <20261113035019.3747461-1-xiangzao@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113035019.3747461-1-xiangzao@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_201541_781580_2D757D45 
X-CRM114-Status: UNSURE (   6.70  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 11:50:19AM +0800, Yuanhe Shu wrote:
> Clear X86_FEATURE_SGX from an x86 early handler for elfcorehdr=, which

First of all this cmdline param naming is maximally unintuitive and why does
it even exist in the first place?

In case some user decides at kdump load time to disable sgx?

When do distros normally load kdump kernels? During boot?

So it is probably a script doing that.

So no user is even going to pay attention to this param or even know of its
existence.

And how does an init script know that the kdump kernel should not dump EPC
mem?

Do you catch my drift here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

