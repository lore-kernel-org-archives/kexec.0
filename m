Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63385E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CotM2SU2a8i8FrULYZwWp0/mPi7doZZEEGMpk41stc4=; b=ztWGbtXXGjGsiz+R90u9f83E7l
	GVVU7JQ4P1YhoYNqsNgZpfTEa2cTu1mC+gxlkemGVxL/cOo38UhbThdNyHyAGJ7mqmUgPwX+sZi9R
	Nuky+KduzjmhjsPMPAQF3AkqAdn3xJbj9nm9/TCCPa9s2FH7nb2keQWB3jHLVfER+gdIhq4YCqE5T
	bGYn1TKYWgVG4J8/f0AUSQplTaKraSHL/+NGunnGLb96s3L+v8Z3koeQRrZIZOXMRkeoXjXgcwr3r
	agKf4Go22fsTAgBv6v9tqxc11TmIjdMuzw7sh39riJJUyp6LSJ62+gSyVvzuabVcflfyRziL0aHTm
	4AhtwZkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM54J-00000003kwl-0CTf;
	Fri, 13 Dec 2024 12:46:55 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM54G-00000003kw8-2p3e
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 12:46:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B5D63A42111;
	Fri, 13 Dec 2024 12:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD5DC4CED4;
	Fri, 13 Dec 2024 12:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734094011;
	bh=ZPJ+9JjOhjVZ0b/pFYHQbFG5K5Pfjcsph7kRAy49iIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBhkZ9bq7oADAASynAg23r26DjQn8GeR9RKJRPU62G7eM4vLqJsSTW8N8R9Zb8k5M
	 LyV5RJiwntKznXR48cHEz6GsUmHmSAF50i2HLYAQikVMuNZ+BC0blMrNjoQFPxpK5v
	 c9sUx+B3kzk5+nk7wTj4HlGt8Lp5XpO28yksqLrEQdA0KqiRN/XbSbCnaXRU11z6hJ
	 2pZMIRg0Yp6V+26kmiIOlPb0NlFFVx5tArZYJDzdW/2opX9lyPP9Vkg6grEO1C3bkH
	 PriiDZrFV1BLyPVvGzWwTfyE3koXs7EXpj6s8Ea5ZE0Pae0s0/WsaU1yevul25s9Zv
	 uotftleMG0yFQ==
Date: Fri, 13 Dec 2024 12:46:48 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: kexec@lists.infradead.org, piliu@redhat.com, dyoung@redhat.com
Subject: Re: [Patch v2 1/2] zstd: Add zstd decompression logic
Message-ID: <20241213124648.GZ2110@kernel.org>
References: <20241212211325.805138-1-jeremy.linton@arm.com>
 <20241212211325.805138-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212211325.805138-2-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_044652_773316_1FBC2FE3 
X-CRM114-Status: GOOD (  10.48  )
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

[Dropped arb@kernel.org: mail.kernel.org refuses to accept my email otherwise]

On Thu, Dec 12, 2024 at 03:13:24PM -0600, Jeremy Linton wrote:
> zstd is becoming a popular zlib replacement because it both tends to
> get a better compression ratio as well performs considerably
> better. As such, zstd is now one of the options that can be used to
> compress the Linux kernel.
> 
> Lets enable it by using a system provided shared library, creating the
> required boilerplate to match the existing zlib/lzma function
> signatures, and creating build options to enable/disable it.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Pingfan Liu <piliu@redhat.com>

Thanks, applied.

