Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E02606A325
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cyB9RTPW;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OdFPmX7Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Z/lgf/GnvODHH2kSfd1ioOa/KiKtGaKkOea+zkHk+YI=; b=cyB9RTPWN2Vorb
	zXal689nfWcnuKZ9vIfZe1CuHMYNeGj32satrWP6AhF2K2LfRr2F1DNSaMVGEdseIeWHLijvHTHje
	Xug/luvU/Sp6kor/rFP/N1gPJ18vejGFgwAIP8zyQI5oHTYqzHwKqMU2dKDIp9zo/+8ttmjhk010j
	DG9jCe/p7M/4AVgHXgqdvYVTplJEm0Mkj4nVOm+RtKKhZ4S3nYZFHZAAuXnhr7uNKKrgSlhO1+DUb
	HTz9wPnzHVtOXCUGM54/f+2HVOerX5RepenvHqWiseWWFm/nh/WJNVgkcwMbDnu+b/GzRRXgAVlM9
	0cI3g1r+t3zSy+htiL6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTkNB-00000009xYq-3rg9;
	Wed, 18 Nov 2026 18:27:09 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTkN8-00000009xY9-3d06;
	Wed, 18 Nov 2026 18:27:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E52071477;
	Wed, 18 Nov 2026 10:27:02 -0800 (PST)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BBFA3F673;
	Wed, 18 Nov 2026 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795026425; bh=KD00H1LZROLiORUw7YDn6v/wgRaKM9BnTfzpbzUCeVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdFPmX7Z+SLEjJNH0jSOiiUGQ/J+Aol+4r8E/VTNF6DOQRuVpf4adrDYexah8mmF+
	 4jDcYK8Wk7NsokRYoqRZ5Qw1H/1WTK2rN/deYIZVtBYReCe+v+Dclr7yWoC3bHHqXq
	 xX5Rd+MsP0iG6Nw7Zw5AUKcb6i8eo2z7FBvm9dDE=
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Ben Cressey <ben@cressey.dev>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	kexec@lists.infradead.org,
	llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Jeson Gao <jeson.gao@unisoc.com>,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/2] arm64: use typed entries into copied code for kCFI
Date: Wed, 18 Nov 2026 18:26:38 +0000
Message-ID: <179502639864.2187887.8685436920018120058.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
References: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_102706_942491_32B1AB4E 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 15:26:03 -0800, Ben Cressey wrote:
> An arm64 kernel built with CONFIG_CFI=y oopses after "Bye!" on every
> kexec that relocates the image. v1 [1] marked machine_kexec() __nocfi.
> This version types the copied relocation code instead, as Kees Cook
> suggested [2], and does the same for hibernate, as Mark Rutland asked
> [3], so that swsusp_arch_resume() loses its __nocfi. Only kexec faults
> today, and its fix does not depend on the hibernate patch. x86 follows
> as a separate patch.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks! The second patch is for 7.5.

[1/2] arm64: kexec: use a typed entry to fix kCFI oops
      https://git.kernel.org/arm64/c/b059e957d07b

