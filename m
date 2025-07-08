Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2B5C8303C
	for <kexec@archiver.kernel.org>; Tue,  8 Jul 2025 21:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xI5bJu9KJgVOofLcjN47oRbaLf7PJ7KIh+BLa45sx10=; b=XtORzhiPJJfsUpQ+NoH4F/QJez
	P3IhWufBhbZ+kUmS9QLvb67OB/dAnpC+7NM69HBlw0q9nDMjtbX6Zkycc9FfvoXJXjFKKItpYq4vw
	Yfp/un03KJQPg2FTvtP8s0s3hbMdXoCsAAS9L1847WXKcuDpRGTK3fESmb0sstyqSyhwfCnhGWILX
	aAkt8GAqn4eh9SdGyX2Fqpq9WUaeRH3Fx//ir8hWtayt33uKwVymJUSnGe85phdL6mYyrH2ZfA8wH
	/DAgkd5Ar7rxiYm+YZqtjORb9ZAHf0rSSJhJA7B0S6+LjJwI7sXnOA792UIsv00vIrLBw0FxKdQId
	iEsIxT7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZG9S-00000006hMZ-3TrM;
	Tue, 08 Jul 2025 21:46:58 +0000
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZG9Q-00000006hMF-21Aw
	for kexec@lists.infradead.org;
	Tue, 08 Jul 2025 21:46:57 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:57132)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZG9N-008LxS-Uc; Tue, 08 Jul 2025 15:46:53 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:36886 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1uZG9M-00Enas-U3; Tue, 08 Jul 2025 15:46:53 -0600
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
Date: Tue, 08 Jul 2025 16:46:19 -0500
In-Reply-To: <aG2AcbhWmFwaHT6C@lappy> (Sasha Levin's message of "Tue, 8 Jul
	2025 16:32:49 -0400")
Message-ID: <87tt3mqrtg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1uZG9M-00Enas-U3;;;mid=<87tt3mqrtg.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19OibnjGVd1ekZqgNZch7WHltki3akpgkU=
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, len.brown@intel.com, pavel@ucw.cz, rafael@kernel.org, rafael.j.wysocki@intel.com, lucilanga@7pot.org, nat@fardog.io, mario.limonciello@amd.com, stable@vger.kernel.org, patches@lists.linux.dev, sashal@kernel.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_144656_516758_A30AA90B 
X-CRM114-Status: GOOD (  13.51  )
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

> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
>>
>>Wow!
>>
>>Sasha I think an impersonator has gotten into your account, and
>>is just making nonsense up.
>
> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/

It is nice it is giving explanations for it's backporting decisions.

It would be nicer if those explanations were clearly marked as
coming from a non-human agent, and did not read like a human being
impatient for a patch to be backported.

Further the machine given explanations were clearly wrong.  Do you have
plans to do anything about that?  Using very incorrect justifications
for backporting patches is scary.

I still highly recommend that you get your tool to not randomly
cut out bits from links it references, making them unfollowable.

>>At best all of this appears to be an effort to get someone else to
>>do necessary thinking for you.  As my time for kernel work is very
>>limited I expect I will auto-nack any such future attempts to outsource
>>someone else's thinking on me.
>
> I've gone ahead and added you to the list of people who AUTOSEL will
> skip, so no need to worry about wasting your time here.

Thank you for that.

I assume going forward that AUTOSEL will not consider any patches
involving the core kernel and the user/kernel ABI going forward.  The
areas I have been involved with over the years, and for which my review
might be interesting.

Eric

