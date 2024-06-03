Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CCEC25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pG8PTvTofFzfzbMFazP1Pld/Lni4WRDEGzhONimK3jI=; b=pJgzfnZp6gq/QM
	aVLsBPuObFHc39941bItBNHME/SJ6eqAGAvXfOd43qpLeDrQpxVTPvphS0H4evX5lDGcpVgPvhWlc
	/RKu/gALTggyYt+/lYwbIjetXMsYaXbhwKF9nykEIhGX/n3stL5vrFPn9odmn3OlbrtF7WiMR72XQ
	0W292oj2ncTwc/6bpULXv/DpHpgT7dSu11F7GOyzzaXw78/gLRSIUYc0p3rD8NKnXq2xqjIr9g56O
	1CL9uLQYjY1CqR5XJWcnOGPHpiVLpYlyFSvRkhD9RZfJzM5eoNyGzzPDNegZ/Y5B0wk/v+9WhXcNY
	XAijvyoWRmtHOGlg8CVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBzw-0000000HZcX-1dbR;
	Mon, 03 Jun 2024 18:01:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEBzu-0000000HZcB-0NLh
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 18:01:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 671E660DE8;
	Mon,  3 Jun 2024 18:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6CCC2BD10;
	Mon,  3 Jun 2024 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717437687;
	bh=7wbfTvzN1ZGYxMgm7ZA/tR9fMo/2aHMXnL51s275mE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeHcZpkN4zwepuyuMN/cVcQXXrW4X7lsm8bk/i1qf6KEFBcesVZLxx+k/XNH1mSTQ
	 6g9fF6ZRUIJmJ379Lff5V3xeEUVpQcJydVHXCWZfcCiTEOMHKdCeRcznBFffV/s0in
	 iNBaSfub7M16NSQ3EuNwz0wLwmpZ+7AMydDRT+TUpSBVDx42BwxOp/NdzfAC2rr8rg
	 CQqZ9J/i5RhbWj+wn+PLmnS5DhuOOKWs20NyaoXZXPtXuv515s4wxXM3Px3eu+pYsf
	 YTe3wRH86dNDT0aCYc8seWxVOOLJ4LqtoSM5vClTe8Sn/ZqMWIPUxlje+C05LxCX9f
	 xCPtJhf3PYciA==
Date: Mon, 3 Jun 2024 19:01:21 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: amir73il@gmail.com, bhe@redhat.com, clm@fb.com, dhowells@redhat.com,
	dsterba@suse.com, dyoung@redhat.com, jlayton@kernel.org,
	josef@toxicpanda.com, kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu, netfs@lists.linux.dev, vgoyal@redhat.com
Subject: Re: [RESEND PATCH 2/4] fscache: Remove duplicate included header
Message-ID: <20240603180121.GF491852@kernel.org>
References: <20240502212631.110175-2-thorsten.blum@toblux.com>
 <20240526212108.1462-2-thorsten.blum@toblux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240526212108.1462-2-thorsten.blum@toblux.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_110130_200437_1518946D 
X-CRM114-Status: UNSURE (   5.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sun, May 26, 2024 at 11:21:09PM +0200, Thorsten Blum wrote:
> Remove duplicate included header file linux/uio.h
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Simon Horman <horms@kernel.org>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
