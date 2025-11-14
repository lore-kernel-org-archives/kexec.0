Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5E0CE8D68
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AgjgO/JE3OZ07MDSlomAz877pTgtrV+LOc7uLI5gBYs=; b=b5KqeQ5lc0oUiTZgIY0RulIAUR
	+I9pElQ6PA70B5+QKUE+CnETekZkwpoPx1w6TWthwSovvCC7uppbRPEUBt1mmxRDyrbOUBP94aq66
	Z0mB3QeeXw/UyvXyOnDCjn1xWTiZtqsAXzyBg/rabaBY3miCZwAazT4DC8tnf15oryEnEXBGdQq0a
	F2UscYBOL56U/l2pS+yfHF8/k+03jAR0UNEL7VHKugcocLxwIixOqza/Oca24qXGV//7fg/XUQiKM
	rxBJTWZirk1pKw6cFdCTk/7N2uvxLL2jK1wOJvKCtm0z1GJF3fjeq82ZgW3khTa/JC/7p+xjO4j4z
	hIU0S99A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxtp-0000000CsGq-01Np;
	Fri, 14 Nov 2025 17:47:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxtl-0000000CsEP-2wgU
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:47:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DF4E444F6;
	Fri, 14 Nov 2025 17:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F2EC19424;
	Fri, 14 Nov 2025 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763142469;
	bh=AgjgO/JE3OZ07MDSlomAz877pTgtrV+LOc7uLI5gBYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=O1JN87/mEAZ2GV9XXdpj2U2zwA/hBk99V1wsYW4hRleUWzdwgTDhR6QC+ZZutfR2u
	 LReqZKxbczhxFlzL5kJ2Ypk0uA7rnYlSc2heSnMezFYbeEfkI0frfTZw1M3sGRrLC+
	 eRZ1Rpd7o6M6PLw4WizL7smDg3pPuOCG1zhd+eUMEqRmFw7Xiw5QQ9VY/8G8pOf5h5
	 NzJCoCSTiNsvo09Pd8vJ+qWI3rhKbI45ucsKByNBIOAa6k6lltQEZlxxZ1ALE8KVWq
	 01THR5ZKvsKSycYUONgiUdsiJHT01W199neZwA5ESYZv4zHSaEff3PfAva5n14IwBv
	 uLYHSUFJe7Rzw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  akpm@linux-foundation.org,
  bhe@redhat.com,  rppt@kernel.org,  jasonmiu@google.com,  arnd@arndb.de,
  coxu@redhat.com,  dave@vasilevsky.ca,  ebiggers@google.com,
  graf@amazon.com,  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 08/13] kho: Remove abort functionality and support
 state refresh
In-Reply-To: <CA+CK2bCS52_vU-Z5ZRPrceiVCnJim=8VoYRMmBkx5iEd8-B8tw@mail.gmail.com>
	(Pasha Tatashin's message of "Fri, 14 Nov 2025 12:23:54 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-9-pasha.tatashin@soleen.com>
	<mafs0cy5k7ct3.fsf@kernel.org>
	<CA+CK2bCS52_vU-Z5ZRPrceiVCnJim=8VoYRMmBkx5iEd8-B8tw@mail.gmail.com>
Date: Fri, 14 Nov 2025 18:47:45 +0100
Message-ID: <mafs0ms4o5wvy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_094750_211223_4F7D4041 
X-CRM114-Status: GOOD (  16.15  )
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> On Fri, Nov 14, 2025 at 12:18=E2=80=AFPM Pratyush Yadav <pratyush@kernel.=
org> wrote:
>>
>> On Fri, Nov 14 2025, Pasha Tatashin wrote:
>>
>> > Previously, KHO required a dedicated kho_abort() function to clean up
>> > state before kho_finalize() could be called again. This was necessary
>> > to handle complex unwind paths when using notifiers.
>> >
>> > With the shift to direct memory preservation, the explicit abort step
>> > is no longer strictly necessary.
>> >
>> > Remove kho_abort() and refactor kho_finalize() to handle re-entry.
>> > If kho_finalize() is called while KHO is already finalized, it will
>> > now automatically clean up the previous memory map and state before
>> > generating a new one. This allows the KHO state to be updated/refreshed
>> > simply by triggering finalize again.
>> >
>> > Update debugfs to return -EINVAL if userspace attempts to write 0 to
>> > the finalize attribute, as explicit abort is no longer supported.
>>
>> Documentation/core-api/kho/concepts.rst touches on the concept of
>> finalization. I suppose that should be updated as well.
>
> I looked at it, and it is vague, we are soon to remove finalize with
> stateless kho from Jason Miu, so in that series that section can be
> removed or replaced.

Okay, fair enough.

[...]

--=20
Regards,
Pratyush Yadav

