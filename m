Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF433CC6B19
	for <kexec@archiver.kernel.org>; Wed, 14 Oct 2026 03:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDjUElk5if0m2jgHTjpsjD17usFdMvcgFewB8GpYAq8=; b=CSPi0JBAtMq/07E4MTocffknl2
	fyjbGT4SQiqGZIYuOfdKmIC4jI7et1OezAPJr8LZZM4zAXXUBAGz1cajOeukCB1XtLAV/dNFeGCVq
	B4KZInOkjie1sqneKw4XRJJInkvQdvjz8oB7P6H1bQ1/z5Q9+Kl+wN+rvVpLDQY7ye5gT6F8kAKs0
	X1o+R+u5VhyeY45g4WTaETEHEkalGAmHeK+dbHyllcWVR8Fy3DL1aAbZQiPtecyECo25tUcgL+yzV
	RvTIlDEpdSXFuyq9YcJJJC+6uaqqTP/51cX33zLG5VrOCnaHwi6yo9tMNX0jHeCxOC2WeE1NExTK9
	ggD5ZwJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGpZt-0000000EQcQ-1jDO;
	Wed, 14 Oct 2026 03:22:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGpZr-0000000EQc3-3NKy
	for kexec@lists.infradead.org;
	Wed, 14 Oct 2026 03:22:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D8102601DB;
	Wed, 14 Oct 2026 03:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41ABE1F000FF;
	Wed, 14 Oct 2026 03:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791948170;
	bh=nDjUElk5if0m2jgHTjpsjD17usFdMvcgFewB8GpYAq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZM6kLDaaILD9ZwN1Mn8dPRHAzLQz3+fZSRROSkC+G+Tf8oJPuEW9Y8QTW01YURMH
	 8biQkYCnD40qR4DG8oRIzfJDugCCvsGAmNdWL9IOX6TpCPHsv7bUDbfXFE+ABeQypV
	 SMDUouXo5Or5nTki4w6EA0QMRocQFGu7Jv3gAfpUg1oM7tiT1/Auv+ZeZpJ362wSKS
	 i+cactRqgT8SPC1wC5UMa/A1BrpmNNKi79A5ED6jz6wan16fsHhS0guZozpqjHHcal
	 O/8y0Aal4inSU02W9o8DjqfKWn8PY2w9kVOFzJEvkpaxm3n5Bkk8ZrXLl9enQRlZgr
	 iLyEjMk9Nf81A==
Message-ID: <sashiko-outbox-170773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] mm/memfd_luo: release preserved folios when
 retrieve fails
To: "Haolong Wang" <18766350203@163.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, kexec@lists.infradead.org
In-Reply-To: <20261014031254.432582-3-18766350203@163.com>
References: <20261014031254.432582-1-18766350203@163.com>
 <20261014031254.432582-3-18766350203@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 03:22:49 +0000
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

> retrieve() only frees the serialization structure on its error paths, but
> the folios it describes are still preserved at that point:
> memfd_luo_finish() deliberately skips its own cleanup for records whose
> retrieve() failed, since it relies on retrieve() to have released them.
> The folios and the folio array are therefore never handed back and stay
> reserved in the next kernel.
>=20
> Release them from retrieve() as well, by sharing the cleanup with
> memfd_luo_finish().  After the record has been validated, the folio array
> is restored before the file is allocated, so a failure from
> memfd_alloc_file() or memfd_add_seals() can release the folios directly
> instead of allocating memory while already handling a failure; a record
> this version does not support is rejected before that and uses the shared
> cleanup too.  The folios may only be released while they are still fully
> preserved: once memfd_luo_retrieve_folios() has run it has consumed every
> [ ... ]
> by Sashiko AI review).
>=20
> Fixes: f85b1c6af5bc ("liveupdate: luo_file: remember retrieve() status")
> Assisted-by: Pi:glm-5.3-flash
> Signed-off-by: Haolong Wang <18766350203@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014031254.4325=
82-1-18766350203@163.com?part=3D2


