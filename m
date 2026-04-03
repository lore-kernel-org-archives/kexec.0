Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47ECE7E36C
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FKfl9TdVDizzlO2LSkdlwxuYXtAA09Pi4B9rN5R3bSs=; b=TlJ8J7whBF6NjI4IPsBE0/S/D6
	m9W5MohtpVf7E1IMI7AwW3l0dEc0KjEU/hyXjXKRqCTgbX/Q5AGoLpR4c2jRjmGIon1ikjRxkCU59
	f/HsynuEIDeIYPPPzb+Eqx73+yJITJ8sZHlZ4yvRV4YJYk4R7d9su3r8hf0QGgvb1Lg7UtKwt9Jsr
	bwgfVse1WMJHdzY5yi1aANLIZObPVfKlU3NGKe0yOPGGDu0UDq5GMpLr5O8g9ABe5KNSC7J+zrMMU
	SczkJb2lioEW7zWx+AKTCrzotnTu5lsTc9DHahMFeqjONUICvD9jnC7/zmNjEK/fitVqpLyuYQ/XF
	v1xA2RaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8cds-00000001xBy-43ou;
	Fri, 03 Apr 2026 11:24:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8cds-00000001xBs-0Akf
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 11:24:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CD1D60121;
	Fri,  3 Apr 2026 11:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5912C4CEF7;
	Fri,  3 Apr 2026 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215486;
	bh=n2kIfPcxv9fpCDmESjetmPVIXXSHk10QB/niw+4zBdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MPnN5DluGKOUu49y7lrQ31VECTcn+7zuVK939IQ5sR/OYJUUpHW5cHhN86TpjW4ZO
	 GWAnpWC9hE3EaJmqVEmgKjv3EI7JPlNNtKzt9viRA+HTBDfMkDoih68tiF8CTXXb/d
	 y+M3nDSw/J1tEGuM6JqsqQgdoSNuw1ddWxE6tUE6FZyqtuonPwaE0L8RIUHlnjkB0a
	 g3UBF2uo+2owZ0fVzaZAnY5b2wDOxiwaRcF+79st1pSStTkWc+3CIDSh17AFfji0+/
	 IKrp5d0S0voXE2VTuh4ICx0KqwvSLDAqAshzULkTs16KdZEm15RW4ltzMWiPQBaEBl
	 Q47Y4/9dxpbTw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usama.arif@linux.dev,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v9 3/6] kho: persist blob size in KHO FDT
In-Reply-To: <20260316-kho-v9-3-ed6dcd951988@debian.org> (Breno Leitao's
	message of "Mon, 16 Mar 2026 04:54:33 -0700")
References: <20260316-kho-v9-0-ed6dcd951988@debian.org>
	<20260316-kho-v9-3-ed6dcd951988@debian.org>
Date: Fri, 03 Apr 2026 11:24:42 +0000
Message-ID: <2vxztstscmmd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Mar 16 2026, Breno Leitao wrote:

> kho_add_subtree() accepts a size parameter but only forwards it to
> debugfs. The size is not persisted in the KHO FDT, so it is lost across
> kexec. This makes it impossible for the incoming kernel to determine the
> blob size without understanding the blob format.
>
> Store the blob size as a "blob-size" property in the KHO FDT alongside
> the "preserved-data" physical address. This allows the receiving kernel
> to recover the size for any blob regardless of format.
>
> Also extend kho_retrieve_subtree() with an optional size output
> parameter so callers can learn the blob size without needing to
> understand the blob format. Update all callers to pass NULL for the
> new parameter.
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

