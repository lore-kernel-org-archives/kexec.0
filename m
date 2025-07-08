Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CDAC83F09
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 22:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/pV2laUaP5KydpuaM+0nsFpkRDJJ3/tPoYGgyNyAHvY=; b=OL6n6C0UU2pGv9qvUuigxDDRTL
	ge1ZpyXyOd181irHMlHGf7wkJ1cQMIDZt0BUgI09yoMU84qGVOSXT3w+e0pCKAqggeiv1iQobI3K0
	ZhZDarQxtBx9MvWgnJ4CYE33GS4jcP5GRCX2qvcEzk8eQI+izmDJcaFkrsqcidmRlO4j6wr74ixqm
	hAfcDMte9eyKfZD+79jNpplXZ4Vfh66oRc76cSDMvvaqATq8lIs7HGTSk+pheEuqUbLW/t1C+sGBQ
	gWMG2wmR5v7GoB73mJY5bKE4aRTDXvOEuDMG/s6mJ04dmmKbiPel4IG/p5nuVfHhxxhfpEq2e/xpW
	2nX7mm2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZGmY-00000006njw-2Kd2;
	Tue, 08 Jul 2025 22:27:22 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZGlS-00000006nZf-07Zo
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 22:26:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 15080A544EE;
	Tue,  8 Jul 2025 22:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86910C4CEED;
	Tue,  8 Jul 2025 22:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752013572;
	bh=kYrg6N+iGJMB3IncQTR1f8OwIscAnjjBNP5f3b7e5/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N62kqzG3NbPhzfYpzEbe0IPQjFyIGvaSTDFEhbBD/JDkeVFMVEjoJFEp77oFrsjVE
	 rCNBR1xWAVvYmjnunsZQ8nClEVBtz+wJ5kAT6OWlXddQMjTXXwTLw4KRI6y92gVUP7
	 ZjFfmpU/0LFOlrGYlGtWWNxcluXoc1wwbUe0NTz//PhGhy/yaBo42EmmHT+pjs2gYa
	 tuvp7weNCCOehJsFmKSzTTH+9vRbk7VshhBMmBLunmjvWt2FkPaDZWDcq0JBFHojeD
	 FcJk1ixVy3/e4C/04RV4dGSJiO2W3K2wUacnkhKTgp+URmsU/twlmNDg+6Cqp2t6bk
	 VrOGmiJSSzdPQ==
Date: Tue, 8 Jul 2025 18:26:08 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
	linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
Message-ID: <aG2bAMGrDDSvOhbl@lappy>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_152614_200851_C805B730 
X-CRM114-Status: GOOD (  20.21  )
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

On Tue, Jul 08, 2025 at 04:46:19PM -0500, Eric W. Biederman wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
>> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
>>>
>>>Wow!
>>>
>>>Sasha I think an impersonator has gotten into your account, and
>>>is just making nonsense up.
>>
>> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/
>
>It is nice it is giving explanations for it's backporting decisions.
>
>It would be nicer if those explanations were clearly marked as
>coming from a non-human agent, and did not read like a human being
>impatient for a patch to be backported.

Thats a fair point. I'll add "LLM Analysis:" before the explanation to
future patches.

>Further the machine given explanations were clearly wrong.  Do you have
>plans to do anything about that?  Using very incorrect justifications
>for backporting patches is scary.

Just like in the past 8 years where AUTOSEL ran without any explanation
whatsoever, the patches are manually reviewed and tested prior to being
included in the stable tree.

I don't make a point to go back and correct the justification, it's
there more to give some idea as to why this patch was marked for
review and may be completely bogus (in which case I'll drop the patch).

For that matter, I'd often look at the explanation only if I don't fully
understand why a certain patch was selected. Most often I just use it as
a "Yes/No" signal.

In this instance I honestly haven't read the LLM explanation. I agree
with you that the explanation is flawed, but the patch clearly fixes a
problem:

	"On AMD dGPUs this can lead to failed suspends under memory
	pressure situations as all VRAM must be evicted to system memory
	or swap."

So it was included in the AUTOSEL patchset.

Do you have an objection to this patch being included in -stable? So far
your concerns were about the LLM explanation rather than actual patch.

>I still highly recommend that you get your tool to not randomly
>cut out bits from links it references, making them unfollowable.

Good point. I'm not really sure what messes up the line wraps. I'll take
a look.

>>>At best all of this appears to be an effort to get someone else to
>>>do necessary thinking for you.  As my time for kernel work is very
>>>limited I expect I will auto-nack any such future attempts to outsource
>>>someone else's thinking on me.
>>
>> I've gone ahead and added you to the list of people who AUTOSEL will
>> skip, so no need to worry about wasting your time here.
>
>Thank you for that.
>
>I assume going forward that AUTOSEL will not consider any patches
>involving the core kernel and the user/kernel ABI going forward.  The
>areas I have been involved with over the years, and for which my review
>might be interesting.

The filter is based on authorship and SoBs. Individual maintainers of a
subsystem can elect to have their entire subsystem added to the ignore
list.

-- 
Thanks,
Sasha

