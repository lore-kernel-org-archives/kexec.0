Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241F4C88E42
	for <kexec@archiver.kernel.org>; Thu, 10 Sep 2026 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+muI1Y++JAFHBJSAeF9UgkoNUlxYs81VMFK72BiNI8Q=; b=slN5yGLpBLbGg73k48mRk72LD+
	SM61ZdDIkdCEDoDSmAMAMyTuIlT3D5748MTKzwHe8NZAfO/O+bYxtGIiBCUh40LWIlPWPDNOkkXtY
	+ZRyPUofHBR3BPauctWLU4Zzc3gc8DLGAm4sHRFfoC71AJvonCpTAEoioNrTxZyHHI1RoI2f65/ja
	4QmgEc3pU3d8e0oCMmAigcUb63yNPRbP1PujijvpMhOKGpRjTJlT0Gi2YLYlaFBZPKsEPvVcbwJ+P
	XQjvbRfMpkmhR0deUyWeTiamB0S7R3iRJB5TkR+SzS3ZaNBcs2QKbVojuFk3jyZ4EDazcVTegUnt5
	aO+Ee4aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4bQE-0000000Dw5p-1mrR;
	Thu, 10 Sep 2026 09:50:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4bQC-0000000Dw5Z-1kfv
	for kexec@lists.infradead.org;
	Thu, 10 Sep 2026 09:50:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DECD440F0C;
	Thu, 10 Sep 2026 09:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C871F0089A;
	Thu, 10 Sep 2026 09:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033819;
	bh=+muI1Y++JAFHBJSAeF9UgkoNUlxYs81VMFK72BiNI8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iXU/ICQxczIvc0UXPeHKVCCyAbyrOUnU28ptUDZtcUkKUshVpMQecMXSxoJfLo2y8
	 tLHwnte/wRhOF3BSyZe4lOs9Va5P1R95418z+3EO3bsGo0h8ovmkIrijsO1HYcOr98
	 Z+yp4LVKWS8UiOn8DM6OoE4YVEHGLmZWeRxTH5kTF6x0hBV8zZxGllJekHEdzEoBIv
	 kbbt+84OtF64aQPTikgs4DN7nFHRTAnIcxs7AYRZVwSuzCk7W1swrWwIPIouZgA3X9
	 Mh8vHTdS4hY3j/QroBuuqMR/JP3hgbnEPIlvnraDWpTclm8ozqf263IuJqeqOkYYp6
	 TRgx0mM8LsjyQ==
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Graf <graf@amazon.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-mm@kvack.org
In-Reply-To: <20260909103001.2423403-1-kamalesh.babulal@oracle.com>
References: <20260909103001.2423403-1-kamalesh.babulal@oracle.com>
Subject: Re: [PATCH] kho: docs: fix scratch_phys debugfs cross-reference
Message-Id: <178903381353.3691424.1681861521367117461.b4-ty@b4>
Date: Thu, 10 Sep 2026 12:50:13 +0300
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

On Wed, 09 Sep 2026 16:00:01 +0530, Kamalesh Babulal wrote:
> kho: docs: fix scratch_phys debugfs cross-reference

Applied to liveupdate-7.4 branch of liveupdate/linux.git tree, thanks!

[1/1] kho: docs: fix scratch_phys debugfs cross-reference
      commit: dc645f2db7539352404525dd1b80236520fb39eb

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: liveupdate-7.4

--
Sincerely yours,
Mike.



