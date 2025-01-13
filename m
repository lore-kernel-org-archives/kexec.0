Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837B8C02183
	for <kexec@archiver.kernel.org>; Mon, 13 Jan 2025 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HBo0YMZ3d0oXUPnPJWk3InYyenyWhNMLTbu8rwC8ej4=; b=C4Y48oJtqCrjnM6m8AB5w7fDog
	cllDEqvAOfz9+lCfT4PsALskzlEtWz+3VLR6VI3rli+UMfW/aRF51qkCMW/MBxQjmx8Kuhp6csIxc
	czYPbmXDpVsubClx9ikeY3oLgoWEdq+wm6NNA7Isfh8LMplKh5jMrJ8DKo8boDbNvTLE1U6iT1njx
	pu8DSfukV66h3mlZnq1j+WBpD+vf5nL5dp5ZvXRQOgmxJsrIUB5v2bArMIF63DAyPKFh18NmXVdNX
	dEvzOa/NPJp5b7fBrvIPhOrwIqVV+6WF/shLCPhCcU7d8LwO3/P4blj0VvQ9u0VdTagYadJ2bqNo0
	DgTIToAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMfv-00000005iKg-2QqX;
	Mon, 13 Jan 2025 15:48:23 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXLvQ-00000005WbG-0yHk
	for kexec@lists.infradead.org;
	Mon, 13 Jan 2025 15:00:21 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:35590)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tXLv7-00Admf-N7; Mon, 13 Jan 2025 08:00:02 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:55228 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tXLv6-000swr-IG; Mon, 13 Jan 2025 08:00:01 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Baoquan He <bhe@redhat.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
 akpm@linux-foundation.org,  kexec@lists.infradead.org,
 Yan Zhao <yan.y.zhao@intel.com>,  linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev,  x86@kernel.org,
 rick.p.edgecombe@intel.com,  kirill.shutemov@linux.intel.com,
 <security@kernel.org> 
References: <20241213094930.748-1-yan.y.zhao@intel.com>
	<xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
	<Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
Date: Mon, 13 Jan 2025 08:59:29 -0600
In-Reply-To: <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv> (Baoquan He's message of "Mon,
	13 Jan 2025 19:12:27 +0800")
Message-ID: <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tXLv6-000swr-IG;;;mid=<87zfjuoj3i.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18ro5uu5wQTqj8Qfoky/SpdstYY4sC8eAg=
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: security@kernel.org, kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, kexec@lists.infradead.org, akpm@linux-foundation.org, kirill@shutemov.name, bhe@redhat.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_070020_269731_4BB1AC16 
X-CRM114-Status: GOOD (  25.44  )
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

Baoquan He <bhe@redhat.com> writes:

> On 01/13/25 at 12:01pm, Kirill A. Shutemov wrote:
>> On Fri, Dec 13, 2024 at 05:49:30PM +0800, Yan Zhao wrote:
>> > Hi Eric,
>> > 
>> > This is a repost of the patch "kexec_core: Accept unaccepted kexec
>> > destination addresses" [1], rebased to v6.13-rc2.
>> 
>> Can we get this patch applied?
>
> This looks good to me. In v1, we have analyzed all other possible
> solutions, however change in this patch seems the simplest and most
> accepatable one.

Truly?  I will go back and look and see what I missed but I haven't seen
anything that I addressed my original objections.

To repeat my objection.  The problem I saw was that the performance of
the accepted memory paradigm was so terrible that they had to resort to
lazily ``accepting'' memory, which leads to hacks in kexec.  I would not
like to included hacks in kexec just so that other people can avoid
fixing their bugs.

I did see a coherent explanation of the bad performance that pointed the
finger squarely at the fact that everything is happening a page at a
time.  AKA that the design of the ACPI interface has a flaw that needs
to be fixed.

I really don't think we should be making complicated work-arounds for
someone else's bad software decision just because someone immortalized
their bad decision in a standard.  Just accepting all of memory and
letting the folks who made the bad decision deal with the consequences
seems much more reasonable to me.

> If Eric has no objection, maybe Andrew can help pick this into his
> tree.

I have a new objection.  I believe ``unaccepted memory'' and especially
lazily initialized ``unaccepted memory'' is an information leak that
could defeat the purpose of encrypted memory.  For that reason I have
Cc'd the security list.  I don't know who to CC to get expertise on this
issue, and the security list folks should.

Unless I am misunderstanding things the big idea with encrypted
memory is that the hypervisor won't be able to figure out what you
are doing, because it can't read your memory.

My concern is that by making the ``acceptance'' of memory lazy, that
there is a fairly strong indication of the function of different parts
of memory.  I expect that signal is strong enough to defeat whatever
elements of memory address randomization that we implement in the
kernel.

So not only does it appear to me that implementation of ``accepting''
memory has a stupidly slow implementation, somewhat enshrined by a bad
page at a time ACPI standard, but it appears to me that lazily
``accepting'' that memory probably defeats the purpose of having
encrypted memory.

I think the actual solution is to remove all code except for the
"accept_memory=eager" code paths.  AKA delete the "accept_memory=lazy"
code.  At that point there are no more changes that need to be made to
kexec.

Eric

