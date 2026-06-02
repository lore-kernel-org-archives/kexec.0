Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A32FCD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 17:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D0Boguu0LesyWMHeJhzuparvQJGWjUOs54nvxOhsjj8=; b=yPDzrZ4u2+m413BDsgRXrynTr1
	ELIdlWh/bCIn0RUHTCZqRdH38cdx6HBcIKUGNUzOS6n1m7dg0WFU43xqwgrDdR5k0jiycWu+JwZKp
	bBpLPueLJbCQhnCoGdjf+Uw51vFTIvAkEYdTVJQi5LpSZb7O734mChEvlo8wfzfIrmt8IYAVlUIuF
	Bw22oppmYCEGZLZYvwCeWkzvIwi2F8SkO9kzdtoIJE+Gp6l+7npNh/JPuBh5+K62WhLXSc8zC8f9s
	smTEKYkLnynd2xktWImnbu24aKqJnNxZaJeSaQI0kVTPQmXEsc0RJ5ZEoUafC1MrtGVVwR7sp4U5O
	3pRamKdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSkx-0000000DZXc-2y4R;
	Tue, 02 Jun 2026 17:18:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSkv-0000000DZXR-4Ate
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 17:18:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 470F66001A;
	Tue,  2 Jun 2026 17:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE2C1F00893;
	Tue,  2 Jun 2026 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780420701;
	bh=D0Boguu0LesyWMHeJhzuparvQJGWjUOs54nvxOhsjj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZBxrHBw6VSwU1zg4uqbpFnH3K0w7m+VvpVuAbGTdRTiPirUpWt1BSpygDe1jF3Jsw
	 DvSsjdRlSHSDpZdFuvh/R/QyaC+wlVWWftrQEaqhmW18agJn0ay/I8YcGm5Rqw35dg
	 V4+xQuLSIaXuA90whmsDlQq/PIv5Bwlt76TXLPyD2Xy3Q7kLiRamRafwkwMbehFxpm
	 t6S+lZSE1exIY/EdwMVwwmljjLcnJ/KsxhLODXEf5gm6NiZ8N7VFKFDvdOUKHKU9Nm
	 WyLnqK0gektVM6OMrhQf6W4ZqeheKqEB3zozTPfDMEc/0p3BVqxdyyqOXfm+HVJDaD
	 pGToyiFVGhFfw==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Mike Rapoport <rppt@kernel.org>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>
Subject: Re: [PATCH 2/2] liveupdate: Remember FLB retrieve() status
In-Reply-To: <20260528174140.1921129-3-dmatlack@google.com> (David Matlack's
	message of "Thu, 28 May 2026 17:41:40 +0000")
References: <20260528174140.1921129-1-dmatlack@google.com>
	<20260528174140.1921129-3-dmatlack@google.com>
Date: Tue, 02 Jun 2026 19:18:18 +0200
Message-ID: <2vxzbjdsdfol.fsf@kernel.org>
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

On Thu, May 28 2026, David Matlack wrote:

> LUO keeps track of successful retrieve attempts on an FLB. It does so
> to avoid multiple retrievals of the same FLB. Multiple retrievals cause
> problems because once the FLB is retrieved, the serialized data
> structures are likely freed and the FLB is likely in a very different
> state from what the code expects.
>
> All this works well when retrieve succeeds. When it fails,
> luo_flb_retrieve_one() returns the error immediately, without ever
> storing anywhere that a retrieve was attempted or what its error code
> was. If the user attempts to retrieve another file registered with the
> same FLB, LUO will attempt to call the FLB's retrieve() callback again.
>
> The retry is problematic for much of the same reasons listed above. The
> FLB is likely in a very different state than what the retrieve logic
> normally expects (e.g. some KHO pages may have already been restored and
> freed).
>
> There is no sane way of attempting the retrieve again. Remember the
> error retrieve returned and directly return it on a retry.
>
> This is done by changing the retrieved bool to a retrieve_status
> integer. A value of 0 means retrieve was never attempted, a positive
> value means it succeeded, and a negative value means it failed and the
> error code is the value.
>
> This is similar to commit f85b1c6af5bc ("liveupdate: luo_file: remember
> retrieve() status") which did the same for LUO files.
>
> Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
> Assisted-by: Gemini:gemini-3-pro-preview
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Thanks for fixing this!

[...]

-- 
Regards,
Pratyush Yadav

