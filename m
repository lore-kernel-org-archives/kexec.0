Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB3606A31C
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZT6YiX96;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=JtlQtMUH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kVFpNKJHonPsoU0rKznaV1aSGj2r5pa7n7k1+LB8yBg=; b=ZT6YiX96Up5FIO
	Op8ej4DbAHTZiZHDYoREmm+o6Bqr1a1nK3fusXw4XVcjreYtI4OfCmbc3GShpxHUKLqqhoNM3DKxq
	7ci4n6n1jHigbOyFyjwZZgOB8ieZIb8n4k8dnW+j9QEuH5MC72uCw9Its/9c01l6EYlQ2Ol1HRn9Q
	wKmeMFwpYVpzKJgr+AHn99NRtMIRU8fRUU/VSu7AExUxrbxcTdqc/a2UQ7RRynRsHhp6LLjR3PmJJ
	NJL/ujqzdN4dzQ7XFZtmTKWLHcQ/1jr83uy9pBdUBb0nUNF4JHBSzTT8qENEZ3qvXdAHhapux4RkB
	lfGdD79mm8QlPCvdUjaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6lS-00000006Woh-39eK;
	Wed, 11 Nov 2026 11:45:18 +0000
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR6lQ-00000006WnK-1Rim
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 11:45:17 +0000
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-998749fe872so1486600241.0
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 03:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794397515; x=1795002315; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kVFpNKJHonPsoU0rKznaV1aSGj2r5pa7n7k1+LB8yBg=;
        b=JtlQtMUHhD80abuE4kFMRk1nYI1IJGY+mUx1RXh+wU7JaFAO5HWwXcRrppyS6qs82A
         lGacNbcHlUQjb+l1XwDE1tMmhHpmhEZrYHA/kN8q4ufc5+7n/0yGfo27xQIqieiHbVYB
         9ZW+QTzXb7UTuR6YwAL+C1fS/u15ARTIiH7dQkjP8Mo5fA+Tb1JPV8I7QwqvZ+Q0FOIx
         oOgWCCTGGh3us4R3VUQArHfSQr5HqJ7v3Qr/TTgMjEbdzybhB1XmjnTLd5caG0OLFyTZ
         t4dcsIjXjcuo2xEy0VS0d/5xYX/MFU0pPsOycFYLu3rVWCs58/zNOJTMzmfxh0njSsdv
         bV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794397515; x=1795002315;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kVFpNKJHonPsoU0rKznaV1aSGj2r5pa7n7k1+LB8yBg=;
        b=hUYr3AxTlVnrT+51eJ5Na8L5ym0q/wIWiQP9SPguRDtsLZc2O2lYajpNV+E/1cX13F
         Nj3yth2REnbRdKqW9q2iPW+veB+wNglc60Mqs1WmWBDiqv9hkadgdbTeTj6dR4AQZrRr
         SijzTtfts4cH9LMshSdohgrtR8Q9Tq76pFabzYSWfD22eDJpUhKhR1uYRMQtWRxwHu/u
         RW58VaZsdQr8AW6cjWRpr1Cu6AW03Id1zBsVcMz2axI69nCw9CgSLkwaJRWkpgnKlZ9g
         7RlbcOr0vETFfAcwY1vcEMtY08R/t4kAVqoQZg0j2AE8wyCoV9LGns4YZkA0xWDtZMS1
         lVbg==
X-Forwarded-Encrypted: i=1; AL+hErHHGRtln9DQrrmUXvBQ/aiWkFwAJEiwgOnk3i/eZu2m88woMDHI1JX53/GC4aUjP6zooA8swg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/DsqeScFF1tBA8PcbxAGWrukERtFVbnP7Tv4HBCQA7YSjvXA6b
	dIGBEp22WEWlQzzSRxLeBcFfAXsiIU5EPo4WjIuRyJU/VgZmVLvajhSPrXvPH73SEOs=
X-Gm-Gg: AYBFou2fg4NKR00HLYqvtQ34kUPqLo+756DF297Qj5IPrzfa+LwhnyxxgKO1mJn/QDe
	wglJRW2u0N5IE0mq6HGZ8OeA/VbQOazTXVE9r/mBbMfYe5aehcxBkS/3TaekRfmlnwjQoEN8md+
	ya0Ixvdf6Sa310dp9oVlYhHoLmBaWEvECbCemfjdtH+kFcL/Zx/ywxcVWUPcZjD0S4Hw/YmI37Z
	2eLm1rNFWgGoK8SvRwtJqt+zCwo674lzWqaZVPS1NXQbm5NTITyjEydwAOE2dU8ns0iFHwxlMKV
	yMBn8BgmYRxkv3RvAd3KGfm4ngX8HMTBSRICh5ttvGK71q7snU92vPTpxsh0u8bQo+Jab/fklz6
	I/qQBcdJmvaSe0apYfTK7/jb3UcVx/zwzi4ZAU7Po9m+edlvQXy1KeI+87X+0qZnHmaUzgoV0UR
	MSP6rb6sADnAd6iLKERK+gHXWcBO5XlPMGhnsWCKSEU9juXL0KmuKKbLVKWIvEP0724lQxx0Xvg
	aEStWC17i4xfJ7g6MR6DAFjNpYS3MaA3+9CekdfRq+jXU37MuGdgYKSNiAQQ5QC4CjKsi79thJv
	N6MMDXt11B6tMJCuj+OfIqMzjiqWCutl9cXHc4iiI+KQeCnueIujZyTrAFbjUFBKJFW61W81dQg
	HK1MuV9HZ9/jnmQnZBqLeYnW4TOG2fpQ=
X-Received: by 2002:a05:6102:5241:b0:7cc:306:d3ab with SMTP id ada2fe7eead31-7d4efab730fmr666726137.5.1794397515001;
        Wed, 11 Nov 2026 03:45:15 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023543casm3548860137.5.2026.11.11.03.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 03:45:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 06:45:13 -0500
Message-Id: <DMSCTXTWCJWK.QF8T3E7OJ7L2@soleen.com>
Cc: <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
 <linux-mm@kvack.org>, <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>, <vipinsh@google.com>,
 <linux-kernel@vger.kernel.org>, <corbet@lwn.net>, <dmatlack@google.com>,
 <kexec@lists.infradead.org>, <pratyush@kernel.org>,
 <rdunlap@infradead.org>, <graf@amazon.com>
Subject: Re: [PATCH v5 0/6] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Mike Rapoport" <rppt@kernel.org>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
 <179439592040.425130.10808690337075841196.b4-review@b4>
In-Reply-To: <179439592040.425130.10808690337075841196.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_034516_401454_8E44BF69 
X-CRM114-Status: GOOD (  10.62  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 11, 2026 at 6:18 AM EST, Mike Rapoport wrote:
> Hi,
>
>> Currently, LUO freezes outgoing sessions only inside the
>> reboot(LINUX_REBOOT_CMD_KEXEC) syscall path, serially under global write
>> locks, and binds every outgoing session's lifetime strictly to an open
>> session FD until reboot.
>>=20
>> On hosts running many workloads (such as VMs or stateful daemons),
>> workloads do not all pause simultaneously inside reboot(): they quiesce
>> one by one ahead of the host kexec. Userspace needs an explicit
>> per-session freeze point to snapshot final file state (.freeze()) as
>> each workload pauses -- concurrently across sessions under per-session
>> locks -- along with a way to commit a frozen session into KHO so it
>> survives closing the session FD.
>>=20
>> This series introduces LIVEUPDATE_SESSION_FREEZE on session FDs:
>>=20
>> 1. Freeze (flags =3D=3D 0):
>>    Freezes all preserved files in the session under the per-session
>>    mutex while keeping session lifetime tied to the session FD. The
>>    session stays frozen as long as the FD remains open; closing the
>>    session FD before reboot (for example, to abort the session or on
>>    process exit/crash) runs .unfreeze() and .unpreserve() and reclaims
>>    all resources. At kexec time, already-frozen sessions skip the late
>>    auto-freeze step and are published into the outgoing KHO subtree.
>
> Let me bikeshed for a moment :)
> I'm not fond of "published" terminology. We just moved serialization
> from one place to another, why not keep the naming?

sgtm, I serialization it is.

--=20
Pasha


