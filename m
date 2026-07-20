Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF86C44515
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PpKzFRD9cEYof2Fp0aMJb/vwEY/DXfz3K4ZsYykrMKo=; b=0ud5f5bIB+sWcsH0xWQCGjtrco
	SiEmBUUO5RIJc0nNjhP1QnCRDggQKRKJ318yzt/1Xvuj7Wv0XniFZXuS1sR9TcEaT+vWc4QYPZI//
	4bFSE5sj/Xes3mONEByN+Ka3PS3qLWfrOR6g9lfAxwBfPmKfjLX/u1tDmZW4Y9d9z+DTOg26AWFyN
	DAVe15y8KsHEniGBFhoyHa1Yu9Bp69lBXgHlADWi+Vs9E09zdapvsvZtPvU/eArCKP9NyKGefTy2g
	2b5BflMCzwiGQNBnhMLlNhrxaGPQy6QIZWBTlTmA++CQV81O21UwWpq/Njs5dJEZpUxU8z28U/vX/
	WrM+eY5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlihK-000000068AH-026s;
	Mon, 20 Jul 2026 07:45:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlihJ-000000068A9-0jcK
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 07:45:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DB4A3402E7;
	Mon, 20 Jul 2026 07:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB151F000E9;
	Mon, 20 Jul 2026 07:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784533556;
	bh=PpKzFRD9cEYof2Fp0aMJb/vwEY/DXfz3K4ZsYykrMKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LbvIXf8Fv/2iiTcDlm7q1K55UXyE4WrZ8idp7iBdPhBgn8J1PHlFODmmorjFqAR86
	 YiCeT55AS9ZtIe55+fw8vTIQh8AgStnPoGdbtaEVrKomAj36wsa1ntMiZkuM8ts3+z
	 E5ef55N/JWPnvWGPgzTwQvpudJcF3dI9EhMGksGg7s5pUWxFpGxgmE+5bPeW6gFToZ
	 sZ95M3cf7IFffXekvmmvkdKS39zKpDvMMCuFRdzXQDmYZZAdAQVUaNLSl1Ac0DkRDd
	 cJ640V8jiqGyig4SZ4eZH88kXLsdoDzliRL3UuoxL09nhdO57W/+ZYl++ZEfUmtAdn
	 9TIwDXLmugdMw==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, 
 Michal Clapinski <mclapinski@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260717134028.2880508-1-mclapinski@google.com>
References: <20260717134028.2880508-1-mclapinski@google.com>
Subject: Re: [PATCH v2] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
Message-Id: <178453346331.1178000.18393988680596713513.b4-ty@b4>
Date: Mon, 20 Jul 2026 10:44:23 +0300
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

On Fri, 17 Jul 2026 15:40:28 +0200, Michal Clapinski wrote:
> kho: align kho_scratch to MAX_ORDER_NR_PAGES pages

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
      commit: c553c774c9715e1c92c48b342f30d60601693fb4

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.



