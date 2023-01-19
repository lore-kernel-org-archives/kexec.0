Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDBDC678D4
	for <kexec@archiver.kernel.org>; Thu, 19 Jan 2023 21:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u2xf8LkyXtAEl9OYuW9dLpd2sRS3YXinaixv5fDmMv8=; b=BzFBT0L8/2wv8I
	kcovLvC6b2ee87SrGNBMuqzMWDtth5tQ3HWoT6zUAj/75bM4ecLHwwCBaXQ7GJyCBNO6CPO5BVwXP
	mjBlvCIf7DV9szS7pame5uz8BP0DYraAn4hbWQFfrBI35rFus4Yo6MuOhD7IWhpnJ+UwacwUHUcMu
	nUzFTKmDC2AS6FXzKY+qC/O8XyJlT9lyJZbwkZmj26VPBsgb4dKGAIAq5ZT7UDJ8qwvGIaa2oPRmr
	cX4/0yxBOgoUBffynr9YJyk1aGS4Z4BaQyn9oBwLTxx2GHauXvl9Kn5BjMpcO+8+MbMz8LzUj0V+x
	6WAb5rcABuNzAX6guADA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIcVP-007IrY-SY; Thu, 19 Jan 2023 21:31:31 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIcVM-007Iql-Pk
	for kexec@lists.infradead.org; Thu, 19 Jan 2023 21:31:30 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1674163887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpLGkp7TW3vMSv6Ch08YsOSSkac6mSrH3tdNKGcKrTA=;
	b=WqVmr62Yz1+gEStX8aVtZcB/rMuQyay0eAvJoqhCGlQhsGot5ok21q1YXXEMAb7SYBGWZW
	qWEeYlQWJe5D4jHo4oxzM8+TDwtoGtlGXUidZFwgeJY7UK9iPqCJ9uaJ4IYnhX3uodnHVw
	6kdqG4RR8HpSbJFL4uPOo2HEYhqdaWnLEiCdal/Tdi4lDQYkVrr3SJmKklPil85Rivz9pq
	oIT+JyWINCxt+Ppn6kpXFStKSx7959F99J28QW3EbND5qG0mBk0y2JX45drpPx90i3m5iO
	ZGWtLOGmVx6uAfJ9npqjlBgEUamWpdMLv8uM1SIs/o5pVnmytIkMWTHgq5UMFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1674163887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BpLGkp7TW3vMSv6Ch08YsOSSkac6mSrH3tdNKGcKrTA=;
	b=2JSBiIV6G3QTOfLM2pkSn1rkkucbgtYAFO0EXPd97m9XM8NDKyvvaZsMTlFAOzLTVgS+/z
	EDySbq6Ge3jhaWBQ==
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
 dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
 robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
 sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: Re: [PATCH v17 3/6] crash: add generic infrastructure for crash
 hotplug support
In-Reply-To: <20230118213544.2128-4-eric.devolder@oracle.com>
References: <20230118213544.2128-1-eric.devolder@oracle.com>
 <20230118213544.2128-4-eric.devolder@oracle.com>
Date: Thu, 19 Jan 2023 22:31:26 +0100
Message-ID: <878rhyi53l.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_133129_019462_BD7F944D 
X-CRM114-Status: GOOD (  14.66  )
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

Eric!

On Wed, Jan 18 2023 at 16:35, Eric DeVolder wrote:
> CPU and memory change notifications are received in order to
> regenerate the elfcorehdr.
>
> To support cpu hotplug, a callback is registered to capture the
> CPUHP_AP_ONLINE_DYN online and offline events via
> cpuhp_setup_state_nocalls().

This sentence does not make sense. The callback is not registered to
capture CPUHP_AP_ONLINE_DYN events.

What this does is: It installs a dynamic CPU hotplug state with
callbacks for online and offline. These callbacks store information
about a CPU coming up and going down. Right?

But why are they required and what's the value?

This changelog tells WHAT it does and not WHY. I can see the WHAT from
the patch itself. 

Don't tell me the WHY is in the cover letter. The cover letter is not
part of the commits and changelogs have to be self contained.

Now let me cite from your cover letter:

> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr, which describes the CPUs
> and memory in the system, must also be updated, else the resulting
> vmcore is inaccurate (eg. missing either CPU context or memory
> regions).

The CPU hotplug state you are using for this is patently inaccurate
too. With your approach the CPU is tracked as online very late in the
hotplug process and tracked as offline very early on unplug.

So if the kernel crashes before/after the plug/unplug tracking event
then your recorded state is bogus and given the amount of callbacks
between the real online/offline and the recording point there is a
pretty large window.

You can argue that this is better than the current state and considered
good enough for whatever reason, but such information wants to be in the
changelog, no?

Thanks,

        tglx

Hint: The requirements for changelogs are well documented in Documentation/process/



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
