Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFA606A326
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wzCtRMSG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B2osoGBB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DbUVBYaOAaZ8N4Yttl9LzlzQUuvFtuX+KuOxQuXrWMY=; b=wzCtRMSGwqG7w0
	DBgkxsG+iNwx8kNTk8BGUTJVO3VBJqfhP7Yk2W5Tr0Fi7sBcAeNc8V0n+Svh1CNxtxQ3kB1bwvl7F
	c+3mTg7p3xxSzaxZW7UWjgN/gczjn8oB+XXqyvbCiGGM2Iv3I4pNy69xz09MTxCkFeLw4HUTG4Qws
	QBwM4B+c4n4nLJfKBTSbK9pzVQ5pZ6AZcnilTBs36OaSTBD1/3NGVWClLA9BoWEFIUlN8mdZa5/2w
	BMPPmKIUaK35cvLeI5waF6cBh+Ix2cIkaDjhwq/jMik/usvZuRRpzGJKvZG30xlAIPeZwG6DJoZ6j
	6dSAK4Y3cEJ8iQjzkDcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzvq-0000000Behr-1lMC;
	Thu, 19 Nov 2026 11:03:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTzvp-0000000BehX-2BaX
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 11:03:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1C96340350;
	Thu, 19 Nov 2026 11:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A866A1F000C4;
	Thu, 19 Nov 2026 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086237;
	bh=DbUVBYaOAaZ8N4Yttl9LzlzQUuvFtuX+KuOxQuXrWMY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=B2osoGBBe7uF8ZbwgVmdo1sn8AqqGcsrxgTxty3Z+7Gbb3d+U684xXU35y+halObR
	 yC9SECXlJe+iYGpGg81eyWdfTSDSJMGqRIaX17m9yhk3Wq+ISjG1q4rxa9Fs1MKwPI
	 4sQugLMQyZUMRvZ1akdf9dG5QQLgv5TQNnif0keBFUyhvhcqGACzZRIwmpfpAgehCv
	 LE44m4hPaO+PPZSE3QCUD5iRmwMWLsnhcsGNxT1DZwcS25qWJFJuxK/1pP+3+8jbxX
	 mxLyREVlSFdK6sVMH1TTITPcC1chHF1mJ12Gj915Lh/urbZdIYPbPGFT579J+25YsM
	 nzuCLdIxjmTyg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 2/7] kho: link outgoing blocks lazily in kho_block
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org, vipinsh@google.com, 
 linux-kernel@vger.kernel.org, corbet@lwn.net, linux-api@vger.kernel.org, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261118212845.2855249-3-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
 <20261118212845.2855249-3-pasha.tatashin@soleen.com>
Date: Thu, 19 Nov 2026 13:03:49 +0200
Message-Id: <179508622989.425130.3752251663949335075.b4-review@b4>
X-Mailer: b4 0.16.1-dev
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> Currently, kho_block_add() links each preallocated block onto the
> serialized chain immediately, even while it is still empty. This
> assumes all preallocated blocks are populated together before the
> chain is referenced by KHO.
> 
> When sessions are serialized incrementally ahead of reboot, extra
> blocks may be preallocated for sessions that have not been serialized
> yet. Keeping those blocks linked leaves empty trailing blocks on the
> KHO chain.
> 
> Keep preallocated outgoing blocks unlinked in kho_block_add() and link
> each block lazily in kho_block_set_it_reserve_entry() when advancing
> into it. Also unlink blocks in kho_block_set_clear() and stop at
> unlinked blocks in kho_block_set_it_read_entry().
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kho_block.c | 38 +++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
> index 0d2a342ef4228..21cee45fa1cc0 100644
> --- a/kernel/liveupdate/kho_block.c
> +++ b/kernel/liveupdate/kho_block.c
> @@ -16,6 +16,11 @@
>   * array of serialized entries. Multiple blocks are linked together via a
>   * physical pointer in the header, forming a linked list that can be easily
>   * traversed in both the current and the next kernel.
> + *
> + * Outgoing blocks preallocated via kho_block_set_grow() remain unlinked until
> + * entries are reserved via kho_block_set_it_reserve_entry(). This allows
> + * entries to be serialized incrementally without exposing empty trailing blocks
> + * on the physical chain.

With the kho-ro preparation dropped, I don't see what the empty linked
blocks break. Every session is serialized in luo_session_serialize() before
kexec, and nblocks always matches ceil(count / entries per block), so by the
time the chain is handed over all the preallocated blocks are populated.

Empty trailing blocks exist only for a short while before reboot and nobody
looks at them. If they did reach the next kernel, kho_block_set_restore()
would refuse them anyway.

It only matters if something reads the chain while sessions are being
serialized, and that's kho-ro. So either describe here what actually goes
wrong without this patch, or move it to the kho-ro series where it's needed.

-- 
Sincerely yours,
Mike.


