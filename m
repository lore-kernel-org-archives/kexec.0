Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B58ECD4F47
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IWBCWLK4YOKW66OmMF+gPXIJouaI8UPNNLHz8oyf5m4=; b=nSjOr2yuxqr22zaPc0wSGposaH
	ppQdok7w964rbFM7BI5QhXWPdD8U1j1U6W7xFS912OFqOHlkYHr20u5Z0xsv1Thh0q5P17hBmel8q
	lFrcpRcFxZf3M6XjNsQe3oClqYHLqA80N++JBs81Lo86eMcg/oSRhZcJggpiQ8Sp2pnTlhuVoy2nX
	+rE8mdwwz0tzWnQ1wG2fX79Bs+zr5P/PwronXbw7xBddOwKJiPig8rGmIjf6+9wnWZMF6e2Lyxy+H
	tVwMAQmeBwvBkbW152k5GmaZFVw90I90o/Tit6x7HonTHKaVj/JAS3CSOE3QJvr+x05/S2WuODFhY
	ZTIGDx1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfNR-0000000D7q8-3KNd;
	Sun, 17 May 2026 17:34:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfNP-0000000D7pU-1i2n
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:34:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 08C5142A3C;
	Sun, 17 May 2026 17:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CC3C2BCB0;
	Sun, 17 May 2026 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039246;
	bh=b1CihbG6Lv3rAko83KCLGmjfW/rZKCyOv9GyH40QTlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZ1GvY8fdnO+l/zGvP4VDMRnDRsgS23EQXBw0Bhc9SCHNm2fQe7oCHrcfFa0Yayt8
	 4KLpNnniSchkf2IFw75iOUdlxhDlHwo1IIpx/7a/KudFTColN2WspHtOZnrvS/UbHN
	 MIxGswkl9C8QFvcc4zHB4n91IvOS45YuDM8TL0EVJbH6u0O1x4aGLtDsaA9VLfniHP
	 0PyAgLzCHJBByLBAs2QRtW1r1z94kc25XwF+iv4PgVhf1p5BT1yJjHpt2O2mOksKSo
	 53r3aUZnlbpowcIbUScvst4A/x4U6s+WapVuJwS8oLIrkSq0K/0YtK9/WVbPs4gjPA
	 dPI8qsdP8mfxw==
Date: Sun, 17 May 2026 20:33:59 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v2 07/10] liveupdate: Remove limit on the number of files
 per session
Message-ID: <agn8B_OIH1fQjwa5@kernel.org>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-8-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514222628.931312-8-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_103407_466232_10B3C759 
X-CRM114-Status: UNSURE (   9.98  )
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

On Thu, May 14, 2026 at 10:26:25PM +0000, Pasha Tatashin wrote:
> To remove the fixed limit on the number of preserved files per session,
> transition the file metadata serialization from a single contiguous
> memory block to a chain of linked blocks.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kho/abi/luo.h      |  13 +--
>  kernel/liveupdate/luo_file.c     | 142 +++++++++++++++----------------
>  kernel/liveupdate/luo_internal.h |   5 +-
>  3 files changed, 77 insertions(+), 83 deletions(-)

-- 
Sincerely yours,
Mike.

