Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D516BC8303C
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vY3shkf8z5FBsuZ8kVm+yw6jHQ4FsVU5pkD2RW8AOE=; b=blCC0RbWwY+sxseJ03eUGiHNWy
	+ea2wEpwD6iYhEC7s3/tU1R5iS04tAkZC0Sy05lgpLqOuEXXbOa/F6/25/7rO+sP/ewYpp+DMY6iu
	egl4QjM0YdisVeOmpSxBhyV00PO6Ne3IUet5JmUDa8T6U2jed2jlOX+nmD56bP5194/chuSSYJC1D
	TBj/WlWYV+LWi7ABtqlsqCq119MMzg7Y79SMKP/EaF1NcbQCrcbU35NnBVMxSP8adePBEt8MYonN7
	TeRmPT70tYqwFyDyiv8r5LVRApf/VqckTTGdMgooDfhCTvLeyLcxEnzN1gpI3rtC2/4lmLS9bQp61
	LjRqjTzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZEc4-00000006SlH-0vQz;
	Tue, 08 Jul 2025 20:08:24 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZE4O-00000006LyI-3hRX
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 19:33:38 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:54402)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZE4L-000RSs-N6; Tue, 08 Jul 2025 13:33:33 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:56478 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZE4K-008C0F-0d; Tue, 08 Jul 2025 13:33:33 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev,  stable@vger.kernel.org,  Mario Limonciello
 <mario.limonciello@amd.com>,  Nat Wittstock <nat@fardog.io>,  Lucian Langa
 <lucilanga@7pot.org>,  "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
  rafael@kernel.org,  pavel@ucw.cz,  len.brown@intel.com,
  linux-pm@vger.kernel.org,  kexec@lists.infradead.org
References: <20250708000215.793090-1-sashal@kernel.org>
	<20250708000215.793090-6-sashal@kernel.org>
Date: Tue, 08 Jul 2025 14:32:02 -0500
In-Reply-To: <20250708000215.793090-6-sashal@kernel.org> (Sasha Levin's
	message of "Mon, 7 Jul 2025 20:02:13 -0400")
Message-ID: <87ms9esclp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uZE4K-008C0F-0d;;;mid=<87ms9esclp.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+WnfoI1XgX4gSY7g//vFBSvkA5FSvHJZo=
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rafael@kernel.org, rafael.j.wysocki@intel.com, lucilanga@7pot.org, nat@fardog.io, mario.limonciello@amd.com, stable@vger.kernel.org, patches@lists.linux.dev, sashal@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_123336_954657_D776632F 
X-CRM114-Status: GOOD (  36.93  )
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


Wow!

Sasha I think an impersonator has gotten into your account, and
is just making nonsense up.

At first glance this reads like an impassioned plea to backport this
change, from someone who has actually dealt with it.

Unfortunately reading the justification in detail is an exercise
in reading falsehoods.

If this does not come from an impersonator then:
- If this comes from a human being, I recommend you have a talk with
  them.
- If this comes from a machine I recommend you take it out of commission
  and rework it.

At best all of this appears to be an effort to get someone else to
do necessary thinking for you.  As my time for kernel work is very
limited I expect I will auto-nack any such future attempts to outsource
someone else's thinking on me.

Eric

Sasha Levin <sashal@kernel.org> writes:

> From: Mario Limonciello <mario.limonciello@amd.com>
>
> [ Upstream commit 12ffc3b1513ebc1f11ae77d053948504a94a68a6 ]
>
> Currently swap is restricted before drivers have had a chance to do
> their prepare() PM callbacks. Restricting swap this early means that if
> a driver needs to evict some content from memory into sawp in it's
> prepare callback, it won't be able to.
>
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
>
> Move the swap restriction to right after all devices have had a chance
> to do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
>
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Nat Wittstock <nat@fardog.io>
> Tested-by: Lucian Langa <lucilanga@7pot.org>
> Link: https://patch.msgid.link/20250613214413.4127087-1-superm1@kernel.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> **YES**
>
> This commit should be backported to stable kernel trees for the
> following reasons:

Really?  And when those reasons turn out to be baloney?

> ## Critical Bug Fix for Real User Issues
>
> 1. **Fixes Actual Suspend Failures**: The commit addresses real-world
>    suspend failures under memory pressure on systems with AMD discrete
>    GPUs. The linked issues (ROCm/ROCK-Kernel-Driver#174 and
>    freedesktop.org/drm/amd#2362) indicate this affects actual users.

Those linked issues are completely corrupted in the paragraph above.
From the original commit the proper issues are:

  https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
  https://gitlab.freedesktop.org/drm/amd/-/issues/2362

Which indicate that something is going on, but are old enough and
long enough coming to any kind of conclusion from them is not easy.

> 2. **Regression Fix**: This is effectively a regression fix. The PM
>    subsystem's early swap restriction prevents AMD GPU drivers from
>    properly evicting VRAM during their prepare() callbacks, which is a
>    requirement that has become more critical as GPU VRAM sizes have
>    increased.

There is no indication that this used to work, or that an earlier
kernel change caused this to stop working.  This is not a regression.

> ## Small, Contained Change
>
> 3. **Minimal Code Changes**: The fix is remarkably simple - it just
>    moves the `pm_restrict_gfp_mask()` call from early in the suspend
>    sequence to after `dpm_prepare()` completes. The changes are:
>    - Move `pm_restrict_gfp_mask()` from multiple early locations to
>      inside `dpm_suspend_start()` after `dpm_prepare()` succeeds
>    - Add corresponding `pm_restore_gfp_mask()` calls in error paths and
>      resume paths
>    - Remove the now-redundant calls from hibernate.c and suspend.c

Reworking how different layers of the kernel interact is not minimal,
and it not self contained.

> 4. **Low Risk of Regression**: The change maintains the original intent
>    of preventing I/O during the critical suspend phase while allowing it
>    during device preparation. The swap restriction still happens before
>    `dpm_suspend()`, just after `dpm_prepare()`.

There is no analysis anywhere on what happens to the code with
code that might expect the old behavior.

So it is not possible to conclude a low risk of regression,
in fact we can't conclude anything.

> ## Follows Stable Rules
>
> 5. **Meets Stable Criteria**:
>    - Fixes a real bug that bothers people (suspend failures)
Addresses a real bug, yes.  Fixes?
>    - Small change (moves function calls, doesn't introduce new logic)
No.
>    - Obviously correct (allows drivers to use swap during their
>      designated preparation phase)

Not at all.  It certainly isn't obvious to me what is going on.

>    - Already tested by users (Tested-by tags from affected users)

Yes there are Tested-by tags.

> ## Similar to Other Backported Commits
>
> 6. **Pattern Matches**: Looking at the similar commits provided, this
>    follows the same pattern as the AMD GPU eviction commits that were
>    backported. Those commits also addressed the same fundamental issue -
>    ensuring GPU VRAM can be properly evicted during suspend/hibernation.

Which other commits are those?

> ## Critical Timing

Timing?

> 7. **Error Path Handling**: The commit properly handles error paths by
>    adding `pm_restore_gfp_mask()` calls in:
>    - `dpm_resume_end()` for normal resume
>    - `platform_recover()` error path in suspend.c
>    - `pm_restore_gfp_mask()` in kexec_core.c for kexec flows

I don't see anything in this change that has to do with error paths.


> The commit is well-tested, addresses a real problem affecting users, and
> makes a minimal, obviously correct change to fix suspend failures on
> systems with discrete GPUs under memory pressure.

The evidence that a 3 week old change is well tested, simply
because it has been merged into Linus's change seems lacking.

Tested yes, but is it well tested?  Are there any possible side
effects?

I certainly see no evidence of any testing or any exercise at
all of the kexec path modified.  I wasn't even away of this
change until this backport came in.

Eric

