Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A5606A320
	for <kexec@archiver.kernel.org>; Sat, 21 Nov 2026 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vJg3sWx6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXZ6/DgU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6wI6hd3wCr92yJ1fH/9oYnu0+cWq1GtimCY3YbDctlM=; b=vJg3sWx6tklmYM
	heeKxHKLwH8p/JpuDyV85PBHgFd8x4w7bmCT0FMzcmwryRDn1Kl2PHNLsp0Oe9wmfVay4rCje1W1Y
	PwXQffVnnfpI7PIOjr+joz18erwIwc2NPxtakEcLCL9GlZq39Y5zC3oy9kr1h1j9qkK/pVJgsW51D
	VZ+1pKgyMm2liwGTxWxwomGZB/LudSWJKOFLjv0N4a+NlQ4jHGMqgXtaoV6apOkzZJ9zONcJ3hrBw
	0nSky4Sgb2r8JxUXecDyXqXi8GGagwFZ55O9Stat0/IxJKAUUj6vfFcWItNFSexXO6QrDSc/QLfDs
	rPtNgxNfYoX2IsQrjf9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUn6P-0000000HOJm-2DHN;
	Sat, 21 Nov 2026 15:34:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUn6N-0000000HOJd-3yeV
	for kexec@lists.infradead.org;
	Sat, 21 Nov 2026 15:34:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0929560DD6;
	Sat, 21 Nov 2026 15:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924EC1F000C4;
	Sat, 21 Nov 2026 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795275246;
	bh=6wI6hd3wCr92yJ1fH/9oYnu0+cWq1GtimCY3YbDctlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TXZ6/DgU0Y11jqGYzn3bje7TSdZiIGiSXkZAEoSxtBv7TZXoxUGOe2vRvQKyACC5I
	 KHgQ4RqnELsug+V0cp+sQZJDvnL0+HSow7AmFmoa0ZsoAwPZLgVjfSHd4F/AQX+zPa
	 KwkQDRkKRgv2nhPAN5X6brheQNQw+7GvdVdyM+cKbwxRuxwrQvuqScexYOawo4/U/t
	 E/HbGrdBYXxA19S6fnae2ZZ7/vR+EB1tnvlRd81C+UG4lyZDOa5ek4/nMXYjWW4Iwk
	 5vbxiUfUbqrjUhtOeZV/KNcuDCMURpiiXv+JfRgraskMR95cVd4YhSnbxiPQsuD+oc
	 vlOAWmyuH7IAw==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	kexec@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Wake Liu <wakel@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/3] selftests: target selection fixes for cross and LLVM builds
Date: Sat, 21 Nov 2026 10:34:04 -0500
Message-ID: <20261121153404.2241652-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105125701.1605281-1-sashal@kernel.org>
References: <20261105125701.1605281-1-sashal@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew, Shuah,

Ping on this series. All three patches still apply to current mainline and
to next-20261120.

KernelCI still hits what 2/3 and 3/3 fix: the 32-bit arm clang builds
fail size on the undefined _init and _fini, the loongarch builds fail it
on _DYNAMIC, and the powerpc builds skip kexec.

-- 
Thanks,
Sasha

