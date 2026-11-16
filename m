Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F76606A8B9
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RqxEQqdP;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Y66sG2sM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z/lO0d4awc7COFA/57IeDRMAZfL8lXDL1xwEp8NDS/0=; b=RqxEQqdP25YVtBmfFZcacybg+N
	21CYdHsEccfsf3v3lPBQ/+lIaIJmeuPupfQIz60D5YhrxHNB0+7sCA5NLvSbMjykSFPKdmnqGToz9
	8jSYLVRFSxJKIg7UmLfF8fy8gcTHXu8N25cL3+mVKSdpaRgTHPQK2IRcXVLcZyjX0JJt41By71nvr
	p/diWFmKYWpI1TwFqvhMuOBRg+Hg3V6GKYpQDLvSVpyYAVasc6UjytQwtsAIhRdRBx+oPzkq6Rc+R
	+KjHUNdaao34vRBUEBS7DA7hkc8aMfgRRVgKz9/3svSC1Py23WdOn5x8Th6id8ha/6deb/qtPNOgx
	NSUecyYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT0C4-00000003Ml9-35Ie;
	Mon, 16 Nov 2026 17:08:36 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT0C1-00000003Mkd-2jfa
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 17:08:35 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4b467581b98so32304815e9.0
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794848912; x=1795453712; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z/lO0d4awc7COFA/57IeDRMAZfL8lXDL1xwEp8NDS/0=;
        b=Y66sG2sMUhtgBmhjSQ14XLrqTQqtt4ij+px+y9wxgAzF67C91WgB70weeHyX/QMUue
         SHJgtiih6P+zUT0L0tQ2LV8fvrqKweK7eG9bnupeY3UkjGvr6wMDbK4Csftz0Vfu5Ot0
         LxL8rlhHd7vP/lxqE6PNcbtMtOzfc8gKLsbLMrxTvMGwHX1LEO8ORSSqdNjvqU8f126g
         bwZTSdy2mUBLtncj5uGwtSVTNF08EC8POVMfAPsvAj1UFHPjYA8Roto2H3DIb8VKljmO
         vYWaLFzO8PFcUUXzRa1Hu9cEGDVUq8tj3OQUgPfG5e5WBFJyKrc7FR8hKiQ5dZgTQLrR
         qn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794848912; x=1795453712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z/lO0d4awc7COFA/57IeDRMAZfL8lXDL1xwEp8NDS/0=;
        b=EeaOEDZDakPN437//jlUAHfcwjbBOeV4xvgxFP3URVKQoc9f5EDCqGA4Geii+t/nvN
         e+zeRv5BcwuelFuc6P9OpmAMnfjnqGyIdYOcGSug5getzZj6i7jJKKB+MaGySut37ABC
         EwIOgFOWaLm4j/ruLbsMO0NFdHcewtKUw3B4Y/JT4LZJgj07g5QueNG7iadW+sf4j178
         7HVnFg5ltJjmffnt/LUehqeLRZCLf14MFDtojRjQ+vEao4V5f53Zyy2V7DGgGEBlVLR0
         ahBenLzQhFJu2xAb7eaVJ+B3p0ZeOaIwG/ia9xqSHaaWMChDt2i0KB3PuyjTrlwKzLzT
         Utng==
X-Forwarded-Encrypted: i=1; AL+hErERFc6vfmxEPm7GLzBWLNTZUBTOdDlcTGq7kdZSIG3PjyaV5dk3ECf43cczlKqGeLUAZfBwQg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+Xrj9WdL2JOP1GTQkjjFOAPiUYiaCYduvQeR/gUaKvPgGNWVGM
	jL80BTdG6jopG4ClZbW6vWip6HBi+kvfrx9dCwiamtcMpYKA+UJimEwDDvuVLnbay94=
X-Gm-Gg: AYBFou0vFCigP9Fr1ATBB80qhgI9i5QxcMAP2+vO+AnKBQtv2eYuYK5lQDxwsDdJOCU
	/XE3ux43bTJvIsdp8lCexkZ6isGAsTF3LssFfFfRxdPN2HVbjeIYdQWpAPSKD4yXCJ40xHwC25c
	7uox6AIXx6nFKJU+sug6jhGpDBA4L+gfRPE/2dajrlkidSJeVaO9XM23j5G0Mvpds7JXG4NhTgz
	IVp4VjCKNYOXnve9kPcJWiqNHh24hs1mHBs3QL4yXxlt4y8zILt7ZTra+gVsgA6S/5eTKYx1iql
	PwK3L4XrNuwSgSoyCVkOOkwHwH2kmf5UQEskgtNmCR4ar5Fy28Gld164yOPvnE1cmeMnIJBBx3a
	r9oGBLoqUNqXpGvEY2utbKDQ1EHiqBYw65P8qvXSdz2iKu3Xlj3gxKLvsVvD9KJeZJHcit5c4eq
	BpAnmmMuvxBG4GAJVZYng9h6dxQSMBmAhzjOas1x3GQKj4cgauyZRFAFYbV6WYFFsSHGjS4KUIo
	SStwwn/J0kmGGpXX2alnE0NXnOumePaqTaqPIkivJrxuMtCG9U+9xoaoTzOVDo+a3eUje1Kf+ki
	psMQQyoi0J+pwNW/tG5oq2XvVH025dc=
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb6c71c232mr97325545e9.6.1794848911805;
        Mon, 16 Nov 2026 09:08:31 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c77393700sm22964108f8f.18.2026.11.16.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:08:31 -0800 (PST)
Date: Mon, 16 Nov 2026 18:08:26 +0100
From: Petr Mladek <pmladek@suse.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: john.ogness@linutronix.de, rostedt@goodmis.org,
	senozhatsky@chromium.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, kees@kernel.org, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev,
	hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 4/5] printk, tracing: Support console flush
 suppression and tail pinning
Message-ID: <avs4igB_mEc9U-Yw@pathway.suse.cz>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-5-atomlin@atomlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103024453.922373-5-atomlin@atomlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_090833_718886_93103A7B 
X-CRM114-Status: GOOD (  26.54  )
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon 2026-11-02 21:44:52, Aaron Tomlin wrote:
> When collecting high-volume diagnostic output into the printk ring
> buffer during a kernel crash prior to kexec, synchronous console
> emission can stall the panicking CPU for tens of seconds on slow serial
> or IPMI Serial-over-LAN links, risking external hardware watchdog
> resets. At the same time, uninhibited ring buffer rotation can wrap and
> overwrite the initial Oops, faulting registers, and primary call trace.
> 
> Introduce two scoped mechanisms for in-memory crash telemetry
> collection:
> 
>     1.  Console flush suppression

Nit: We already use the word "suppress" for filtering less important
     messages on the console, see suppress_message_printing().

     I would prefer to use another name to avoid confusion.
     We basically want to "block" or "pause" consoles here.

> 
>         Provide printk_suppress_console_flush(bool) to clear the console
>         flush mask in printk_get_console_flush_type(), guard legacy
>         record emission and kthread wakeups, and suppress
>         wake_up_klogd() in vprintk_emit(). Records written via
>         vprintk_store() are stored in the in-memory ring buffer while
>         bypassing synchronous hardware console emission and kthread
>         wakeups.

We already have similar infrastructure for suspend, see
console_suspend_all().

We should not use a completely different aproach to achieve
the same. It would just complicate the code and design.

I suggest to add CON_PAUSED flag and handle it similar
way as CON_SUSPENDED flag. It should be enough to:

   + update console_is_usable().
   + add console_pause_all_in_panic()

, where the console_pause_all_in_panic() would do similar
things as console_suspend_all() with the following differences:

  + no flush
  + take console_srcu_read_lock() instead of console_list_lock()
  + no synchronize_srcu()

And I think that it will be only a one-way operation. We do not
need a resume part.


>     2.  Ring buffer tail pinning
> 
>         Provide printk_mark_panic_start(), printk_clear_panic_start(),
>         printk_freeze_tail(bool), and printk_is_tail_full(). Recording
>         the next reserved sequence number at the start of a crash (or
>         clamping to prb_first_valid_seq(prb) if the crash output itself
>         already wrapped the buffer) allows data_make_reusable() and
>         desc_push_tail() to continue recycling older pre-crash records
>         while refusing to advance the tail past the pinned crash
>         sequence number. Once the watermark is reached, prb_reserve(),
>         prb_reserve_in_last(), and ftrace_dump_one() finalize the last
>         record and stop reserving descriptors or consuming trace entries
>         so the primary crash context and remaining trace buffer remain
>         intact.
> 
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -377,6 +377,90 @@ static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
>  	return (void *)&data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
>  }
>  
> +static atomic64_t printk_panic_seq = ATOMIC64_INIT(U64_MAX);
> +static bool printk_tail_frozen;
> +static bool printk_tail_full;
> +
> +/**
> + * printk_mark_panic_start - record the ring buffer sequence at crash start
> + *
> + * Pin the next reserved sequence number at the beginning of a top-level Oops,
> + * fatal warning, or panic so subsequent tail freezing can recycle older
> + * pre-crash records without overwriting the primary crash output.
>
> + * Context: Any context.
> + * Return: true if this call newly pinned the crash start sequence from
> + *         U64_MAX, false if a crash start sequence was already active.
> + */
> +bool printk_mark_panic_start(void)
> +{
> +	s64 panic_seq = atomic64_read(&printk_panic_seq);
> +	u64 first_seq, next_seq;
> +	bool pinned;
> +
> +	do {
> +		first_seq = prb_first_valid_seq(prb);
> +		if ((u64)panic_seq == U64_MAX) {
> +			next_seq = prb_next_reserve_seq(prb);
> +			pinned = true;
> +		} else if ((u64)panic_seq < first_seq) {
> +			next_seq = first_seq;
> +			pinned = false;

What scenario does this handle, please?
Why do we need to move the "pin" when there are concurrent callers?
What happens when the original caller clears the pin and
the other racy caller continues with panic()?

> +		} else {
> +			return false;
> +		}




> +	} while (!atomic64_try_cmpxchg(&printk_panic_seq, &panic_seq, next_seq));

Are the atomic64 operations safe in NMI? I would expect that they use
some locking.

I am afraid that we might need another approach.

IMHO, it would be much easier when the caller knows whether it will
panic() or not. And the panicing caller would just freeze buffer so
that the next_seq will always stay there.

Finally, please split the console pausing and ring buffer freezing
into separate patches.

Best Regards,
Petr

