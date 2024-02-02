Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F72BC47258
	for <kexec@archiver.kernel.org>; Fri,  2 Feb 2024 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JmxAOhY2pYJiWLu0wqinazqr2nDEOM+7df6GWo95zp8=; b=iPPW0KH/mdnJOs
	MW2mMv5KEUXBPbkJAREL0ZA/X9TY/N1iKajbTxcRr+O5YPweLmm363vOnGwCphfIBM1sjMp99JUnG
	a+8MRRRQZd0RfckLv9iWY2zfhrqh0tuTOMT5ESZmRe2C++/6fB3kfUAQrjo+qGhp7fPUIKCxV5KuW
	t14KzxZY+CUvfK8eUDMJZYxZCqXbsF/aMUKM0wRzrnVWec/Bu8OxDKy+t9iovjVgVIbCXGlNgcIwr
	mo89pIYRr/SqlLrtwxKfTaQbdptuU5uIRjlub+1Jw5pDUJbX0QGInxK/ScC3vHVM3zMiNibZAFwFT
	KpEVu1gdlzhaDdsYMx+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVp7t-0000000Ankv-0BV1;
	Fri, 02 Feb 2024 08:42:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVp7p-0000000Anje-42R3
	for kexec@lists.infradead.org;
	Fri, 02 Feb 2024 08:42:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 66D4362306;
	Fri,  2 Feb 2024 08:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E902C43390;
	Fri,  2 Feb 2024 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706863337;
	bh=0wcKGTYVMX/a+PxYdBc2ncRniLKVKD5k+Z3j7EYRH5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JR43nUvL3Gkwkh8lODl37QJFZIWJNxAJNQxmsAsDsTMQmycsxtogYIXiNqgr+7WzR
	 tUJla797Cggn6r/GqEVv9g+46mSNYkbjsNo6dtdtL+JzDlsENoJTitz4cXVCAKVkla
	 iXoLfS7Y6il9mDXoP6j5XCl67aIso5JyTotsOCoCFU9yS93H/OVbrWFiyWqaG1lZ6n
	 9C0TbT2mr0MkhJTPOfe2s8yexA2bDGYr8EwB9fL6MxeloDAnnWl1BLtItxU6U07cfg
	 Do9N8Z0Zbb5oBPWDgTPl8u7uqLyyuqWcLVLPh+HTeiiYZBWO6qqHgbNlZB9ukPLcxT
	 MHETfq6vpi/tw==
Date: Fri, 2 Feb 2024 09:42:14 +0100
From: Simon Horman <horms@kernel.org>
To: michel@michel-slm.name
Cc: kexec@lists.infradead.org, Michel Lind <salimma@fedoraproject.org>
Subject: Re: [PATCH] Fix building on x86_64 with binutils 2.41
Message-ID: <20240202084214.GI530335@kernel.org>
References: <20240130-fix-binutils-2-41-v1-1-99ee0fcfb5ce@michel-slm.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240130-fix-binutils-2-41-v1-1-99ee0fcfb5ce@michel-slm.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_004218_060733_272EB970 
X-CRM114-Status: GOOD (  10.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Jan 30, 2024 at 04:14:31AM -0600, Michel Lind via B4 Relay wrote:
> From: Michel Lind <salimma@fedoraproject.org>
> 
> Newer versions of the GNU assembler (observed with binutils 2.41) will
> complain about the ".arch i386" in files assembled with "as --64",
> with the message "Error: 64bit mode not supported on 'i386'".
> 
> Fix by moving ".arch i386" below the relevant ".code32" directive, so
> that the assembler is no longer expecting 64-bit instructions to be used
> by the time that the ".arch i386" directive is encountered.
> 
> Based on similar iPXE fix:
> https://github.com/ipxe/ipxe/commit/6ca597eee
> 
> Signed-off-by: Michel Lind <michel@michel-slm.name>

Thanks Michael,

applied.

- Fix building on x86_64 with binutils 2.41
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=328de8e00e29

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
