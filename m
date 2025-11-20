Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB01CF6497
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 01:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3oyM318uH5S1Nn1ZG/gh0i4UmP1BvYgaynzgkilEmmU=; b=CJ3di7h7jnLBm2mWpbLpqf3+vZ
	iXBaEfBILlo52GQLfr6YCnZ/ar30i0Z54SkfSuT+qE2Fz6EghINbjfZIZbFTzMfp8Zc58xuSAVRRY
	bSoRcf1YDI+PtzdkEvuCZj6uq3EG4+SkR6wGx0zGy7ZbUKDiFvVYMl2z7gTXAroaUhErZW1OCOSUr
	jPS1nA7soFHySqq4mmSpNSe/7Xf+5OOuohdXX6sxCNQFQjov6Td1rmYOUrxFQVNgwTUzpZYsfr2LI
	BTCMFTern3VTBtuCnIldiTnNW8vbRMSUGkluME/bcm7OTXB20aPRo843pRjuITeRKKJmka4fngYeB
	gT1E7Izg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLtK3-00000005vbz-2I0y;
	Thu, 20 Nov 2025 01:18:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLtK0-00000005vbg-3GAu
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 01:18:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 99AAB42D75;
	Thu, 20 Nov 2025 01:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D20EC4CEF5;
	Thu, 20 Nov 2025 01:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763601531;
	bh=O7zgRWKMoo8FQsJbNJswAKghVra7cYWb26LJqJOXoU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1zlCzpb7taE9BcvNT/M+eEUDk0sbpOVM3BhGG2zAqUd54Jh01nR78Zel6pPSVjir
	 F8qHnn6slUVPotwcSq6Q/t1Yt1Fe0ItQu6h9TDjowr9Rh4diy7t7SN8GzWwDPXm/10
	 MS7KTcgz5/U0KEr5B0eLnlQmE9eq/AeIfxoYI0OgG6VIMqjWCG7kU2r0EbXTn2FTrD
	 BFrun0KNQCmSl6TP5402DRyByH0AZDv8WNYa+r3XQBOSYuJVGZb9M8NYScbCR0q0tH
	 sFiKAxq7nCznFFSiznA4bcxBlrUoAByViTpYFOfsaXy7RWhsmZ5P3ycTKGJ8wIAGj7
	 iwkJ9YeyEDD9g==
From: SeongJae Park <sj@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kerneel.org>
Subject: Re: [PATCH] test_kho: always print restore status
Date: Wed, 19 Nov 2025 17:18:48 -0800
Message-ID: <20251120011849.74672-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118181046.23321-1-pratyush@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_171852_837795_97AB8F46 
X-CRM114-Status: UNSURE (   6.14  )
X-CRM114-Notice: Please train this message.
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

On Tue, 18 Nov 2025 19:10:45 +0100 Pratyush Yadav <pratyush@kernel.org> wrote:

> Currently the KHO test only prints a message on success, and remains
> silent on failure. This makes it difficult to notice a failing test. A
> failing test is usually more interesting than a successful one.
> 
> Always print the test status after attempting restore.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Acked-by: SeongJae Park <sj@kerneel.org>


Thanks,
SJ

[...]

