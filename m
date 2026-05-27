Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE69CD5BDE
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 07:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cWt/6w0kQoxKTHO5Ge0ujfg3rLlK36EJh5xy2N8IUUo=; b=WO+3z0JQRjCGP6aWFl4FlSOsk2
	FHT36P6VmRgJzCbvXUez3zgPDCoxtScAPLl6JjQOjDUo0O2Etr60nGMWOVGsCt7wAgQW9Y8DCpT7X
	GH/6FMsQa6QRQBzmsutaXQnrHu+oY8GBas/DrsBsAK5mXuzDsJ6hKDDE52N0YO8F+6cUWtgpNOKNP
	ToC1DKfKe0MhvbXXLaHJnCO70ZYzf3axhJmzP3XYBm0OoirZx85n85UnQamuyOXnyUkOXd75a8nKK
	EGHAkDlur0dz5pD524XjJhGNDm3P9tXVK8AQYoN5DGwCSrJZaGwCW9FBPOj/2x2GWrRJ8j8q4vdfj
	BS/cjc9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8tA-00000003U7b-0qiw;
	Wed, 27 May 2026 07:41:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8t9-00000003U7V-2mjm
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 07:41:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D308F600AB;
	Wed, 27 May 2026 07:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E002E1F000E9;
	Wed, 27 May 2026 07:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779867674;
	bh=cWt/6w0kQoxKTHO5Ge0ujfg3rLlK36EJh5xy2N8IUUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AVxluFoL7uCF3WFkTLa3AzTjOdWWQKS/VTQuNTortN1/KiDY2PcFqobQNIXOMHV47
	 7nSRkBnPRwiFxzQ3VPw3aKOEObni22i85f8arDRIwkfi+l/5Hu8csQBNSPPasJKSf0
	 Z3m71oY2lI+CcwggoOggAYdcVuj4Tf4RxlF1C1PLTuZlpOJ9AW211ClFBTB4ARcoKO
	 6nBfPEFalCuQsZziXQCGEtwr0t3lOhb+KbE/X2fs/aM1vhswQKCJwUKgPXac/0PFN4
	 F6kQP2RH9GN1IlBHIAJtEkUFTgPyzUYQMXSRn+ZBCUNJDsqO1nEIOO6aTYN1RENXOI
	 IMU6NSIzLlxiQ==
Date: Wed, 27 May 2026 08:41:12 +0100
From: Simon Horman <horms@kernel.org>
To: Tao Liu <ltao@redhat.com>
Cc: kexec@lists.infradead.org
Subject: Re: [kexec-tools][PATCH] RISC-V: add kexec_load support for vmlinuz
Message-ID: <20260527074112.GB51310@horms.kernel.org>
References: <20260526045806.23933-2-ltao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526045806.23933-2-ltao@redhat.com>
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

On Tue, May 26, 2026 at 04:58:07PM +1200, Tao Liu wrote:
> Copy arm64 code and change for riscv so that the kexec -c can load
> a vmlinuz image.
> 
> Signed-off-by: Tao Liu <ltao@redhat.com>

Thanks, applied.

