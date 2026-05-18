Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD04CD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+JXc6urRqBaQ7zlEv206JAVdV/Q99F+ECVZQ3WOS+NM=; b=P1yWSGJN4N9AH6hrsBiH9R6+xp
	wAFUvFBZ6qzxBKi+lyPmcnwlPtjYQnJM8ZH3KIBr1M6WeMqiuHMVdMj0Akq24lIKVQDpdXXYIuiMH
	T4rjmZYRH4Fp5uu6Rez7LlWzgb+jepUJlHIeZ3u+AH4yt79eGeZWnwCGiIYPw2goE0HD/MJd23q3G
	/Jp39CG8c0A6lfVXhP6iytUaDifMTlsodIFxq4Cjy/EP2s3OmYCz0oWjpDa9Gz8ITQQJM4DeV+nIY
	H1eXDYmTU7lbkHtSevhLbKX6EPCJ7v8ozYYi293TYINoFkfHt/LlRPy9111ZQ2/RL2ZwPyJyjzpWW
	pBdFmkJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0aa-0000000GGaV-404z;
	Mon, 18 May 2026 16:13:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0aZ-0000000GGaD-0mvg
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 16:13:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 60F7F600CB;
	Mon, 18 May 2026 16:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A879AC2BCB8;
	Mon, 18 May 2026 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779120786;
	bh=raMKx6Stu/7Zl70P8bwT58GnJzUQ+aRrbtvxtvfijnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RQypuo5gKzQ1SgqJu7j5Ad7nyMFzOS5MvYwNIwTyMtRV+y8ufV27zOIWPy2pFrjrR
	 8VBMhn3Y4AKv85nwtgDPxwxDbQf9JKsU1ndbtLCZedxUvCEM58UZasSnATcgCJ0Pgx
	 ehYk8AQZhdaiBJTI5Jj2ofGMx0thXqdJconVy9ns2299Djfo4Og53UAgxAnU2cFiZR
	 gDBzZlqaOmkiLiPOLCE8WyyOgVldTA1/0gggJliJEPDojSBLk4athlLGJtYioIdjcp
	 5ECwMDoeQUYNYQkhUeBey0rTYaKuVoyV+UejDzbVqYejNPAlBTAJCFLeecozLvj95y
	 CTd7ZaJhqawew==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com,  mario.limonciello@amd.com
Subject: Re: [PATCH v5 2/5] liveupdate: fix TOCTOU race in
 luo_session_retrieve()
In-Reply-To: <20260518125459.1092373-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 18 May 2026 12:54:56 +0000")
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
	<20260518125459.1092373-3-pasha.tatashin@soleen.com>
Date: Mon, 18 May 2026 18:13:02 +0200
Message-ID: <2vxz1pf8ae7l.fsf@kernel.org>
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

On Mon, May 18 2026, Pasha Tatashin wrote:

> Extend the scope of the rwsem_read lock in luo_session_retrieve() to
> overlap with the acquisition of the session mutex. This prevents a
> concurrent thread from releasing and freeing the session between the
> lookup and the mutex lock.
>
> Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

I was about to comment that perhaps we should drop session header lock
after getting session lock, but I think the session retrieval is pretty
fast so this should not matter.

So,

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

