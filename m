Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954AFC83F1D
	for <kexec@archiver.kernel.org>; Thu, 10 Jul 2025 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G7DcbmMqL58QSRYvjU6ux4tXv5N0M2pspqDuxfXvmwI=; b=oqsTSEDWsIOaVIizjs4kvRMDHh
	IPRYqyGtvfYSXiYmRH75w2RfuxG5J1jEDNSgqO2HfFdfd3tX/gthGqVPuSN+1qjo56yN2+lfmrKSS
	xTXf5WcjgS71DafdYm2nFXpWY+MXKr2NLsQWZYdg8Bc4UKMMnViZJSKVg8Sf9KHuNJd5F9rxbka5H
	E9aCJEvrjeHLOd1IQfB7G4simq9PKqNS9Fp/jsPxP7piZrnKWxoaB6+bb8MsonBvBI8tlyLbX8pWO
	2HLk24E/Ko32tlfBGHq+eJWC6QLzYReZaHyWV0baSmQWUXJjk2xPVtnmogaBM8zIAaahLkAIFmvGm
	EXC7w4Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZsZw-0000000CAUE-0uVi;
	Thu, 10 Jul 2025 14:48:52 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZr5C-0000000BtAE-0pHB
	for kexec@lists.infradead.org;
	Thu, 10 Jul 2025 13:13:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A45BF6146C;
	Thu, 10 Jul 2025 13:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EABC4CEED;
	Thu, 10 Jul 2025 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153181;
	bh=G7DcbmMqL58QSRYvjU6ux4tXv5N0M2pspqDuxfXvmwI=;
	h=From:To:Cc:Subject:Date:From;
	b=SeKNo4PnRUeD1IItr4pG0/AKI2v46qPG5UEB0UWIikDIyYgIjSSn6wB0nrpxB7UVp
	 CLqTZahoWQ32TjMjoaTaPzL9mPvsUj053OB3u8GnYFcHqWlh6KavJRs2VlDGMg0EjD
	 fqvag2hAkjGHtUWceQHTuiSJJwX0syKisP3CFCy9oPr2+S+i67zheIwi6sk1AryxaV
	 g9flzqa+nsX4u+HT9Ljbf/rH3M1aMlYl0VbytabwmsOTsBjXeQryFbOacPqti2eX1d
	 ZclD4LEXw5H02FGEwezHxKZRIg7sIOVVccaLO4f1ntUIMDv9GKCL+I3DHgtDi8ohTK
	 3dK9Q0eVyPrFQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: kexec@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v1 0/2] kexec_core: Fix and cleanup for the KEXEC_JUMP flow
Date: Thu, 10 Jul 2025 15:08:58 +0200
Message-ID: <5046396.31r3eYUQgx@rjwysocki.net>
Organization: Linux Kernel Development
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
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

Hi Everyone,

These two patches fix an error code path issue in the KEXEC_JUMP flow (patch
[1/2]) and clean it up a bit afterward (patch [2/2]).

Please see patch changelogs for details.

Thanks!




