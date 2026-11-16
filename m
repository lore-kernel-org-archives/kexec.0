Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A1D606A33A
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ng74w1W6;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Sq+Jm38K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hPr9IOYFjtJaYI4q2QerjW2bLfRzLv1kPuZUspzu/XY=; b=Ng74w1W6AvSOMH99PEfmS5vfyE
	G8xNJ1Laflkkvf+f3FJP3l+U8uQSVlwPBT1kh84/4mfbxjmoQd/X0mBwc9n9xYGaq7jBU6cO8+W2s
	BY28V54wUnN0ZwGVzldQJwZjMp3xT9Rde/9/QXPvwGO9PK+cpL4vM3Q9R67w0z7+bmL+KhcAHKgzT
	1X4XxJ3YwlUyHc+LLLA6hTVjeTkcx7dNvAAUDWHc31KW4B3Sbd5Ii794B7zbJKhRxYxKHKrWN6PwZ
	MycEt9W7A2OB6MbtnVhO/w1Kc3LzGWEW0aMxZWnCVeDaoH4NvkCTfp97I0Y2hQCR0eVAO6AS8W6RG
	e8NrZ7Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSyfa-000000034hy-1Gqm;
	Mon, 16 Nov 2026 15:30:58 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSyfR-000000034fP-36s2
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 15:30:53 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so11585265e9.0
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794843047; x=1795447847; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hPr9IOYFjtJaYI4q2QerjW2bLfRzLv1kPuZUspzu/XY=;
        b=Sq+Jm38K28AHm9O8FLMQGcaV+mvjV0T8ngsnMTxjkAfpEk/p0monWDcKs5yYGdpqnN
         3slDhZs8dwAJw7LnJzOKM1dOMgudhPIktVOcj+LeJzML0/QQqEm0x8X4ZVZzHh7Qgcav
         cqiHOlc9xR08diz8kJ2I01u6faGUbg0HdfkxXZxC7sWW0/ZrateHCUNPg41rEI6MTaPb
         cbiefD/PX3S5gmqy5U/dYPIkcoLRUvP3cqbRdnZv+zQWB7PzWtTvBPtw+aqp24YHnIW+
         4648p2slnX9lUQnN4oaYDvoGyM7n7bKEBmkdP62Cj07Ad6UBd/X6iTnAgWQen+pB45hp
         cEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794843047; x=1795447847;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPr9IOYFjtJaYI4q2QerjW2bLfRzLv1kPuZUspzu/XY=;
        b=zjkjz7pcjpc5vjIbpLoWs+sS1Ijdq8jlVxyFCehmfISEu7JIExDOvLjVsMD/ELorsc
         kXC6n0ADOVXEzqaCkRHdK6fY60NtkB+OPfPt1CKmaAUcE+CEdYgjYH4ArzgDxACCw64/
         iK0YSxi77j8gYnHz0r+XRVuTxEyARZDjkNz3+YYnq0mI2z5t05HHv409KMModLQOu9Zh
         HCQ5ioQXQJkYGh6lequQpTzbDpTzZVsaOAtKCIG8VMQqBWal2OLb2wsMVuV1bI+iaDwM
         D3G7p3w6v2a180/tBl7VUzOEgQ2fFfpZVl1q5DZvd73iX0H5sphMW62tGYxuQfaBxVup
         2DHw==
X-Forwarded-Encrypted: i=1; AL+hErGpwxcx7Nni5pNtVnzawCa8K17tZNvHcNHW+J9OqvrDVmebkWrRFjnUPe8Wa2BjEOKghiKHsw==@lists.infradead.org
X-Gm-Message-State: APuU4Z+afIoRchnR3H27pc+asfU9lsvBcH/XpVNYWeENgaDz1AxAhN9J
	onKKlO6x4x+ujewsHXjrPXTkvUIdfXiIOHqOu3B207v0++B4zEZIitYSS6WoFOCG6M8=
X-Gm-Gg: AYBFou2maDHhzC1LOspTAc3seQRGZ068mWw5YwiZo5X58go5H2oBg1B29PyjxjrDMMc
	7pyHEHDnFCTHon46L25wSkZ/eR5QYrUMwZeysXAUm90JeEclcZIgGMmbimnZgtLv7zGvKWaVlYZ
	DcV5THbLuMYe9MfqG8HcFUU7U+SS01g+reXuiZomFWT9p1YVrUiQ6qyZj8H9jz996x1rTN1I6rd
	dgYH1onIF68+6X9BRI39/PoovCG0BY9ya7mOHLJPnIhy/rLi3D3q7wJQa2P1uqe0eD4Lpb2rZVq
	8Pchp5jommvtHcNf2al0cx7xvPcCX/cRRKoB1cKHvXtvaiux0y9mUJe6Xj+E+1z6Q1AFI+eRcQF
	F0KaOUlAhChzLfUVCds3bZvOYjhbZM3ISRrFKKX6+lCsygn+2VP++VhY0xxxtgZsAAM/A0GWSnq
	cbrH3Tw2WZk/3MG/4z2ZTqtJNAGh4d7406WCv7XI+USpeH9PdnslZjO3L2Q94OPgrYSxhcK60Li
	2G0qqNojFf5Txt9gQILfZFGR5Vg4aQcUd5xgmagy2Ny3UH3/L0GXlH6G4jWfA/0tqc3v2f6d5UD
	kvD3Fgy0k+nuRn0N41Dsq7Dyrg0Ghts=
X-Received: by 2002:a05:600d:8449:b0:4bb:5f07:10d7 with SMTP id 5b1f17b1804b1-4bb5f07134dmr146384475e9.26.1794843046610;
        Mon, 16 Nov 2026 07:30:46 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae5299sm315252695e9.11.2026.11.16.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:30:45 -0800 (PST)
Date: Mon, 16 Nov 2026 16:30:42 +0100
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
Subject: Re: [RFC PATCH v2 1/5] panic, sys_info: Fix duplicate and dropped
 all-CPU backtraces in panic
Message-ID: <avshouTNBIeM5qtP@pathway.suse.cz>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-2-atomlin@atomlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103024453.922373-2-atomlin@atomlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_073049_812470_BD25EF6D 
X-CRM114-Status: GOOD (  20.07  )
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

On Mon 2026-11-02 21:44:49, Aaron Tomlin wrote:
> When sys_info() was factored out of kernel/panic.c by
> commit b76e89e50fc3 ("panic: generalize panic_print's function to show
> sys info"), __sys_info() gained an unconditional call to
> trigger_all_cpu_backtrace() when SYS_INFO_ALL_BT is set, while
> panic_other_cpus_shutdown() retained its own call to
> panic_trigger_all_cpu_backtrace().
> 
> This causes two problems during a kernel panic:
> 
>     1.  vpanic() invokes panic_trigger_all_cpu_backtrace() inside
>         panic_other_cpus_shutdown() before stopping secondary CPUs, and
>         then invokes trigger_all_cpu_backtrace() a second time inside
>         sys_info(panic_print) after secondary CPUs have already been
>         shut down, stalling for up to 10 seconds waiting for offline
>         CPUs to respond to NMIs. Furthermore, if SYS_INFO_ALL_BT is
>         configured via the kernel.kernel_sys_info sysctl rather than
>         panic_print, panic_other_cpus_shutdown() misses it prior to CPU
>         shutdown.
> 
>     2.  If sys_info(SYS_INFO_ALL_BT) is invoked on the panicking CPU
>         prior to panic_other_cpus_shutdown(), calling
>         trigger_all_cpu_backtrace() directly bypasses
>         panic_trigger_all_cpu_backtrace() and leaves
>         panic_triggering_all_cpu_backtrace unset. Because panic_cpu is
>         already active, vprintk_emit() silently drops all NMI backtrace
>         messages originating from non-panic CPUs.
> 
> Export panic_trigger_all_cpu_backtrace() with a panic_on_this_cpu() and
> one-shot guard so all-CPU backtraces are only emitted once before
> secondary CPUs are stopped, consult sys_info_get_mask(panic_print) in
> panic_other_cpus_shutdown(), record prior Oops stack dumps in
> panic_try_start(), and route SYS_INFO_ALL_BT in __sys_info()
> through panic_trigger_all_cpu_backtrace() on the panicking CPU.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -451,13 +452,21 @@ bool panic_try_start(void)
>  	old_cpu = PANIC_CPU_INVALID;
>  	this_cpu = raw_smp_processor_id();
>  
> -	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
> +	if (!atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
> +		return false;
> +
> +	if (atomic_read(&panic_redirect_cpu) == PANIC_CPU_INVALID &&
> +	    (test_taint(TAINT_DIE) || oops_in_progress))
> +		panic_this_cpu_backtrace_printed = true;

This would be pretty hard to maintain. The complexity of the check
shows how many code paths affect the decision. I can't imagine how
to synchonize all the pieces this way.

We need another approach. I remember that I have already proposed
something some time ago.

The idea was to enhance sys_info() API to remember what has already
been printed. trigger_all_cpu_backtrace() and frieds should
not longer be called directly. They should be called only via
sys_info() API.

See https://lore.kernel.org/all/aj5tFiwhRqPkAkqU@pathway.suse.cz/
for more details.

I think that this would be a better way to go.
What do you think, please?

Best Regards,
Petr

