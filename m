Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54771E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PMAzXk8kOG9HWfvJfv3/34qgBHZ1UuEjzgkgRwOmNyw=; b=ZrOU28vdEQXoDdN/s9smG1lQNY
	kvFG86lH31sKQEAAWo3l2yHv0Y9ffAw1ghKJ09X1h+9Z1W0b5909+unjJ/01wjK+3FdhT1Sv5rfjD
	MjSy8hDtEShqHGXGB7ZWlA/xNd2AGh8OQ/cBGeYqwhjpOEMrGFfUZ1kCfaCyr+CT/kvf4o99e5P7v
	W6U+ar7mulC/TDmqn7z1jEER1BgQpuA08NGTp7kKg1cmLh5CUuNs3cpmYdQ00lPTAV3EwFf3frGS4
	l+Z8D57b2i45h3d+h2W7onBWrJpxcWZCpRpu53deVAwbFameEenB4tPrSQy4yeHYOXsIvTJ0nP3ma
	qiZhEmrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM51H-00000003kbQ-0MIz;
	Fri, 13 Dec 2024 12:43:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM51F-00000003kb0-1gpj
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 12:43:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8CEE15C6A0D;
	Fri, 13 Dec 2024 12:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE931C4CED0;
	Fri, 13 Dec 2024 12:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734093824;
	bh=ookeueMvQOtHZ2qTcQtX3riDJqfjS2g8lIC9Fkbx89M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3VlXXCCsxmVJ7WPqiw6IgUkgDZklTPt41b+xtW6bzNMVjd+ANUlFZhQDH9PJJ/33
	 IQC/bw5Nmlvys7a9jM2FuzOnWsM2/1aoq4ZUWQkbJSfQQyyjedIiG0VnAEI8Wqh2YK
	 0/tS4SWwnFe4txYP/1HKMob5fbpkf2UqFLLKFDTvy2KeoH9EKt9O3U1DiC91iukwMz
	 3q7HrRx1SNLosCnVrIZ4eaUwvI2PB3C2Y2sKd472NDhT8a/ZkE/bPpJM44vHA3qfi9
	 iUVFJb20o4OagF9BR9gHWpmV9bT9H8B/LzYTXqi/W17FvwDM14zwk7nL0UqZz8siHH
	 sZbwMq85QYhjA==
Date: Fri, 13 Dec 2024 12:43:41 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: kexec@lists.infradead.org, piliu@redhat.com
Subject: Re: [PATCH] Correct string specifiers
Message-ID: <20241213124341.GX2110@kernel.org>
References: <20241211025846.243026-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211025846.243026-1-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_044345_479341_F0FFC4C9 
X-CRM114-Status: UNSURE (   6.12  )
X-CRM114-Notice: Please train this message.
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

On Tue, Dec 10, 2024 at 08:58:46PM -0600, Jeremy Linton wrote:
> Recent GCC's on fedora complain about the use of
> %lld for uint64_t because its unsigned. Convert a number
> of these and similar calls.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks, applied.

