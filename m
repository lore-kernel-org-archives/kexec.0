Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81098C79F9F
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUYxAj4HnarvzsP+eubGIWnHw0kdeifpIluNpTBfJ7Q=; b=i0QMDx2O/rjm9XCI90gnBEQ68I
	EA4BQPi4iPAWhp7cdJuiiglmwiHwENBonNerRPr8bc6K0Fuxa/N071ZsIM8wmaBs0vj3iDnZAs2CX
	XR607qj0PDQVaNAxX/GAGq7Ftq9pyn1r/oAgUb8v8+61KHeYVnoZ3wOrJdATvTlknVsRe71loICvc
	/tKGWJ1Bsr0S2ImW4Lxm1x7scBAzVIo+97vNi6ggfN2qnHQypPZtVtAgffmldsXLtMVLtTp4P9lOj
	ib8xlSChRJLkTy5eHsjfp8gkbl2gzTbE7qO5FLXUtYcQ/a7aDdbTv6s18UOQbMtNstyqptYxO/JOs
	OEY2/0OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ijN-0000000F5Kv-0KdL;
	Thu, 10 Sep 2026 17:38:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ijL-0000000F5Kk-2iOa
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 17:38:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D860C60204;
	Thu, 10 Sep 2026 17:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D831F000FF;
	Thu, 10 Sep 2026 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789061914;
	bh=JUYxAj4HnarvzsP+eubGIWnHw0kdeifpIluNpTBfJ7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFytRu4FsCW1KcbAT4M/jjQmFi0i9VtqGmHByi7GwG0edq2iIDIQVRlYkPd9JzHtE
	 IaFcYBc3AeTj2fNGpdmo98ROUVR8Bb2GtvSzQzqwce3MYnvD2OUM8B533QBPrrcVb0
	 g/0G5nZdOC36N5fWWS60rShMqaCSGCDhdgtiauoTIvWRH00VfmGpu2Jh2DxzPI0ki5
	 3Kw3gvHN6hr0/HkyaczumZcQodz39vd2c0V46qCHBXkFzcW7+Xmzx4CIhD0Sq5XLxu
	 GvwdvJHPmOmlusXQp3dWTVP3D/EuEVdyaHGmzDV6z7+a0Qp5ZoUHHHFwEUamGX9BY2
	 g4Rv+W4jQIiyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] liveupdate: luo_file: Add documentation for
 dependencies
To: "Mike Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Alexander
 Graf" <graf@amazon.com>
Cc: tarunsahu@google.com, "open list" <linux-kernel@vger.kernel.org>, "David
 Matlack" <dmatlack@google.com>, kexec@lists.infradead.org,
 =?utf-8?b?b3BlbiBsaXN0OktFWEVDIEhBTkRPVkVSIChLSE8p?= <linux-mm@kvack.org>
In-Reply-To: <20260910173659.1945246-2-skhawaja@google.com>
References: <20260910173659.1945246-1-skhawaja@google.com>
 <20260910173659.1945246-2-skhawaja@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:38:33 +0000
Message-Id: <20260910173834.16D831F000FF@smtp.kernel.org>
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

> Add documentation for dependencies between FDs preserved by file
> handlers. This supplements the previously added
> liveupdate_get_token_outgoing() and liveupdate_get_file_incoming()
> internal APIs to allow file handlers to resolve dependencies.
>=20
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910173659.1945=
246-2-skhawaja@google.com?part=3D1


