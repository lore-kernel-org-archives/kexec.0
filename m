Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6ED8C531D1
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OxDEn/Flx2JsTbvw3aRK9+ph/beITac4a1J9fuT8ijI=; b=ea47jKBizuRgcy
	m3CukR6X64uoa3hkTA/eojRKWt+JNX76cEu5g3UJ3JHSNNDWNPTR3hKhMj6QT4I/DiBZeUnhN6pNl
	wHr78zA9PdXZedyMdnkZXY+whpE3yeJWa0tTk7yn0FuFa0SxSXVpZIS0EdNnmIwsxNlMXfvt1K0Fq
	XMyoMtcSZ0In1SUw7x+8QIrpcTRePyj1qkVql2PvJVD1LBf1NTFXdrNyAMh374NljCUNbLJBuJXw9
	UvEWrZYvNrs3P1yJqhTRZvnvSL9Dc7WGYx2BRUdngryyvAJZzp5P4RpWFnAU7CyDI6kzwVnu2mYNO
	wYdVWByBtjNjVBUodJ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmvV1-0000000EcTf-3XHI;
	Thu, 23 Jul 2026 15:38:15 +0000
Received: from confino.investici.org ([93.190.126.19])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmvUz-0000000EcTA-1iyl
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 15:38:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784821091;
	bh=OxDEn/Flx2JsTbvw3aRK9+ph/beITac4a1J9fuT8ijI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=s8WfEio2i6aDEx3X+OET6fhU25nviJreNTtsIY2D9Dt5zAlXRP8tF1AeAqiwQbSyL
	 8DLMu2l59j02mMzzOevUEx5NmMEDP2q1iESU04SYXpfkklk9d0KNAGxqKayQ7341gB
	 A0MG8gOOUs5/Px6dKRZfrPmK044WFCgD/9yR5iCo=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h5ZyW44TBz12rr;
	Thu, 23 Jul 2026 15:38:11 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h5ZyV5KP0z12rq;
	Thu, 23 Jul 2026 15:38:10 +0000 (UTC)
Date: Thu, 23 Jul 2026 16:38:09 +0100
From: Bradley Morgan <include@grrlz.net>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/3=5D_PM=3A_hibernate=3A_log_?=
 =?US-ASCII?Q?the_task_that_initiated_the_power_down?=
In-Reply-To: <CAJZ5v0g-=5fmRLrJJg=HBvnEew+LhPN4gV1OJJhDLS4tW49Dnw@mail.gmail.com>
References: <20260721151358.4185467-1-include@grrlz.net> <20260721151358.4185467-4-include@grrlz.net> <CAJZ5v0jN0QQordGJ+7EyO42Zwidok0j+TKZLCmRhU8CFeRHMuQ@mail.gmail.com> <22B60EFE-21BC-4E2F-9542-93D9FC2AAAB1@grrlz.net> <CAJZ5v0g-=5fmRLrJJg=HBvnEew+LhPN4gV1OJJhDLS4tW49Dnw@mail.gmail.com>
Message-ID: <B254B844-AA37-437D-827B-B13E27166D08@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_083813_616939_8D90747D 
X-CRM114-Status: GOOD (  22.01  )
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
Cc: pavel@kernel.org, tony.luck@intel.com, baoquan.he@linux.dev, linux-pm@vger.kernel.org, kees@kernel.org, kexec@lists.infradead.org, pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org, rppt@kernel.org, akpm@linux-foundation.org, pratyush@kernel.org, lenb@kernel.org
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On July 23, 2026 3:55:10 PM GMT+01:00, "Rafael J. Wysocki (Intel)"
<rafael@kernel.org> wrote:
>On Thu, Jul 23, 2026 at 4:46 PM Bradley Morgan <include@grrlz.net> wrote:
>>
>> On July 23, 2026 2:55:41 PM GMT+01:00, "Rafael J. Wysocki (Intel)"
>> <rafael@kernel.org> wrote:
>> >On Tue, Jul 21, 2026 at 5:14 PM Bradley Morgan <include@grrlz.net>
>wrote:
>> >>
>> >> Give the hibernation power down the same treatment as the reboot
>> >> syscall commands.
>> >
>> >Why?
>>
>> 1: Andrew suggested it [1]
>> 2: because going down for hibernation is the same as "Wait, who the hell
>took the box down?!"
>
>No, it is not the same unless the system doesn't resume.
>
>> >
>> >> hibernate() runs in the context of the task that
>> >> asked for it, whether through the reboot syscall or a write to
>> >
>> >It doesn't use the reboot syscall.
>>
>> Hmmm.... I may embarrass myself here, but it *could* (wink)
>>
>> See kernel/reboot.c:
>>
>> #ifdef CONFIG_HIBERNATION
>>         case LINUX_REBOOT_CMD_SW_SUSPEND:
>>                 ret = hibernate();
>>                 break;
>> #endif
>
>Ah, I'm wondering if anyone actually uses this, but fair enough.
>
>> >> /sys/power/disk,
>>
>> I'm wrong: /sys/power/state
>>
>>  so when power_down() runs current is still the
>> >> initiating task.
>> >>
>> >> Log it once the image has been written and the machine is committed
>> >> to going down:
>> >>
>> >>   reboot: initiated by systemd-sleep[812]
>> >>   reboot: Power down
>> >>
>> >> The line comes from kernel/reboot.c so it keeps the "reboot:" prefix
>> >> and sits right next to the final "Restarting system", "Power down"
>> >> or "System halted" line, same as a plain reboot.
>> >>
>> >> The one exception is platform mode rolling back on a pending wakeup
>> >> event after the line has been printed. The existing "Wakeup event
>> >> detected during hibernation, rolling back." line follows immediately
>> >> in that case, so the log stays real about what happened.
>> >
>> >(a) Why is this information in the log useful?
>>
>> when the box just randomly goes down, some people prefer to know
>> "And what process did this? Or what did this?", say
>>
>> "Was it systemd-sleep? Or some random power daemon?? Or some stray
>> reboot(SW_SUSPEND)??"
>>
>> Userspace logging can't really do this...
>
>But it doesn't really go down in the case of hibernation.  It's more
>like suspend in that respect.
>
>> There is software out there which can do this, but it's not the
>greatest.
>> [2]
>>
>> Hence, this series!
>>
>> >(b) Do you realize that it only appears in the log when hibernation
>> >fails or it may appear on a serial console or similar?
>>
>> yeah. The image is written when the line prints, so after a successful
>> hibernate and resume dmesg won't have it.
>>
>> Thats exactly the
>> same visibility as the final "Power down" / "Restarting system"  line it
>> sits next to
>>
>> Well, if you want it, please say.
>>
>>
>> [1]:
>>
>https://lore.kernel.org/all/20260719231540.455bd5c3eac842686c05bd7f@linux-foundation.org/
>>
>> [2]: https://docs.memfault.com/docs/linux/reboot-reason-tracking
>>
>>
>> (oh and btw, if you don't buy in, it's ok, just say.. any questions,
>ask)
>> :)
>
>Yeah, I'm not convinced.
>


ack, dropped.

btw. I wasn't the surest anyway abt swusp, don't worry.

thanks for the review and sorry for wasting your time

Thanks!

