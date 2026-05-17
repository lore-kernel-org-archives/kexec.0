Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE81CD4F4B
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iPqvW9kquYgvzmaiz++fw4/QyFASXqMx3JRJpCmeGxc=; b=n+3E0iCZQiBsbeRBp/E3TL8rww
	JqP1bQo/QsX5p2sZLOsqezk8eHdttO2a2ic61QgDD3TFqon56HezXHHQ6UqjDg2TtaThffD/T1MEd
	dg128SuRTSh5F910IeRtZmP7ofMHpzMR92A35M7P3ArSo12eNk94Ny0HSUfVHftOZigCp+ar4xmWr
	BMy2b+3ihxoQCs4IXUt1aeVpBhNQOghqra3EZi7pQhnVM2NA8I78tq4gZIu0d0JXr/14lRgD5yq43
	jcMcTSApel8avZQ3AzQIJPIQwaGuWBsb8wqPtK7QZIOVMqCXnOeHBiXzpfQHM+mFOJMZQgw6bflTp
	XNUWajqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfWk-0000000D8hm-3dot;
	Sun, 17 May 2026 17:43:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfWi-0000000D8h5-1EJ3
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:43:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D7237419BE;
	Sun, 17 May 2026 17:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118B7C2BCB0;
	Sun, 17 May 2026 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039823;
	bh=rWCwn0WhZmPuLcMpCzhXHEHqKaFyvDfyRV9d6IBQCpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LxnXMPN3DwEeFnD+T6HY2+pMONdBh+tn06Qz2lB/yxMEd/VAUkNs2PlZKOiTSNgKS
	 sBzrflt7jRNKxLO+cc9YxHhDQHa7XZI0s/LfNi78xBu33hHs7W2to4KcdX+40y3Ywl
	 KC9gKkcxcsix2Af0AtkG6j/8ERSXWFhrbl/mWdBuaiEAOWWrbR1sa0WKig6GyTktTx
	 WeU3H/yjG99XgekNHH3ckYytmdCajw6j9POPgxrG/iHKTJbe4kUZq7V1VGC2zR70XK
	 jwhMi9ErZJkA+XirPdeTF/pXRqSgYA8rHDDSwW3KMb0yVzz10IEXgXabNXgjEQpRrv
	 liEeRoB6MeFAA==
Date: Sun, 17 May 2026 20:43:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kees@kernel.org, sourabhjain@linux.ibm.com, jbouron@amazon.com,
	akpm@linux-foundation.org, bhe@redhat.com,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	rafael.j.wysocki@intel.com, piliu@redhat.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com, mario.limonciello@amd.com
Subject: Re: [PATCH v3 0/5] liveupdate: serialization safety and race fixes
Message-ID: <agn-R5TPNmUSeU3y@kernel.org>
References: <20260515003722.938123-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515003722.938123-1-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_104344_374287_D616DAA8 
X-CRM114-Status: GOOD (  20.52  )
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

On Fri, May 15, 2026 at 12:37:17AM +0000, Pasha Tatashin wrote:
> This series addresses several issues related to the synchronization
> between the reboot process and LUO session management.
> 
> Changes in v3:
> - Refined the session mutation blocking to use a dedicated global
>   rwsem (luo_session_serialize_rwsem) instead of pinning individual
>   mutexes.
> - Fixed a use-after-free race in luo_file_unpreserve_files() where
>   a module could be released before its file handler ID was erased.
> - Fixed a TOCTOU race in luo_session_retrieve() by extending the
>   lock scope to overlap with session mutex acquisition.
> - Removed an unused 'ser' field from struct luo_session.
> - Dropped the KHO skip patch as it was not needed.
> 
> 1. Skip LUO serialization for context-preserving kexec: A
> preserve_context kexec returns to the current kernel, which is unrelated
> to live update where state is passed to the next kernel. Skipping
> serialization avoids unnecessary work and prevents sessions from being
> left in a frozen state upon return.
> 
> 2. Block session mutations during reboot: During the reboot() syscall,
> user processes may still be running concurrently and attempting to
> mutate sessions. To prevent this, we introduce luo_session_serialize_rwsem.
> All mutation operations (create, retrieve, release, ioctl) hold the
> read lock. The serialization process holds the write lock indefinitely
> on success, effectively freezing the subsystem.
> 
> 3. Fix use-after-free in luo_file_unpreserve_files(): Reorder module_put()
> to ensure the file handler module remains pinned while its operations
> are being accessed during cleanup.
> 
> 4. Fix TOCTOU race in luo_session_retrieve(): Extend the rwsem lock
> scope to prevent a session from being released between lookup and
> mutex acquisition.
> 
> 5. Remove unused ser field from struct luo_session: Clean up the
> session structure by removing a field that was never utilized.

Sashiko is still unhappy:
https://sashiko.dev/#/patchset/20260515003722.938123-1-pasha.tatashin@soleen.com

Didn't verify it's actually right, but its complaints seem legit.

Among other things sashiko noted a TOCTOU issue and then found it's fixed
by a later patch, maybe move the TOCTOU fix earlier in the series?
 
> Tree: git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git Branch:
> luo-reboot-sync/v3
> 
> Pasha Tatashin (5):
>   liveupdate: skip serialization for context-preserving kexec
>   liveupdate: block session mutations during reboot
>   liveupdate: fix u-a-f in luo_file_unpreserve_files() and
>     luo_file_finish()
>   liveupdate: fix TOCTOU race in luo_session_retrieve()
>   liveupdate: Remove unused ser field from struct luo_session
> 
>  kernel/kexec_core.c              |  8 +++++---
>  kernel/liveupdate/luo_file.c     |  5 +++--
>  kernel/liveupdate/luo_internal.h |  2 --
>  kernel/liveupdate/luo_session.c  | 27 ++++++++++++++++++++-------
>  4 files changed, 28 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 7b0b68b2b95606e65594958686833e53423f58f2
> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.

