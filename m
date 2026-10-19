Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2862ACCF2D4
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ihGOIXiwGHGUwHe8g+LPq4tQYcWX9D8eYCyMvZ90md0=; b=JFABWSyy8wWAegvUiAwDBcCrvs
	o/7y5wJYevR/dUXgHNqs/QGToHS2zaCIaKVDfVC6r98MMtoyoDWFvl1yg8MSFSFwJNrnwXxV1pk4C
	DhzVgn3zB+Z/ykvq2UcffOz0gr7ucfcAk/uQY3zacoq472pU3bayLWW9zOW5fxDZIFGhDM/p0oppJ
	dL6yZkY4STgi4iA8S1LdMlswk73o3snc4otNjbu3G704vNR97Mepo00R2KbpwIg6KZQs8sKAkaKVY
	KK6V2TfTsSEjY7pVZ7BzR5tnvP94dgt29einVDaMKQYdBxRO2i3E3oxbvdvNv+qfZQxIIa5Z6Q4bK
	mIJmTocw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxh-00000006SLY-25sn;
	Mon, 19 Oct 2026 02:18:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxf-00000006SLG-1Mz6
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:18:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C38860DA1;
	Mon, 19 Oct 2026 02:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B411F000C4;
	Mon, 19 Oct 2026 02:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376330;
	bh=ihGOIXiwGHGUwHe8g+LPq4tQYcWX9D8eYCyMvZ90md0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=L52NhCc831Qoi4M26hNQK7X4uA9Uq/sUvVpCt6cw8w3+9YM5ZqVedRBxa6R+A90TV
	 qqZoOZmJ/3/T+pf/Azt2UI/DkWLqpNMRLnedFdGAN8HqhT0bKe7uOChZsgnXxZ4NDZ
	 iTUdROofFqpp3Tcjc2OmXvK8j9b6KG38AEI3xKWRIhfFTZ8ig9iDmXcV+3H4++8tax
	 leqt50e6OOAuT/+5KgUghHofN0npqxl13X07uV+2olvphcWMcuO8tqwBEYncFiWa+p
	 iEuN2t613fbL6irA9qJFHipHMeamcchvij2RT3xHb4psKklStVoP2EofwLLwZKk2D3
	 FHbC41/t08dbA==
Message-ID: <sashiko-outbox-176518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/8] kho: expose physical address of outgoing FDT
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261019021111.990394-2-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
 <20261019021111.990394-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:18:48 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019021111.9903=
94-1-pasha.tatashin@soleen.com?part=3D1


