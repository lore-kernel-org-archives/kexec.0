Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A93E909D2
	for <kexec@archiver.kernel.org>; Tue, 17 Feb 2026 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7MA76AG6tK9tcyNeJzB4mQq5hd3vdoHJD3YHcgB1gp8=; b=QtsxcZTOnmvMN7ESKfc8Cudikm
	Pb59Vtxywo8X1yWIdiN0FDcCFepAhHXKAjgXwc6zIhAJGr84OstuzXRJAzk84/aWheuxZOwCJ89CR
	VyF8CBh5OqEzgVu73YuF7A/MnowsSK72nFe/df+K4/dNc7DeseBD5HG7TUiasM+8ein9kJv1JeoMM
	BZ4Uo6RDt3g96WJeXD6c0uiolTVZooiIxPyN0UhsgY7Erm93qVAzuuBpPmT2CU75Gn48PoP+pEtfO
	q0W0FgATD29/RmrltB6l0b9bfGH2gNPuLVV1voc/HkjPwRQ2ntQcEBE+UqDs14VB+YS80M8HEMM9r
	dhzvussA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsNft-00000008Y6E-2QyW;
	Tue, 17 Feb 2026 16:11:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsNfq-00000008Y5k-0uvV
	for kexec@lists.infradead.org;
	Tue, 17 Feb 2026 16:11:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 148F243B6F;
	Tue, 17 Feb 2026 16:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A07C4CEF7;
	Tue, 17 Feb 2026 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771344700;
	bh=W/0x24MhceikicVUT999x/ThkajGOQJS4pAuIVVsQHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGbDsFmSnm1FQ7OM4HQ4gnWyontM4641uJH46Fj8U/IaBBXBtdm66cXG7X4W7pc8e
	 ogMewVwoOaeimKcCBcvDb3o+RhuSPR0ZpKWZlEpkgpz7d8WApTXd7Q6gASdAvX1tTD
	 zrwu9MsryPj/SbfLN1BY3kQxSvE1f8GCrcNPfjPPWGz3XuXtFrWolpk2Rjv1A2iae+
	 Vm5gudERjy0IEVHtLruKliGSj+nibNwXIrONXKqavknnNY6tVjQ3qbZl2hEfPU1Rfr
	 hxwk1UndVBkAiESwIgjYDqQkDzrXSR8NUak1qQORjTCtRK0A+9OqPEbiK9SLYoHSQU
	 nz5vBXKQUaUow==
Date: Tue, 17 Feb 2026 16:11:37 +0000
From: Simon Horman <horms@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: Re: [PATCH] ppc64: Reserve FDT memory for full elfcorehdr memory size
Message-ID: <aZSTOR0MuaCTjEb2@horms.kernel.org>
References: <20260210050536.285923-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210050536.285923-1-sourabhjain@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260217_081142_297627_DD5AE3BC 
X-CRM114-Status: GOOD (  10.23  )
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

On Tue, Feb 10, 2026 at 10:35:36AM +0530, Sourabh Jain wrote:
> With --hotplug support, extra memory is added to elfcorehdr kexec
> segment to accommodate additional resources during memory hotplug
> events. However, the FDT is not updated with the same size, which
> can lead to elfcorehdr corruption in the kdump kernel.
> 
> Fix this by updating the elfcorehdr size in the FDT memory
> reservation entry to use its actual memsz instead of the current
> buffer size.
> 
> Fixes: b8408c95e7c0 ("powerpc/kexec_load: add hotplug support")
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Simon Horman <horms@kernel.org>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks, applied.

- ppc64: Reserve FDT memory for full elfcorehdr memory size
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=600c2f9512b5

