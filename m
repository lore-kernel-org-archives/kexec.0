Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC6606A32A
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GEmh8gtk;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Dzr4H4Uu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:Cc
	:To:Subject:From:Message-ID:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=3oezv2c2NxkYBuJOQKRHFZurgThAtx7ut9Mj3a1tfIA=; b=GEmh8gtkplWZStyQ8XPlPZWw0N
	dhBuMJvOvHfy/YTidp3J7bRtb+Iz8n3T/OHs5whky2K/XTA1HSl/70aPzLPe567sOCRxTq4SevOSl
	zC/dJMWwHjnm2oh9mHjN8s72p7N/AFiHTTPXx2pcMfe74gLHYYQsYVYhTHiD3jjRWVhBSzCZZtk4Y
	tt7XgLabyOB+0p6QrmCyAhA4+xX3qo0FJiAafwd5o91zK4yfIgztct5XmfvzIZTIbNAVpEgh2cFM0
	R05murURKNIBWZAkxeJhXpzJVFWqEZPKkOWyUAxi8hfIQpnYtRBJvIl/0e58DKNIUfZsIBqOVDzSj
	H9LAOdRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEd3-00000000Zaq-36Xy;
	Sat, 28 Nov 2026 09:21:57 +0000
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEcx-00000000ZZp-3C2M
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 09:21:53 +0000
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-8b4d26094beso74737277b3.1
        for <kexec@lists.infradead.org>; Sat, 28 Nov 2026 01:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795857710; x=1796462510; darn=lists.infradead.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3oezv2c2NxkYBuJOQKRHFZurgThAtx7ut9Mj3a1tfIA=;
        b=Dzr4H4UupBvv4ktE3Ux+0j9bErqw4ZROCZRgWjjIiddzI0wN+lLtPVHrydUkZCiQIk
         NoJflzVSIPtqVqTrxC/Bn+fUM2VXpa23AIAzI2aQBzhCv/CeQJVvOuqzGtx+iqsioT5g
         lQmE1KxP8zyDO4FKFIcU4+f9d0qw4RP0LPjFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795857710; x=1796462510;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3oezv2c2NxkYBuJOQKRHFZurgThAtx7ut9Mj3a1tfIA=;
        b=0x97awsi6izXxQDnT+Bwd4i53aQTtiKarSrGSbLHfENuMBGNZqJFVT3Ml0Ykzk8nNI
         CJBosimGT+QfpBCE5cUl4ZbLhhIE8WZgQ1Dwki9FDWV13g3KP5oH4VrtvCVolHa1qXib
         LdOvGlm/Vx5n6zbXsB0Rqvy0TMjvH5r4KcTpocdVsYS/1xGEPy+PU0gcg+AoI3kQHePJ
         9tztAv8cxVFGeqWRH96FKiCPbU9SjcIAivltjha3rMgCfbD+xTCZxeSxH9D19m3EHIr2
         w+KwtpxmAX0+4jeKGSAsgtP0TIT1+d8JtDNdTqwGhNJEIciHOXYRYxWCEjLVY4KYpIPv
         FZlQ==
X-Forwarded-Encrypted: i=1; AL+hErGwZVPkbd5seWfT5OJzdIbpuipE6rzl5tZDfF2Ty0HuuT/wl3bV5zkmSd2779V5bgxwrFKCLw==@lists.infradead.org
X-Gm-Message-State: APuU4Z+WLlO20Ay9a0yOJEwNfQdUml+Q4kYDrWSL/3DpCW+gbC5Qv1LW
	qm9AcckREkwR+prtK/LGuex2awxqR9Ayobgk8OfgtrQFpGaQrenbHhfkzsU5X6I6lJKtJlpigwE
	NbXoC3quvp0IEPWQ=
X-Gm-Gg: AZFdTZcebQ2KLcsc2AxI/VEcysR1e+XPbaT13zlCu4VzX6QwBLGcWGNUVqNUgnHSFlK
	WqjOZHkQG3HYn+h4CXZM/QwapgWCineqsODOPLh8ScnrMmYysTHxTQ6JTFHssc0WMg2YcrvUJK/
	SCnNaN5Szj/8NDcXOqjpv1a25jtuaMcHMGbiXzVyKScGJuFDGmonyClty+5+HkBaJ9JCgcIBXXl
	T4ebp6QcR6dtJbI5mt8/lPGDQwdY/+mR3o24B/opIkzIq4IMi44x4Pjdpg7I6LjPQuvd0ugGlBw
	ovX7E+lzU1+825LXvvcN6k9d//4jmW6kb9z+DC05JeH4QAlZPvIVZda2sERSx7112pql6o8s4vp
	e8f7rfk9fXs9pkhxuDGqrwVi8bC0itcx9YRNV7JtNNkLhJnZKswIRK8A/RecYVoaT41E5BFvNS7
	8i/b1IDYZEwt1jTONDMyMDw2QV+RiacPZ/byA+5JBOHBmBZUFuf/PUnsjhElicHMftViKR2VxAr
	5+6mPCT2WeTi9PYbdwUax+pVyFybYWVYIwjeHZ06uESv0UExH74tLw9AwCeqehnjH1i/B+i0xiU
	R8CN1T+L4FuDQn97bicPbNpGxjZce/WwYA4M0BxknIrps6Jq4/C1yrdZ3ekH6DxmDrPvdWAVwJF
	2OigzIQS/twt6VtcWamec5Pn3Aj4O/uHm4/JZQp5ub4HD1WaLcWktXEwht+9LLZHc0szcUw61Y/
	zQfKk8ERbzzt6t4cb4425jIEZtK9quXbTanmiSl6ERrsgZjNbW96esXtfk43KrskAaM18iaNCyK
	pVISjOWknd3a412pbinTaU=
X-Received: by 2002:a05:690c:63c6:b0:8b0:ecb2:8861 with SMTP id 00721157ae682-8b52051cd01mr122748457b3.63.1795857710306;
        Sat, 28 Nov 2026 01:21:50 -0800 (PST)
Received: from [172.20.0.3] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52032d09esm102449777b3.35.2026.11.28.01.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 01:21:48 -0800 (PST)
Date: Sat, 28 Nov 2026 01:21:46 -0800
Message-ID: <cover.1795835884.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v2 0/2] kho: fixes for kho_init() failures
To: rppt@kernel.org,
    pasha.tatashin@soleen.com,
    pratyush@kernel.org
Cc: graf@amazon.com,
    kexec@lists.infradead.org,
    linux-mm@kvack.org,
    linux-kernel@vger.kernel.org,
    kernel-team@meta.com
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261128_012152_191745_EE1EF7DF 
X-CRM114-Status: GOOD (  12.39  )
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When kho_init() fails on a KHO boot, its error path frees the bootmem
areas that were inherited from the previous kernel, even though the
running kernel was loaded into them and is still using them. The new
kernel then oopses in kho_init() and panics.

The easiest way to get there turned out to be debugfs=off. With
CONFIG_KEXEC_HANDOVER_DEBUGFS=y, kho_init() fails when it can't create
its debugfs entries, so a KHO kexec into a kernel with debugfs disabled
is enough to hit the panic. That's a bug in its own right, because it
means KHO and LUO can't be used at all on a kernel that has debugfs
disabled, although nothing in KHO needs debugfs any more.

This series stops the error path from freeing bootmem areas that it
didn't reserve, and stops kho_init() from failing when debugfs is
disabled.

v2:

- Use is_kho_boot() instead of checking fdt (Mike)
- Say who reserves the bootmem areas on each kind of boot (Mike)
- Describe how to trigger it and add the oops (Mike)
- Add a patch so that kho_init() doesn't fail when debugfs is disabled
- Rebase onto liveupdate/fixes

v1: https://lore.kernel.org/r/au_vQhHAcJbkryXN@chrisdown.name

Chris Down (2):
  kho: don't release incoming bootmem areas when kho_init() fails
  kho: don't fail kho_init() when debugfs is disabled

 kernel/liveupdate/kexec_handover.c          | 19 ++++++++-----------
 kernel/liveupdate/kexec_handover_debugfs.c  | 19 +++++++++++--------
 kernel/liveupdate/kexec_handover_internal.h |  8 ++++----
 3 files changed, 23 insertions(+), 23 deletions(-)


base-commit: fa1c0f103fd68558613d3df76e222463c6e4fc37
-- 
2.56.1


