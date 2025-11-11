Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3B6CCFA18
	for <kexec@archiver.kernel.org>; Tue, 11 Nov 2025 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WqjC0KPSA/kJx0Q/UZ/gAekn4c4P6V9dOQ2k1QcmT70=; b=VHXNun11v9pWBY0IsqeDpo5LH8
	JEhllaxkq/sSO2lc4RdktOnZtoVXLrok79f7ZYG869vmRoa/8FSyyPEa7aEDZPuXkwgFogtA2YtXX
	bBAIu8SX+lnEj8fEyHoLSrZws2IAQoMlq9X6J4XSXOo1meCpGkjYsIMkpNX0vRsFQOviRquEP4eQQ
	d+DA0q5W+20udK34kA8XUp+KgX5jXNRmlzat22sO49g/Kqa3vA5k33aREhhCluVznXvxfYi0y5ZBi
	mCaDWlINmEQJ4I8GPhvpqVEp4s7GzqHepuDPiOZf+zY75bgXtXhc51ddKZognO5cV/8KI/tdkIk6e
	4zzvzIuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIonw-00000007GXp-3uMr;
	Tue, 11 Nov 2025 13:53:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIonu-00000007GXA-1rLv
	for kexec@lists.infradead.org;
	Tue, 11 Nov 2025 13:53:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CCCAF429FB;
	Tue, 11 Nov 2025 13:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA90C4CEFB;
	Tue, 11 Nov 2025 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762869181;
	bh=iqEYhUWSjHlr/b5/W4ozAZn+rYEu4lKJIK+ekzjR42Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwVLupmRy6c0UrYHcD4WSohk5CpV3P0HuODbkwNH6O8YSIWf7OeZQJzfPTWOacTKk
	 hbcWME4TqOf5YIZ6i8BtOSJgB7AIgqoUvWzCT3EJ1/mlBqLv5aKJkRhmFzLTKEYi1U
	 84cNq+wX8gGRfGuWgephvy4cGD/4BBy5vogJISXRKhRyVJPv7FA6xNHiC8/TmP36Bb
	 PQ6XfNrvilOciOfkrays21Jh1KpKYgL+xjPDDOEDuCPzSFGPKGMG0Ur2rSExJXYotr
	 cQh/51u8jjnYa6N5V/3GGZW94jAQhw3bZqyP45Nqp6Y72O8IfpIHhoTvICGBaH6C7B
	 vaFRSbZPHscEA==
Date: Tue, 11 Nov 2025 13:52:58 +0000
From: Simon Horman <horms@kernel.org>
To: Pnina Feder <pnina.feder@mobileye.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org
Subject: Re: [PATCH] util_lib: Add direct map fallback in vaddr_to_offset()
Message-ID: <aRM_uuDPsZD4f1ei@horms.kernel.org>
References: <20251106120344.2382695-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106120344.2382695-1-pnina.feder@mobileye.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_055302_505516_B46B5B2F 
X-CRM114-Status: GOOD (  10.45  )
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

On Thu, Nov 06, 2025 at 02:03:44PM +0200, Pnina Feder wrote:
> The vmcore-dmesg tool could fail with the message:
> "No program header covering vaddr 0x%llx found kexec bug?"
> 
> This occurred when a virtual address belonged to the kernel’s direct
> mapping region, which may not be covered by any PT_LOAD segment in
> the vmcore ELF headers.
> 
> Add a direct-map fallback in vaddr_to_offset() that converts such
> virtual addresses using the known page and physical offsets. This
> allows resolving these addresses correctly.
> 
> Tested on Linux 6.16 (RISC-V)
> 
> Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>

Thanks, applied.

- util_lib: Add direct map fallback in vaddr_to_offset()
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=393c449aec3d

