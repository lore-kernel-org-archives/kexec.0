Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2610C43334
	for <kexec@archiver.kernel.org>; Thu, 30 Jun 2022 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=26YW2mk4YXUikqGMUiVuyUkTRZlY7nI7zmw2xqCPuLM=; b=qnSCTAMFvxFvkx
	tk0/oJpssuaaZ1z7/3ZIAmeySmkjx8+ZCqwqV5PNxDcpLAdxkNl0bcfJCyiH8mMpYzYUjO1mMag0M
	ei6vluUBk/K2L3Msy134KBSe2QBiOvHXwPZuyQ9GMBNTnXs+O6i2ttD6Iom4WUh5FEHGvZNgx+QO+
	0jV40zTT90oZbTYSYMKCqHkbYH99efWdHkuDw7s8NVxv6ozhtitCEP+whFTa42lkTbeaePCfy+lNb
	I0E7kxHf2j0QDrZlR3KK6Bz61Y9pTW7YqGZL1vPNRxaq1O6jeDLeuCENMbNdsmyZ3/wYSSuKRZZSu
	g0VOSo81cP3lERsq9/Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6u65-00HGjp-Ro; Thu, 30 Jun 2022 13:20:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6u60-00HGjG-Hh
	for kexec@lists.infradead.org; Thu, 30 Jun 2022 13:20:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E785461F08;
	Thu, 30 Jun 2022 13:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A5BC34115;
	Thu, 30 Jun 2022 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1656595235;
	bh=Gjs1D9vdtTbVIpCgMrFXplqipTLraLCHH4B9AHCpl/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPO7S7+b+VQXn8XPN0Aw/4Cm1s3T9irr43M+Rxhf7IsLt0Z7FH7ZkueR5Fs8fNffu
	 5O1hEithJbc9BVXJ3XXFkLmP8iLjrMUzyFsVGbxhF+PkRy9C8fKnNqR0MAB8+fsaOH
	 mBKZa/1WC/aN80kxm4eGk7DCzStxPLqGLvLerwlA=
Date: Thu, 30 Jun 2022 15:20:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4.9] kexec_file: drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-ID: <Yr2jIISAEVwi+YYH@kroah.com>
References: <20220628154249.204911-3-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220628154249.204911-3-naveen.n.rao@linux.vnet.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_062036_686988_29F415EF 
X-CRM114-Status: GOOD (  14.22  )
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

On Tue, Jun 28, 2022 at 09:12:48PM +0530, Naveen N. Rao wrote:
> commit 3e35142ef99fe6b4fe5d834ad43ee13cca10a2dc upstream.
> 
> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [1], binutils (v2.36+) started dropping section symbols that
> it thought were unused.  This isn't an issue in general, but with
> kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
> separate .text.unlikely section and the section symbol ".text.unlikely"
> is being dropped. Due to this, recordmcount is unable to find a non-weak
> symbol in .text.unlikely to generate a relocation record against.
> 
> Address this by dropping the weak attribute from these functions.
> Instead, follow the existing pattern of having architectures #define the
> name of the function they want to override in their headers.
> 
> [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1
> 
> [akpm@linux-foundation.org: arch/s390/include/asm/kexec.h needs linux/module.h]
> Link: https://lkml.kernel.org/r/20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/x86/include/asm/kexec.h |  7 +++++++
>  include/linux/kexec.h        | 26 ++++++++++++++++++++++----
>  kernel/kexec_file.c          | 18 ------------------
>  3 files changed, 29 insertions(+), 22 deletions(-)
> 

All now queued up, thanks.

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
