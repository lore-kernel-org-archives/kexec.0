Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B0AC43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fRYwLKFW5okacBeAUFEZkzLVQVNz/VPICpHOIwpSzVw=; b=eOe8ci4u91muOqtQE+OKNrVdYH
	q6jJbhcXOM7Ei56oY9aQaDlIWJHST/3CvS6u3TeiTX2RG/mPqszELpDoJNRsXNjoaqCCQDuVdjCL2
	UC0b8zhAJFQxwOg4at0ax7R6CMDOtTtVNQ+bt8T1SwyXEwNafN8g9gUY3shbVqqsf1DmJ2utSa/Hp
	xZMFxZ2rLzH1NkXNnb4KGuzhD7v3HI+1KORtkqdfrauQbYqG+hnKC8mox8lUo0s4fXQD2XT7oNCCa
	v4kErrwixvw7RmXDa2KTgT+4BcupMNq3ruFCZdAnxBva2nUFh7jOq7adymKEDdyTmx86RNA7nTmDo
	LybKVnRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weFBV-0000000FFgb-2Z6I;
	Mon, 29 Jun 2026 16:50:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weFBV-0000000FFgO-19zc
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 16:50:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 83F1742AFA;
	Mon, 29 Jun 2026 16:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99A81F000E9;
	Mon, 29 Jun 2026 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782751812;
	bh=fRYwLKFW5okacBeAUFEZkzLVQVNz/VPICpHOIwpSzVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fAQ/FQZPFJdL1E+lwZz7Y2DQxvXCBRugYvrLlkLg0WufX4gAXhlk36fd2fb4nwF+p
	 bqhpD7BOox/hhIfOUYc1fQTXKz6HAbwZgZPdnHskBbL7EZ3c4c4zjrAPR4cqF6N/h8
	 aAJMsEfERBSeXOMSQ2NJDZQXa52o4o6SnlAlpYgzCTaC23UYkzHByh0MxkNcC+IdMq
	 5cveQdr4SVTQE9pEqDy1HxBJeuztseBtisogTicde16xe8uVcO/2oEBGyoY5sl0NGM
	 4lnKcHyD4IKATGQOBGfrTnqbNniyI3jx0QI+cwMhApGCzJbgR1r02pgEjoJb/CFM/V
	 d/vVxThFRTwFA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  Mike Rapoport <rppt@kernel.org>,  Alexander Graf
 <graf@amazon.com>,  David Matlack <dmatlack@google.com>,
  tarunsahu@google.com,  open list <linux-kernel@vger.kernel.org>,  "open
 list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>,  "open list:KEXEC
 HANDOVER (KHO)" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] liveupdate: luo_file: Add internal APIs for file
 preservation
In-Reply-To: <2vxzse65k938.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	29 Jun 2026 11:08:11 +0200")
References: <20260613012521.835490-1-skhawaja@google.com>
	<20260613012521.835490-2-skhawaja@google.com>
	<2vxzwlvljyzs.fsf@kernel.org> <akIask9nPTEAhd76@plex>
	<2vxzse65k938.fsf@kernel.org>
Date: Mon, 29 Jun 2026 18:50:09 +0200
Message-ID: <2vxz7bnhjnpa.fsf@kernel.org>
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

On Mon, Jun 29 2026, Pratyush Yadav wrote:

> On Mon, Jun 29 2026, Pasha Tatashin wrote:
>
>> On 06-26 13:57, Pratyush Yadav wrote:
>>> Hi Sami,
>>> 
>>> On Sat, Jun 13 2026, Samiullah Khawaja wrote:
>>> 
>>> > From: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> >
>>> > Live update orchestrator file handlers depend on the preservation of
>>> > other files. To make sure that the dependency is preserved, the file
>>> > handlers needs to fetch the preservation token of the preserved
>>> > dependency. Similarly during restore, a file handler wants to fetch the
>>> > restored file of the dependency.
>>> >
>>> > Add APIs that allows fetching token of dependency during preservation,
>>> > and fetching the restored file dependency during restore.
>>> >
>>> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
[...]
>>
>> To achieve this, LUO provides the .can_finish() callback. So, LUO does
>> two-phase verification:
>>
>> 1. It iterates through all tracked files and invokes .can_finish().
>> 2. Only if *all* files return success does it proceed to invoke .finish().
>>
>> If a VMM restores a file (such as guest_memfd) but fails to restore its
>> dependency (such as the VM FD), or attempts to close the session 
>> prematurely, the .can_finish() check for that file will fail (returning 
>> -EBUSY), and the entire finish sequence will abort. This guarantees 
>> kernel-enforced correctness at the session boundary and without forcing 
>> the VMM to execute restores in a strict sequential order, which anway 
>> would not make  any sense from kernel side due to circular dependecies 
>> issue, where topological sort does not exist.
>>
>>> 
>>> But on the preservation side, VMMs still do need to follow the
>>> topological order of dependencies. Because if they don't, the
>>> liveupdate_get_token_outgoing() call will fail and preservation can't
>>> proceed.
>>
>> Actually, preservation can also be performed in an order-independent manner.
>> While a handler can call liveupdate_get_token_outgoing() during .preserve(),
>> it can also defer this query until the .freeze() callback. Because .freeze()
>> is invoked after all files in the session have completed their .preserve() phase,
>> all dependency tokens are guaranteed to be available, completely eliminating any
>> topological ordering requirements during the initial preservation calls. It is
>> up to individual file handler implementations to decide whether they wish to
>> enforce ordering at .preserve() time or defer it to .freeze().
>
> That is the worst of both worlds. I get your point that LUO doesn't want
> to enforce dependency ordering. My arguments against that are somewhat
> subjective so I can live with this.
>
> But then you can't let file handlers enforce it as they wish. The
> dependency ordering is uAPI because it directly affects how VMMs
> preserve files. If the VMM has to keep track of dependencies for some
> file types and doesn't have to do so for others, that is a terrible and
> inconsistent API.
>
> Ideally, LUO should handle the dependencies on its own. preserve() can
> give LUO a list of files the preserved file depends on, and LUO makes
> sure all the dependencies are present in the session at freeze. We would
> also need a way of getting the dependent files back from LUO on
> retrieve(). That would make sure the dependencies are properly enforced
> both on freeze and finish, and the enforcement isn't left up to the file
> handlers.
>
> Unfortunately all that sounds fairly complicated so I am not sure if we
> want to do that just yet, although I would like to hear your thoughts on
> this.

We had discussion about this in the live update bi-weekly today. The
conclusion we arrived at is to keep the current functionality. That is,
we don't enforce preservation dependency.

But that also means file handlers can't try to get their dependent file
in their preserve() callback, since that would implicitly enforce
ordering. They always _have_ to do it from their freeze() callback.

Similarly, on retrieve side, file handlers enforce their dependent files
are restored via the can_finish() callback only.

So I think the next steps for this series is to clearly document this
requirement for file handlers in the documentation for
liveupdate_get_token_outgoing() and liveupdate_get_file_incoming().

Also, I think you need some way of tracking if the file was explicitly
restored by userspace, which is something file handlers would then need
to call in their can_finish().

[...]

-- 
Regards,
Pratyush Yadav

