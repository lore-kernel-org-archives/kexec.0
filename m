Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE74C88E7C
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yC9dNYMx8a3aPFHGUz1eG+4PftVW8uXalOORr96sP88=; b=ldaL5AtDLCCJpAJ1oBuPqVqbAK
	imTAqvdSpZMCHc4k3dY6ShXPAHSQupZn+FMSBTFI3FBRIAn4Gmo05oSqpF3U3SavLmFHl4XUShC6Q
	1A0RKwK2QrN0U79fPFTztReEPxcxgEavQJ6gSf3bLGPZ72RdZFppK3fNPKSxU75eVS5qqkeluhw0z
	WZ6vcQqgIw0h4LRad8J35adQD8w6oKfQ7NGmW3cxfy9N11EnsvjtfXidy8UUBBQsTePKvaaRWhXR3
	iRn9z4CpHxaVCVhgK5SNttyX8XDoBLnEsX9G3b9zr+p3ufjDa0SJJ4pFajgH6sI/vI7glmFic4a5A
	SJOEGTmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkM1O-0000000CZgi-3os7;
	Mon, 26 Jan 2026 12:48:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkM1M-0000000CZgN-2EeK
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 12:48:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1BF554442E;
	Mon, 26 Jan 2026 12:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCDAC116C6;
	Mon, 26 Jan 2026 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769431723;
	bh=A7DYWrpyfHFVWltF6mJpprzDHTr2ZLlsNkHc14svh3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZImDQmkFknNM/HRBpo4EztcpeaH7C9U7edLdMLwrMUzW5tMc6aD4a4cD9kKPx6KVS
	 yYEVGeBS9+Od1AEmxQNT/EduaKcUqJn48kvyxE2OWJhDsWEen2ms81KLOS9psdMaeD
	 tnuMOZWNRt5DnpznBPLfjh22VmjBSHp67wJKxmhM+wDxbrK6IbraqkfO2TWx1btfHx
	 Q66+YWuUunra8vVBGHbJvO+CMoPWe3yf1aABV68/mwK3zASIx6v2Mzjpj0ed0wz73A
	 aM9/e7Fz8sM5JrGJ2ZRUcNwlr/QRkw9XNSHqTDyVRE/Nt0dMkX3/3kktFEcKn3sSy4
	 VYZeYe+ZOB9Yw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tycho Andersen <tycho@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: fix doc for kho_restore_pages()
In-Reply-To: <20260123190506.1058669-1-tycho@kernel.org> (Tycho Andersen's
	message of "Fri, 23 Jan 2026 12:05:06 -0700")
References: <20260123190506.1058669-1-tycho@kernel.org>
Date: Mon, 26 Jan 2026 13:48:39 +0100
Message-ID: <2vxzms20a6ag.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_044844_610853_6BDDAADC 
X-CRM114-Status: UNSURE (   6.77  )
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

On Fri, Jan 23 2026, Tycho Andersen wrote:

> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
>
> This function returns NULL if kho_restore_page() returns NULL, which
> happens in a couple of corner cases. It never returns an error code.
>
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>

Thanks.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

