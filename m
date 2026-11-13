Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137E606A32E
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EMQc9G5n;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=NsnfPiMv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gPM9xW3HCUFDBCdeg2Fdt7LDLtrkk4BbVgNADER2L98=; b=EMQc9G5nEeualk
	ek4wY1uGt+u74gkcwWmctRpbHKve0rqsHnNXAZJDXRLgKKLs0hXbhH+xkWTfiItkL6R5GIevc80cu
	7qTU7OftLC20USWTewlLx/j9Tu+QnYGVaHwKIoHe+vKVAmJGSmJwAbGxUGz7N7bTWo9m53awTaogG
	zDJRteyA8XO9LQe0jQc4rb+I3TkjMGpMhF6LJGr/teMW4UsyS5Fk6tTMURnqgW2Y19FV9kmDdYoEQ
	7uHgIFtDAA2V0/sTHYNu4KlC8WKTorXY+ImbLea1EiqY8dTwukgYk2b75WrGIZCTwe1nxXKWyWatb
	ftW9xt9xv4BSbI1/z+Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRkcs-0000000BlJH-3CyI;
	Fri, 13 Nov 2026 06:19:06 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRkco-0000000BlIe-2L8q
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 06:19:05 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 43F8F40E0218;
	Fri, 13 Nov 2026 06:19:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pjC1BT2I1lNC; Fri, 13 Nov 2026 06:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794550737; bh=gPM9xW3HCUFDBCdeg2Fdt7LDLtrkk4BbVgNADER2L98=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NsnfPiMvMcVzCWYFFmgJICLutuTwIGLmlcr/AAYmo+UyGe7rENiPn6qvefdkZkhKQ
	 i0qN8fTwDp1VUL5p/mF7NmT2LQV0x4qqzK8bF3FPznb4jSXPTu/exZ6YfGXYHHdkUW
	 H59QcHeLOSlKtjwZ5GbnD3CHW7YH2mpIJZMJT36ZOX8eCe7xKFIGR7tg+1+sak4K3M
	 AAmwC8871YGH8UZ96QjWIH6TOra0wSw0Rv68WIA5gzDe/KVdzRLD1sVUDF8UzJy4bh
	 8U825zBRkwgCJohHUy8DH4ItTmxlywzgXzT2fg6m/ATJ+YmqKYnwTB/PK3Bi9lEVPE
	 pZbPZc4odnlz9WwnNBotsPbcT1h7t/62S8CDkGd9DeMOeOXH1cx/hcWMzmcD8j21Ko
	 bIVLer2hNEqcyUs63swVu3xruesfH1xwLc0JdhFsVeRPkfRMU2CPOKeFrzHlQEriGo
	 4JM65Ma97h1JIfOBpYl/3ix4fgTrtHGTxyNvh2QHjwn/6H0kjKwCvLYjNxZHeOwrYn
	 nyYm0if8r7kzICXTYi61/JRn6qaXpdQopkLw3smss4zCt3Lbw1fDUJKY4siNtvLiam
	 SDzdvamyljXR1Mo+XqKN2kZpnXuvQ8km+b4whMKsc2hyNAWDnBrI7v9VXkxSq/ulge
	 b40LPZ9GrEHOUhufRFwY3l50=
Received: from ehlo.thunderbird.net (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CEFC40E015B;
	Fri, 13 Nov 2026 06:18:45 +0000 (UTC)
Date: Fri, 13 Nov 2026 06:18:34 +0000
From: Borislav Petkov <bp@alien8.de>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
CC: dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@kernel.org,
 mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, challvy.tee@gmail.com, xiangzao@linux.alibaba.com
Subject: Re: [PATCH v2] x86/crash: Disable SGX in the kdump kernel
User-Agent: K-9 Mail for Android
In-Reply-To: <20261113055734.3976582-1-xiangzao@linux.alibaba.com>
References: <20261113035019.3747461-1-xiangzao@linux.alibaba.com> <20261113041516.GAavaO1CiqZ3otjh3I@fat_crate.local> <20261113055734.3976582-1-xiangzao@linux.alibaba.com>
Message-ID: <0E3109CB-AE2B-475D-95AF-BD5465748ED9@alien8.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_221904_440306_97E93F73 
X-CRM114-Status: GOOD (  10.10  )
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

On November 13, 2026 5:57:34 AM UTC, Yuanhe Shu <xiangzao@linux=2Ealibaba=
=2Ecom> wrote:
>On 11/13/26 04:15, Borislav Petkov wrote:
>> First of all this cmdline param naming is maximally unintuitive and why=
 does
>> it even exist in the first place?
>
>Thanks for the review=2E
>
>elfcorehdr=3D is passed by kexec, so every capture kernel boots with it
>on the command line=2E  We use it to detect the capture kernel, the same
>way is_kdump_kernel() does: that helper checks
>elfcorehdr_addr !=3D ELFCORE_ADDR_MAX, and this parameter is what sets
>the address=2E
>
>It also keeps the disable logic in kdump-specific code in the x86
>path, as suggested in the v1 review=2E
>
>We looked at two places: adding an is_kdump_kernel() check in
>setup_arch(), and this handler=2E  We chose the latter to keep the
>disable logic in kdump code rather than the generic boot path=2E  As an
>early parameter, it clears SGX before alternatives are patched=2E
>
>--
>Yuanhe

I don't think you even read my mail=2E

NAK=2E
--=20
Small device=2E Typos and formatting crap

