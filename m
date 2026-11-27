Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA453606A31C
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YKylgZR6;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q7GzMu+L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Unsubscribe-Post:
	List-Owner; bh=k9p76ZePMrJ0nFwcIhgoG10NwQVXv3BeVhZuust6LQQ=; b=YKylgZR6/7nvUj
	zkHyKBoQ+YXaWjThMNWVH08GRtfuwspNdtx5CZsYdg15JKfmytUP4FC3uGEQidL5ZhkcWS/uu6ulU
	wYrpJa2iNPuF0necLNQhsrVzkMRrMSsgBK8uXN86Xd6X6mEfsoV2NVziYFXE7S2wvF9rdAzcz87OE
	uWW0QFs8++hW7R7gt59dmdn51v8f4Fm/81XmaQqCFyIX4lJWIe1LOc9EFXpLxMapXW5Y+/0wPUL1h
	LIfVCbGUxNUTnY5sCHQnUgjGDqicA/0lTaCMxlSz3V/cABPFUxaMPbBHfuxaQrx+xT6lsMhHodxm5
	ap/S5QHbYIMfmodH+fyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWyVM-0000000H0ek-1Emq;
	Fri, 27 Nov 2026 16:08:56 +0000
Received: from out-170.mta0.migadu.com ([2001:41d0:1004:224b::aa] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWyVH-0000000H0dS-0Hs0
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 16:08:52 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=J2nVnfze42D4hpgWO1bcsfvJDrSnGqMqHcISfjmmVgk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795795727; v=1; x=1796400527;
 b=q7GzMu+L0l7/xI0pvW+crcK0P7tvq1N5joY9+D240LJ4t1Kc5CgAYVI1+f1FGm5OBnOZ42kg
 PRhiAxsyZtVYsUIXvaUBDBbfbZ4JKrursQZtZn9XjSEAEl3elapcrgEPBqmivTddzXe5aGUobWf
 wAsCO/3IG/TjjqO9S4vJjTFU=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 3c569014ab5b12aa;
	Fri, 27 Nov 2026 16:08:47 +0000
X-Mizu-Trace-ID: 3c569014ab5b12aa
X-Migadu-Flow: FLOW_OUT
Date: Fri, 27 Nov 2026 16:08:47 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: mpilaniy@redhat.com
CC: horms@kernel.org, include@grrlz.net, kexec@lists.infradead.org,
 ltao@redhat.com, prudo@redhat.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_kexec-tools=5D_kexec=3A_fix_ke?=
 =?US-ASCII?Q?xec=5Ffile=5Fload_fallback_error_handling?=
In-Reply-To: <f4270f12-a1c3-4462-9574-d9fdf2501fb7@redhat.com>
Message-ID: <9F5D9F78-0D9E-4BBB-B66A-98C21EF44730@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_080851_409599_878E3D72 
X-CRM114-Status: GOOD (  16.63  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27 November 2026 13:18:57 GMT, Mukesh Pilaniya <mpilaniy@redhat.com>
wrote:
>Hi Bradley,
>
>On 24/08/26 4:33 pm, Mukesh Pilaniya wrote:
>> Hi Bradley, thanks for review.
>> 
>> On 22/08/26 12:44 am, Bradley Morgan wrote:
>>> On 14 August 2026 08:53:29 BST, Mukesh Pilaniya <mpilaniy@redhat.com>
>>> wrote:
>>>> With the default -a (--kexec-syscall-auto) option, kexec-tools first
>>>> tries kexec_file_load() and falls back to kexec_load() when the
>syscall
>>>> is not implemented (ENOSYS) or the kernel does not have a loader for
>the
>>>> image format (ENOEXEC/ENOTSUP). [...] Falling back on EINVAL hides the
>>>> real error, because EINVAL means something went wrong during loading.
>>>>
>>>> Remove EINVAL from the fallback path.
>>>
>>> Hiding the real error behind a fallback is exactly what makes this one
>>> hurt to debug, so good direction.
>>>
>>>> Several kexec_file_load() image probe functions incorrectly return
>>>> -EINVAL rather than -ENOEXEC when encountering an unrecognized image
>>>> format. This kernel patch fixes the issue:
>>>>
>https://lore.kernel.org/all/20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com/
>>>
>>> That one is still being reworked, Pratyush just LGTM'd the
>>> probe_default change a couple days ago and the fix isn't in any tree
>>> yet. And until it is, the arm64 probe and the riscv image probe still
>>> return -EINVAL, and that last errno is what kexec_image_probe_default()
>>> leaks to userspace (I checked the loader lists in the tree). So if this
>>> lands on tools before the kernel fix lands, an image that used to
>>> silently fall back to kexec_load() on those arches now just fails with
>>> EINVAL.
>>>
>>> Is the plan to hold this one until the kernel side is in? Because right
>>> now it looks like it can race ahead of its dependency.
>>>
>> Yes, the kernel patch will merge first, then this one. I will follow up
>> on the same thread once the kernel fix is merged.
>Both kernel commits (b7c94f4d096 and 2792b4b15f) have been merged
>upstream from Linux v7.4-rc1 onward, so this change should be good to
>merge as well.


Thx!


Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>

>
>> 
>>>> Print the actual errno for ENOEXEC/ENOTSUP before falling back
>>>
>>> Good, that is the part that makes the s390 command line case visible.
>>>
>>> The my_load/k_unload ENOSYS message hunks are unrelated cosmetics, fine
>>> but could be their own patch if you feel like splitting.
>>>
>> The my_load/k_unload ENOSYS hunks are not just cosmetic, they address a
>> misleading error output. Today, when kexec_load is absent, my_load dumps
>> the entry pointer, flags, and all segments, which is debug noise for
>> what is simply an unsupported syscall. Similar, k_unload prints "kexec
>> unload failed: Function not implemented", which reads like something
>> went wrong rather than the syscall not being available.
>> 
>> I'm happy to split this if you'd prefer, but since they're small and
>> directly related to the error-path cleanup, I kept them together.
>> 
>>> Its a good patch, I just want the ordering question answered first.
>>>
>>> Thanks!
>> 
>
>

--- Thanks!

