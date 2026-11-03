Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEBC606A32D
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zu5KgGHk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kz4K6JZL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=o/fdt424hIU68uAYJONXv1npbcycyDxRVgKexRLZ6GQ=; b=zu5KgGHkn0THWg
	5Fc7Z7jG8dVgnRLRuoMy4KjRolDa7oaeysxm46eNor9bgdKEjowSwajXSuK4Vf4Qxjv+wpti0JtvH
	VmwU9ZevXHmzTDpbKFKjOv+TmarTQoDuc7emqQ5vDvua53llG2HzfwLzqTT++8H56WhwZ61ODHRHu
	NJ9zSA86dgLDbst7IfMkuAcoXbvtxIkj+pmHwZ3dcfswDuIoRDHMVPoy+EENLpdJWYY2c7Yn4OQTt
	MFHnJtuuNiVbq5gcNrH5IKAIbVBG+AB3KETxS7pGRdV3k6Uj6GzVCmcZC0u5hsIBEuq6s3AParMp5
	gko8284tPGTgGtguP7XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJH6-00000003Qpt-2pKG;
	Tue, 03 Nov 2026 18:30:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJH5-00000003Qpn-0edN
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 18:30:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B403343281;
	Tue,  3 Nov 2026 18:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43BB1F000C1;
	Tue,  3 Nov 2026 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730622;
	bh=o/fdt424hIU68uAYJONXv1npbcycyDxRVgKexRLZ6GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kz4K6JZLVW9TKnN76d6D3OuUrgzUrK9/fEb1e0p3TxSKIHbz9YDtGtsOu4Ksf/ZpK
	 kD9MIMNtYaY78h8abOFdpaEUU0XC9wQdOyjbmJutHgEb/Cza2BNZeUzCVbvAG1jSPB
	 I5wQlgz3ORyE2naRjKjRA34AgZhiIFksIHnmvxbho49MKRY1F82rzjl7YuNhxLte71
	 MIxtjfCMlYruQm+S8tJB6aMPvuWiiZE3vZ4n7B0/c4UBlqcFcfiJAMl8tEdWFZ98Wf
	 0oFJC2ltiQ7mPt5M+4d57iM9NA4ZC43W3kP92E0Cyo8yF5Y5AedKjVl3n0qAxdRPP0
	 ODC4LrgGrXN7g==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: check for duplicate session before growing block set
Date: Tue,  3 Nov 2026 20:30:15 +0200
Message-ID: <179373060810.1731986.15227244276856998447.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103153928.716753-1-christian.aurichzm@gmail.com>
References: <20261103153928.716753-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Tue, 03 Nov 2026 12:39:28 -0300, Christian Aurich Zanettini Martins wrote:
> luo_session_insert() grows the outgoing block set before checking for a
> duplicate session name. On -EEXIST the new block stays in the set.
> 
> If the session count is an exact multiple of the per-block capacity (51
> with 4K pages), that block stays empty. It is serialized with count 0,
> which kho_block_set_restore() rejects in the next kernel:
> 
> [...]

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: check for duplicate session before growing block set
      commit: 7d4282ec2d3bfd5e7959bbd2663936a29c45f609

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.


