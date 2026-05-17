Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4899CD4F47
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ANGdet01btbIVwd5pO5dEijpIwWAXlcSALe+yO4D/s=; b=XyalFB/2fMVL3DDr9zpN6VfRFb
	6ZBKWd4i7++C+PLRxJGzSylzgwK/VLZROBBFOnjUPzBI3bTEcOe5/LOVqwHhF0hwwa1fSKPqjmr9I
	1Vl0XSksk2uWVErPCmgwrKwIX9Vi0TW5eYgoWfWn7VcnLCsrKg/q/u6dvz8CFT80Rmy8edlmWyoq/
	H5NWbp7EdSCPexzo3YVLro00Ja3enfl/8U6Swa++MmYpP6VprY7MikZAb6d4sfLbJFrq6p6v821Zb
	djjN8MsL36XTBYI/Fy/5y2WIoBSjvj/bH/2kAr/ULy+expGtYmd6UfytWNT2oWAkBf6pjXRlWbRQ9
	j+6xSovA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfOQ-0000000D7wt-3rYU;
	Sun, 17 May 2026 17:35:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfOQ-0000000D7wi-1Ujz
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:35:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A63FF60125;
	Sun, 17 May 2026 17:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE652C2BCB0;
	Sun, 17 May 2026 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039309;
	bh=Z12kFRYy0M/EBrdKq9sEAZ94/ePFMsKWkRd0ZfTHxeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8zZOOisPy/dfHu9zDiX5r9+1f/foenG+EZgtGulAhMTuEQ2qVvK4717slDC7SCLg
	 E/B7XlG86btudizxXtXqSE0NW0I87DRHbeMEC/dMrLEN8zwI31Efv/LevZZQEXrlvS
	 HgauKMxBADhqmfIvQrJEfAMBfTO2X1kHe74Ep9Jq4Sc4CIt+QqHx0tloWRB21GHkYb
	 N6Hs3zOcdKc7bASLfS4kj2KSwTynl6TPJQg2QTKrIKId8HpQbqGewBS+kqZ0z6c08X
	 eQDfp4yYE2BZorJA6AiqM48Lr76dbJo5JCK9p3YPX2XD2LEKXSFaz43wdZDS4PZaZC
	 h3O5unJAhv+Rw==
Date: Sun, 17 May 2026 20:35:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v2 08/10] selftests/liveupdate: Test session and file
 limit removal
Message-ID: <agn8RUGJ5RcySkUY@kernel.org>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-9-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514222628.931312-9-pasha.tatashin@soleen.com>
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

On Thu, May 14, 2026 at 10:26:26PM +0000, Pasha Tatashin wrote:
> With the removal of static limits on the number of sessions and files per
> session, the orchestrator now uses dynamic allocation.
> 
> Add new test cases to verify that the system can handle a large number of
> sessions and files. These tests ensure that the dynamic block allocation
> and reuse logic for session metadata and outgoing files work correctly
> beyond the previous static limits.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  .../testing/selftests/liveupdate/liveupdate.c | 75 +++++++++++++++++++
>  .../selftests/liveupdate/luo_test_utils.c     | 24 ++++++
>  .../selftests/liveupdate/luo_test_utils.h     |  2 +
>  3 files changed, 101 insertions(+)

-- 
Sincerely yours,
Mike.

