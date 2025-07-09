Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFD0C83F1A
	for <kexec@archiver.kernel.org>; Wed,  9 Jul 2025 21:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y9bMpUuQtQeeQH+QiKzkr3wMeLvk6l4d4iV8OOHq5bE=; b=b04FE+BGwJ7l3laY6Deq+7Lq8s
	mqtaeYrovE57wJCVsvrZJcXSj2YFSd6uevHRJSRrSsdU6IhcivtuTknm1IW5LgckQdO/65LNLjwIg
	eQxg+1DVaucQa7DcAlJB/qW3MBoaddw7W271ax2dAAhYoh+Xlx3WeyhyI8ZBNde5oHWyB31091r4W
	j+xTezv+BfSOIdkpqTqcbyrfzi9BWRwXz49l5++24iO1fQJ5cB14S7pFxMcuL+e/l7oIQfMpERe7u
	L4mThjH0UT46pWpy1FY86mprFztuLqUgs8hGb9oz9GbRAV9wbVOjWitudt7/cljEBgkpJVvbFyUrR
	nDG5QQ3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZcoL-00000009xfg-3Qav;
	Wed, 09 Jul 2025 21:58:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZYjq-00000009Rky-0LfN
	for kexec@lists.infradead.org;
	Wed, 09 Jul 2025 17:37:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 60F0761154;
	Wed,  9 Jul 2025 17:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC82AC4CEF4;
	Wed,  9 Jul 2025 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752082665;
	bh=UrMsQCIJDhTzvXs4RqAiNo8Cvl8Hxt1Ziw4xZzCivP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLHtwoBRBDQXByIwztN3KSGJHjSq3oNBskn8+BqLMMhqdtnTR0UyUptamUZIYxGzS
	 05rD14LKHLKqTeimzJ2y929jnGWklGIhtvQp6ocTIgZI3vagwr61joiQn1TPHnUZ89
	 ycdYhIM+lzyzlbzjyDSkxSyKQ6uYEu5lkXBMrDbs3vtdGAMwESE30BKXvvCDPaVQUt
	 W7dT2TuhGDf9YXB8WzyeFU2zclFXHgGlkoBe4ce2jqo0L70OLsP/cbUwRrE/xtKpDK
	 byWECBlTs4hfYQ4Le26gLoYuh+ujVmaP2G9fkzWyxgJrH2kUpRW7Z/X8wfGAOFJC6w
	 5tyz4QMbmlGCg==
Date: Wed, 9 Jul 2025 13:37:40 -0400
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
Message-ID: <aG6o5BYqwe1RmSqb@lappy>
References: <20250708000215.793090-1-sashal@kernel.org>
 <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org>
 <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
 <aG2bAMGrDDSvOhbl@lappy>
 <87ms9dpc3b.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ms9dpc3b.fsf@email.froward.int.ebiederm.org>
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

On Wed, Jul 09, 2025 at 11:23:36AM -0500, Eric W. Biederman wrote:
>There is no indication that the kexec code path has ever been exercised.
>
>So this appears to be one of those changes that was merged under
>the banner of "Let's see if this causes a regression".
>
>To the original authors.  I would have appreciated it being a little
>more clearly called out in the change description that this came in
>under "Let's see if this causes a regression".
>
>Such changes should not be backported automatically.  They should be
>backported with care after the have seen much more usage/testing of
>the kernel they were merged into.  Probably after a kernel release or
>so.  This is something that can take some actual judgment to decide,
>when a backport is reasonable.

I'm assuming that you also refer to stable tagged patches that get
"automatically" picked up, right?

We already have a way to do what you suggest: maintainers can choose
not to tag their patches for stable, and have both their subsystem
and/or individual contributions ignored by AUTOSEL. This way they can
send us commits at their convenience.

There is one subsystem that is mostly doing that (XFS).

The other ones are *choosing* not to do that.

-- 
Thanks,
Sasha

