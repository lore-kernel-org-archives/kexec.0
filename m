Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1627DC79FAD
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1or08Cl/oOQml/DEZq6dmSOvYX9gsw/HGxWMpfSXX6Q=; b=T2BYdN6nbbv1ax+rS6u3SQEy2n
	2W01cPDruywUamALOS8QwxZt3fh8XfmvpU51uiYb9eLiz+xBNirmamgObrU249Bk1PxKPKYaID5uL
	iXOihGN67OTfBZG8LZjbSwgJ0S27Y959qdCP+ngOdePTZTFq10c0OhYhdy/6asLuVeztqkVeqMoll
	1I8KAsuieZO85ry9Sa7F2dYX3oSVwTezEzqvbuDUNorROX8LKSjzeUm3PqVmhcdRuxFLYAKubnFTT
	ZrklkOrRY4OR7nzpx8B0jY41JeIrwO+h7BF4Kmtj6fsZTHAZGTBDUirwHaJ8z1MSceKoyjVFXHRAq
	YnDv6HVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Fbr-0000000BRM2-3vd4;
	Wed, 09 Sep 2026 10:32:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Fbp-0000000BRLv-3q5N
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 10:32:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9405342B62;
	Wed,  9 Sep 2026 10:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3CB1F00A3D;
	Wed,  9 Sep 2026 10:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788949973;
	bh=1or08Cl/oOQml/DEZq6dmSOvYX9gsw/HGxWMpfSXX6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gw5YFqsCgsVuhLTgR0h6VYOggGKAcT14+oSd7ei90H1dAejVV9s0danJX9+quVwTB
	 +fLTVYXsHgCSPtgK7AkvvV5lvHgAAtTJo8Q2ZC45MHuITQvFXMh1bHC3pKm7iFStdG
	 PPJralRhoTcnn2kMhF3HS3JvUV6WR8OnBrJHrOmTK5ovyKnIqty971wel1zbpM1MbM
	 9l3rpsYNklfsm59yn6ioYACXXteQAGGC0pj/vCjqrVbrnWAlDbZ02xK9RpQSfvtmZs
	 JqoCLFxemaD/yD8cLis6c8WV5Ek+mLWh0bW/PbXKh0ohbTPWS3EmvGbLOEco3nm/AE
	 w9nCmhYJ4N4OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kho: docs: fix scratch_phys debugfs cross-reference
To: "Pratyush Yadav" <pratyush@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Kamalesh
 Babulal" <kamalesh.babulal@oracle.com>, "Alexander Graf" <graf@amazon.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260909103001.2423403-1-kamalesh.babulal@oracle.com>
References: <20260909103001.2423403-1-kamalesh.babulal@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 10:32:52 +0000
Message-Id: <20260909103253.0D3CB1F00A3D@smtp.kernel.org>
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

> The scratch_phys documentation incorrectly tells users to use it
> together with scratch_phys. It should refer to scratch_len, which
> provides the length of each scratch region.
>=20
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909103001.2423=
403-1-kamalesh.babulal@oracle.com?part=3D1


