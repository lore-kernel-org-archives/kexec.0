Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DFA1094469
	for <kexec@archiver.kernel.org>; Sat, 21 Mar 2026 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TCqNFyyPUUdW9ZMPxDkboCXhDE0SUM9SHSiNMtFzQiE=; b=DRKmuIeikbHf5q5TFUcOwzVjrI
	HRs9/Xp/+4su8EAVnrv0EZUTHwEfOTi/Niauwtpo5Ky+puLoE8Aa0G677pIZf5boLn2EhuTATjLcT
	l33257uQhoPk6mWwC8ksPr5M1SyXGIiA5m19Hy8dRrXVXfU+no+eIPIgVg6IqnvgdVPJWSrDhSpvD
	ThDH0gP/S9HSqx/N+YMLituJqD14s3sJqI15gK4feH3NBe/qyh5z/lEhLwfPjAcQN9726abNiauWg
	IehqT4WFHgsgxkbKV4NEFhwzVFncpYMMp70yz0ublgfyWAj7pcu0CCfTJ2H7xjwhwt5ImNg5LdKC6
	BlihpYtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3tYe-0000000EM7H-3j4i;
	Sat, 21 Mar 2026 10:27:52 +0000
Received: from hillsboro-edge.smtp.mymangomail.com ([5.78.130.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3tYc-0000000EM6i-0nZk
	for kexec@lists.infradead.org;
	Sat, 21 Mar 2026 10:27:51 +0000
Received: from smtp.mymangomail.com (localhost [127.0.0.1])
	by smtp.mymangomail.com (Mango Mail) with ESMTP id 893AE41963;
	Sat, 21 Mar 2026 06:27:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774088831;
	bh=WGQD1ZsKdugY1KTxZSSSEplvqr53gUI6cKQKc+OHL1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p9UBjw60JFvX5QGlAhtaEm3GKgshG9pnkCkbfl5muB8nOVBJKhjPnNc7wDB+U4KK2
	 ap5sfw24DYfiealUvfeYrtG8tzZKmb1adON1zrWqNKtKus5UAPFLBm6Xqn+wFBcsXS
	 JAFzVyE/vVXqTxFaz+p7slnZI6R6TMAxcvF+Sl1I=
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
	by smtp.mymangomail.com (Mango Mail) with ESMTPSA id 29FB9418D0;
	Sat, 21 Mar 2026 06:26:00 -0400 (EDT)
MIME-Version: 1.0
Date: Sat, 21 Mar 2026 11:25:59 +0100
From: oskar@gerlicz.space
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport
 <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, Pratyush Yadav
 <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] liveupdate: block outgoing session updates during
 reboot
In-Reply-To: <20260320182352.ca6c88e409ff12d0368b03ae@linux-foundation.org>
References: <20260320163720.100456-1-oskar@gerlicz.space>
 <20260320182352.ca6c88e409ff12d0368b03ae@linux-foundation.org>
Message-ID: <af15eae6ea9007aa6fd7924512657168@gerlicz.space>
X-Sender: oskar@gerlicz.space
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_032750_279552_02F00203 
X-CRM114-Status: GOOD (  20.05  )
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

On 2026-03-21 02:23, Andrew Morton wrote:
> On Fri, 20 Mar 2026 17:37:16 +0100 Oskar Gerlicz Kowalczuk <oskar@gerlicz.space> wrote:
> 
>> When kernel_kexec() starts a live update handover, LUO serializes
>> outgoing sessions before the reboot path freezes tasks or shuts
>> devices down. That leaves a window where close() and
>> LIVEUPDATE_SESSION_PRESERVE_FD can still mutate an existing outgoing
>> session after luo_session_serialize() has already captured it.
>> 
>> The race is dangerous because the next kernel may inherit stale file
>> metadata or references to memory that userspace has already
>> unpreserved. That breaks handover consistency and can later trigger
>> restore failures on already torn down state.
>> 
>> Mark the outgoing session set as rebooting while serialization is in
>> progress, reject new mutations with -EBUSY, and make release wait
>> until rebooting finishes before unpreserving files. Reset the flag and
>> wake waiters when serialization rolls back, and use READ_ONCE() and
>> WRITE_ONCE() so the state is visible across CPUs.
> 
> Sashiko AI review has quite a few questions:
> 	https://sashiko.dev/#/patchset/20260320163720.100456-1-oskar@gerlicz.space


Thanks for the careful review.

Patch 1

You are right. The incoming .release path can return before
luo_session_remove() / luo_session_free() and leave the session
stranded. This is pre-existing rather than introduced by this patch,
but it is a real bug. I will fix it in v2 by ensuring the release path
always removes and frees the session, while keeping the warning if
finish fails.

You are right. This wait can be hit from userspace while the
preserve_context path is entering the freezer. I will switch this to
wait_event_freezable(), as this path can be reached from userspace
during the freeze phase.

You are right. Dropping the rwsem before luo_session_remove() leaves
a serialize-vs-close window, so v1 still allows an outgoing session to
be serialized after close has started. In v2 I will keep the outgoing
session exclusion across the entire unpreserve/remove path (i.e. prevent
serialization until the session is fully removed), and I will gate both
PRESERVE_FD and FINISH under the same reboot check.

These issues indicate the outgoing session lifecycle still has race
windows, so I will rework this part more substantially in v2.

Patch 2

You are right. On the preserve_context flow, machine_kexec() can
return to the original kernel with error == 0, so the current
abort-on-error logic is insufficient. I will fix this by explicitly
aborting liveupdate state on the preserve_context return path in
kernel_kexec() after machine_kexec() returns.

Agreed. The abort loop only stays synchronized as long as the outgoing
list cannot change after serialization. The remaining release/remove
race in patch 1 breaks that assumption. I will fix that in v2 by
ensuring outgoing removal is excluded once serialization starts, so
abort can unfreeze the same session set that was serialized.

Patch 3

You are right. luo_file_discard_deserialized() currently drops
file_set->files without freeing the preserved KHO block. I will fix
this by routing the discard path through a common cleanup path which
calls kho_restore_free(file_set->files) before clearing the pointer.

You are right. The direct returns in luo_session_deserialize()
bypass cleanup of sh->header_ser, can leave previously restored
sessions behind, and do not cache the final error value. I will fix
this by routing all deserialize failures through a common cleanup path
which removes any sessions restored so far, frees sh->header_ser,
clears sh->ser, and stores the cached error before returning.

I do not think this specific UAF is reachable, because deserialization
happens before the device becomes visible to userspace and the device
enforces single-open semantics. The cleanup and leak issues are real,
though, and the common unwind path above will address them.

Patch 4

Agreed. The file-set validation failures currently share the same
cleanup hole as patch 3. The common deserialize cleanup in v2 will
free the preserved file_set block via kho_restore_free() before
dropping the pointer.

You are right about the direct returns in luo_session_deserialize().
I will convert those to the same common error path so sh->header_ser
is freed and the cached error is set consistently.

You are right about memfd cleanup. I will route early validation
failures through free_ser:, and I will fix the folio unwind so it also
releases the current folio entry rather than only the tail entries
after it.

Agreed. I will also validate nr_folios against the vmalloc backing
metadata (ser->folios.total_pages), not only against ser->size,
before iterating.

Patch 5

I agree this is a bug. It is pre-existing and not introduced by this
patch, so I will fix it in a follow-up by rechecking the incoming state
under the mutex before returning success from
liveupdate_flb_get_incoming().

Overall, I will rework the outgoing session lifecycle, unify the
serialization exclusion rules, and fix the cleanup paths in v2.

Oskar Gerlicz Kowalczuk

