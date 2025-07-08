Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15794C8303C
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u+UdQVATKpynu6Se/2hwAPkISfyKdcXbbPHKp8LodwE=; b=SCkwa9er5M/oKQ8PJiwuhEuaZ8
	Gjt13GDkZQvfzHmHl7CSbl2LBfDlxt99cd/OIBKKtvBNlf5iteeDsXposdSMb6cOD5vJKl8sw9ZLh
	df5Xt4Np1/yPG6GKD4J0X06dKsr27XvQTsn52bObEVajHnl3nfHIct/yIBYyUx0ZRMqubDB67hONA
	Vdf46np0mrgRhIZ2iqCBHDF7unZPe9GKhUsXozcKwqS9By+Gn9JWbtiooFUSdhepz6Uge2oszRIcu
	e+oHjPzccipiHqlnJpYhhVOrvNdgmy6kaonqB4Cok+Cjl6m2D1dGF30ztFyO/LPF4DGe1lBzZwCjA
	8dSIKh6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZESm-00000006RZa-1T3f;
	Tue, 08 Jul 2025 19:58:48 +0000
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZDlx-00000006KgB-3ksr
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 19:14:35 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:47190)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZDld-0087r7-EQ; Tue, 08 Jul 2025 13:14:13 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:57294 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZDlb-00EWoI-M0; Tue, 08 Jul 2025 13:14:13 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev,  stable@vger.kernel.org,  Mario Limonciello
 <mario.limonciello@amd.com>,  Nat Wittstock <nat@fardog.io>,  Lucian Langa
 <lucilanga@7pot.org>,  "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
  rafael@kernel.org,  pavel@ucw.cz,  len.brown@intel.com,
  linux-pm@vger.kernel.org,  kexec@lists.infradead.org
References: <20250708000215.793090-1-sashal@kernel.org>
	<20250708000215.793090-6-sashal@kernel.org>
Date: Tue, 08 Jul 2025 14:13:42 -0500
In-Reply-To: <20250708000215.793090-6-sashal@kernel.org> (Sasha Levin's
	message of "Mon, 7 Jul 2025 20:02:13 -0400")
Message-ID: <87ikk2wl5l.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uZDlb-00EWoI-M0;;;mid=<87ikk2wl5l.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18eWuTXhpEEG+cAz+KqRLkQHqIlLXpyYLk=
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rafael@kernel.org, rafael.j.wysocki@intel.com, lucilanga@7pot.org, nat@fardog.io, mario.limonciello@amd.com, stable@vger.kernel.org, patches@lists.linux.dev, sashal@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_121433_960831_54E441A4 
X-CRM114-Status: GOOD (  28.67  )
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

Sasha I think an impersonator has gotten into your account, and is
just making nonsense up.

This reads like an impassioned plea to backport this change, from
someone who has actually dealt with it.

However reading the justification in detail is an exercise in reading
falehoods.

If this does not come from an impersonator then if this comes
from a human being, I recommend you have a talk with them.

If this comes from a machine I recommend take it out of commission
and rework it.

If I see this kind of baloney again I expect I will just auto-nack
it instead of reading it, as reading it appears to be a waste of
time.  It is a complete waste reading fiction in what little time I have
for kernel development.

Eric


Sasha Levin <sashal@kernel.org> writes:

> **YES**
>
> This commit should be backported to stable kernel trees for the
> following reasons:
>
> ## Critical Bug Fix for Real User Issues
>
> 1. **Fixes Actual Suspend Failures**: The commit addresses real-world
>    suspend failures under memory pressure on systems with AMD discrete
>    GPUs. The linked issues (ROCm/ROCK-Kernel-Driver#174 and
>    freedesktop.org/drm/amd#2362) indicate this affects actual users.

The links in the first paragraph are very distorted.  The links
from the actual change are:

 https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
 https://gitlab.freedesktop.org/drm/amd/-/issues/2362

Those completely distorted links make understanding this justification
much harder then necessary.


> 2. **Regression Fix**: This is effectively a regression fix. The PM
>    subsystem's early swap restriction prevents AMD GPU drivers from
>    properly evicting VRAM during their prepare() callbacks, which is a
>    requirement that has become more critical as GPU VRAM sizes have
>    increased.

That is a justification.   There is no evidence that a kernel change
made this worse.  Thus there is no evidence this is a regression fix.


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

Completely wrong.  

> 4. **Low Risk of Regression**: The change maintains the original intent
>    of preventing I/O during the critical suspend phase while allowing it
>    during device preparation. The swap restriction still happens before
>    `dpm_suspend()`, just after `dpm_prepare()`.

This is a fundamental change to a susbsystem that the subsystem
maintainer does not say is low risk.

> ## Follows Stable Rules
>
> 5. **Meets Stable Criteria**:
>    - Fixes a real bug that bothers people (suspend failures)
Addresses a real bug.

>    - Small change (moves function calls, doesn't introduce new logic)

The change is a large change in the logic.

>    - Obviously correct (allows drivers to use swap during their
>      designated preparation phase)

It obviously changes the behavior.  It is not at all obvious
the change is behavior is desirable for all callbacks, and in all
other scenarios.


>    - Already tested by users (Tested-by tags from affected users)
Yes it has Tested-by tags.

> ## Similar to Other Backported Commits
>
> 6. **Pattern Matches**: Looking at the similar commits provided, this
>    follows the same pattern as the AMD GPU eviction commits that were
>    backported. Those commits also addressed the same fundamental issue -
>    ensuring GPU VRAM can be properly evicted during suspend/hibernation.

Which commits that were backported?

> ## Critical Timing

Timing???  There is no race condition.

> 7. **Error Path Handling**: The commit properly handles error paths by
>    adding `pm_restore_gfp_mask()` calls in:
>    - `dpm_resume_end()` for normal resume
>    - `platform_recover()` error path in suspend.c
>    - `pm_restore_gfp_mask()` in kexec_core.c for kexec flows
>
> The commit is well-tested, addresses a real problem affecting users, and
> makes a minimal, obviously correct change to fix suspend failures on
> systems with discrete GPUs under memory pressure.

What evidence is there that this commit has been tested let alone
well-tested.

The entire line of reasoning is completely suspect.

Eric

