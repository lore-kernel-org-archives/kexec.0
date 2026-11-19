Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62EC606A334
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ejOuz/pV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oy8Bv2ht
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TG1nYNTcyHyUOWzd5MXIw5ZMjc5V360SZkt3R3ZKcZ0=; b=ejOuz/pVfd529p
	uNCFxS0rm/6My8zom2tBXzuHW5DOxic7j6qnRfNZFS7fCP6gQQd2qvHjUnKvt+rtU/2GdRroa7eSX
	hRaNkC9bTqQtBEIiZQmyYtCTBcTNmaw6i9VoMLYyybQGW5f/8FjugI25MRSKfz0Z+DrNNc90PRODA
	YOgyUN5cNeA7+1aSX/lg9vflDDCpADBhQbZoP6U0lkxiYI/Ucq1eIQMoFYKb/wa5PH8wGGxzCAXxG
	txj9eaLIOvv2m8muUd91cNXqpv1WOX+ybXY8/+dwV08pVKOMRtxx6q6ivriS/Qu9A884KnqmvB94J
	6puRrjAZplkoeJ6zx0jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU08t-0000000BgCv-1VXf;
	Thu, 19 Nov 2026 11:17:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU08r-0000000BgBt-3RZJ
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 11:17:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 98E98633B6;
	Thu, 19 Nov 2026 11:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB501F000C8;
	Thu, 19 Nov 2026 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087044;
	bh=TG1nYNTcyHyUOWzd5MXIw5ZMjc5V360SZkt3R3ZKcZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oy8Bv2ht8Z31GiXHlzXSp+X8i+LdKi+A80wBsB56MX4yrnfzRl6Vl4L8OlITkHEqp
	 9t9oEkYzCGYR27uioqP/4jUcusdffaFZdSe5GdlSAMu20ZQTSGlPFEuIiMekhTRHAG
	 RvTulDh+dz2/k/LpLKHWfPauRY9Q4RyOOLznMU8Ygr/EeOq3zypKD3I1++z+7EIt1r
	 8lV3s0YAQTwxkPoXgbVq+Pu1QQArC6iKTatyIKgFHYxmINrvnmnL0JfArsuymvAXSS
	 JiE1rhf0LzNCJ3e5ooQfRy4r5+iiwroEeLT3sSosXplwKH0ByzxGmd2K3p94pmkp3A
	 ecq21BmBr1mww==
From: Mike Rapoport <rppt@kernel.org>
To: pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	akpm@linux-foundation.org,
	Long Wei <longwei27@huawei.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	graf@amazon.com,
	leitao@debian.org,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hewenliang4@huawei.com
Subject: Re: [PATCH v3] kho: do not expose incoming sub-blob contents in debugfs
Date: Thu, 19 Nov 2026 13:17:07 +0200
Message-ID: <179508700586.361583.12491114908870226409.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119095937.826980-1-longwei27@huawei.com>
References: <20261119095937.826980-1-longwei27@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 19 Nov 2026 17:59:37 +0800, Long Wei wrote:
> Incoming sub-blob pages are owned by their consumers and have independent
> lifetimes.  Some consumers, such as LUO, restore and free their state in
> early_initcall, i.e. before kho_init() (fs_initcall) builds the debugfs
> view:
> 
>   early_initcall: luo_early_startup()
>                     -> kho_retrieve_subtree("LUO")
>                     -> kho_restore_free(luo_ser)   /* page is freed */
> 
> [...]

Applied to liveupdate-7.5 branch of liveupdate/linux.git tree, thanks!

[1/1] kho: do not expose incoming sub-blob contents in debugfs
      commit: bfc4b321d12e344627c1ee4977d6a0a084746d7e

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: liveupdate-7.5

--
Sincerely yours,
Mike.


