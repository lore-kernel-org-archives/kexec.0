Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90853CCF2D4
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f3DLT83umxHx9u9Q0YPGhGlc6CgPavjI2nFWmAA+8Zo=; b=Kq5jdk6tn6tN/oggaho8dH2/4g
	4DVxp87NLWG7v49PKplIVhepkuBATnH3mrI4/x/UosxnBws98VjgB/6D1uNKcEIJs4AAehsuHnrMr
	h/jZP5ELe5JsGEBroz2OpzfPlysUHEaEMJHXf7na2KFuMVMmcNfJ5oUSklJrqnNeNm2aws2hNs58s
	Fw4I6pfCtOFyBLRiiEAf6aKmOKETpXTw0EbN0g/SGbNH0SKfJblX5HfIEm+5Vd2G19S/0VTIdK9In
	DMzeKQ/5CDYY7hB+ii07IUtVh5wG4mz99X2w0PphglrjIpDgpNhh1mPf/ZX98mBKQKnzjEc6B5TgP
	zYKfLz0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxm-00000006SOj-35uX;
	Mon, 19 Oct 2026 02:18:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxl-00000006SNp-28gb
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:18:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9274960DA4;
	Mon, 19 Oct 2026 02:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213561F000C4;
	Mon, 19 Oct 2026 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376336;
	bh=f3DLT83umxHx9u9Q0YPGhGlc6CgPavjI2nFWmAA+8Zo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RLhdXBdOYsf+UwxpFbi77Rw3diyW7MEaSyjVBfNQcxKQFPI3jpFvyLQX7cwVFoSL5
	 +FLwxVpckhRBu/wPOdIGqVtztTH/O9v1z4p4mZGbh4p8fylGd29atMXKpqCh7RuPqF
	 Oxu6lqAWbuyUYwN9W8kIIlzQDb5DiM8yMuDT6JiB2rPJj59v2aJqpj1YgyKHI/MZpi
	 HwJiUUBFzcTIEAARxqzo5UwxURlfdwfsapRaWMbKI9ebv4b4rtdux3hsaj2bYXl1my
	 CFnh8VB50sJoAaSIP4WhSoIeV/zfWvm7dO9TbbmcR6AVXxnoF+AzEKJE3v8CzDaEUa
	 5buc9h/LAX1fw==
Message-ID: <sashiko-outbox-176521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/8] kho: do not modify incoming serialized blocks
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261019021111.990394-5-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
 <20261019021111.990394-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:18:54 +0000
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

> When restoring an incoming block set via kho_block_set_restore(), the
> physical chain of blocks is already linked and bs->head_pa is already
> set. However, kho_block_add() unconditionally rewrites last->ser->next
> and bs->head_pa, and kho_block_set_shrink_one() clears
> new_last->ser->next even when operating on an incoming block set.
>=20
> In the upcoming KHO read-only mode, incoming serialized blocks are
> mapped read-only and must not be modified. Guard the ser->next and
> bs->head_pa updates in kho_block_add() and kho_block_set_shrink_one()
> with !bs->incoming.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019021111.9903=
94-1-pasha.tatashin@soleen.com?part=3D4


