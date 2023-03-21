Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49589C6FD20
	for <kexec@archiver.kernel.org>; Tue, 21 Mar 2023 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=odBXRcBk7su7mpIwCe9nCT9N53c280TnE0Q6kHIKxy0=; b=sgibfyr624XYvr
	S7jKDDKP2njzft5zqgu5dFUjVsl2YdjLIhI7dMxGj0QdI5Xq7iKayEbBiYvf7K/H2xcyD0oy0xOvp
	7Da94GwP0ySzg/Y6xxFm7AgcfjpZdEqKGIM73SlWDhu0Aw/aUyolcnLIwaiu3Yt31mTUm8GY3+ZuB
	ncMO7ZzedMsRbkSv4kwRHIe8UfzICvfrLTohK5DMSFF7kqm3XU+bKb7YIUCAGn5TiFVaXU6HrNJJX
	rH747pD24RjzHtrGCOdTibpk3RMtzDYPCjU8n6C8BopNQE85+7nlJg0MRtJjezcwOfJ77NI1gB5Eh
	0pkOqjCnRHUpM6tz4DmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pehP2-00DR29-2Z;
	Tue, 21 Mar 2023 19:12:12 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pehP0-00DR15-0A
	for kexec@lists.infradead.org;
	Tue, 21 Mar 2023 19:12:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D5981B8197C;
	Tue, 21 Mar 2023 19:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73704C433A0;
	Tue, 21 Mar 2023 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679425926;
	bh=3oQnKbOQRcz+1a1mG3KN8MbM5OfK9jqbMpXvELJ/eWE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=D35ZgZ9+4kB2KhmgVMOC/L0qeExzqOyJ7gXm8aGbgBPDa5VA+rQ7+oW7XBrzpTpQQ
	 3otgRIE183mYD2ly4pEihSIA2gMfSQ/StXLKQAC6kLPOkNp4koMoA0uH3sUf/O2ZFE
	 whz+oiACRxJskrkvmtw65FxBxaQw/oZ65u9dZZQJMsy6dGWHHfmEHCZRcxrn+goYay
	 7knCJTILIJQJFWTND+hNqUGhBfp2v5fUikGWY3lQH0MRDAvvZaWqdgjO3JPXzOq9kT
	 Kvfral3XDQ0ADsTCyvR1Co+qVRw8lW2MZgb9T9HkLT/kT6e1YPZRbCtZoxE/FMXECp
	 +Oe6ieVw4fyKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60B89E4F0DA;
	Tue, 21 Mar 2023 19:12:06 +0000 (UTC)
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <2851036.1679417029@warthog.procyon.org.uk>
References: <2851036.1679417029@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <2851036.1679417029@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-fixes-20230321
X-PR-Tracked-Commit-Id: 3584c1dbfffdabf8e3dc1dd25748bb38dd01cd43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2faac9a98f010cf5b342fa89ac489c4586364e6e
Message-Id: <167942592638.7771.15271996800197050832.pr-tracker-bot@kernel.org>
Date: Tue, 21 Mar 2023 19:12:06 +0000
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>, Bharath SM <bharathsm@microsoft.com>, Shyam Prasad N <nspmangalore@gmail.com>, Steve French <smfrench@gmail.com>, Robbie Harwood <rharwood@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, linux-cifs@vger.kernel.org, linux-crypto@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_121210_240433_546D142D 
X-CRM114-Status: UNSURE (   5.99  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The pull request you sent on Tue, 21 Mar 2023 16:43:49 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/keys-fixes-20230321

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2faac9a98f010cf5b342fa89ac489c4586364e6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
