Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFB5C4345F
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 03:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RRVgrUn6ari5BU2h/aA9y4C4vRekZ8by3PRTUnmzn50=; b=FilMEN1bonyp5I
	dlQiZcTtmpxJp2c9hxh2rtt7C7cZkbMbki05ljPvfoDgTSM2m2m1en1qXGHn5qnv+gm9B9Ojds3LS
	POtkvi2Msd39tuZ0pL3K8RTzQDQo1McXrnMVTI9M8XZDxz4j14mOucAoCSN6yjLTyL8hjuzfSimQN
	zxF7dqRFaf78N4eshiVbmxpIwU3es3BMJxb+CL2fFuheVDAYuvphi92zbkVkKOAKh0qlHCcuFX3ZD
	g4ZV8XfTVkbsyFpNboNDzYOUHHIhqfYzg6jaXapalZTM6EkPQhU2sVKDmNj0yQUSfJO74yjzjeBrL
	HMk1Pn6LfkI8rqmhWReA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzpXM-00000006mas-2ZfE;
	Thu, 25 Apr 2024 03:12:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzpXK-00000006mZz-0wx2;
	Thu, 25 Apr 2024 03:12:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ABCB261D28;
	Thu, 25 Apr 2024 03:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C57C113CD;
	Thu, 25 Apr 2024 03:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014756;
	bh=Cc9/KJ14ILnwNdU8czLRH7creacZ14o3hne1jmTaNs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PspTijnPTb4cLwKaUXaBK6lgKqrykqW7TnXryDjg7qy1V4DjZ9qYPfEzdMwJcLXmE
	 2q4vN4nwJllD1z/pH7aACsx2p2ofCITa183q4xZiAclRBaq/82Q7A/KwffAzVOELei
	 BATUW6SiIq4LeUt/sDYn/hnGKl2shhXeP1rwhzi0rZHTU/OxLjZRFcQA8QACF8kBTq
	 Md3p5a2MNJIshoUuU+UOn1xH4LNXomCzxGby8JGUI0mSu2HkcgWhSAkP5pU+L9gZk0
	 nFvpPG5wZraQmtC6JOcQTZn622/SbjwBkjxqFODHiN0ijyqtZ768dGuDQszSMnLkI8
	 ayXyd+53H5Hzw==
Date: Wed, 24 Apr 2024 20:12:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Joel Granados
 <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>, Eric Dumazet
 <edumazet@google.com>, Dave Chinner <david@fromorbit.com>,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org,
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Subject: Re: [PATCH v3 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <20240424201234.3cc2b509@kernel.org>
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_201238_332342_AF3624AF 
X-CRM114-Status: UNSURE (   5.34  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMyBBcHIgMjAyNCAwOTo1NDozNSArMDIwMCBUaG9tYXMgV2Vpw59zY2h1aCB3cm90
ZToKPiBUaGUgc2VyaWVzIHdhcyBzcGxpdCBmcm9tIG15IGxhcmdlciBzZXJpZXMgc3lzY3RsLWNv
bnN0IHNlcmllcyBbMF0uCj4gSXQgb25seSBmb2N1c3NlcyBvbiB0aGUgcHJvY19oYW5kbGVycyBi
dXQgaXMgYW4gaW1wb3J0YW50IHN0ZXAgdG8gYmUKPiBhYmxlIHRvIG1vdmUgYWxsIHN0YXRpYyBk
ZWZpbml0aW9ucyBvZiBjdGxfdGFibGUgaW50byAucm9kYXRhLgoKU3BsaXQgdGhpcyBwZXIgc3Vi
c3lzdGVtLCBwbGVhc2UuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
