Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61F6CD4F47
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zu/LWTizL3SjAuLjTBQJufmfGg+ZRq3DiDPk4KVPVUQ=; b=CMHQhaidg5o+iVBu83yc52KvFa
	nw2yleuOR3t0x5+z8h+Z3LMAr7Cg9CHa7Ff6gyvgq3LYuXOmddIChn2YgHTHBNjLHrvTC1lCrdzG8
	k/+Xel+fijh2pFMsQcorvoOHfBIMQaMK6Hd0w0ciBkLNhJpPGEFepiOTL8WHrxt7XJYHfrxnIU0Rv
	S6IAdhQvRLIAu9vdLRW7xw5eQuYJOL1c6LdyeyXXJyWnRzoCbWEGeQ0UUhNqLXHOktuou2oL8T2zo
	xjQv/yvu/K1WCq12+IdsCJ1h8YvaamdKaCX7lHEMkP4X7wM8hQKgiNjPdrhCFzQgsIr8CS47tKtMP
	p9lyMqkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfQY-0000000D87x-15vj;
	Sun, 17 May 2026 17:37:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfQW-0000000D87Y-1CWu
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:37:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D07CB4166D;
	Sun, 17 May 2026 17:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCC7C2BCB0;
	Sun, 17 May 2026 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039439;
	bh=heISmBIXKjYA/PcXWrm1JL8+liejO4P4u/DbNOAbEhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4Z0tbN2A1OK22DR42hgCLTmeRx4VTbKz4jGtH+Duv3y3zMD8eOlMeywPQbDJigkk
	 44MEeSgbeqd2X9dYLqF0yonVJwYbAwZf/sUhwwJCar3JMyRiy9c8/fvAG19SCVNwrd
	 +tNl+6zcVvLhE4XlYh2Aj7AK9pOCAVHW9CO/nBPNUjIZdwjljqlVr4Q6E2EVUCHaFP
	 6H0Tl7m0pZjaz99wHUTGiWRdcsk01uHOSqHLpiNN342xAYkpxCu3O47oti0ct4ojJz
	 0Sb6x6hX07KDWMSRHD7w+1tkaloJgZQq9UHL4Zb6fWrJz0pepF+M/cgRzx9q4Av3m8
	 H8c0BE05EHC/Q==
Date: Sun, 17 May 2026 20:37:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v2 09/10] selftests/liveupdate: Add stress-sessions kexec
 test
Message-ID: <agn8yJVcdvPw8ZCQ@kernel.org>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-10-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514222628.931312-10-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_103720_350264_20587CC5 
X-CRM114-Status: GOOD (  10.07  )
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

On Thu, May 14, 2026 at 10:26:27PM +0000, Pasha Tatashin wrote:
> Add a new test that creates 2000 LUO sessions before a kexec
> reboot and verifies their presence after the reboot. This ensures
> that the linked-block serialization mechanism works correctly for
> a large number of sessions.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/testing/selftests/liveupdate/Makefile   |   1 +
>  .../liveupdate/luo_stress_sessions.c          | 102 ++++++++++++++++++
>  2 files changed, 103 insertions(+)
>  create mode 100644 tools/testing/selftests/liveupdate/luo_stress_sessions.c

-- 
Sincerely yours,
Mike.

