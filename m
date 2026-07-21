Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BE3C44529
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 10:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G9KptbPfnIgk2bUb5Qj1IQpjzcDG7GjvoAGyCyRjQo8=; b=TPCUNTDn/MJ+boScOsFyyrbIlN
	Je1AZWaXC5f6a+3Zvae55gbQAfeL63fZQ6iCPuvMQVc6oO7cWNeGiEmTQ5Zx++qAB+VVfok++wte6
	qK8GQUrT7YQFUPKO0aCoBIsyIJd9+eMid5MMigpHiHfFE4zFcrUqOAooDgraKJpqSRvcbZlDhBp7y
	YSZrq+i7nLWnO/JkZu0N6WuIMJmAFdnHNbYak2RHcieYY7l79XS8RRiYqn4krVtdpbv22G0txTQSR
	lu/7y5pgou6xymt+Yx1xXEZnywIZrGP6H4gc8dqA7dOjckU6hQhWvm9XLhd6Y/wX24gTLakJsyq4S
	PlQye8gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm7YA-000000095pB-3cwK;
	Tue, 21 Jul 2026 10:18:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm7Y9-000000095oW-3Yna
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 10:18:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2649760A95;
	Tue, 21 Jul 2026 10:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EBA1F00A3A;
	Tue, 21 Jul 2026 10:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629088;
	bh=G9KptbPfnIgk2bUb5Qj1IQpjzcDG7GjvoAGyCyRjQo8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oY/8CdIMianL5NblgYWpWiFUahwsegpJQhFwXg6BtToG1IzacIHXoqtYGefB0IRfI
	 49RD764ijYJMa7BUsqWpsuswZJOk1UxbEiyxLITx4l3MhOcBVeElMa6tzDM26/HA4J
	 5gtGcGEY1KHkHCbCKLLHLztDhsmdJLEXvJqL4HE6WEIaKVlesh3gg6HQznjOWWameg
	 D13kINwDITXDS28jEEAthAwYnAPxJFxEedBLUsCTN5lzapJSeXcEmqNbCV053UbGWT
	 3HRA7sQDvhDIagbU1OcbQeBIl9FgSI7xl4AWk/xqoWHIyEdm25vBu/a8j8NbquORDD
	 gUO8l1sU6Nztg==
From: Mike Rapoport <rppt@kernel.org>
To: pasha.tatashin@soleen.com, pratyush@kernel.org, 
 Vipin Sharma <vipinsh@google.com>
Cc: tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
 dmatlack@google.com, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-kselftest@vger.kernel.org
In-Reply-To: <20260720203202.1964557-1-vipinsh@google.com>
References: <20260720203202.1964557-1-vipinsh@google.com>
Subject: Re: [PATCH v4 0/2] Make liveupdate selftests library
Message-Id: <178462907906.500652.4199471528336671016.b4-ty@b4>
Date: Tue, 21 Jul 2026 13:17:59 +0300
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

On Mon, 20 Jul 2026 13:32:00 -0700, Vipin Sharma wrote:
> Make liveupdate selftests library
> 
> Hello,
> 
> This is v4 series of refactoring liveupdate selftests as a library. It
> exposes common liveupdate ioctls as a library which can be used by other
> selftests like VFIO and IOMMU.
> 
> [...]

Applied to selftests-lib branch of liveupdate/linux.git tree, thanks!

[1/2] selftests/liveupdate: Use luo_test_utils.c for liveupdate ioctl APIs
      commit: c5555d4777e3bb80b1b4b25bd678085e22a02d08
[2/2] selftests/liveupdate: Move luo_test_utils.* into a reusable library
      commit: a19aa15b814d0b824b4af8718568e69397fc2e95

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: selftests-lib

--
Sincerely yours,
Mike.



