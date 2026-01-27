Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD15D2F036
	for <kexec@archiver.kernel.org>; Tue, 27 Jan 2026 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t599xbmZE2GB13LKvdMLpDhqpSryEGxxihUq+rs7ENk=; b=m9BdMYtNTH3VBup+oN2DAqratc
	CSNdf9rHlPD65CzomqXLQNrapyc/jX8b+BtJJ4iyU5fnNiV0rlyLoGIfIgKYMx1ztzqLpTtwfAhgl
	T797Q6YKHCsAZQNbCITnW2a+DxqiFbxjriNEAMEhWHncYVrMfTYurDCq5FSUHTMtkHobaUcZvRBYF
	EJ20mNqx7DYw5scX5Rf3dclQPPcu6bGuInsN8FhXeeeKESSClHzSXFJid8EO4GixNak1zscRFIKDM
	I1wFyj2LxZn/r3wIYDR1V/dIZ/gDL3xsktUknuHztDt/ZGfmXM4s2oFdfixcKgk3hZhvCo2ZRCT5d
	0c+OAvFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkHs-0000000EShG-0jYZ;
	Tue, 27 Jan 2026 14:43:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkkHo-0000000ESdQ-3sRV
	for kexec@lists.infradead.org;
	Tue, 27 Jan 2026 14:43:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0271960133;
	Tue, 27 Jan 2026 14:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0350C2BC86;
	Tue, 27 Jan 2026 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524999;
	bh=ZGQYIyfjcPJn4+omCcIuFsQUbHXUEiUGwOQtBXIp2c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTI7IY1wCiHRVzID0jaZeAUCCEVb2t5bMxEB+keEfYqAeKCU6tjToAwpbqp94zCgt
	 ZOi/3R6PXbhc3Diq0i4K+Qqlfpf9xl6zkkQ8yPUjn2ut+K1KUDK8k5gznF/pstw0kq
	 YmjMTarMzmoPa3CYXoFHK1Od2wuANFJwZUVBRXSJzjqXe5hlIMHmVvnWDQjLaCd/5g
	 a6040u2uwRYXXHq51ZVf9BHX8tn1P7uOQ/0PhBuxFt9m6MoAqNd4ttqYHXUrLItStO
	 8gR854yvXHWPSMhGI4voNwPZXUZcyqOjZfVn7BmzvR3bV302jYavlkgViFN9lQ5Yss
	 vQwxlS4AkL6wg==
Date: Tue, 27 Jan 2026 16:43:06 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com,
	riel@surriel.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v6 2/4] kho: rename fdt parameter to blob in
 kho_add/remove_subtree()
Message-ID: <aXjO-jQ2_pzVcp9o@kernel.org>
References: <20260127-kho-v6-0-56f9396681c2@debian.org>
 <20260127-kho-v6-2-56f9396681c2@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-kho-v6-2-56f9396681c2@debian.org>
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

On Tue, Jan 27, 2026 at 06:37:37AM -0800, Breno Leitao wrote:
> Since kho_add_subtree() now accepts arbitrary data blobs (not just
> FDTs), rename the parameter from 'fdt' to 'blob' to better reflect
> its purpose. Apply the same rename to kho_remove_subtree() for
> consistency.
> 
> Also rename kho_debugfs_fdt_add() and kho_debugfs_fdt_remove() to
> kho_debugfs_blob_add() and kho_debugfs_blob_remove() respectively,
> with the same parameter rename from 'fdt' to 'blob'.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

