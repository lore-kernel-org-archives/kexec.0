Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ABDCD4F47
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQ51mDNmzYlOwO2RNhKMup+LJn3UvUp1u2hQb0kvOlw=; b=ZYQj0a21gZJQ10akqKNG+HI8PI
	TnSCWl6tgRk6XqsOIv7AdCE6SO+7TeVHmW8EznCMk1sztj4kxTw+wfcdDIqHQMx4JVHO5RBRvkRsE
	MaZZAeTEqLCtySs54nhz4NJM7k1LOkXFLS5wRbRyvpUywEIzBYTavyj+Pj6zz9XuwhFJvtJzSOFwq
	Q4l3nDMXwp5jw98Nk0UFOSeo4R0K/v9NDLngHKkoDKbZ3n/H2rOHt4iCkTuPLygM3J/zBo5WXu9cM
	3Ueq3STsdolsG7qg1GPPfEoB/rzRj3uPCGg0oIk3kCt4FFE+1yuB1cKB/J3BSPklOSd2amBe25s/E
	tjUdlZuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfEq-0000000D6bf-2WnL;
	Sun, 17 May 2026 17:25:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfEo-0000000D6b6-2vFa
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:25:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AF6726020B;
	Sun, 17 May 2026 17:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D36AC2BCB0;
	Sun, 17 May 2026 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779038713;
	bh=dhS9wVv40cgOex3fqEGWAJwNPN0dvGp8u4KcgCsmWV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKvjCb+wKRGA9xiiCNbRlqsxXuUdAB4R1A/U0fGy180AVGpyQhHWCIZyle1QqYBL9
	 X1S8o+7dJztCIkngZZmyOti6FuvshZ5IxQ5HzImT3wBfj05+ljzNuC3yN8at6VCwTJ
	 KVm7QVCGtFvJIHtTdl1t4/qX00JkcdCM3PlpfyfRHJZs+Jw7TjKCGj4yi9aGQlGGZ5
	 OUwk7sXt8f271KeRvmGmzDszytUKK7MgQSQ9U1SCWplSyTYyaU12+Eno9c7ytzXxSf
	 1S4Rb+H9f1eagWaXhLxyfdMBzjCWILZifNyk7j+3D93YalZOE1sEFndj7Rb+9NjWGr
	 gS1NDt/r92Wcw==
Date: Sun, 17 May 2026 20:25:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v2 03/10] liveupdate: Extract luo_session_deserialize_one
 helper
Message-ID: <agn58YPpCkkKFfWA@kernel.org>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514222628.931312-4-pasha.tatashin@soleen.com>
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

On Thu, May 14, 2026 at 10:26:21PM +0000, Pasha Tatashin wrote:
> Extract the logic for deserializing single entries for sessions into
> separate helper functions. In preparation to a linked-block
> serialization for sessions.

It would be nice to mention that this is a pure code movement without
indented changes.
 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_session.c | 62 +++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 26 deletions(-)

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

