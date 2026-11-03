Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB6606A33E
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TWA5R/u2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnZtfiJ4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kq5BwZFlyCx7Ts+tlLob/ycCmrlDmGIBrdYtnLLIhRQ=; b=TWA5R/u2X8hcy3
	56rG6IWYh85Ugiwz4iqyl7QQn4IMmgoBgJml6G6DJfmhkQrIIe7mZo6p4iZFiHuFcpZKLuKrSOsAt
	/QinN/x/9Pjk8X/ROZw9eOYQvlokQ1L52oIwv0Ih1Xzr4ocF5RBZafGssXshHMzqKi80GPPbbrXuN
	bTwyznIMLNX/0L3j4i0ekBNIQC0knsQvt7FcWhLOpbHZqwUmPkmBxMO51VpgMQ+lEscYZAAJAQq7X
	dwrfHJxH/RzLbKHi1qYZx4BSVBGqB/0W1Vap4w3PGOeoqiWtENcYP+qIFamvjKSKkKi5C5qae70cI
	AzA6782Dn3akcB4kDYbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOE8w-00000002S1P-3D14;
	Tue, 03 Nov 2026 13:01:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOE8v-00000002S0z-3D70
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 13:01:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C771260008;
	Tue,  3 Nov 2026 13:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259AB1F000C1;
	Tue,  3 Nov 2026 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710896;
	bh=kq5BwZFlyCx7Ts+tlLob/ycCmrlDmGIBrdYtnLLIhRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LnZtfiJ45MApyCSpJguo0tOn5IzCJqlk3dCFfTSJlW2DkL5NawvtQU95uVhOON2gl
	 jJcFWKMscToJYgxM5g4JYYHTepp3iN9pCQhHLV/xfrDuxhrEeopcy+UqeYiD4sesxl
	 WPmZrlIOPJpKhy9PiwLZZg337q0EQ6KqslCiyXhofnPQtmgBtA/jf0T8A6txLIzw1R
	 /0oDXlM94agtOYLSgivi1jsPgwhDXzkOm2LUnwK8sAVbwOyuL9zDv5BgAYHK1ckJuR
	 7CtQTgsdX5YZvzBVKhPFB0BpQ9R97FEw7mu07A3cp7CGgxOXDxglQ744DH0nzj3Qub
	 NqOcvwsexmNKQ==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-pm@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Nageswara R Sastry <rnsastry@linux.ibm.com>,
	kexec@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Wake Liu <wakel@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] selftests: target selection fixes for cross and LLVM builds
Date: Tue,  3 Nov 2026 08:01:24 -0500
Message-ID: <20261103130131.4069212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200127.1363472-1-sashal@kernel.org>
References: <20261014200127.1363472-1-sashal@kernel.org>
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

Hi Shuah,

Ping on this one. Rafael took 3/5 through his tree. The other four
still apply on 7.4-rc1, and Thomas reviewed 5/5.

KernelCI still can't build prctl on any architecture (the Makefile is
skipped whenever CROSS_COMPILE is set), kexec on powerpc, or size with
clang on arm and on loongarch. Could you pick up 1/5, 2/5, 4/5 and 5/5?

-- 
Thanks,
Sasha

