Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E532A606A897
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wYR/NMbh;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLXy011t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ayTEljGwz/C/9F1gwd1UVwjVow2ZOVRqTAfEDPNcmCo=; b=wYR/NMbhnpCVqg
	oaTKnlP2TVn+x3XYDT74Yg6zkiGV2iM5sBV82tkmGqtgZLTcgbCUh/gTYFaoMpt6iequxythfUr9g
	x5UzAZzSkCreVHtXzh9bcCY3oL5BSevnsV+fhQXpwVnT9dfRpU8kgNMpP98didW+BYZDTrJhwie+V
	1UH8QkqBtJQXrGWu4bumKSQNguA9fLVNtGsl9CDZZ53jbLciiJRW35VwyIrgoA6nHXjmq5Pn7GNk4
	T2MHpbm5BLGs+DpYYjqZwlWdm3uzCUH3bISP2nAAxXh1uGsrcURODLEKjNOUox/GmaGgT5Tl7JJqB
	4majpHpdmk7qtFVhrfdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIob-00000005oA9-2iZB;
	Tue, 17 Nov 2026 13:01:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIoY-00000005o7u-07u0
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 13:01:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B8FBF4089C;
	Tue, 17 Nov 2026 13:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11DC1F000CC;
	Tue, 17 Nov 2026 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920493;
	bh=ayTEljGwz/C/9F1gwd1UVwjVow2ZOVRqTAfEDPNcmCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oLXy011tD0Lq2XmQGbPDQXGMNJhwNlcl7ow9id2rCTBLZY7lgGwg4Hq5cXNP2uXWc
	 s4s2qxProB4VQtOIN6Zop9n05AEqH8Ak5MYY1s4tqVfmhYyEzV22KerCWaJ/yZ/wVI
	 cLrTTJLrhPepY39XdjZNdK8KP7aMAiwR+g0VQgCLBr9pA3+/aHtqCniC1l1rKEk/h0
	 Y0O9z564FqUJaenebFu3Lph65xPq7+IbKx/+V4r8IN+4gr8inBR2qM/mW7CABfMFUh
	 Om6Tq1cgGQx3Y/EZjrERb6ecCV4OPuCmsv9JGy2YLq2lgUA3pJQtIlyQTkEMiKxVve
	 U/vSZ2C9WgwRg==
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	George Guo <guodongtai@kylinos.cn>,
	Kexin Liu <liukexin@kylinos.cn>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Mukesh Pilaniya <mpilaniy@redhat.com>
Subject: Re: [PATCH v3 0/5] kho: fix bootmem sizing
Date: Tue, 17 Nov 2026 15:01:22 +0200
Message-ID: <179492040138.3797543.1666695922414228895.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 12 Nov 2026 12:38:52 +0200, Mike Rapoport (Microsoft) wrote:
> There were several reports about issues with KHO bootmem sizing.
> 
> The bootmem areas are sized from overlapping views of the memory reserved
> in memblock, so on NUMA systems memory allocated on a node is accounted
> twice and with CONFIG_NUMA=n the lowmem and the global areas are accounted
> once again in the area of node 0. Besides, the lowmem and the global areas
> are reserved even when they are empty.
> 
> [...]

Applied to liveupdate-7.5 branch of liveupdate/linux.git tree, thanks!

[1/5] kho: reject zero bootmem scale
      commit: caeb2173b83441d991171dbbaa59455dae5399ea
[2/5] kho: walk bootmem areas in address order
      commit: f117bbae706f44c7dd1e811d89057d1dc7886554
[3/5] kho: skip zero-sized lowmem and global bootmem areas
      commit: 1010dc3150fc835695df7b21cb9d56016477fab8
[4/5] kho: fix bootmem sizing
      commit: ee4505fe8c4490827244668dab3659c100f4e7cd
[5/5] kho: docs: update description of bootmem regions
      commit: 5b27be339c42a7540eeca5c179e7e0bbdb7a4cdb

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: liveupdate-7.5

--
Sincerely yours,
Mike.


