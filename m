Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E96F4613F
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rMH01xhswRxeY7akcHE4uW++/WwOEsKp15HODGw/Qzc=; b=uaDBwRBhMdMhBQqAf2CbKD3/P1
	NxTg/FLo2OdNmwv8CuKWCK91cNvBquZTJfKtHFyJmt5z4ttO7pTPzCO/ut3XelVsX8BO/OXghFgST
	HZhCdcZj5LBIW9oJBCnvLkFjBnM3Bxr0BEypGVuQ/FvQe0O93IO3dJuIFR8KzvG9YbalATdeDVnRO
	rKn8PQ3p3frEx4JP+wc9JLhQlD1m3IXYdpxnhAQhVuyrS9D+05J8CRqQZ9n/l6ifM23J5f3qlvPpe
	/HXPJV85rHZCIMKz0zYLI5JYQyvlJBuIU6CUzUDE1cxVSn1SZYUSSAL9st2Bi6nt1NR855VUIIxB8
	u9iyORYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ngy-000000004em-3Rd7;
	Mon, 23 Mar 2026 22:24:12 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ngu-000000004dx-1puE
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 22:24:10 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-66971ccfcabso1047808a12.3
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 15:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774304646; cv=none;
        d=google.com; s=arc-20240605;
        b=SgWLP+7MqY8H4sQw301kViBDDAjnf+soHg2BEBNZvtrEQqXnj/ZY4qMjEthE25sd5V
         VXT7wbLZ45da1iR+/mSMz0MK2kNydBXY0hmScKxxWh88oo1D08Ax/NCLp36fESip+xt3
         Ia8Al5/o7qPrwmPO9AfL/A81OgwUlzAdlqDldaNyTo5QgapXDlgjfnl6oxoNmfECQOlE
         3fh2gIZ6vgQDzv8nyCC7he4oa+B25Y+H20lN9Gb/+26AVJ7RGqnNTrTMmq1jv9uAXuRZ
         Lv07EUJ3lY22B8RijmpHMIlKXDQX+K4xd8J7A5N5ZVpMvPZm4ZcdmTg6XPdtXN64hhnb
         xeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rMH01xhswRxeY7akcHE4uW++/WwOEsKp15HODGw/Qzc=;
        fh=YVa4tMB2pSWQ/xe/rTzld5CzE7t38y7ezM4Ptgden0I=;
        b=h00wvpU44xLY6HaVcS9MR090nywlYVZfJ84YQHrllk7ObJ+kVJkDctDBmt66sWUeho
         kn/D4uvA5ueOFAh3fJuupiTJteCZ3wZO8lc0Hazugzg4YlnZwuNDjTzJu2fIVLahUiLy
         PbAT65SnHvXibGeT2OB/CoqRiuYrH9bHFaCjqDRt5ml9rsVNhZHfD5dY2cFcAk8moGe5
         pl/Wp3soK6q9McQd7QIDXhqz6qo9Tgnh3NbD8EwuQpdxAmF4xTIPdlCI52VY+o+luHdT
         1Gb30/+F2TzYta5pGugEaeTQPEugvH9ysJa1gJnH8dcyb0Rlcn29ImAlW5lnPd8k7by+
         x+uQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774304646; x=1774909446; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMH01xhswRxeY7akcHE4uW++/WwOEsKp15HODGw/Qzc=;
        b=eg/kfUrst+ET8mmj2vc915JpmloSaQAQwuQXbXNgNpoXcbIV8x2KPlzCCr0WZMeZnn
         KwBezEF8hxFqvn28AQxmMGykgXvPvEkpMt43WvRpKtr73E0ThTvjyTCyImvOfDDBLtAw
         k93KEdTVSLZM5b2JxNQOvuJjnjBjWNMQkCwbRlXRom9l7iblxMBPp1xGsv1CooW5mSRE
         aDdZefwsJqjS674aDSSLgfqvZwwgEVcmYJmwoNl2jxotZKbfD5AY/ZtKR/daRrlUnRBx
         ds0Bk4A4zHIMBvKa1LDs8BN4JeQhPKX4/ajH3dahfl+ayIL9ao549pntupXAGuVIByZX
         l7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304646; x=1774909446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rMH01xhswRxeY7akcHE4uW++/WwOEsKp15HODGw/Qzc=;
        b=pawMiGtfs/jYlwYFQbadW91lhOA+hirPLz96uvcSeA67wWbO6Qmt1TFBIk29i1EgC9
         CB7YWCt1DbvhFAVZWJLYQtLtTr8fJEJsugb39B4R7BYnPXm+mjQE4w6C2q9FJ2T67L6U
         B23nE3JTn/tIhLs8vmamB3i2gQXvep6VtcWOiaqvYHdCmAeczyrYRO378OJLWfMK/NN1
         1yqEliZ5eTNjXbmGaNTBG4SRgYR7Hay77L+Jkft9MmMA4oncVheoHAIPuz82zprEjg6M
         NXJc3faEETsQA3raWGaqCKnhtSrbrouJo8mevzXXgAmkcXQq3uzLgk/wth3lDBdZQ72Q
         mSNw==
X-Forwarded-Encrypted: i=1; AJvYcCXvqjajFdbt8eTDEvruAumNRNTeKru4q+3/8B+DEUpZXAzLtFY2Aq6P1XvPTPGmXwFgY8Qerw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwNUrXpC5Edxozacj2MrjMzltfpbeTGYq2wREZoDR9mZ010YqqO
	k2uw5NY3jSTnYsoVvu1/qyw2O9EbUBSDP3tMpoBQMG4mlMXwHGIHWBS7YG90VF5UgkNKRitvUtG
	V0vJ53BNembKb7fS/zSLPJ7V90MaqCEBy5fffrsGOSg==
X-Gm-Gg: ATEYQzywkFMHtqOj4QmigBsCfqPb0Mcq41PmbQTAPj2dvQG9lSNLfaQAd/YMfLIpsl/
	Ho3GeZFDgnzpwGczveXqFR0xQFQeyAJFgGXgNMDq5gN1dd1jcIs8vC84QkVAlD2GtTzuFXgpmxH
	IMvkiOjIfic1EwDe4UxDEcXc7VUpipJwDImpPg8W8j/lm37Q4TkUGQSKIh58hOcHnOsFPaOK50W
	lTme3zaLcW4Ev43j70j8PskXyeMYaXhSZ4K6t/l8M/0n2UJjamvgLz5JR10J78WQc38H4hoOP5e
	+UAc/vZB6vSeF8LbxzpWByoNnJDfkrmMFOcC1Q==
X-Received: by 2002:a05:6402:5d0:b0:65b:f342:d1a2 with SMTP id
 4fb4d7f45d1cf-668c8f08c14mr10693463a12.6.1774304646108; Mon, 23 Mar 2026
 15:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260321143642.166313-1-oskar@gerlicz.space> <CA+CK2bAfPSKfV=_Sw20oqF56+H3a4k3x+47i6-EUK8mLV-i2+A@mail.gmail.com>
 <CA+CK2bC8o2p_poLb0yfp6mAAwR42Vg_99Yh_HLK1iJZrCrsVig@mail.gmail.com> <f76e6cbcf6752342ee940ed0dfeca7bd@gerlicz.space>
In-Reply-To: <f76e6cbcf6752342ee940ed0dfeca7bd@gerlicz.space>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 23 Mar 2026 18:23:29 -0400
X-Gm-Features: AQROBzBYmbrN8P_EZJ8f9HXtmmp65c7B8Ck9f-JHx34u3fy-gh4kUtkFo_LM52g
Message-ID: <CA+CK2bDN3bk5Y-LP9OD+6vPrr50Eyy4ALJvhK36ZFGEgj7yjLQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] liveupdate: block outgoing session updates during reboot
To: oskar@gerlicz.space
Cc: Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_152409_728850_504D7E89 
X-CRM114-Status: GOOD (  41.93  )
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

On Mon, Mar 23, 2026 at 4:54=E2=80=AFPM <oskar@gerlicz.space> wrote:
>
> On 2026-03-23 20:00, Pasha Tatashin wrote:
> > On Sat, Mar 21, 2026 at 6:28=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> >>
> >> On Sat, Mar 21, 2026 at 10:38=E2=80=AFAM Oskar Gerlicz Kowalczuk
> >> <oskar@gerlicz.space> wrote:
> >> >
> >> > kernel_kexec() serializes outgoing sessions before the reboot path
> >> > freezes tasks, so close() and session ioctls can still mutate a
> >> > session while handover state is being prepared. The original v2 code
> >> > also let incoming lookups keep a bare session pointer after dropping
> >> > the list lock.
> >> >
> >> > That leaves two correctness problems in the reboot path: outgoing st=
ate
> >> > can change after serialization starts, and incoming sessions can be
> >> > freed while another thread still holds a pointer to them.
> >> >
> >> > Add refcounted session lifetime management, track in-flight outgoing
> >> > close() paths with an atomic closing counter, and make serialization
> >> > wait for closing to drain before setting rebooting. Reject phase-inv=
alid
> >> > ioctls, keep incoming release on a common cleanup path, and make the
> >> > release wait freezable without spinning.
> >> >
> >> > Fixes: fc5acd5c89fe ("liveupdate: block outgoing session updates dur=
ing reboot")
> >> > Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> >> > ---
> >> >  kernel/liveupdate/luo_internal.h |  12 +-
> >> >  kernel/liveupdate/luo_session.c  | 236 +++++++++++++++++++++++++++-=
---
> >> >  2 files changed, 221 insertions(+), 27 deletions(-)
> >>
> >> Hi Oskar,
> >>
> >> Thank you for sending this series and finding these bugs in LUO. I
> >> agree with Andrew that a cover letter would help to understand the
> >> summary of the overall effort.
> >>
> >> I have not reviewed the other patches yet, but for this patch, my
> >> understanding is that it solves two specific races during reboot()
> >> syscalls: session closure after serialization, and the addition of new
> >> sessions or preserving new files after serialization.
> >>
> >> Given that KHO is now stateless, and liveupdate_reboot() is
> >> specifically placed at the last point where we can still return an
> >> error to userspace, we should simply return an error if a userspace is
> >> doing something unexpected.
> >>
> >> Instead of creating a new state machine, let's just reuse the file
> >> references and simply take them for each session at the beginning of
> >> serialization. This ensures that no session closes will happen later.
> >> For file preservation and session addition, we can block them by
> >> simply adding a new boolean.
> >>
> >> Please take a look at the two patches below and see if this approach
> >> would work. It is a much smaller change compared to the proposed state
> >> machine in this patch.
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git/log=
/?h=3Dluo-reboot-sync/rfc/1
> >
> > Oskar, I made a few more changes to avoid returning an error if
> > get_file_active() fails. This prevents a race condition where the user
> > might call close(session_fd) right before calling reboot(). I
> > force-updated the above branch. Please let me know if you want to take
> > these changes and use them to in the next version.
> >
> > Pasha
>
> Hi Pasha,
>
> thank you for taking the time to prototype this approach and for the
> detailed explanation, I really appreciate it.
>
> I agree that reusing file references and introducing a simple blocking
> mechanism makes the solution much smaller and easier to reason about
> compared to a dedicated state machine. Your patches definitely move
> things in a nice direction in terms of simplicity.
>
> While going through it, I was wondering if there might still be a couple
> of corner cases worth discussing. In particular, do you think a boolean
> gate is sufficient to cover in-flight operations that may have already
> passed the check before serialization starts? It seems like those paths
> could still potentially mutate session state during serialization.

I think it is robust, it works in conjucition with session mutex. If
an operation already passed the check, it already holds the session
mutex, and since serialization also takes this mutex, it will see
consistent data after pinning sessions via
luo_session_get_all_outgoing().

>
> I was also thinking about the lifetime of incoming sessions (especially
> lookups holding pointers). Do you think file reference handling alone is
> enough there, or would we still need some explicit lifetime protection?

I'm not sure about that; I have not looked into those patches in your
series yet.

>
> I=E2=80=99m currently working on v4 and will take a closer look at your b=
ranch
> to see if we can combine both approaches in a way that keeps the
> solution simple while still covering these cases.

Thanks!

Pasha

