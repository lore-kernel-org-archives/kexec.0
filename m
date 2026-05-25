Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D7FCD5BB1
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OtJlsoM2fF6Cnpl17HukfO1fqAnQBAvmo87VBXGoBmo=; b=2UFSZMLX534k1QV0HUPGTK9e0F
	4LsRg0kP1cQq9Aqm0a6MjJZ6yE1yw5+vYsU1oy1vGLQ/bPekmzMVrf2fuwiaPI7JLH26ZUZLFzouJ
	OnAjix3IKSbpxPSZbM/L8OJi8LNLjP39piYWhMjrcX/3/qICqE6OjubL+w8s10wZ0c2oqibE7m2rt
	V/AWazH7jssL06fBliB5RLDAL3M0jtjDU/AskisEghb8ATBrUszqnS4Lsq7e6VA44AngDmBd9yfnV
	ntpRonXiWwGlzN5XI/o/g5Ep3H3jLNK7IhUeec1BkPaG6eaVdARAuAAXNVlrKHsOHBJKi95lSio6T
	cRlB5pDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXGK-0000000HWmo-0voD;
	Mon, 25 May 2026 15:30:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXGI-0000000HWmb-2oAv
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 15:30:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 140F3600AB;
	Mon, 25 May 2026 15:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B50B1F000E9;
	Mon, 25 May 2026 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723037;
	bh=OtJlsoM2fF6Cnpl17HukfO1fqAnQBAvmo87VBXGoBmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=S415AHNc03IacdvQbnISEPk2z1abb4XVpEac+IYMKNL9F1T65+bfcN7/vL7fDcTGs
	 k1Xo6TYD8kyRb+MZZ3ENaTNByGpWEMCVtiTRgVFpKqGzqgqNQ9xtVnHXPClP9EXaPb
	 PECYEHpyJ0oY5f5i58xKCWrexuNtdvWil+ULjWJky+EIZAFDD9KzhG6ukX2rHZdAUo
	 5gR4E1/5hHfaq6mcMKV5dynarDuH78p69AqniiNyE+bVzTOR/s0fGUp5yKAX4ED7Eg
	 dZ511PZk/USgwGcq3z4JmYrxjbQgP0Mg+QR2tQ3utqOU8kUjgz5FZuHPp5FCHexA66
	 w9vJIQ8e/3Plg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Yifei Chu <yifeichu24@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  linux-kernel@vger.kernel.org,  Pratyush Yadav
 <pratyush@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Alexander Graf <graf@amazon.com>,  linux-mm@kvack.org,
  kexec@lists.infradead.org
Subject: Re: [BUG] liveupdate/memfd: duplicate memfd preserve restores same
 KHO folio twice
In-Reply-To: <CAPJnbg+nrOfyYGaX7rPP1pQunzuLb9QXVbi_cnBhj8NoiXjM5g@mail.gmail.com>
	(Yifei Chu's message of "Sun, 24 May 2026 10:44:40 -0400")
References: <CAPJnbg+nrOfyYGaX7rPP1pQunzuLb9QXVbi_cnBhj8NoiXjM5g@mail.gmail.com>
Date: Mon, 25 May 2026 17:30:34 +0200
Message-ID: <2vxzfr3f7bhh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Sun, May 24 2026, Yifei Chu wrote:

> Hello,
>
> Short version: I found that the same memfd can be preserved more than once in a single liveupdate session under different
> tokens. After kexec, those tokens can both refer to the same preserved KHO folio, and the second restore path hits
> kho_restore_page(). With panic_on_warn=1, this is a reproducible panic.

Pasha fixed this with 00d0b372374f ("liveupdate: prevent double
management of files"). It landed in v7.1-rc1.

Since you seem to be using 7.0.9, please port this patch to the 7.0.y
series and try again. If this fixes the problem, please send it to
stable@vger.kernel.org so it can be included in the 7.0.y series.

-- 
Regards,
Pratyush Yadav

