Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB56C982ED
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKLJe92aVR8cHrhFneRg88j7sXG35q2Vmlm5uDiLVCA=; b=i/cATE01pFOkMVceA7NgsRC3g6
	5RsEqNq7/NHkVO2X0JjXY5XAhWhs2HAjnYQUbKM1VPTxludIx8xvSOG+w/t7P6H0Ff7T0e1txomrE
	3bQ4EQC9soBAlDsYjGUCTyl7dNPwC0Hm13RA6U4ZxdORLtD0DIHms0zDBjp9i23fE5umfo3+4slRj
	9xmDAqg8QGdkSHQIUVlYCiDVLtJ0AfKEGNsEzDdspWkDo6yLJQ/KIWHHMLvhNDMriaWfCfqbsnt49
	TU9Ga/RghNJl2tt2nVG1iYGyuK6iNTbW5ehgs1hhPjy6hblJqrkn5hv4mOKheW2nMlzfVGF0GTeN2
	O1BS80Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8bd2-00000001ktc-2ZOg;
	Mon, 21 Sep 2026 10:52:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8bd0-00000001kt0-3o9t
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 10:52:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 469C54140F;
	Mon, 21 Sep 2026 10:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5001F000FF;
	Mon, 21 Sep 2026 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789987926;
	bh=lKLJe92aVR8cHrhFneRg88j7sXG35q2Vmlm5uDiLVCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T2/ARBWLeGHSlrpe4bAuhGSmBr44RpxAcaS/cxFBl4fXDBa3EI5IlTzo24WpaT1Hq
	 qZOfLdgZPnNhOq20bPiPe/39LIway+9pUZTzPtxojeCaI3l1ryq5eRd2fbxJEubTKA
	 lH4Twe0HbBXnS089Sv0Xn9Gx0U//qlfNk+tqGJX83vwg2llOcXApa9MV5DYBgtVctS
	 bxkhQeGvJ21vi0su0SkSt/zm0POeIFDdrEKGRBe/FH/5FU8DXCp+R2FsGhhWZ0suHk
	 +MD2sD9GH75WQMXAEzreFe+cNwnprmgXVUe3lRD+9SAgKev1wo1fhBkPTJI4INcD+l
	 TIAXZ5Ufb4j3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vmcore: report the release of the crashed kernel
To: "Breno Leitao" <leitao@debian.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, kernel-team@meta.com
In-Reply-To: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
References: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:52:05 +0000
Message-Id: <20260921105205.9A5001F000FF@smtp.kernel.org>
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

> kdump runs in a very small environment and cut-down set of drivers, and
> it can die before the dump lands: it runs out of memory, a device hangs
> on reset, or a watchdog fires while the dump is still being written out.
> This happens about a single high digit percentage on most of big scale
> datacenters.
>=20
> When that happens the only evidence left is what the capture kernel
> printed to the console, and that does not say which kernel crashed.
>=20
> A fleet typically pins one kdump image and boots it after crashes from
> many different production kernels, and it is useful to understand what
> are the combination of crashed kernel panic and succesful kdump
> collection.
>=20
> Whether the dump completes at all tends to depend on the kernel that
> died: memory pinned, devices in flight, dump size.
>=20
> The release is already recorded.  crash_save_vmcoreinfo_init() puts
> OSRELEASE=3D in the VMCOREINFO note, and by the time vmcore_init() has run
> parse_crash_elf_headers() that note sits in elfnotes_buf.  Walk the notes
> for it and print:
>=20
>   vmcore: dump is from kernel 7.3.0-rc3-next-20260917
>=20
> Given this is cheap and useful, I think it is worth adding to vmcore, to
> improve kdump monitoring.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-kdump_prin=
t-v1-1-e445fec3177c@debian.org?part=3D1


