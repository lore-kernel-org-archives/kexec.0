Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55594C05027
	for <kexec@archiver.kernel.org>; Wed,  8 Feb 2023 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4ErkOhp9FF52sDtj0oS5eLHOSD/WMfVbXkW/5SaKQGM=; b=USfFHyRb9B6ojA
	9z3645CA207x8ZZTF4DIcbPVT7ifNOiSU1QJeGiyEGiWiOt3H/PG4VxnX8V9JyLjuUxnSv9ZspL1u
	YAnEQ3C/o0y4x8JdFxYRDoz3xApttkw8GHm0V98SRw1/VXI4c1k1SFHuXSTAsjKDUoB4CnXvhGQSS
	FtsjPnGXYDQzTfk5XtwM7egI/sfngZ/Dec0/3i9qwUPaGqzBPQTxZnxr7SeUdy+iESewNvjbdvdFd
	5M74H2kFKV72Zf6dtzen7XAw2LV6moxjiiwHK3iHQNHMTQwL8zI14/vlFVAd3OK8N+oO9CVMn/LhB
	2iCQfNtiFHLaGg1ZB4FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPkki-00Fo7c-Px; Wed, 08 Feb 2023 13:44:48 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPkkg-00Fo4N-5x
	for kexec@lists.infradead.org; Wed, 08 Feb 2023 13:44:47 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1675863873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i8F4anSaAXOgaD7d2SXNTwzuF6VCoNge2r+vc3EHUuw=;
	b=jza22pT4f+uyQ+xvhLROf+nawi64DF8K4bQV/5xIE1VXfuRmBDEhtuaOsVKfdsUL83UhJF
	LlMuQe26cozAAFD43T1MgHuaEfTgp8odHGJ2pXgCt6Lk+0xeWvZ6l0aqiiHSWUQWylmbVB
	gFQ5kR9azZGf4DsWHaU8m1+VZqDpi+ehDzJoFz8Ap+LHverBvY5sHq0k/L7Z5bw2pWIMiV
	2u6VBhqWAh6xeN12ERHy745IzOQo1AFYjFTjah24UjAjFqtMyOHpz+CCyJMbKHkO4Nex8C
	CgnqJUjXLuT10ocz6JfVFxtWGnd0tBA1W2hDrvQ1ghwehA2FedgikW7j+8HRlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1675863873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i8F4anSaAXOgaD7d2SXNTwzuF6VCoNge2r+vc3EHUuw=;
	b=vCi+2bWwXSLRxMWFjtnYZTiNH4pFrBS/pZXytPYxbX4+sRUdN1fSg6tCxzU+cE1091n3vl
	/5nLMLIT1UmlB9Dw==
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
 dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
 robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
 sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
In-Reply-To: <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
Date: Wed, 08 Feb 2023 14:44:32 +0100
Message-ID: <87h6vw2rwf.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_054446_370795_3DB68A0F 
X-CRM114-Status: GOOD (  11.48  )
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

On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
> On 2/1/23 05:33, Thomas Gleixner wrote:
>
> So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.
>
> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
> attempts at locating this state failed when inside the STARTING section, so I located
> this just inside the ONLINE sectoin. The crash hotplug handler is registered on
> this state as the callback for the .startup method.
>
> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
> placed it at the end of the PREPARE section. This crash hotplug handler is also
> registered on this state as the callback for the .teardown method.

TBH, that's still overengineered. Something like this:

bool cpu_is_alive(unsigned int cpu)
{
	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);

	return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
}

and use this to query the actual state at crash time. That spares all
those callback heuristics.

> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
> makedumpfile and (the consumer of it all) the userspace crash utility,
> in order to understand the impact of moving from for_each_present_cpu()
> to for_each_online_cpu().

Is the packing actually worth the trouble? What's the actual win?

Thanks,

        tglx



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
