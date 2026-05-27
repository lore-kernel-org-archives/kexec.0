Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9835FCD5BDE
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wtN812ZgHMOTSxhHE1XR6p6sP8XdGXG7Hx+KfzNK4pQ=; b=f1udBNu3V7Y4Zj6IdEtbtRqHoz
	fRuHmCXjQlivSI8imHMuagu4FIbYDMPQqpOOqqUIvBl1wOm2c8vZLu0FUuWI7dGNzCMCRnZJGVh3k
	6nkAm52C4OPYs6K2rEaXm+SQ8302c/BEvV3s3dVIip7/k8Q3AaRlAUFf1c/oJ7YRr0jqRlQPM8prZ
	qYTy6Td8a2fScVPZMCMeNJ652+xLBcP2EZj992jl5STNZZyLybb7jt1EehnnPLVP3zPBzvwB8FA38
	SAiXjSfxsr9emT+5thwmDUE/oc+eQl/rL4mV+0FGDXuKQbVX8oAeTd4Z88pU31qtEqtjfRmNQxN8P
	M9F+OPQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8u0-00000003UBd-1LPP;
	Wed, 27 May 2026 07:42:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8tz-00000003UBU-2mPH
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 07:42:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD602600B0;
	Wed, 27 May 2026 07:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42BC1F00A3A;
	Wed, 27 May 2026 07:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779867726;
	bh=wtN812ZgHMOTSxhHE1XR6p6sP8XdGXG7Hx+KfzNK4pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WnjqLaTP0n0GG3l1DtZ3X1oh/6HcGgH72O5kSPFXy4UKNevu2/g17IpPVH2vZb+Zf
	 kDFHoQqU3PsRQR6e1bN84nyyNLDOp7LfvBHo2ddEvq8x9i8fJneBWuNOz/7C7XqYlH
	 OQ2r13mgbAYjDfdeSdKVy6n47xgjcZ5M+kKwWYmVi0pV9Q+pB3TLC+TzUQwMEtn0FE
	 gl6ZtjxJmbtPqR1yT6C5t3Lf6d0hxz3AENXCI5Q8h8ZK3W2pLWWUSbHM5aJirSAbbt
	 sD6gtlJcFKQ8AUNOO/VPBZs1X5dE+/444G5dFEKUngBOHf9pT9toJAk9W3qgTxfk2v
	 kZ52b3/b2sz4w==
Date: Wed, 27 May 2026 08:42:04 +0100
From: Simon Horman <horms@kernel.org>
To: Alejandro Hernandez <alhe@linux.microsoft.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v2] kexec: restore functionality to preserve fd xattrs
 for uncompressed kernel images
Message-ID: <20260527074204.GC51310@horms.kernel.org>
References: <20260526151714.4181388-1-alhe@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526151714.4181388-1-alhe@linux.microsoft.com>
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

On Tue, May 26, 2026 at 03:17:14PM +0000, Alejandro Hernandez wrote:
> Since commit 714fa115 xattrs attached to a kernel image file (such as IMA
> signatures) are not being preserved, do_kexec_file_load() was modified to use
> memfd_create() which now passes an anonymous file descriptor to
> kexec_file_load(). This change eliminated the filesystem inode identity of the
> original kernel file, hence attributes are no longer visible to the kernel IMA
> appraisal handler during kexec_file_load, causing IMA policy enforcement to fail
> even for validly signed kernel images.
> 
> This patch attempts to restore such behavior although, only does it for
> uncompressed kernel images. To do this, we first figure out if the image file is
> compressed or not and call each method accordingly.
> 
> Compressed images continue to use memfd and cannot carry forward the original fd
> security attributes, since their decompressed bytes do not match the signed
> artifact. Proper handling of compressed images with IMA would require either
> signing the decompressed artifact or kernel-side support for decompression
> within the kexec_file_load path.
> 
> Signed-off-by: Alejandro Hernandez Samaniego <alhe@linux.microsoft.com>

Thanks, applied.

- kexec: restore functionality to preserve fd xattrs for uncompressed kernel images
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=f75be9241acc

