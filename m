Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE44BE7717F
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=seg56wEn4x/gV1V32Q+7/9PzRw2+AhF/OxpGg6C1CVM=; b=glok+N35MViJLjJwiG+nxZo5eq
	1ELov4qNwex3KL4F1+QwCuqaHQrsgjbTsuUZ3SX/l7vq266d4TGa7KiNtvQ4+Yx9oHQNuTlLTV3OJ
	KSTu8n8HWzHXT/ZF9tqrEP2C5Rta2G5ETYN4aKFlg1eUv9RU3xpeLgZLC/NI7FBTSK4lnlU7QkEmp
	508qqtkLgqlrf21nnrwsNHuaCVCuAaMlxovf+aBK1y60dqkPxavGjJJYhYO8zASKEczHhNN3+FXN1
	VGDbVb9aE7tzHVLja9LNIWQ5+70ZWltJetOwD3ePxhL/WBc9wgZjSthWFdPOXDxLpMQWTUVn/Sm9u
	kqtQsbgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM50p-00000003kVj-0HaT;
	Fri, 13 Dec 2024 12:43:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM50m-00000003kVI-2fQt
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 12:43:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C345D5C6C0D;
	Fri, 13 Dec 2024 12:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C219C4CED0;
	Fri, 13 Dec 2024 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734093795;
	bh=pIJ10irMhjIWYyQruv5wNK7V2LnmcQQ+bf0Hx3kjKUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rc1ftK+Ei1KOQsJh/d6gCEy0qgmiUDq+yZQU9jEpkkpeQnUybwdnE6VxYxoMHE9tZ
	 YAnv9iA7NRQwSiI3N5h7c/lcume5e67L5kULfCVRV5CbHWtIfVZ6Bc7hK5Ljno5RxB
	 JCysvdG4avfVZl4GIm8FXXiH/YBeaBUXyflJnCxx95txV/bYesN1hHwscWGVaAtjwz
	 T8CbpfdK08hHFIoopPkc88TFow2R7ginZuUPpwZDQINqETI3eMQF7TzPb5UfX+2lsY
	 CQUaiIeAOxmsfLTTxpwtTBlCQD/qDyHZ6Bi1tiTVCJCUnV5o+090K3yaB7z0dTdOhV
	 1MT+zfjp+TV1A==
Date: Fri, 13 Dec 2024 12:43:13 +0000
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH 2/2] pe-zboot: Truncate the trailing zero if Image is
 signed
Message-ID: <20241213124313.GV2110@kernel.org>
References: <20241206024445.10442-1-piliu@redhat.com>
 <20241206024445.10442-3-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206024445.10442-3-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_044316_714300_023D1664 
X-CRM114-Status: GOOD (  12.61  )
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

On Fri, Dec 06, 2024 at 10:44:43AM +0800, Pingfan Liu wrote:
> *** Issue ***
> In the linux kernel drivers/firmware/efi/libstub/Makefile.zboot, the
> original Image is padded with zero, using the following instruction:
> 	truncate -s $$(hexdump -s16 -n4 -e '"%u"' $<) $@
> 
> Hence pe-zboot.c decomopresses and gets Image plus trailing zeroes.
> 
> These trailing zeroes don't affect loading the original PE file. But
> they do raise an issue during the signature verfication. The root cause is
> that the kernel function:
> 	static int pefile_digest_pe_contents(const void *pebuf, unsigned int pelen,
> 					     struct pefile_context *ctx,
> 					     struct shash_desc *desc)
> treats [pebuf, pebuf+pelen] as valid payload, which includes the
> trailing zeroes. But that is not the truth.
> 
> *** Solution ***
> In pratice, the table of attribute certificates come at the end of a
> PE file. This patch utilizes that fact and truncates at the boundary of the
> certificate table to get the original Image.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> To: kexec@lists.infradead.org

Thanks, applied after addressing some minor spelling issues
in the patch description.

