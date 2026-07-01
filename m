Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A0CC43458
	for <kexec@archiver.kernel.org>; Wed,  1 Jul 2026 10:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8CCY7OYpqxpsp92eM772a+zVPwSSFAuN282U7gVioZw=; b=aa7jJnVzfp/l96NVik7LlAXQTO
	zVO42zHZ6SiIQtrgHNI69DwRRIjmt35A8e6KGx3WMrmN3eSh0EWVh05sOFB3TdgLSAbLL4DXFf7aQ
	JKBxQ4Ndmlpcs2/DTFwvlVXbNsZYblSuyufFoP8A3DnXnNNoh9F7FOT8dxiDpd28U3K2Ezq5LK8+m
	F2j6uEJhOFIIcKcrd/EtOw6IvTYSrQtibNYcjGJp/KGU0Jkbg8mE3jnSt0BuQNlWqsTIOV3NtYY2e
	ANKJ9yQwuJNA8d5FysrmpltnQW7d4Oy0Rb7KZjGgGdlA1ICta1+FBRQSByBeDcO9EJvlEF/Bu/nSG
	hdt+GquQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weroX-00000001H0s-2rxp;
	Wed, 01 Jul 2026 10:05:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weroT-00000001H0c-3e6q
	for kexec@lists.infradead.org;
	Wed, 01 Jul 2026 10:05:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B28260138;
	Wed,  1 Jul 2026 10:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA8D1F000E9;
	Wed,  1 Jul 2026 10:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782900300;
	bh=8CCY7OYpqxpsp92eM772a+zVPwSSFAuN282U7gVioZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=niplvckwsPi9dDsHvK3vnDW0tNxiBlv64bTr/vg+1rBF2pNsqptrN1yR2Vh+AKgnt
	 IO8zLQLn1eoP2YBVXFJ/L3YNxgivsjRkI5cE0piCOzrdi/ooeyk0jne2yPGVnl7DyV
	 OmBGh2sBwKbFRwzmV1FcIeVbI1VzPRmskLZaAqJaKAwYjbJQS6JCwCFMquPgBX8rCN
	 XC2CRvoBMHnkTCzUcMPIN+WivvssaQ72ISDdU4rmUMTzdJPv5cVDV9mjYOcjK4uYYA
	 vyte2en6U4PFRvT0gE/fu06OOAgIjz9WZakt6UhdcoElEovnxu1PVwh0rBvkiuYO/n
	 jsIIWk7D4f62A==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Thomas Huth <thuth@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260619160654.75980-1-thuth@redhat.com>
References: <20260619160654.75980-1-thuth@redhat.com>
Subject: Re: [PATCH] kexec: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 header file
Message-Id: <178290029504.1271197.2576579399755177150.b4-ty@b4>
Date: Wed, 01 Jul 2026 13:04:55 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, 19 Jun 2026 18:06:54 +0200, Thomas Huth wrote:
> kexec: Replace __ASSEMBLY__ with __ASSEMBLER__ in header file

Applied to kexec-misc branch of liveupdate/linux.git tree, thanks!

[1/1] kexec: Replace __ASSEMBLY__ with __ASSEMBLER__ in header file
      commit: 6a673b6c419a5b5bf7457f33b80a77f842057066

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-misc

--
Sincerely yours,
Mike.



