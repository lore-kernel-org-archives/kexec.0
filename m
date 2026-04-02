Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515EBD3941E
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TIDAGUq2ox58mNj8RAJDIO3jke+fJLSXCQUmSvSgvp8=; b=DjQCfteM2vr1iRfcKr5LgDyNTU
	hD2GcH0OQaAMm9bdeu/gJ1PUkBaCCTZpZ4OdERvsUrTSGVXOLjA9rUdZmCKO7QeG9Vjj1H2veqkeM
	hmYtEcykpv274iwm0fF+xATcqqtCTjViSQ0N9boQxVfV91DoYaLyhtC66FchX+wkes5Xs6EwFNUtg
	xPiZr9BzILkkWFa3mESmSJPCjDRVcE0Ua4YjiGj8d4usgvb6hX3+nMBWpWBA9dR4HU6HHzJbH7Hf0
	Z9nvJyjPO2UnMuUmjrtU65ZSUjnbZx6YswUN+g+XWXQElPU9YfuvvcOh5yoJ0mkpPpYpTJSbQt1iD
	qMwbT5fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HGP-000000005Bb-2PHE;
	Thu, 02 Apr 2026 12:35:09 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8GIQ-0000000HX6P-37m9;
	Thu, 02 Apr 2026 11:33:12 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4B00540E0176;
	Thu,  2 Apr 2026 11:32:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jw2z8pECY3z7; Thu,  2 Apr 2026 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1775129569; bh=TIDAGUq2ox58mNj8RAJDIO3jke+fJLSXCQUmSvSgvp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akAPieEEczl8U7UBUYzKWZHF1yo8GWIbNtqvDnuU2xvWpQOTrCJvcM5YJXF/dlYab
	 YMHcN0kOoA9PaeZnalKe3TvEQU1ba12c6CK4GXE3QzR6fDCbiJXz/9OcwPZGYsD48b
	 7pWAUdwhCHC15+ODwz9YQ8+jBPuGHlaUTU3+7GD5IOP7QpdaSdOBVzpkcEajUVKe0v
	 7IMQq9XXEz3i+9pW3Hm1PSVtRqVDSivVNRcd2mBotzDLx2HlFQ43hQbYKH+hg/AkLO
	 uH1dugwlsst3UbYPenADA3Fgpugf7XfpWVmzZWNT/LuGUn9zNqKSWlwP3inH1kH9+F
	 ZduzT3zD4Ko7hOfXj0k+tQfDczDNNOcmMtQH4Snlh/wpwrTHZHlmGjmdk469rI2Cbb
	 BxBk3megOkdnJ/Kxe+EIeFcvWANIoV5ElsZoz0AEl9W5Huuonsjm2xnvtDa1Umr2rv
	 eBlXfEfKXFM1F5VEoXOGA6AJgTkAkHfHHKhDEgI/DgERCha6jNmVJ2OXGpjZUuxn0j
	 F887snfYoARdSYw6ag7tbwdSz5idvDgTWGRJX8ciczfA0ccLSB43HzSjNzVE+ftdMz
	 vcgwLZdAi/8xzDeOc6eIboCqt6HmYZJ9Jts/xsnL0CZrD8i8WSz9YYkCdLYoAXQzEK
	 Kz4yU1iMV/H/FkYlB1wYbzNU=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 68A3940E0031;
	Thu,  2 Apr 2026 11:31:44 +0000 (UTC)
Date: Thu, 2 Apr 2026 13:31:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	rdunlap@infradead.org, peterz@infradead.org,
	pawan.kumar.gupta@linux.intel.com, feng.tang@linux.alibaba.com,
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com,
	paulmck@kernel.org, lirongqing@baidu.com, rppt@kernel.org,
	leitao@debian.org, ardb@kernel.org, jbohac@suse.cz,
	cfsworks@gmail.com, tangyouling@kylinos.cn,
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com,
	hbathini@linux.ibm.com, eajames@linux.ibm.com, guoren@kernel.org,
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com,
	vishal.moola@gmail.com, junhui.liu@pigmoral.tech, coxu@redhat.com,
	fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com,
	takahiro.akashi@linaro.org, james.morse@arm.com,
	lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <20260402113137.GAac5Tmc5b7SL98KdY@fat_crate.local>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402072701.628293-1-ruanjinjie@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_043310_957302_F8AB79A8 
X-CRM114-Status: GOOD (  10.21  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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

On Thu, Apr 02, 2026 at 03:26:46PM +0800, Jinjie Ruan wrote:
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.

From: Documentation/process/submitting-patches.rst

"Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
						     ^^^^^^^^^^^^^^^^^^^^^

one week before resubmitting or pinging reviewers - possibly longer during
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

busy times like merge windows."

You need to be patient and send once a week and not spam people:

Feb 04 Jinjie Ruan ( :1.0K|) [PATCH v3 0/3] arm64/riscv: Add support for crashkernel CMA reservation
Feb 09 Jinjie Ruan ( :1.5K|) [PATCH v4 0/3] arm64/riscv: Add support for crashkernel CMA reservation
Feb 12 Jinjie Ruan ( :2.1K|) [PATCH v5 0/4] arm64/riscv: Add support for crashkernel CMA reservation
Feb 24 Jinjie Ruan ( :2.3K|) [PATCH v6 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Feb 26 Jinjie Ruan ( :2.5K|) [PATCH v7 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Mar 02 Jinjie Ruan ( :2.8K|) [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Mar 23 Jinjie Ruan ( :2.9K|) [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA reservation
Mar 25 Jinjie Ruan ( :3.7K|) [PATCH v10 0/8] arm64/riscv: Add support for crashkernel CMA reservation
Mar 28 Jinjie Ruan ( :4.3K|) [PATCH v11 00/11] arm64/riscv: Add support for crashkernel CMA reservation
Apr 02 Jinjie Ruan ( :4.5K|) [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA reservation

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

