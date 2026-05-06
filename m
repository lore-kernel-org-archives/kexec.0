Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8C2CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WF0iZnEHF7bRzksospKqX4MVtccF/VV/c4eBSjx3nVI=; b=dVdrl1h38rCH+ZLvxuOPHVh1Q+
	oGhkCE4ZzoGdq9amCP5liLp7QCJFua72OUgQDQaEc/l0yBvaQHLe69PyptA5bu+4LXDWDrPKT3l8u
	2MH7g7DQG90LwNF6pW9jsLbO5wsuZxn6ykk3gZjpaYkKwdUOSBRKI1HiVnjfPNu75zUxnIfuZhFlV
	136wPiu41iWRrG3k97zbqGoNxCPlF45t9uZqiC59TZclkMPPnqiKeKsRmoolm0UTJNyGYWBU8Z+/s
	O/hCwtUrmuqsyDJg+rxM4mQ1FKUz3Exsa211o8cjjjN5WwOvDIc/Mn3PlTfP579RJJDyasnB8h+cp
	qCk0+B2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKY99-00000000HFt-0G4e;
	Wed, 06 May 2026 09:02:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKY97-00000000HFN-1OUS
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 09:02:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 39C0D6012B;
	Wed,  6 May 2026 09:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD0CC2BCB8;
	Wed,  6 May 2026 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778058138;
	bh=Dw1Rx65D0dR6RpuF0bMJRvsHapDYA7j30OtceP9WKRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ABhWe+QwA67krx3H/v590dbcsj5PBVLTlwoY0yXUoyaqgls7sm04Nwgez/PjANGwP
	 PYXTmAK7Zpq3mBwp8CyfojZpy3MaCzzj7Ns2FgAG20xvV3cmOgiaXkmEsAacN453RZ
	 bAmpQBhMrbqDrHtwI+TCQM9q/t4FD+0frYzc5bZMs32mtLukkvpx/oMNHLklNdl9Bf
	 MK9FaPpsgF2UkklRsBX3pCTko1oMciKUBTcm5Dy8TbbEv1jsWr/LqZhM4bPjprEp8L
	 GqU17E36DJOGZnB0Vyt29zolICucxdoifruY2DLwXGlYF/yZtWbVn2Fd1mdm6dudrU
	 7wkkypPZOFt6w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Cris Jacob Maamor <crisjacobmaamor@gmail.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf
 <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] liveupdate: validate restored LUO metadata
In-Reply-To: <afT_xHDuFwAUSR0X@plex> (Pasha Tatashin's message of "Fri, 1 May
	2026 19:34:25 +0000")
References: <20260501094637.38650-1-crisjacobmaamor@gmail.com>
	<20260501173053.73116-1-crisjacobmaamor@gmail.com> <afT_xHDuFwAUSR0X@plex>
Date: Wed, 06 May 2026 11:02:15 +0200
Message-ID: <2vxzse84zzag.fsf@kernel.org>
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

Hi Pasha,

On Fri, May 01 2026, Pasha Tatashin wrote:

> On 05-02 01:30, Cris Jacob Maamor wrote:
>> LUO restores metadata from KHO/FDT during liveupdate. The restored
>> metadata contains physical addresses and count fields used to access and
>> walk preserved session, file set, and FLB arrays.
>> 
>> This series adds a non-consuming KHO preserved-range check and uses it
>> before phys_to_virt() on restored metadata addresses. It also rejects
>> restored counts above LUO_SESSION_MAX, LUO_FILE_MAX, and LUO_FLB_MAX
>> before traversal.
>> 
>> As far as I can tell, this is root/admin-only; I do not have evidence
>> that a normal unprivileged user can trigger it directly.
>> 
>> Changes since v1:
>> - Dropped RFC marking.
>> - Added changelog text to each patch.
>> - No code changes.
>> 
>> Cris Jacob Maamor (5):
>>   kexec: handover: add helper to check preserved page ranges
>>   liveupdate: validate LUO FDT physical address before mapping
>>   liveupdate: validate restored LUO session metadata
>>   liveupdate: validate restored LUO file set metadata
>>   liveupdate: validate restored LUO FLB metadata
>
> I have replied separately in the security report to clarify that this is 
> not a bug. The behavior follows the ABI specification exactly: we use 
> the PA addresses and ranges provided by the KHO FDT tree.
>
> NAK

I really do think we should do a restore-only variant for the
kho_alloc_preserve() family of allocators and use it everywhere. It
would prevent problems in the future. Not because the previous kernel is
malicious, but because we might have bugs and the KHO page magic sanity
check acts as a defense in depth.

For example, I am currently looking at a LUO bug where LUO does not
track if a session is outgoing or incoming. So you can do a retrieve()
or finish() on an outgoing session. A lot of nastiness is saved because
of the page magic check. Things like kho_restore_vmalloc() or
kho_restore_folio() fail early and loudly.

If we want to squeeze out more performance later down the line we can
move it behind a debug config, but having this usage pattern of always
restoring before using is going to be a lot more sane than just using
physical addresses willy nilly.

The approach this series takes with kho_is_preserved() is the wrong
design. But a kho_restore() or something similar (maybe we can find a
better name?) is really where we should be going.

-- 
Regards,
Pratyush Yadav

