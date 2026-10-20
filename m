Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793E60A2604
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mLI1BG1g;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARO/ajo2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nLyz9JhGDWxy9NbjsVWTRULOrIKXHGlt/Z6IB5TxlIQ=; b=mLI1BG1gR4idUXI9nsNKg6uEV4
	WDJCd/61/g8ZyBwWLnwLI/vd5Ae/hBGSFhWfy2sQiTkGJiY3+6b3WblVzXGsQEZwx8mBBJbPLFbqb
	zpmXvrB5MA8i/0FHoQQCwiCWiT8mtFZeGSSeHMyKLmRl0ovnRNrd65IZRLNx30OHheOZU0c4Ldcpv
	yXZgysdeKhTSF2XDMiS1Hot99I7RbLW/V8if9XPIrNsnTirrgr/YzRQEQc00MjIzkslwO2Py5OKDg
	cK9IV3LO7PINjWqUpibkiUhbXGEbkwdfzs2B+Hpsnc8SeVV4qJV+VhIrwmxNtWr2HBKkEURII7Ry8
	LlBX4dBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ6xP-00000009PtS-0KOa;
	Tue, 20 Oct 2026 10:20:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ6xN-00000009PtK-1wiV
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 10:20:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF639605ED;
	Tue, 20 Oct 2026 10:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEC51F000C4;
	Tue, 20 Oct 2026 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792491632;
	bh=nLyz9JhGDWxy9NbjsVWTRULOrIKXHGlt/Z6IB5TxlIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ARO/ajo2zgnbhFh5hCsGaz2xlsiTq5MKQA6QPpY92hDVzgorsIZh6oB+ih4SUR7Sz
	 tIwJgdtYXc3kdAtc8zIZB1sQAhih9AFMDP5WLOrHIyxgNB/ReCHVUJyJqFnTHEjBqd
	 84SBrjEEA3ccXcwJHCAHI0pCb64e09QbkB+WwlUSIAJSRYofca91MsD2O5S/01RU8s
	 Kb2wYkAbksfdst2H+OBT2H1jGVQ5oyRchc/cWEuy3ecycbLOpz6QFvwMcn0KG8joWJ
	 0iBmrCBKxSd91sy0cvV/QL47OD2pi12m2LMfPXiVyiX3Kx6I6KP2r2/i6sSNyHy01m
	 jKAi1djIrLRrA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com,  linux-kselftest@vger.kernel.org,
  rppt@kernel.org,  shuah@kernel.org,  akpm@linux-foundation.org,
  linux-mm@kvack.org,  vipinsh@google.com,  linux-kernel@vger.kernel.org,
  dmatlack@google.com,  kexec@lists.infradead.org,  pratyush@kernel.org,
  graf@amazon.com
Subject: Re: [PATCH v1 3/7] liveupdate: Pass user argument to file preserve
 and retrieve
In-Reply-To: <CA+CK2bD83qVv54_Wps4GRr9otg32pW2A01WVTo-gTR=oYs95Vw@mail.gmail.com>
	(Pasha Tatashin's message of "Mon, 19 Oct 2026 15:31:50 -0400")
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
	<20261015093816.2438942-4-pasha.tatashin@soleen.com>
	<9huzwlrdh4q4.fsf@tarunix.c.googlers.com>
	<CA+CK2bD83qVv54_Wps4GRr9otg32pW2A01WVTo-gTR=oYs95Vw@mail.gmail.com>
Date: Tue, 20 Oct 2026 12:20:28 +0200
Message-ID: <2vxzfqy0hdw3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19 2026, Pasha Tatashin wrote:

> On Mon, Oct 19, 2026 at 3:26=E2=80=AFPM <tarunsahu@google.com> wrote:
>>
>>
>> As Per Today's Hypervisor liveupdate meeting, This patch will be picked
>> by @dmatlack@google.com for latest tmpfs preservation series.
>>
>> I have a suggestion to make here.
>>
>> Let's send this patch as a saperate patch so that I can also use this in
>> my guest_memfd preservation work. This will help landing this feature
>> sooner and unblock other subsystem who needs it.
>>
>> Let me know what you think?
>
> Hi Tarun,
>
> You can include this patch the next time you send your guest_memfd
> patches. Whichever series lands first will pull in this change.
>
> We are trying not to merge new features without an actual user,
> especially ones as important as those changing the uapi. I think tmpfs
> preservation may actually make it easier to land, as it only changes
> the code that we maintain.

+1, let's use tmpfs preservation to land this change. It is a simple and
relatively small change compared to guest_memfd preservation.

[...]

--=20
Regards,
Pratyush Yadav

