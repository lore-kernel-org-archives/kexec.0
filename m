Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F99D58CBF
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 20:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c60hJIyNyv9yh8aBhgVysIO8a8ET5sR/fQVUyc4EJU8=; b=0iOxaySvupXnBhzCwzAoV5gigc
	uVvom9MWwQ2K07tzw7oK+uEQlnnXKpTE1pnpWKOvCDMUfi/3DIM+cnlsshuNiXeSDbrH3R0+OuDpe
	JDAxMQgWOrVjEVxhDyb07cWEg90h9bQTfRndp6oZjm+qguJx9o39N0oNQ4+1ggO08rkAwMcZv4aTh
	QPzvRc19TdR2ffIfyew/SnVL2q7LXEkitFj7I+qMjNeM/hXHzrNsv6RtllcV/F5oAuby+PQwFQ/SW
	t1DsR8U10XcSubzcvByvz9dinmSrckupB4HBh2W2B1Xz3IN3jQ/Hqu1QigM+b7QKg+xY2H1ccWlwj
	ZNfWcmbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4mHq-0000000HaCo-471g;
	Mon, 23 Mar 2026 20:54:10 +0000
Received: from [209.141.44.239] (helo=smtp3.mymangomail.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4mHl-0000000HaCP-0cXG
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 20:54:06 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id D31315D9BD;
	Mon, 23 Mar 2026 16:53:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774299230;
	bh=zXUX//KKN2ShokHoNvZQWtxG3NpHa+Qkb5EmvEAmUdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hEtjmfsc36898xBxppbvJmaSSXZ9V8cKYQVNd8eWcHb+j1Y+sHmDKKzTM+1c2nC7i
	 AGVknnRIrDPU9zRpN03H7+dA045k/V9jyF/NdBa38udN9MNeIwDgVBTRqeBH6JXRHE
	 lyb6t5ECkf8f1TL3VkXGpjeOufXV5N6288xL+9LA=
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
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id E37B15D9B9;
	Mon, 23 Mar 2026 16:52:31 -0400 (EDT)
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 21:52:31 +0100
From: oskar@gerlicz.space
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, Pratyush
 Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/5] liveupdate: block outgoing session updates during
 reboot
In-Reply-To: <CA+CK2bC8o2p_poLb0yfp6mAAwR42Vg_99Yh_HLK1iJZrCrsVig@mail.gmail.com>
References: <20260321143642.166313-1-oskar@gerlicz.space>
 <CA+CK2bAfPSKfV=_Sw20oqF56+H3a4k3x+47i6-EUK8mLV-i2+A@mail.gmail.com>
 <CA+CK2bC8o2p_poLb0yfp6mAAwR42Vg_99Yh_HLK1iJZrCrsVig@mail.gmail.com>
Message-ID: <f76e6cbcf6752342ee940ed0dfeca7bd@gerlicz.space>
X-Sender: oskar@gerlicz.space
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_135405_522487_A015E8B3 
X-CRM114-Status: GOOD (  31.44  )
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

On 2026-03-23 20:00, Pasha Tatashin wrote:
> On Sat, Mar 21, 2026 at 6:28 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
>> 
>> On Sat, Mar 21, 2026 at 10:38 AM Oskar Gerlicz Kowalczuk
>> <oskar@gerlicz.space> wrote:
>> >
>> > kernel_kexec() serializes outgoing sessions before the reboot path
>> > freezes tasks, so close() and session ioctls can still mutate a
>> > session while handover state is being prepared. The original v2 code
>> > also let incoming lookups keep a bare session pointer after dropping
>> > the list lock.
>> >
>> > That leaves two correctness problems in the reboot path: outgoing state
>> > can change after serialization starts, and incoming sessions can be
>> > freed while another thread still holds a pointer to them.
>> >
>> > Add refcounted session lifetime management, track in-flight outgoing
>> > close() paths with an atomic closing counter, and make serialization
>> > wait for closing to drain before setting rebooting. Reject phase-invalid
>> > ioctls, keep incoming release on a common cleanup path, and make the
>> > release wait freezable without spinning.
>> >
>> > Fixes: fc5acd5c89fe ("liveupdate: block outgoing session updates during reboot")
>> > Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
>> > ---
>> >  kernel/liveupdate/luo_internal.h |  12 +-
>> >  kernel/liveupdate/luo_session.c  | 236 +++++++++++++++++++++++++++----
>> >  2 files changed, 221 insertions(+), 27 deletions(-)
>> 
>> Hi Oskar,
>> 
>> Thank you for sending this series and finding these bugs in LUO. I
>> agree with Andrew that a cover letter would help to understand the
>> summary of the overall effort.
>> 
>> I have not reviewed the other patches yet, but for this patch, my
>> understanding is that it solves two specific races during reboot()
>> syscalls: session closure after serialization, and the addition of new
>> sessions or preserving new files after serialization.
>> 
>> Given that KHO is now stateless, and liveupdate_reboot() is
>> specifically placed at the last point where we can still return an
>> error to userspace, we should simply return an error if a userspace is
>> doing something unexpected.
>> 
>> Instead of creating a new state machine, let's just reuse the file
>> references and simply take them for each session at the beginning of
>> serialization. This ensures that no session closes will happen later.
>> For file preservation and session addition, we can block them by
>> simply adding a new boolean.
>> 
>> Please take a look at the two patches below and see if this approach
>> would work. It is a much smaller change compared to the proposed state
>> machine in this patch.
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git/log/?h=luo-reboot-sync/rfc/1
> 
> Oskar, I made a few more changes to avoid returning an error if
> get_file_active() fails. This prevents a race condition where the user
> might call close(session_fd) right before calling reboot(). I
> force-updated the above branch. Please let me know if you want to take
> these changes and use them to in the next version.
> 
> Pasha

Hi Pasha,

thank you for taking the time to prototype this approach and for the 
detailed explanation, I really appreciate it.

I agree that reusing file references and introducing a simple blocking 
mechanism makes the solution much smaller and easier to reason about 
compared to a dedicated state machine. Your patches definitely move 
things in a nice direction in terms of simplicity.

While going through it, I was wondering if there might still be a couple 
of corner cases worth discussing. In particular, do you think a boolean 
gate is sufficient to cover in-flight operations that may have already 
passed the check before serialization starts? It seems like those paths 
could still potentially mutate session state during serialization.

I was also thinking about the lifetime of incoming sessions (especially 
lookups holding pointers). Do you think file reference handling alone is 
enough there, or would we still need some explicit lifetime protection?

I’m currently working on v4 and will take a closer look at your branch 
to see if we can combine both approaches in a way that keeps the 
solution simple while still covering these cases.

Thanks,
Oskar Gerlicz Kowalczuk

