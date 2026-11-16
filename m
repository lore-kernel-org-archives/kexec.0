Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7A606A31C
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4i9my7OY;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=gcSHKEaG;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=PnNGzpEq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=; b=4i9my7OYT5ahxb5j/US9vc/6Ys
	c3A5FzkusGS4n5zdiQ8l6yFmtB3Xui0rAfPmvOT2XQ5uTSmVFwPgr1ebpStslMcCg6CYKCuf0WDVT
	YvRxBuy81pyyeM/luaRLaHZu5plBuK8M/P2btZCG/db7FJsuSk4iKv8NxGVMH60P376OOHlRlu2D0
	Bo597S2x4lYBvaHnOiezfA83sn7R+g0SRi0q0/INno6qoUUYBZaKEmIRz2OGk4+TaPwuD3Q9aKHay
	g9rvSyNv62VIZbKFHjSduqotxd57j3hMBq57c27or0yX97b3KmW4KdU+qSJXL40OOhYJuPMCttRu4
	17E6kCTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT2sN-00000003oW3-2Y2W;
	Mon, 16 Nov 2026 20:00:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT2sJ-00000003oVH-2X1j
	for kexec@bombadil.infradead.org;
	Mon, 16 Nov 2026 20:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=; b=gcSHKEaGXPoe6U+aJvHd1tN597
	4WeQQAH5Dx917G9D5wh8dYkgowNs/MBZY96b+6thItZjKp8Ua2/CuUZ5XLhSc9wVFFlD3Zmdmd5/m
	JK+roayarV2R3ILphHpDbV8P0EuK2df+e/7Z/iOQ3n9UDTu3OSMTJIK7T64ACu8lk6XEtdl3erV/1
	VuaF5tQEbs6I7X4LqkX9bSsxbV/ZfutArJDvyUG+k5tCaG7eFjTdfMwo3fDQHVorOk3lOt/qVA9CP
	+Ob7YHPrZ4NmCJ/cvWk+WrchxP0KztrCTst5Dx+FT1LGC6sglU6nERX9Jg3t3v1X4PvgFgwOvOs1V
	t5kxAlLA==;
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT2sA-0000000EFSe-1guM
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 20:00:22 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so23687765e9.1
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794859212; x=1795464012; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=;
        b=PnNGzpEqgPrHZ+4n0lSf6KMvI5i8OX8KNrCjqqAPOmDGjKvM2zG068lFZatg4ClwQE
         1N6W/sd/0qWoHPvKzV9B5oWP+nOaVWkXAFIJY5S8kJL4qf7LHtSs1yo7mPg5U8RQrCxv
         ho7afoLqb9iyfl0p4/3Vh40jBUBrLmF7psr3zSMhnIBl8EA393cvHUknoBV9gAgTS3Cy
         TLbozguYQY/+vPQXOLB2RdwKb4N0VTJgwEx6Vim1CiXMTcshAr7xlCh+DvjZzQG7VdND
         fVsW5qThYwxl8Uv7XjOqobKjW4YZBfgj7Ls7Cy2RVjqsDGtE41uJPL90z+j0IHcFVP1c
         armg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859212; x=1795464012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fgYoS8Jg+X3AS3gIOJEgllVRt0eGZvLJAbdMyeSaVoE=;
        b=lTIy93Iq+dB0WNzlR60GN7BoMUD7717MTlzlYj3FyBSWlUzhO2qmhO/3wkvErujHEQ
         t8IuVqMshsRqBvRmmQjsseLjRz2FZj+CoxLZAN4YbPCY7ppsPHWJ6wgI9jvnUb4zSGPF
         aMiQem53eFcrHd7oBrUoHRa9HbOMBT8q4dQCzSbV8H1DrSd9GChU07eMPuDUddfv1PFz
         DhKRxtU/5BpZ74vGvwrcC9ev9bBaFqMYKu/towkftJ1+i7FV9VuTiU5OqznvDfTjfAEm
         PvpDrc/XSdDavLomcrrzxte4Pc86HK7mJUfzbiNutyZ9ObHbFUHHSK+4D1MWiNKKtD8w
         kqSg==
X-Forwarded-Encrypted: i=1; AL+hErF0TBgmLBtGTkrinCjhbWldltoSikrL3VnovDPGsR9CYqkIYIXtxikz9qywDMHhzkV0HJOubA==@lists.infradead.org
X-Gm-Message-State: APuU4Z+17TzGuuVK2fE0vp7KGm6hhI5PztuFFkwAoMVfk2ZqHKSs+j5a
	nfTuHWlYsaSfcaVl1whVJSMNIaC46MEv2tnqC01e+5/csUviG6ezr3sK1VjEHzn9Rsk=
X-Gm-Gg: AYBFou1ImVoWK0WMltBnNcjTU1iXZIyp3iT3v5d/J5IjAI7/etGKANo6/gNO8dlXnPG
	k3yKLDtnCMZgFcbn7PIs5taR0Fqa9ee4TWHf43IyqwedAztEZ/Nb59248dZx7rF+HTxAflRus/F
	bUyoi1hyH4sPr9K2fc0SukTW3+zxBeWJMKEup0x26FY4dXRfBvmOvFW9CKcskpKxTRj4DsXoHTe
	GYYG7iczzYnoR9RUEq22rB+DlLxO8nGTXzf++CkeKsiBcEzljez/yJXp5rq4f9eRbJBX0mx4q7f
	qEq6TzNHyY6yYZfzdl7nRezc55WeAbf3slE9kfibxujOIMxxRdikqgY+b6utS+nFXh6zWnB2J/6
	Lw1cR6m1MrdSgIpGYJDDogyTVzMz23/iAnVvpdMiz2/LPVMItJtwkJT2+Riy8nN7CbKKk/+FPWA
	4c12I4mLARrF9Eim5d3oazVg/VuwONXzUQWRi0VAyS0oh0QDudMeBQn35nKnwNxEmZb4RZDzDnQ
	4sRkSHK1voj+sP/V+F3gPXoYwx6UnUFCsnB60Sx6SsAX9VikvYRqfBvp6eXp1gHw6/MU8QYRdl0
	KirCTi1/dhS3z28KtCZUS4yRX/3mUFQ=
X-Received: by 2002:a05:600c:8709:b0:4bb:73ad:c1f0 with SMTP id 5b1f17b1804b1-4bb73ade318mr72004685e9.23.1794859211890;
        Mon, 16 Nov 2026 12:00:11 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78386902sm14032225e9.1.2026.11.16.12.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:00:11 -0800 (PST)
Date: Mon, 16 Nov 2026 21:00:07 +0100
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
Message-ID: <avtgx3WkeDvn7zoK@pathway.suse.cz>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-5-atomlin@atomlin.com>
 <avs4igB_mEc9U-Yw@pathway.suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avs4igB_mEc9U-Yw@pathway.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_200019_424422_719A4DC8 
X-CRM114-Status: GOOD (  30.34  )
X-Spam-Score: -0.2 (/)
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

On Mon 2026-11-16 18:08:31, Petr Mladek wrote:
> On Mon 2026-11-02 21:44:52, Aaron Tomlin wrote:
> >     2.  Ring buffer tail pinning
> > 
> >         Provide printk_mark_panic_start(), printk_clear_panic_start(),
> >         printk_freeze_tail(bool), and printk_is_tail_full(). Recording
> >         the next reserved sequence number at the start of a crash (or
> >         clamping to prb_first_valid_seq(prb) if the crash output itself
> >         already wrapped the buffer) allows data_make_reusable() and
> >         desc_push_tail() to continue recycling older pre-crash records
> >         while refusing to advance the tail past the pinned crash
> >         sequence number. Once the watermark is reached, prb_reserve(),
> >         prb_reserve_in_last(), and ftrace_dump_one() finalize the last
> >         record and stop reserving descriptors or consuming trace entries
> >         so the primary crash context and remaining trace buffer remain
> >         intact.
> > 
> > --- a/kernel/printk/printk_ringbuffer.c
> > +++ b/kernel/printk/printk_ringbuffer.c
> > @@ -377,6 +377,90 @@ static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
> >  	return (void *)&data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
> >  }
> >  
> > +static atomic64_t printk_panic_seq = ATOMIC64_INIT(U64_MAX);
> > +static bool printk_tail_frozen;
> > +static bool printk_tail_full;
> > +
> > +/**
> > + * printk_mark_panic_start - record the ring buffer sequence at crash start
> > + *
> > + * Pin the next reserved sequence number at the beginning of a top-level Oops,
> > + * fatal warning, or panic so subsequent tail freezing can recycle older
> > + * pre-crash records without overwriting the primary crash output.
> >
> > + * Context: Any context.
> > + * Return: true if this call newly pinned the crash start sequence from
> > + *         U64_MAX, false if a crash start sequence was already active.
> > + */
> > +bool printk_mark_panic_start(void)
> > +{
> > +	s64 panic_seq = atomic64_read(&printk_panic_seq);
> > +	u64 first_seq, next_seq;
> > +	bool pinned;
> > +
> > +	do {
> > +		first_seq = prb_first_valid_seq(prb);
> > +		if ((u64)panic_seq == U64_MAX) {
> > +			next_seq = prb_next_reserve_seq(prb);
> > +			pinned = true;
> > +		} else if ((u64)panic_seq < first_seq) {
> > +			next_seq = first_seq;
> > +			pinned = false;
> 
> What scenario does this handle, please?
> Why do we need to move the "pin" when there are concurrent callers?
> What happens when the original caller clears the pin and
> the other racy caller continues with panic()?
> 
> > +		} else {
> > +			return false;
> > +		}
> 
> 
> 
> 
> > +	} while (!atomic64_try_cmpxchg(&printk_panic_seq, &panic_seq, next_seq));
> 
> Are the atomic64 operations safe in NMI? I would expect that they use
> some locking.

To make it clear. I think that it is not safe on 32-bit system.
This is why we used 32-bit lpos values internally in the ring buffer.
Also we use struct latched_seq for "clear_seq" in the printk code.

> I am afraid that we might need another approach.
> 
> IMHO, it would be much easier when the caller knows whether it will
> panic() or not. And the panicing caller would just freeze buffer so
> that the next_seq will always stay there.

I know that your proposed design make the new API easier for use.
You just remember next_seq at the beginning of a potential panic()
message. And you freeze the buffer when you realized that it really
ended in panic(), ...

But the proposed changes in the printk_ringbuffer code look complicated.
They are not easy to review, definitely.

I feel that there must be an easier solution. For example,
desc_push_tail() reads the state of the tail_id descriptor
including the @seq number. It should be enough to compare it
with the pinned sequence number and return failure when
it is greater or equal.

One more variable might be set when the pinned sequence is reached.
And prb_reserve() might then always fail at the very beginning
when we could not make any more space reusable.

I am not sure why you touched so many other locations. I guess that
you wanted to allow saving short strings when they would fit
into the remaining free space. But I think that it is not worth
the complexity. This feature should be used with a big log buffer
so using few more bytes is negligible. And it might even be misleading
when we store some random short string later.

Best Regards,
Petr

