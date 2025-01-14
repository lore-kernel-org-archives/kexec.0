Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25486C02180
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 03:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d7OzC1HKFU8JmEwRobBhBX2vuHvLWfrqgAKGuhYJWcM=; b=t39jUAINZZFsQD4mE6ytsTtxe0
	U8mcDJkW/PwLnEaaeSWY0hKtGKjjLdI4FiFB+fFqwMKVeQGxq1f0NAK3+SLxqUImu4+3m5IJptSqT
	qb+uErGUL+btBMd7KAip4uTTkzyJxrVw2WR4VvR7w7r8a1BV57CoTUsqe0eflz1u6qKGlbdagVPdn
	1gTr9dhWCL8ZQpohwOjLFti3oE5a5Rf50g1h9y3iIj1CqhBiYSDQQlu+ywX0FnuOhE80ZXgiodUas
	n0mcKjArthh4syjPI+3zj7ba3zlk1bB5xeZaUbNAL4DOKLfbb6JWIc/YTaZoVX3sE6E+c4IER8T11
	i4ptMFyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXXZR-00000007Kkh-4Bw4;
	Tue, 14 Jan 2025 03:26:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXXZM-00000007Kjz-3etu
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 03:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736825178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d7OzC1HKFU8JmEwRobBhBX2vuHvLWfrqgAKGuhYJWcM=;
	b=SKdlCmOekccOK4x0vIWbGAiuil6oVgSkrNbf9A0TkhvBqNdtydPcHPVECia3r1OTigQ/vm
	JeVNZYY5CQvSigYlymF6Z05Ruy9CWK+t0dwx9y1YzcoEC5r2tIzlYVUVe8FIV9z2mpK5Wy
	ojgmevs+xPYJTQeN00uvbpHTLt5RNvo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-qAnU3jGiMZ2MKgzrAbrq8A-1; Mon,
 13 Jan 2025 22:26:14 -0500
X-MC-Unique: qAnU3jGiMZ2MKgzrAbrq8A-1
X-Mimecast-MFC-AGG-ID: qAnU3jGiMZ2MKgzrAbrq8A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 506AE1955DB9;
	Tue, 14 Jan 2025 03:26:12 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E70C195608A;
	Tue, 14 Jan 2025 03:26:09 +0000 (UTC)
Date: Tue, 14 Jan 2025 11:26:05 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org,
	kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	x86@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, security@kernel.org
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <Z4XZTdmDMJ3qwIY6@MiWiFi-R3L-srv>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_192620_999402_6257DEFE 
X-CRM114-Status: GOOD (  39.44  )
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

Hi Eric,

On 01/13/25 at 08:59am, Eric W. Biederman wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> > On 01/13/25 at 12:01pm, Kirill A. Shutemov wrote:
> >> On Fri, Dec 13, 2024 at 05:49:30PM +0800, Yan Zhao wrote:
> >> > Hi Eric,
> >> > 
> >> > This is a repost of the patch "kexec_core: Accept unaccepted kexec
> >> > destination addresses" [1], rebased to v6.13-rc2.
> >> 
> >> Can we get this patch applied?
> >
> > This looks good to me. In v1, we have analyzed all other possible
> > solutions, however change in this patch seems the simplest and most
> > accepatable one.
> 
> Truly?  I will go back and look and see what I missed but I haven't seen
> anything that I addressed my original objections.
> 
> To repeat my objection.  The problem I saw was that the performance of
> the accepted memory paradigm was so terrible that they had to resort to
> lazily ``accepting'' memory, which leads to hacks in kexec.  I would not
> like to included hacks in kexec just so that other people can avoid
> fixing their bugs.
> 
> I did see a coherent explanation of the bad performance that pointed the
> finger squarely at the fact that everything is happening a page at a
> time.  AKA that the design of the ACPI interface has a flaw that needs
> to be fixed.
> 
> I really don't think we should be making complicated work-arounds for
> someone else's bad software decision just because someone immortalized
> their bad decision in a standard.  Just accepting all of memory and
> letting the folks who made the bad decision deal with the consequences
> seems much more reasonable to me.

Ah, I didn't realized you object the accept_memory feature itself, sorry
about that. I personally dislike accept_memory either since there's
already DEFERRED_STRUCT_PAGE_INIT feature to improve the boot time
memory init. While talking about the passive providing RAM to guest
system when actually demanded, this seems to be helpful to save RAM
memory for cloud provider's host system, this is what I think is
valuable of the accept_memory, even though Intel engineer avoids to
delcare it formally.

Anyway, I would like to ack it based on accept_memory feature having
already been merged into mainline kernel. If the feature itself is
objected, the top priority is discussing to decide if we should take it
off in kernel or how limitedly it's being used in kernel, or vice versa,
whether supporting it in kexec truly is another story.

Thanks a lot for your thought sharing with elaborate explanation.

Thanks
Baoquan

> 
> > If Eric has no objection, maybe Andrew can help pick this into his
> > tree.
> 
> I have a new objection.  I believe ``unaccepted memory'' and especially
> lazily initialized ``unaccepted memory'' is an information leak that
> could defeat the purpose of encrypted memory.  For that reason I have
> Cc'd the security list.  I don't know who to CC to get expertise on this
> issue, and the security list folks should.
> 
> Unless I am misunderstanding things the big idea with encrypted
> memory is that the hypervisor won't be able to figure out what you
> are doing, because it can't read your memory.
> 
> My concern is that by making the ``acceptance'' of memory lazy, that
> there is a fairly strong indication of the function of different parts
> of memory.  I expect that signal is strong enough to defeat whatever
> elements of memory address randomization that we implement in the
> kernel.
> 
> So not only does it appear to me that implementation of ``accepting''
> memory has a stupidly slow implementation, somewhat enshrined by a bad
> page at a time ACPI standard, but it appears to me that lazily
> ``accepting'' that memory probably defeats the purpose of having
> encrypted memory.
> 
> I think the actual solution is to remove all code except for the
> "accept_memory=eager" code paths.  AKA delete the "accept_memory=lazy"
> code.  At that point there are no more changes that need to be made to
> kexec.
> 
> Eric
> 


