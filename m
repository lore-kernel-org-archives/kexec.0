Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B08ECE582
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=nRp57vkqso5IXYZevGCMU4lMVrmKarXpuqhyr5+8DZ4=; b=3Ae0HALb0LgBPce4iQx5YTMi75
	jn/Pin2jGOmjqERROlx+7v8nXZlXDYBpiO3zfmOS3aez/XEdHx49AaQoH3l3RyVreEkq4epYgY34M
	mFe/AFxsG7739et87H8UCkEC42bqiJYug4+EAv4DRmJrTy+qCv1cFesfcXbxysKyBZ2PvvLbrWni/
	xFcTvRBMixDJh7lTKSHLZ4pK93HyGINNqx4OW1krPRkgeV1jmAh8e6opQLvbd5wt7PPhxsXR47+8d
	kGfOQ62guaVcox9+zIWSVRdWUhNCCiT5M5lnF0xMdlDk8oDrDwpNep4avgFexGCvmN8xfX/mZrfTf
	L4U9k7cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so4KS-00000006T3g-3OVv;
	Tue, 10 Sep 2024 17:07:00 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so4Iy-00000006Sho-3ZM6
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 17:05:30 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:55468)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so4Iw-0092sG-Ob; Tue, 10 Sep 2024 11:05:26 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:46314 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1so4Iv-005kJH-SY; Tue, 10 Sep 2024 11:05:26 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Breno Leitao <leitao@debian.org>
Cc: ardb@kernel.org,  linux-efi@vger.kernel.org,  kexec@lists.infradead.org,
  bhe@redhat.com,  vgoyal@redhat.com,  devel@edk2.groups.io,
  rppt@kernel.org,  usamaarif642@gmail.com,  gourry@gourry.net,
  rmikey@meta.com
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
	<87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
	<20240910-uppish-gopher-of-spirit-f14f0e@devvm32600>
Date: Tue, 10 Sep 2024 12:05:19 -0500
In-Reply-To: <20240910-uppish-gopher-of-spirit-f14f0e@devvm32600> (Breno
	Leitao's message of "Tue, 10 Sep 2024 08:13:44 -0700")
Message-ID: <87seu7a180.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1so4Iv-005kJH-SY;;;mid=<87seu7a180.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19JOxRHwKLUZUCY1QPm1gfN+KbZ5kGU+nk=
Subject: Re: EFI table being corrupted during Kexec
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: rmikey@meta.com, gourry@gourry.net, usamaarif642@gmail.com, rppt@kernel.org, devel@edk2.groups.io, vgoyal@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, linux-efi@vger.kernel.org, ardb@kernel.org, leitao@debian.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_100528_910982_B898B2FC 
X-CRM114-Status: GOOD (  24.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Breno Leitao <leitao@debian.org> writes:

> Hello Eric,
>
> On Tue, Sep 10, 2024 at 09:26:00AM -0500, Eric W. Biederman wrote:
>> > I am wondering if that memory region/range should be part of e820 table that is
>> > passed by EFI firmware to kernel, and if it is not passed (as it is not being
>> > passed today), then the kernel doesn't need to respect it, and it is free to
>> > overwrite (as it does today). In other words, this is a firmware bug and not a
>> > kernel bug.
>> >
>> > Am I missing something?
>> 
>> I agree that this appears to be a firmware bug.  This memory is reserved
>> in one location and not in another location.
>
> That was is our current understanding also, but, having the same issue
> in EDK2 and on a real machine firmware was surprising.
>
> Anyway, I've CCed the EDK2 mailing list in this thread as well, let's
> see if someone has any comment.
>
>> As I recall the memblock allocator is the bootstrap memory allocator
>> used when bringing up the kernel.  So I don't see reserving something
>> in the memblock allocator as being authoritative as to how the firmware
>> has setup memory.
>> 
>> I would suggest writing a patch to update whatever is calling
>> memblock_reserve to also, or perhaps in preference to update the e820
>> map.  If the code is not x86 specific I would suggest using ACPI's
>> arch_reserve_mem_area call.
>
> Should all memblock_reserve() memory ranges be mapped to e820 table, or,
> just specific cases where we see problems?

Just specific cases.  There could be other linux specific reasons to
tell the memblock allocator not to allocation from a specific range
of memory.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
