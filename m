Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21554C98328
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=crboOxvrJ8lPbqxWIICzX00men9f9+ZB4s2xBH/JEm0=; b=sqd+9/2VjsSd0NUtt2+T16UXk8
	xfYRJfpXmVIlEpbKFQTHyZxjPMhcXpxmaH8Lb+zMxwuPmmHKZv9y5EtDE9J1vHiaQtNKqpmvtrRRk
	QcY3XXvzzZfSkf96KmbsX5E0Zm3cixTZ3GPrlLdUrqVlSi21q1jfTrn0SiNvUjT2tbJU88NCBKaYy
	E855o1py+gMQSlZpuo8nKmF6qxLb57tB3YzoHEtpy6GtgM6EUETAwGD16djsnsLa38L/Iu8yi0zpQ
	cOkWXP1ezsoGqNB4jDYqPjksCzsEMvVxkXDVxvTw2h3TABCV7+vZ3M+aW3tHFVB1iYGVBGQ8/Ubsh
	NMJ2NPjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOj9-0000000FCub-2PvF;
	Sat, 26 Sep 2026 09:29:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOj7-0000000FCty-3N1e
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 09:29:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3339C43E30;
	Sat, 26 Sep 2026 09:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D311F000FF;
	Sat, 26 Sep 2026 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790414989;
	bh=crboOxvrJ8lPbqxWIICzX00men9f9+ZB4s2xBH/JEm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MkJMrAH6xEt8MuQePzaeyrvnwAl+wKF6FcLv8A20eC9plGEce3O1epmIsMmNDn5HW
	 mOCiZkCvwX7EmXeMmedV/azMVpo1Z0VBupX+HLvk/cM9uCAKqndOI26sexDbR3z94W
	 t6B0UgcrCzFGrohptYFe+0OHcoCrqwN7sUdjO/pVmIsU5tLRJpx4CHVOhx3cDZZOqs
	 t3SuWXug9kvVE5w30nBv0l789F6wATP1/VMYOwOsnL8Uaw3KWAVhAnV8OjsoBEBDZu
	 Ktu6dTqAxchupgFxxkLjpzTWIh909uR32z5iQm9JCxn+0Ux3PErPF/OiefFzYOmSN6
	 3uaHrPk7EsRtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] memblock: drop for_each_memblock_type() and open
 code its users
To: "Tarun Sahu" <tarunsahu@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, dmatlack@google.com, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, dev.jain@arm.com, "Pratyush Yadav" <pratyush@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260926092448.4090401-1-tarunsahu@google.com>
References: <20260926092448.4090401-1-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 09:29:48 +0000
Message-Id: <20260926092948.90D311F000FF@smtp.kernel.org>
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

> for_each_memblock_type() always starts the iteration at index 0 and its
> body is a trivial 'for' loop, so it hides very little. It also gets in
> the way of iterating from an arbitrary index, which the next patch
> needs.
>=20
> Remove the macro and open code its three users: memblock_add_range(),
> memblock_isolate_range() and memblock_dump(). While at it, move the
> region pointer into the loop body scope.
>=20
> No functional change.
>=20
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926092448.4090=
401-1-tarunsahu@google.com?part=3D1


