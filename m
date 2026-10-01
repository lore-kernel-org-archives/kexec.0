Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFC2CA5FD2
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0qq8oCV2BwBfJa/uaAFfiCThhaiEr4Wxr9Goqf3oQeo=; b=rMWXe+AJtrd/y2p5Axl+jZ13g7
	/lX6+GnbOu0DI0/ok69J2KYXSqNCASx8Ux0QdwTPUsCN4rMuiSzHs0wSOEDDhkvCK6AAQzdWIWaK4
	eDmpB/q6wzHhwiqraWouKdm99sGy8Akw6lSd7d3dTyDIMYy5JuJ0eDigIjkdbdLcnjCeN32JJbwn3
	2aPoRRmyjyXzQJuWoIjxXT2DMF2bS3izsbfF5xH/9cvRiq6SZo9LsWXOfABV2MwJQ849nqCuRN8qx
	1xQiAYW106w+o1r4tsVZYigZrduXqZq4uaZDZ5q013p6+OabCdRXAKVkvMdJkqGoLnNbX6fp7lUlP
	QywAMhxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCGpW-00000009EWb-0DUf;
	Thu, 01 Oct 2026 13:28:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCGpT-00000009EWJ-3gZj
	for kexec@lists.infradead.org;
	Thu, 01 Oct 2026 13:28:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CECF6021D;
	Thu,  1 Oct 2026 13:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D501F000FF;
	Thu,  1 Oct 2026 13:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790861286;
	bh=0qq8oCV2BwBfJa/uaAFfiCThhaiEr4Wxr9Goqf3oQeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ilOfVBdgPzPbenny4hzW1i6fVi6K/wirHM3QC9Xi0TBzGdIkdP1Ca2F4x9tcgIH1Q
	 n1IGd3S4yQXoImH8d26P9hFoqUC2X6TDO5wWCW7GObGUUtCGHAH8I255t9d46CMAV9
	 4Vj4JQHWbK0t3Eaifb2df4oR5rb85E5hGHcvb1b3v6JwN8d5l437S0YM4uqdnRPbDY
	 0VC7Sh1pSGOiYiJfUhPr/zUtjMyNJUaV5ZOwWpgSXtgoWJBgubxIjEErLLgdGI/TtB
	 /mtmPmmcdqi6ALgjA9Ki2i/bjOMMYsvIayCPfVIiwyndVuEMHBkAJgJOFqdo/itaVA
	 GQgoP9NxM5hLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] kexec: Add helper to report an active kexec
 reboot
To: "Mike Rapoport" <rppt@kernel.org>, "Shradha Gupta" <shradhagupta@linux.microsoft.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Baoquan He" <baoquan.he@linux.dev>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Kees Cook" <kees@kernel.org>, "Mark Brown" <broonie@kernel.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261001132147.1703600-1-shradhagupta@linux.microsoft.com>
References: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
 <20261001132147.1703600-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:28:06 +0000
Message-Id: <20261001132806.91D501F000FF@smtp.kernel.org>
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

> A shutdown callback in a loadable module may need to distinguish a
> kexec reboot from a normal restart, halt, or poweroff. The Hyper-V
> VMBus driver needs this distinction when moving its kexec cleanup into
> a common syscore shutdown callback.
>=20
> Add kexec_is_in_progress() and export it to GPL modules so the callback
> can remain guarded when VMBus is built as a module. Provide a false
> inline implementation when CONFIG_KEXEC_CORE is disabled.
>=20
> The helper reports only the normal kexec reboot path. Crash kexec and
> preserve-context kexec do not set this state.
>=20
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001132128.1703=
511-1-shradhagupta@linux.microsoft.com?part=3D1


