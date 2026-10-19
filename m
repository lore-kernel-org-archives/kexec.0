Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4EACCA490
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZoDOp15FiU2RDMS8s9rhtHN2c7YEurzuMGqiCDf+QSs=; b=v9ARhmVn+WoQjNTfz8IAfFRXo3
	MosL8qwGYSgB5f299rZLlNak5x5Odn1w6hBkD4WUoXJKDcl2QleFVMXzAScO6STgC8H7nQUUCClFz
	zWqE4EVnjmznAeVZxDsl0ZeJxMyY8B9tMADQl7M+siJMDSdPfv/6fBr8+ooOlYFvhOMZYKuFfQuu9
	DWz+vip/5OlVo8JBHvHTuOehr8D0cj/gHM3X4u5HxHhjNx3K6ti7Zi8r8+QObJUYT4qDkO6rdjvT0
	EBnPWFW34gxaGHHwIgup7KRBUeerxDVTT87MZXZIEa0CAyJCy17rQVUybXmut5fQdcvDJQDJtCgRh
	QBDkIkyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxr-00000006SS4-1LLb;
	Mon, 19 Oct 2026 02:19:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxp-00000006SQd-04Jl
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:19:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C1F2941164;
	Mon, 19 Oct 2026 02:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7616E1F000C4;
	Mon, 19 Oct 2026 02:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376340;
	bh=ZoDOp15FiU2RDMS8s9rhtHN2c7YEurzuMGqiCDf+QSs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NnMqoYfHj8ItQxYUjQ5bOyfInUZ34EmbeMHyRkdELQdInj2jJQtl8Y/3HTwz9Xc96
	 yDVesHwS/68FZHBrHHN05T7jJMD9sOZt/jzeeyjvPcolxX0fzsohhBrRJKuY4kr018
	 r6W8qID1yjoyaYh+RQ8LPwQ6sP3ofD0PVxwfmeX6TUnke+L7tQ6PCffXak71bd5CLY
	 TMHoq1gylYhrgbcWZ/1hPifnw32OBzksYRJ8+1AiR/pw9pomiJL707SCI9nKdYRwQ7
	 +bLVcho+Jl++8s31OQByvfn2pg/I9Ln/NkGB8iyhKy6/tYYPDwMZlKvqGk1L8t1sXA
	 hqJAzKBedTkzw==
Message-ID: <sashiko-outbox-176523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/8] kho: support read-only KHO mode in kho_block
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261019021111.990394-7-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
 <20261019021111.990394-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:18:58 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> In read-only KHO mode, incoming serialized kho_block chains lie outside
> the kernel's direct map and must not be modified or freed back into the
> page allocator.
>=20
> Map incoming serialized blocks read-only via kho_ro_map_folio(...,
> PAGE_KERNEL_RO) during cycle detection and restoration, and unmap them
> via kho_ro_unmap() instead of calling kho_restore_free() when destroying
> or shrinking a block set in read-only mode.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019021111.9903=
94-1-pasha.tatashin@soleen.com?part=3D6


