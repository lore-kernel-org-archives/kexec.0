Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF9606A31B
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2OunB+xO;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXt3N2T6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lAXg/QVJbwWW8fxD8PWaX1T8khpN9jxPm+FvL63Wv9g=; b=2OunB+xOaWYYwWE1yyuq0xMg4S
	Jd+t1DemDClUn14+H5w9dEm0CACIo2aG0SNs1n+e0RVT3vkJ/VI7ug4jphKk9phYzZprFCL6RfokX
	6t134xUKE7xFelse3jqQDLWfkVX1HJLVsWQ1OwUfJZczGSpk6zB21i8ohwQ+M9xru6LtwpNrQxzJ6
	691XukHc4Idau8Cibz6bYHcs5Z0VuDV08UXF43AJg6RY3o0K5A0Yj7Mus8hAWv70sttGsDaYcoJtn
	rKVslNq/jEjooJqRkq5z1VJWqcnX66++PggmUWooxBEJOSRYAMr5t76YzD55r2rAnPwAOD5kIQP5o
	W8vahdsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sp-00000001Gfy-1wJt;
	Sun, 25 Oct 2026 17:56:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Sn-00000001Gfj-3UDD
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:56:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 23F4E600AA;
	Sun, 25 Oct 2026 17:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B4B1F01825;
	Sun, 25 Oct 2026 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792951015;
	bh=lAXg/QVJbwWW8fxD8PWaX1T8khpN9jxPm+FvL63Wv9g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=WXt3N2T6tmamO1iMXw7+Azm6/yLi7Cj5c4n+uDzZtvUfSxTHUSPsi/u1+Mlx5w5TV
	 mR66m8gvs/amyX9cfDf5EjyMkjjApmBedID66aMnYGhtrtSre6W5ZH0xjusISWuK1k
	 Exbu5rpgwKDww4kyh09l+DTLF+ofOZjGzfw/fxgY5qLBUEYYkUjBsiotNCsB5eRYpR
	 4HRRUkXeVTWSd3oQP9BPf+34GlsjGqxRo9repjV/Eok7T85rCJroq83DLwMiFnHp53
	 OvnrFNDQZjF/0rPZ2bOeyvQ1ZnSrd8J88wz34B3DQC7ZK7jzJZzdu8KFjd6KI/0WJ9
	 bJkBdaKCNUYgA==
Message-ID: <sashiko-outbox-184301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] kho: expose physical address of outgoing FDT
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261025174017.3870481-2-pasha.tatashin@soleen.com>
References: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
 <20261025174017.3870481-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:56:54 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Expose the physical address of the outgoing KHO FDT via
> /sys/kernel/debug/kho/out/fdt_phys (analogous to bootmem_phys) so
> that userspace tooling can locate the root KHO FDT in physical memory.
>=20
> Also add kho_debugfs_cleanup() and remove the KHO debugfs directory
> if kho_init() fails after initializing debugfs, ensuring fdt_phys
> does not retain a dangling pointer to a freed FDT.
>=20
> This is going to be used by the upcoming KHO read-only mode.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025174017.3870=
481-1-pasha.tatashin@soleen.com?part=3D1


