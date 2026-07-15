Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81553C44508
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 06:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AG0W6G4t+jb8ZbbOPB0Y3uGwaQVF1mwA0gu0fmjokjY=; b=JYmxow1tU9V3VyfTIUwa7NRRes
	Q7ohclZh+lH1ALZoUFWUAU9KbkNCyASkIfRrTEtm2fTvIV0I24I7wKLL8J3aAxx/eY5Z6NFBQQ6R9
	QBKYjmNfeaCua0f7/pxjZ34wnaqrELn9PIDkgtnMahvCS5fQpQrVceJRi6TRFKYNZuVz7z02FDrLj
	1PP+P0DSniCECVwt3tCHuQuZZensUK6U+TfsnARr63lrW+rGv21JbtnBy5dkRLJqaAXOUUbHjInyZ
	WXNJkDAfxh0TkKk9ab9oYuAzlo6RUPYpZKr2UHQ1oM6GQKxNuMnfn7v+sKvQqdA2UN8xUJRu9Lhl7
	jtoXRCng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjtE5-0000000DuqS-3qm9;
	Wed, 15 Jul 2026 06:36:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjtE4-0000000DuqI-3tWC
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 06:36:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 16176600BB;
	Wed, 15 Jul 2026 06:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1B71F000E9;
	Wed, 15 Jul 2026 06:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784097371;
	bh=AG0W6G4t+jb8ZbbOPB0Y3uGwaQVF1mwA0gu0fmjokjY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PCJCwlIXbxx9kPE36YcyQOWLabA6hfef3OQHvGsQIoLJvIWcZD2riK6/13l33DJrc
	 zO+Pywkt7gf3BeLBe/rlbrBFzh+z0cqe1PCl/VALXi5na1v7TrseXPxlsNTM2lX3d1
	 sp+TIDZsnPT8yfKvTh0qIDbJaMw1QvWuQ2bpmqUT/NA6RezDvtNwSGqz+n8AwqIEDz
	 B75r1INV6lvjDhS+BCy0/uXpZcu4jnt0iGtTWx3GxjwPVmkBk3Yz8zJaF/ZavqJDyV
	 dVJsYFoks+MhkpCmE29UZ3AqRmSKgKmPPPLd7kAskrDG19yP694OREIFpEMU4vOwQG
	 BjMD1wrI5P2TA==
From: Mike Rapoport <rppt@kernel.org>
To: pasha.tatashin@soleen.com, pratyush@kernel.org, 
 Hongfu Li <hongfu.li@linux.dev>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hongfu Li <lihongfu@kylinos.cn>
In-Reply-To: <20260714074056.95335-1-hongfu.li@linux.dev>
References: <20260714074056.95335-1-hongfu.li@linux.dev>
Subject: Re: [PATCH] liveupdate: Remove redundant INIT_LIST_HEAD in
 luo_session_alloc
Message-Id: <178409736621.255896.18239853655389189289.b4-ty@b4>
Date: Wed, 15 Jul 2026 09:36:06 +0300
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

On Tue, 14 Jul 2026 15:40:56 +0800, Hongfu Li wrote:
> liveupdate: Remove redundant INIT_LIST_HEAD in luo_session_alloc

Applied to misc branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: Remove redundant INIT_LIST_HEAD in luo_session_alloc
      commit: 4867ab462d8d69e73c239b9a1a98e42a222f17a2

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: misc

--
Sincerely yours,
Mike.



