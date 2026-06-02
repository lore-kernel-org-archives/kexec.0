Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5308ACD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+opkI2D1z70JJ/vyXa1VmjlNB/odsO3As2SLbmif/rE=; b=XlgT5VHq21d2DS4rTQlOonguzB
	ibeJSDBISXiU1YsHTIriNU9BxZl6JC9wg/chbPb7p9iYtoXFHufIVf0QbZ+OL1fJ8PY/c9URe7xBN
	yUbgucVC1/e++HcFwTsuJPA99Jtr5R/LOtEgKyhw2W5HH+duVcK5JZf6x2uYmhHACYDGCsGxLiGIl
	vqp65uPTBvGmdI0E6oI7iHAUMBibig/ZVjPgX6Axjs81oA6OVb3ZvTav1Ds88a7iEeE3JjDYTVW+c
	f8oEQ3xJGi3hVXMKHNGsiKd2699q+ET4t+TZSYeCWlfXnoY7L/KpdZ7aPPCOP4jCA6GouUhmY7DVp
	5HMtbSFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUShq-0000000DZEf-0Tnc;
	Tue, 02 Jun 2026 17:15:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUShp-0000000DZEZ-136J
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 17:15:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 74B0860123;
	Tue,  2 Jun 2026 17:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CAB1F00893;
	Tue,  2 Jun 2026 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780420508;
	bh=+opkI2D1z70JJ/vyXa1VmjlNB/odsO3As2SLbmif/rE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hsYhUdN5KKWG43obmuWABfJvvB+ewozEiyAcEJkrqVowvYeX4Sbhkv/ZHsNCsCL0C
	 PuEq3PPixA9x5tQNrGdlZjMs/nfvUuC06QjE2Y7cB0yeUtylrbCbLbF1WPchcNr456
	 YREdjfcjh7jLC+4h3dZpTZYmIp8EQq+TFjuw7bgAbb4H55GQqNBOCPFO/VIOQSIRlk
	 sHMehCjbFbsOZhYgNlcp6gZG3QDfmAlKl46iY0wLWObVA2zJd+cJ8b5eaT1A3duByi
	 q3Xrt86L2n2fGNrpfS2HM51AHoMOKw2VCEPZOgWRjnJk2Rj10j6rc3keb/W+LO08Q6
	 GkKnaVMxdyDMA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Mike Rapoport <rppt@kernel.org>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>
Subject: Re: [PATCH 1/2] liveupdate: Reference count outgoing FLB data
In-Reply-To: <20260528174140.1921129-2-dmatlack@google.com> (David Matlack's
	message of "Thu, 28 May 2026 17:41:39 +0000")
References: <20260528174140.1921129-1-dmatlack@google.com>
	<20260528174140.1921129-2-dmatlack@google.com>
Date: Tue, 02 Jun 2026 19:15:05 +0200
Message-ID: <2vxzfr34dfty.fsf@kernel.org>
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

Hi David,

On Thu, May 28 2026, David Matlack wrote:

> Increment the outgoing FLB refcount in liveupdate_flb_get_outgoing() so
> that the FLB structure cannot be freed while the caller is actively
> using it. Add an additional liveupdate_flb_put_outgoing() function so
> the caller can explicitly indicate when it is done using the outgoing
> FLB.
>
> During a Live Update, the kernel may need to fetch the outgoing FLB
> outside of the scope of a file handler's preserve() and unpreserve()
> callbacks. In that situation there is no way for the caller to protect
> itself against the outgoing FLB from being freed while it is using it.
> Incrementing the reference count in liveupdate_flb_get_outgoing()
> ensures it cannot be freed.

We grab a reference to the FLB's module when the first file using the
FLB is preserved. So the FLB should never go away while preserved files
exist. Once all preserved files go away, you normally shouldn't be doing
anything with the FLB anyway.

Can you please elaborate on the use case and why this is a problem?
Using the FLB outside of the standard LUO file callbacks sounds
problematic.

>
> This change also aligns the outgoing FLB lifecycle management with the
> incoming FLB, since the latter uses the same get/put semantics.
>
> Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
> Assisted-by: Gemini:gemini-3-pro-preview
> Signed-off-by: David Matlack <dmatlack@google.com>
[...]

-- 
Regards,
Pratyush Yadav

