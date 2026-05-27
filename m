Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C082ECD4F54
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DZcQkZpUyQeATWEOUMOofaGCQ1N9UKf7wzc1Cobumfg=; b=oNLSL1NC+rnjy4QmGC2WyBtpjq
	sPKUmHwkLrkq2W5LO9+i1l5sGs4e1vql0ARd8fJJDCD82xFbYGQd9EXpkJwXLMTQz9WRG5Fal6d2J
	8LNHS79gH8WKzyLpjo30dXvqykEV1X0JfcgyUUcbwRePwnnHUD45l6XhgRM0NJw0t6K85VvTY4xvP
	lWDdcDW2f220O85uLEYOqdxBrkLobp4uR8ttuVZUiTyFvtP1u2doPGzbvQIeTS5/yAWDpH1tThm9b
	/TVSVpvxc6ciiUlvyGyy9LTy/FQUPCVfn8I626LXk90xcre30ybbNfKJN7G+t8NOb/idcbuP4nbsH
	NnbwhPTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8uZ-00000003UEO-1l58;
	Wed, 27 May 2026 07:42:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8uY-00000003UEI-2MSr
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 07:42:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 05DFD600AB;
	Wed, 27 May 2026 07:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C27A1F000E9;
	Wed, 27 May 2026 07:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779867761;
	bh=DZcQkZpUyQeATWEOUMOofaGCQ1N9UKf7wzc1Cobumfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wj+VPfVoQGDWO6OGVaEBTcB7BZVmc+AzU53HMITGsLo7VccA5dV0G/lf2R4VkB95K
	 kPFipPYrAt6Tz8ROLfpONzWvH+HSCLqjmSLAFsINg5ub4YmzVksGq7628+6idX/AKX
	 1k5DcnrlpQaer5SxTw/Hb0UIVt1nrJwgQHtNbxiCz/ihqkoq/2XOzEL5zTykvX10M3
	 DR9od0JyD1nb4apFxRGQBkK8gSr/DmTRqIPVsOSlRYzetZJvNwuJTR6ykrQkkdEjPG
	 ocxawBEqe4XkTnAWk5wjeQx4iXZLVOsok7wz3z97jx9lelkdHw/d9GKETQl/IuhdJ/
	 DJoCC274sXA0Q==
Date: Wed, 27 May 2026 08:42:39 +0100
From: Simon Horman <horms@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [kexec-tools][PATCH] RISC-V: add kexec_load support for vmlinuz
Message-ID: <20260527074239.GD51310@horms.kernel.org>
References: <20260526045806.23933-2-ltao@redhat.com>
 <20260527074112.GB51310@horms.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527074112.GB51310@horms.kernel.org>
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

On Wed, May 27, 2026 at 08:41:12AM +0100, Simon Horman wrote:
> On Tue, May 26, 2026 at 04:58:07PM +1200, Tao Liu wrote:
> > Copy arm64 code and change for riscv so that the kexec -c can load
> > a vmlinuz image.
> > 
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> 
> Thanks, applied.

... here:

- RISC-V: add kexec_load support for vmlinuz
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=771e89dc104e


