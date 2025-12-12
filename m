Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B32D4415F
	for <kexec@archiver.kernel.org>; Fri, 12 Dec 2025 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rj8tcO4bgn1qcGATOuGLt4O1i7I3IHOYiaWukbhWWiA=; b=CM3+5+AnhxYD5FJJbDWMBFqI2/
	YV/AMXItU3rBUA6VvS2B5EQWlbBiV0bvO9gUrBAeyMeZ/7TMH/WE25VzUvDoACu8cAlywqSuqdnMj
	omINFkJrYOHaF6TqeM44XDhFPsCeyvZMEXf98z0O+WdS9pbnLVFA/aO8R8x5uut9Zi1HNP5DHJVcj
	L2ZYlre4vW1O7f3XDN4SBJC8ybRkEPFgevykDPvroKPNqsw1cMRxjRtQ7iuqDxAe53vdR4hmRNFdg
	IY/HcTtomsWdrsbuP2RNBWMCKRAQf9sXJVJKR2lKqCFvGQxTFW5TnZskAedfkEw2mxtuFp1l6tvFb
	IbUpUFxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU09M-00000000Q3F-2kIG;
	Fri, 12 Dec 2025 10:13:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU09L-00000000Q31-2Mqx
	for kexec@lists.infradead.org;
	Fri, 12 Dec 2025 10:13:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 99FD560123;
	Fri, 12 Dec 2025 10:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2E1C4CEF1;
	Fri, 12 Dec 2025 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765534402;
	bh=3et33rpirkA749xhnfXWf76yh7Vc/K99F/IzxkgVovo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UUjRPXT/jjqcc855W3pOHy6tlvydYn0wQ4bjJH10STVY/ALsfGt6gIaO2/AwEBAkE
	 ji7vLiGQlGH6qiwFHYi2qF5rTnqk9RqcsQnUXhd9Ltbji+d8V4tyqkNZ2JA71nsCiJ
	 vVSbmxyLkmby8Ck8wjBxKgfMJ/vODa1on22SsEI5y6yCfVmHwK1VEgbUMWoCDyUZEJ
	 HU7i6qx01wEZb2QkWJSkWNU5WyK9EEbLUWoG+I1gm4G8Th3R8XKMww+fTIDV4aVgAT
	 dSGubCQ7ZSFg4HaJzRqB076xiPwuwTs0k16SkfvwuJFnBX22a4m1mGRCGKGb+TN88+
	 Di7btz2jf1ybA==
Date: Fri, 12 Dec 2025 10:13:19 +0000
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH] UKI: Fix the size of real payload
Message-ID: <aTvqv6xXfGRS6WC6@horms.kernel.org>
References: <20251205020536.8358-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205020536.8358-1-piliu@redhat.com>
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

On Fri, Dec 05, 2025 at 10:05:36AM +0800, Pingfan Liu wrote:
> According to the PE file specification, each section's SizeOfRawData
> must be a multiple of FileAlignment (usually 512). So when ukify builds
> a UKI image, it pads the kernel image, initrd, etc. with zeros aligned
> to 512 bytes. The actual payload size is recorded in VirtualSize.
> 
> Since the checksum includes the trailing zeros, this causes issues when
> loading a signed x86 bzImage, which is stored in the UKI's .linux
> section.
> 
> Credit goes to Philipp, who analysed and pointed out this issue to me.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Philipp Rudo <prudo@redhat.com>
> To: Simon Horman <horms@kernel.org>
> To: kexec@lists.infradead.org

Thanks, applied.

- UKI: Fix the size of real payload
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=e18a71faae08

