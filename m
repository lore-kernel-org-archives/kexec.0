Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF07FA375C
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 20:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LynvHTHzFXhbeyMyi2dOf9W44B6h2kWXWJq6csDIFCU=; b=xmqrYgEvBGTJ/LJDQsRnIfrpNO
	0A/xxBVqRKAsnancnWS3+6iqhGoeL5huTk3A3fLdJi/2MUxbqJNAKW5QVH1uoqSAOxjKZA1gGigzP
	VNFUmpHDonX80f9qTAexZFU+iQLOl77W74K28qlnGsbth7kG2I2+GJ7aEAE4f/jkt4xI/WzLtrPEV
	e4GOdyWmyO8R5ZTgUEWQMSfOqNnqWfACAITuC4gnl2xdgrsTfwSW5Jp3MG1tutzAj264bRld4iic1
	N/MkJE5bzNeYHGPljo9bXxDU8ucPg0P/RJBtuTyhiNy/s7JwLLgclDrHLK97DJj4cCF9wkLzFluOp
	mjgItZhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vblaf-00000008hCq-3Yph;
	Fri, 02 Jan 2026 20:17:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vblaa-00000008hCD-1wSF
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 20:17:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A08464171F;
	Fri,  2 Jan 2026 20:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BB1C116B1;
	Fri,  2 Jan 2026 20:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767385055;
	bh=y+x3jWafn0ySZoOf7SO1BpFsnu5XwS14IRNA2tA5RQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RyfEeod24/yZKCI7D+ni5GF12w0rIvHvu7Zs02atNyZbktGxXgW3DVO3n3l4K5k8+
	 ncwOjqZ6tPJjlJZ4FYteSFrzIcV4VLhljCGBJZUcRi0bmPZpoxldXzI0N7GBO3I8Xw
	 8+SJPE27uWSTXEomzX7o709uNxXWH1aF7mfAQORru7cIv34/gwVsawVxwLHfBeEDSA
	 vf2x0q6d5TfIJU7MATctmxT0fjERG0+PcU79NmvH5cnV9MQi58XyeD95HBz2RzMkOk
	 cS9VvQnArGi2uDfRNahvHvUdgEWgjPh0INnV2au9NzYMDtMQCOsZsEtpPhP6FR8mAm
	 Nb0Ifm8fMT8UQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] kexec: history: track previous kernel version
In-Reply-To: <20260102-kho-v2-1-1747b1a3a1d6@debian.org> (Breno Leitao's
	message of "Fri, 02 Jan 2026 06:53:23 -0800")
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
	<20260102-kho-v2-1-1747b1a3a1d6@debian.org>
Date: Fri, 02 Jan 2026 21:17:27 +0100
Message-ID: <86secn7ors.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_121736_748959_024A38D5 
X-CRM114-Status: GOOD (  16.24  )
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


> Subject: [PATCH v2 1/2] kexec: history: track previous kernel version

Nit: please use the prefix "kho: " for KHO patches.

On Fri, Jan 02 2026, Breno Leitao wrote:

> Add CONFIG_KEXEC_HISTORY to store and display the kernel version from
> the previous kexec boot.
>
> When enabled, the current kernel's release string is saved to the
> "previous-release" property in the KHO device tree before kexec. On
> the next boot, if this property exists, the previous kernel version
> is retrieved and printed during early boot.
>
> This helps diagnose bugs that only manifest when kexecing from
> specific kernel versions, making it easier to correlate crashes with
> the kernel that initiated the kexec.

Why can't you use journalctl to figure out which kernel was running
previously?

For example, you can do:

	$ journalctl --list-boots
	-2 a1d93be939b64ac4b7b26aa003bfdb93 Wed 2025-12-24 21:34:22 CET  Thu 2025-12-25 02:04:07 CET
	-1 dbbedcf8fff54d5990c6f2a6399cfce1 Fri 2025-12-26 11:46:23 CET  Fri 2025-12-26 11:46:54 CET
	 0 d002d51c28e748d9a7c6c8cdd391aa73 Fri 2025-12-26 17:40:52 CET  Fri 2026-01-02 21:12:09 CET
	[...]

	$ journalctl -k -b -1

This will show you the full logs of the previous boot, or the one
before, and so on. And when you're debugging, you'd likely want to view
previous boot logs anyway.

Everything you add to the KHO FDT is ABI. While we do have some
flexibility in changing the ABI, I'd rather not add something that can
easily be queried by existing userspace tools.

>
> Disabled by default to avoid overhead for users who don't need this
> information.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
[...]

-- 
Regards,
Pratyush Yadav

