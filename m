Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A456109E55B
	for <kexec@archiver.kernel.org>; Thu, 26 Mar 2026 06:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vatpyTHCvApxrpdQIC/dp3cKCrlOiEv4QlZzcoloOko=; b=Qj0XCRJiOrC/nu1qUdE8pJBqS6
	uXjtNAKwowdlB+8BxdlrZmcO9o17452YqvzSRHEnIRU+J2vT2eKa8PjFEXXv/oEEqPDXlsndK+t9K
	mM4Pn4ZpL104ajLAstU2ZqH/2GctnvMURTvY2ddhGBVdxA6WjBf3PdHZXW98Exvz9M3Yz/NNouKrg
	hxOpYl+jF37yatSy4OnQ+l0GMGpyLLk+OIuGmpSOha0AdhZYQG+QHR3p2pQd9WvhDcua6rJqOftqw
	7ItjxoxM0IUrlY5pg8f5mET6joHnzSF7b0LeZ0anedX9GnFgLu6yd3q/HPhxuZr4uD8sj55pN7v/T
	SnlQtQEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5eW0-00000004s3r-4BsD;
	Thu, 26 Mar 2026 06:48:25 +0000
Received: from [209.141.44.239] (helo=smtp3.mymangomail.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5eVy-00000004s3J-1mcj
	for kexec@lists.infradead.org;
	Thu, 26 Mar 2026 06:48:23 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id 84F925D9C4;
	Thu, 26 Mar 2026 02:48:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774507692;
	bh=3EuSxHtkudq5kGLqdpvQzp2LofPCcj5NY0hFbWKHRwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XxwiZltzYTzUbZgbJj7WdHS/IcmTagynFNvDFKTtrfQuZJwGK7TMBAd2aZttyswUD
	 JL5uX5IcAlO4lplY7KVS13SzRnfYndqizuE2LkfdAHuHuw6A4llsFC1YcQKFvNG6ai
	 r8SwfWUgtWQ/JQ/HUrMw7PncyoE+fbwoSCv+/v88=
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
Received: from authenticated-user (smtp.mymangomail.com [205.185.121.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id 796195D9BD;
	Thu, 26 Mar 2026 02:47:04 -0400 (EDT)
MIME-Version: 1.0
Date: Thu, 26 Mar 2026 07:47:03 +0100
From: oskar@gerlicz.space
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, Pratyush
 Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/5] liveupdate: tighten handover cleanup and session
 lifetime
In-Reply-To: <CA+CK2bCiqCg1Tt0WgP3KszrK96Qahcgfyfige4eUQOkMVyLUqg@mail.gmail.com>
References: <20260324212730.65290-1-oskar@gerlicz.space>
 <CA+CK2bCiqCg1Tt0WgP3KszrK96Qahcgfyfige4eUQOkMVyLUqg@mail.gmail.com>
Message-ID: <7628da0465cd09bfc16bf9353f37045c@gerlicz.space>
X-Sender: oskar@gerlicz.space
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260325_234822_506825_E84163B6 
X-CRM114-Status: GOOD (  39.13  )
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

On 2026-03-25 14:38, Pasha Tatashin wrote:
> On Tue, Mar 24, 2026 at 5:29 PM Oskar Gerlicz Kowalczuk
> <oskar@gerlicz.space> wrote:
>> 
>> Hi Pasha,
>> 
>> this v4 keeps the simpler direction from your mail: outgoing handover 
>> is
>> still driven by a boolean rebooting gate, refcount pinning of outgoing
>> sessions during serialization, and session->mutex as the serialization
>> point for in-flight mutations. There is no return to the earlier 
>> closing
>> counter or a larger session state machine.
>> 
>> The main changes in this respin are:
>> 
>> - reshape the series into five commits, each building and standing on 
>> its
>>   own
>> - keep incoming session origin immutable and use retrieved only as the
>>   checked-out bit
>> - make FINISH and implicit close consume incoming sessions without
>>   reopening races through retrieve-by-name
>> - route deserialize failures through explicit rollback paths for
>>   sessions, files, and serialized memfd state
>> - validate KHO-preserved extents before walking serialized metadata
>> - harden incoming FLB lifetime and remaining teardown paths
>> 
>> Patches 1-4 keep the core session, kexec, deserialize and validation 
>> work
>> separate. Patch 5 carries the remaining FLB and teardown fixes needed 
>> to
>> match the final tree.
>> 
>> Oskar Gerlicz Kowalczuk (5):
>>   liveupdate: block outgoing session updates during reboot
>>   kexec: abort liveupdate handover on kernel_kexec() unwind
>>   liveupdate: fail session restore on file deserialization errors
>>   liveupdate: validate handover metadata before using it
>>   liveupdate: harden FLB lifetime and remaining teardown paths
>> 
>>  include/linux/kexec_handover.h     |  13 +
>>  include/linux/liveupdate.h         |  17 +-
>>  kernel/kexec_core.c                |   4 +
>>  kernel/liveupdate/kexec_handover.c |  22 ++
>>  kernel/liveupdate/luo_core.c       |  16 +-
>>  kernel/liveupdate/luo_file.c       | 237 ++++++++++++--
>>  kernel/liveupdate/luo_flb.c        | 116 +++++--
>>  kernel/liveupdate/luo_internal.h   |  14 +-
>>  kernel/liveupdate/luo_session.c    | 500 
>> ++++++++++++++++++++++++-----
>>  lib/tests/liveupdate.c             |   2 +
>>  mm/memfd_luo.c                     | 160 +++++++--
>>  11 files changed, 934 insertions(+), 167 deletions(-)
> 
> Hi Oskar,
> 
> This is a NAK.
> 
> This patch series is still significantly over-engineering solutions to
> straightforward problems, and the patches read as if they were
> mechanically generated rather than thoughtfully designed. The sheer
> volume of changes (nearly 1,000 lines) is unnecessary for what we are
> trying to achieve.
> 
> As I pointed out previously, we need to keep this simple. For example,
> the problem of preventing a return to userspace after a successful
> liveupdate_reboot() does not require inventing a new
> liveupdate_reboot_abort() function. It just requires placing the call
> where it's the last function allowed to return, with a simple
> exception for context-preserved kexec jumps. That is a trivial change:
> 
> -       error = liveupdate_reboot();
> -       if (error)
> -               goto Unlock;
> +       if (!kexec_image->preserve_context) {
> +               error = liveupdate_reboot();
> +               if (error)
> +                       goto Unlock;
> +       }
> 
> The same principle applies to the other issues. You are doing rewrites
> when targeted fixes should be applied:
> - Sessions mutating after entering the reboot() syscall?: This is a
> 14-line fix [1].
> - Destroyed serialization race during liveupdate_reboot()? This is a
> 70-line fix [2].
> 
> I was hoping that v4 (BTW, why are we at v4 in just a week?) would
> include the patches I already provided, along with similarly scoped,
> minimal fixes for the deserialization path if needed. Instead, I am
> seeing another over-complicated rewrite.
> 
> Looking at deserialization, I am seeing, you are deleting a comment
> that explicitly explains our error-handling design:
> -       /*
> -        * Note on error handling:
> -        *
> -        * If deserialization fails (e.g., allocation failure or 
> corrupt data),
> -        * we intentionally skip cleanup of files that were already 
> restored.
> -        *
> -        * A partial failure leaves the preserved state inconsistent.
> -        * Implementing a safe "undo" to unwind complex dependencies 
> (sessions,
> -        * files, hardware state) is error-prone and provides little 
> value, as
> -        * the system is effectively in a broken state.
> -        *
> -        * We treat these resources as leaked. The expected recovery 
> path is for
> -        * userspace to detect the failure and trigger a reboot, which 
> will
> -        * reliably reset devices and reclaim memory.
> -        */
> 
> You are adding a bunch of new functions to solve something we
> intentionally chose not to solve. Attempting to cleanly unwind and
> release incorrectly deserialized resources back to userspace is
> dangerous. It risks security violations and, in the worst-case
> scenario, customer data leaks. A failed deserialization means the
> system is broken; we leak the resources (make them unavailable) and
> rely on a reboot to reliably sanitize the state.
> 
> Please drop the over-engineered approaches. Use the patches provided,
> keep the fixes minimal, and do not alter established security
> boundaries like the deserialization error paths. Take your time to
> manually self-review your work, do not rely on AI to do everything for
> you.
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git/commit/?h=luo-reboot-sync/rfc/1&id=d47b76707c4f352c3f70384d3d6a818e2875439a
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git/commit/?h=luo-reboot-sync/rfc/1&id=f27a6a9364cd0a19067734eeb24ea4d290b72139
> 
> Pasha
> 
>> 
>> --
>> 2.53.0
>> 
Hi Pasha, thank you for the detailed feedback and for sharing your 
patches. I understand that my previous version was overcomplicated. I 
will rework the series to follow your approach and keep the changes 
minimal. I plan to send an updated version later today.

Thanks,
Oskar Gerlicz-Kowalczuk

