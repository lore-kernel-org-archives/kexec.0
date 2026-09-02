Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8885FC61DFD
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 05:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4+J2Jj2HRrACqcAaQEKzV2dhwA6iYSIh+wTxScdcYp8=; b=GMK+UbR2Ghe7xZflBKWwz2kgAr
	ZHgKd0QtesCLF9vFitA0sEQ3ZjAXLyx/fFYgQtn+/9Z0+Nm+mce0PncNdHtlZWeAOsf0Gc3GIMuKH
	tzMNGwjuIGylKFO14ozReCLis/LtQ5RJ5dpba6th5WfrJoiAt5sBO/DYGIHEziwPoBXuJthtrCTwD
	BYHwTfmRMiciUChTiSutbxLCDeV6FFTmYh9/5VVeH6aPZ7NLpdsVVG0A1cWFJr0VHKQEY3HldWn9U
	UoN2AssZucZPYxsDAI5O2XpqFxiroSvYhzoJUlZilY2kGNcZVwzpkSKusure1EtHU7x1CeMK+qSgp
	zBm9j9EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1dcf-0000000DoE4-3EXP;
	Wed, 02 Sep 2026 05:34:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1dce-0000000DoDr-1CC4;
	Wed, 02 Sep 2026 05:34:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A3B95419CD;
	Wed,  2 Sep 2026 05:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983851F000E9;
	Wed,  2 Sep 2026 05:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327295;
	bh=4+J2Jj2HRrACqcAaQEKzV2dhwA6iYSIh+wTxScdcYp8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SnEiX6ZVRKNTlEzYhdNfLWvZ2V6gv7CAk4V6VlJVOjWftIIfZI4jZjIgP6Ekow5aH
	 Dea+Vm53VDAB4oQGDi8tH78zhPRXDwvL02py7j6g3xDm2VOCAAViiylf+CiqP0SgJf
	 fg/62uxQZenLhBbzQzQLNpYwzO+DW1dkgB1b9YH7qgSXa1VHHFfDtvzEZ2mdgJAZIg
	 A7yaG0RTzthG0310R1CH4miU2uAMobA4Gbzu1/HdGgcYQ3bOdF6FRG2nWtYRqZ9kOt
	 2o+4nKyq2up6v5DA1Ry9IbGDHHLpb5cYrXahXYlF34RaRqxIx8HPlN6k7BXBpDUBzS
	 AhrKMXU+6FOog==
From: Mike Rapoport <rppt@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Tao Liu <ltao@redhat.com>, 
 Philipp Rudo <prudo@redhat.com>, Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
 kexec@lists.infradead.org, Bradley Morgan <include@grrlz.net>
In-Reply-To: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
References: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
Subject: Re: [PATCH v3 0/2] kexec: fix probe error codes and error
 propagation
Message-Id: <178832723438.3691424.5459141264864633147.b4-ty@b4>
Date: Wed, 02 Sep 2026 08:33:54 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
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

On Fri, 21 Aug 2026 19:19:56 +0530, Mukesh Pilaniya wrote:
> kexec: fix probe error codes and error propagation
> 
> While debugging a misleading error on s390x where kexec -s reported
> "syscall kexec_file_load not available" instead of the actual EINVAL
> from a kernel command line that exceeded the architecture limit, we
> found that some kexec image probe functions return -EINVAL instead of
> -ENOEXEC for format mismatches, and kexec_image_probe_default() has a
> bug where it returns whatever the last loader returned rather than
> always returning -ENOEXEC when no loader matches.
> 
> [...]

Applied to kexec-fixes branch of liveupdate/linux.git tree, thanks!

[1/2] kexec: return -ENOEXEC from image probe functions on mismatch
      commit: 2792b4b15f148b142a4302706410e520c8049c00
[2/2] kexec: fix error propagation in kexec_image_probe_default()
      commit: b7c94f4d0961e3ea8ce0463b6eda1bb2cf9f2694

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-fixes

--
Sincerely yours,
Mike.



