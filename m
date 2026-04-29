Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75046FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vv5ZLTnJl69Hs5zEFdRwqVVHcdiD2hLQSYQ2J3Nv3Ec=; b=w3LelYJb/Bl8z0rInh0hLsVeEQ
	CJX+ilAPQtvff8uxr31KUTz0kQxajr1wh6tdjeefHGT42WaiNKm+FPM/h7Ttwb+on3Lb4M6Hoo+JJ
	D8rK0zgPNBE7g0HewIw62HsglPGPXJpjUWHHZTncigmKOa+X0VAEZK81zHuV9ngY7JTbB8PKcs3jG
	3mSnioAijUL4Qvwgk2AMBPHQcUzBZxFDu5IlZ2gHL/oXASUqLjFflLrpfu57UHGjjo6rDrd5Hthx3
	mk2GoPA5CNowvC5jROLsTTjtNnEzqWOqw4vA5TBYFyJmIaTEGt44olEPd4afHNmdncTHO7MC6QCXb
	NRxAGtqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI5tQ-00000003lIP-3ibD;
	Wed, 29 Apr 2026 14:28:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI5tO-00000003lHe-17Yc
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 14:27:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D68643F4F;
	Wed, 29 Apr 2026 14:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA2EC2BCC4;
	Wed, 29 Apr 2026 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472877;
	bh=kr+IZfpp3YRrfsIWF21skEu3u02zUq6YoI3YRfhgI3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gqYGPDFwCNDHYUkXGP+yilaRCVVBVHP4VGn5n3ZaRst5NHItojb8IqX5R5/3GqtTA
	 v3tSdpWpoCZbCghaQ7UYCe6wC4yQ/ZtcfcrrOTI+gMEOANnc4DVK5y0NSKs2M+h8h2
	 edNJE44qS+/LJd6VuIUBYDyX1+u70JxPPkxC0ZYBENQan4jujvbPAPtPuiHLxbuHc/
	 o5alZpMXtaox29BLyNdqDJ9+D9BwR/s3lE1TpbTyZvlSNgUkScCL9NfZruGdxpN3rR
	 4ecrqfRhgC7wLY2yPxftZOXOoFbj4wvbIVCNm8bTo7OpHsss6pO6U3bxIybzmAQFdV
	 sCRyn16H+sO6w==
From: Pratyush Yadav <pratyush@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org,  linux-mm@kvack.org,  rppt@kernel.org,
  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/4] selftests/liveupdate: add test cases for
 LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
In-Reply-To: <20260423234753.3873095-3-luca.boccassi@gmail.com> (luca
	boccassi's message of "Fri, 24 Apr 2026 00:44:21 +0100")
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
	<20260423234753.3873095-3-luca.boccassi@gmail.com>
Date: Wed, 29 Apr 2026 16:27:54 +0200
Message-ID: <2vxz5x594z9x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_072758_483255_0F3B3487 
X-CRM114-Status: UNSURE (   6.86  )
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

On Fri, Apr 24 2026, luca.boccassi@gmail.com wrote:

> From: Luca Boccassi <luca.boccassi@gmail.com>
>
> Verify that LIVEUPDATE_IOCTL_CREATE_SESSION ioctl which provide a name
> that is an empty string or too long are not allowed.
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

