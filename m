Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE5EC44501
	for <kexec@archiver.kernel.org>; Mon, 13 Jul 2026 07:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U5wXgd3TCFVvCmRsbtbFEp0MU1fI5uN5hdvw80ROxQs=; b=FtCc9FGQ6JY+iKZVutnoOyBupb
	mT6K31WxTChothqNrBYY5MzcmP6Mxky/6XCy5qD3W8YOYSNkIr1G6RNnwcRCceR5CidOICrisGQCp
	yLeD1YVI5+6WuLke9KR9NdMJIb57oMtCnGGwzKQk5tKPvNyZfhMgKdX0XUFsnfmRhL+iu7290gMia
	2FZBHxf4/I/0zrn6n0zVoyrJjguP30z5kZFe2wAForzRqJEAgrrvJiOfJw4/ffytkqO+sj9EGedm9
	nUVxExUfxMrIHXxpA0h0UIopm1OwK8BQC+u3SNSTQpBIJaUGG98w5usw38YV9YX7Pq5+nlrvY2Kox
	ksZM4IOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAkX-00000008Kok-1o9t;
	Mon, 13 Jul 2026 07:06:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAkU-00000008KoU-0Tbk
	for kexec@lists.infradead.org;
	Mon, 13 Jul 2026 07:06:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F09E600AA;
	Mon, 13 Jul 2026 07:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A6B1F000E9;
	Mon, 13 Jul 2026 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783926401;
	bh=U5wXgd3TCFVvCmRsbtbFEp0MU1fI5uN5hdvw80ROxQs=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=l8QMFcB0TkmGHnti/h9nkje9pCXe616ZCsmXIHYM9K4sVxJFKpdDxs0wBHvYU0xnc
	 O7DPWoPkeATfVT6tBEyM8j8kdv+D7Eq3lbOSA9oOYB0j+MANkUjr2dp87aFROMWCn4
	 hbocxQ6fPMvUx5so4XyF+ZPqIa6Rr67se4lWAHNTYxPfxxZaQ5In9JgSZhrnxsDPFR
	 4eDClKBS+ZbrSTVuNBI19DDFrzMyXoNFXNam2nOpOKlqyLNVGkKiZO26r0FmAXrD2S
	 Mx/933jq5pfqPFfheqw6tpYnITqOxsHtzYKcDiQvirdQklAex1mknQorqZ2KTC3Pdw
	 jugdq1jzClPJA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
 Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
In-Reply-To: <20260704112509.3717884-1-lgs201920130244@gmail.com>
References: <20260704112509.3717884-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH v2] crash_dump: release keyring reference at the
 correct time
Message-Id: <178392639372.255896.15219634537212682820.b4-ty@b4>
Date: Mon, 13 Jul 2026 10:06:33 +0300
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

On Sat, 04 Jul 2026 19:25:09 +0800, Guangshuo Li wrote:
> crash_dump: release keyring reference at the correct time

Applied to kexec-fixes branch of liveupdate/linux.git tree, thanks!

[1/1] crash_dump: release keyring reference at the correct time
      commit: ada2e5a44e99113e08ad9b7b71396c6c572204da

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-fixes

--
Sincerely yours,
Mike.



