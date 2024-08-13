Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFBBC52D7C
	for <kexec@archiver.kernel.org>; Tue, 13 Aug 2024 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vMJrFB5SpDXFoJGu7SpkMcuakp+QPFmdRHMFI3529m8=; b=xhws17SPNKAlVn
	s2R+vcuvjyhCdgQwLVx53IbZp0V6vjCClKmcrkPXdNc7OMNjVZz4cnrIWxCVDQtOLdCG8s1IQKqIS
	bd73NawzMX7h4v6kmHKwas6MCEw9y+nNMmJEL0QXXk3/qwYH4NozvQKHNlyygV6zCWP9nQ1TgRW/B
	0OkJUUx7EHp5A2U+PEVHYszMJq6xvXXhA0F1kaordTzYCOMnWyNNjQbuHdxSc+QGgUdL2pnlWhV/Q
	9Hpc5vJKexskh4U2mPKa+rpaDDfZXAViQINQwbgatkK9OJLlrTtzwp6fN8SnZfyy915CzX+s0aHDx
	0u0eB3nro+ghYaEUNuSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdsWN-0000000412E-1Ej0;
	Tue, 13 Aug 2024 14:29:11 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdsWJ-0000000410W-49ts
	for kexec@lists.infradead.org;
	Tue, 13 Aug 2024 14:29:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B953DCE11AB;
	Tue, 13 Aug 2024 14:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2B1C4AF09;
	Tue, 13 Aug 2024 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723559344;
	bh=l9aKcjab5aXbSMmUtQw0m+evRSemm3tnUsIQXT7KDVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVokeiVRkcTK/ygioTOs8DI06jU0qZuuCOoyO4ZkXndCLsFG1CVSUSsle0YZ/u4YI
	 0+hui9Jywi8pQTDxLTwV40Qu0KE14x/vZOjWlL9qpJIDQVDbenSIMYmxIvmcUImjNv
	 3lGjzed9Nyo/XLucRXwESsdfA8VxF4xZW0LyKtIMBM1OACITQApo4R4tcv51jTZt0b
	 Y+HmJT5rDOvoNkg0LLX3J37A9nF9zRQtDJt8WgqYtnxOwBfRFRYPz0zPFU0Z6s4VvJ
	 9pEeTgtw8Fa/LHRLILBTRVIfRbr536q7nVkpiKU6xDiXgxmH3pD9yJQRVjMC8Tw+NF
	 h7IFzZ5yZTY/Q==
Date: Tue, 13 Aug 2024 15:29:01 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Tomaka <jacekt@dug.com>
Cc: kexec@lists.infradead.org, dan.j.williams@intel.com
Subject: Re: [PATCH] Add support for soft reserved memory range
Message-ID: <20240813142901.GB69536@kernel.org>
References: <CAKVxXCVpgdybjKFbAQjOKbhepHuwtzqjZjtW_E6YUb3Yh758TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKVxXCVpgdybjKFbAQjOKbhepHuwtzqjZjtW_E6YUb3Yh758TQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_072908_282176_6016BA62 
X-CRM114-Status: GOOD (  10.40  )
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

On Tue, Aug 06, 2024 at 09:57:24PM -0500, Jacek Tomaka wrote:
> Essentially catch up with e820 related changes in the kernel.
> Intel Sapphire Rapids MAX has high bandwidth memory which is
> precious resource that is better not allocated by the kernel.
> 
> Userspace later can enable soft reserved range using daxctl.
> 
> Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>

Hi Jacek,

Unfortunately this patch does not apply - it looks like
somehow indentation white space has been collapsed.

Would it be possible for you to repost.
Perhaps using b4 or get format-patch + git send-email ?

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
