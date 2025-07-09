Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFF7C83F0A
	for <kexec@archiver.kernel.org>; Wed,  9 Jul 2025 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=peiphLn7WYAcws2widEtRJqnYTA5p6lbYcNG/Zm0hf0=; b=qvYW6TdWaQt291XLaltQ4mEqgP
	jqSR+19d44FOZONhY771c0/EZ+syPMz3EuqAF+nAEUVr5YjSLYiLWb5N5vX8AY3XbjNrbPtgvlu0T
	xE0xEc4ai9S/k/oOxFV3XY2Qw8kSYo5MkQRA8Ps6B/PRJ3L20mgmS6lm5bge00AJpE+aoAY955+VE
	7CTU087VmtmmOC8JDROGfjZP/ce0numGsjZneaJg8VFyviQ4HfAf4imUlFo2N/lNS5iAp72hePfTH
	ulDCqfVNJdFqBIqm+rjTyK0zPq0kJv7zYQZY0DU8aiQwzu5WBRmpSt7jwHVKgHtG3/qxweKprELeE
	2xGNiI+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZaFd-00000009g2T-3jRK;
	Wed, 09 Jul 2025 19:14:41 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZXav-00000009J4C-3c1V
	for kexec@lists.infradead.org;
	Wed, 09 Jul 2025 16:24:31 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:55620)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZXap-00GDB9-ED; Wed, 09 Jul 2025 10:24:23 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:58876 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZXao-00G7I3-2H; Wed, 09 Jul 2025 10:24:23 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev,  stable@vger.kernel.org,  Mario Limonciello
 <mario.limonciello@amd.com>,  Nat Wittstock <nat@fardog.io>,  Lucian Langa
 <lucilanga@7pot.org>,  "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
  rafael@kernel.org,  pavel@ucw.cz,  len.brown@intel.com,
  linux-pm@vger.kernel.org,  kexec@lists.infradead.org
References: <20250708000215.793090-1-sashal@kernel.org>
	<20250708000215.793090-6-sashal@kernel.org>
	<87ms9esclp.fsf@email.froward.int.ebiederm.org>
	<aG2AcbhWmFwaHT6C@lappy>
	<87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
	<aG2bAMGrDDSvOhbl@lappy>
Date: Wed, 09 Jul 2025 11:23:36 -0500
In-Reply-To: <aG2bAMGrDDSvOhbl@lappy> (Sasha Levin's message of "Tue, 8 Jul
	2025 18:26:08 -0400")
Message-ID: <87ms9dpc3b.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uZXao-00G7I3-2H;;;mid=<87ms9dpc3b.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18thKjXD4GyCYLuzUNwo9PSKH5r56NcL1w=
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rafael@kernel.org, rafael.j.wysocki@intel.com, lucilanga@7pot.org, nat@fardog.io, mario.limonciello@amd.com, stable@vger.kernel.org, patches@lists.linux.dev, sashal@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_092429_928594_1B253A2A 
X-CRM114-Status: GOOD (  38.95  )
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

Sasha Levin <sashal@kernel.org> writes:

> On Tue, Jul 08, 2025 at 04:46:19PM -0500, Eric W. Biederman wrote:
>>Sasha Levin <sashal@kernel.org> writes:
>>
>>> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
>>>>
>>>>Wow!
>>>>
>>>>Sasha I think an impersonator has gotten into your account, and
>>>>is just making nonsense up.
>>>
>>> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/
>>
>>It is nice it is giving explanations for it's backporting decisions.
>>
>>It would be nicer if those explanations were clearly marked as
>>coming from a non-human agent, and did not read like a human being
>>impatient for a patch to be backported.
>
> Thats a fair point. I'll add "LLM Analysis:" before the explanation to
> future patches.
>
>>Further the machine given explanations were clearly wrong.  Do you have
>>plans to do anything about that?  Using very incorrect justifications
>>for backporting patches is scary.
>
> Just like in the past 8 years where AUTOSEL ran without any explanation
> whatsoever, the patches are manually reviewed and tested prior to being
> included in the stable tree.

I believe there is some testing done.  However for a lot of what I see
go by I would be strongly surprised if there is actually much manual
review.

I expect there is a lot of the changes are simply ignored after a quick
glance because people don't know what is going on, or they are of too
little consequence to spend time on.

> I don't make a point to go back and correct the justification, it's
> there more to give some idea as to why this patch was marked for
> review and may be completely bogus (in which case I'll drop the patch).
>
> For that matter, I'd often look at the explanation only if I don't fully
> understand why a certain patch was selected. Most often I just use it as
> a "Yes/No" signal.
>
> In this instance I honestly haven't read the LLM explanation. I agree
> with you that the explanation is flawed, but the patch clearly fixes a
> problem:
>
> 	"On AMD dGPUs this can lead to failed suspends under memory
> 	pressure situations as all VRAM must be evicted to system memory
> 	or swap."
>
> So it was included in the AUTOSEL patchset.


> Do you have an objection to this patch being included in -stable? So far
> your concerns were about the LLM explanation rather than actual patch.

Several objections.
- The explanation was clearly bogus.
- The maintainer takes alarm.
- The patch while small, is not simple and not obviously correct.
- The patch has not been thoroughly tested.

I object because the code does not appear to have been well tested
outside of the realm of fixing the issue.

There is no indication that the kexec code path has ever been exercised.

So this appears to be one of those changes that was merged under
the banner of "Let's see if this causes a regression".

To the original authors.  I would have appreciated it being a little
more clearly called out in the change description that this came in
under "Let's see if this causes a regression".

Such changes should not be backported automatically.  They should be
backported with care after the have seen much more usage/testing of
the kernel they were merged into.  Probably after a kernel release or
so.  This is something that can take some actual judgment to decide,
when a backport is reasonable.

>>I still highly recommend that you get your tool to not randomly
>>cut out bits from links it references, making them unfollowable.
>
> Good point. I'm not really sure what messes up the line wraps. I'll take
> a look.

It was a bit more than line wraps.  At first glance I thought
it was just removing a prefix from the links.  On second glance
it appears it is completely making a hash of links:

The links in question:
https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
https://gitlab.freedesktop.org/drm/amd/-/issues/2362

The unusable restatement of those links:
ROCm/ROCK-Kernel-Driver#174
freedesktop.org/drm/amd#2362

Short of knowing to look up into the patch to find the links,
those references are completely junk.

>>>>At best all of this appears to be an effort to get someone else to
>>>>do necessary thinking for you.  As my time for kernel work is very
>>>>limited I expect I will auto-nack any such future attempts to outsource
>>>>someone else's thinking on me.
>>>
>>> I've gone ahead and added you to the list of people who AUTOSEL will
>>> skip, so no need to worry about wasting your time here.
>>
>>Thank you for that.
>>
>>I assume going forward that AUTOSEL will not consider any patches
>>involving the core kernel and the user/kernel ABI going forward.  The
>>areas I have been involved with over the years, and for which my review
>>might be interesting.
>
> The filter is based on authorship and SoBs. Individual maintainers of a
> subsystem can elect to have their entire subsystem added to the ignore
> list.

As I said.  I expect that the process looking at the output of
get_maintainers.pl and ignoring a change when my name is returned
will result in effectively the entire core kernel and the user/kernel
ABI not being eligible for backport.

I bring this up because I was not an author and I did not have any
signed-off-by's on the change in question, and yet I was still selected
for the review.

Eric


