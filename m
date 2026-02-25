Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA0AF5544E
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 03:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:Date:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2erXaSzxqouJYHAI7iQgk06x1aOTRy7Rez7nS+35Gsk=; b=V3ZfkM/6/DjsOTb5LFvu8TylBn
	AE5To8eXG6PFeOeD6aZB0C9ZUJpogQsIyW/kErmnAjbjiMw5WHouLar2Kx36Tj1j3xDTnCQViZ1dX
	MaoVv/3vEilfqGiNLvlvF73FykYkuRH7pYAJ3pbBzCAMktJddqDuun+g2EdS/A8mmJnODrU0G52TH
	Sr90qgUlwUv9jyIBDB/vH4UuhYWHuH6yNOb80XWDzYGnwmcG0j5WwJ1TlVDpkRbeXmgRvvF5UqkfT
	ZDWixXf6IegyL/iGRkDw6jxpKfFvrXSMcrkVrpSmQgvYoUoO7xUcCq93JD9I3mOHioEQYdUjLWpFa
	QGZw/1Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv5Vo-000000039Hn-1PDa;
	Wed, 25 Feb 2026 03:24:32 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv5Vk-000000039GT-36vY
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 03:24:30 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-3562212b427so2567367a91.1
        for <kexec@lists.infradead.org>; Tue, 24 Feb 2026 19:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771989867; x=1772594667; darn=lists.infradead.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2erXaSzxqouJYHAI7iQgk06x1aOTRy7Rez7nS+35Gsk=;
        b=kTnoXGCg08QYCtnNF7EmK8W4fO2ylVtXv6x28+YCJgKsanzlW7bQhib+ldKOa92skH
         79Z+Pj3Bm/7HizEloJdNSJwTdIJ04GrxA+TH1kg2rjlgmeww7pxkhLvUuUPBvFqEh1nG
         nGJKf0+5Qeo2afhcvrVv3neINiKcijUiskEDHFmBaoOyMPY1W72AhCOVoL02Y+mj6dMb
         ESRK7HQOKE8OWR8Tz/FDzS7RzA2vlc9B2NnH8GaX/Sklp0shGheC9a+ROxJVcOQSPUOk
         F397RXuWmBS5IdIuTIWcUSKvRfhacoHPIf8EsWTgIBiHH+6HmVnCXr/vcvzmnh9lM37g
         561w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771989867; x=1772594667;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2erXaSzxqouJYHAI7iQgk06x1aOTRy7Rez7nS+35Gsk=;
        b=GGORA9brKcyj2JYJmpGeFFvU30Zchq0+RveE7n3Y0/soC3oaM/ighL6P4q1B9KQBsL
         AzwyRf07VOAiRssLtHhvCDLIrOzkC6/i1WVnPjix4l0kfrFNXIRXuddXgkM96BkAToNM
         ugS2SmoM5nBp8SBpMn6JueMkXl916374ERCmXeIffDpgX9J0bzjGXlcJpbdU2vO/cWJn
         e8rGnkNtrLAxjaW2i3Op7BS0eUYUqoGQaUUp3y2HLS0j/wU3P8o+MFWWUmEQTexrKkky
         p1M5gKEf9gKLTX9mTpGECpGI7M/w10rDvOoj6RUHmtajTnkKW7aoQKT5JNOfKj6vqyGR
         tkiA==
X-Forwarded-Encrypted: i=1; AJvYcCVgPe+IDmVHcNwzhb8nNm7nw0ThqkvJPz1YLAd9tUek04CHRj5ZVt1wS3nB8ROYP42ialmHTQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyT2Y6F+UBwU2qza0jyd5QwViadv1lCGZy0GEImjcyYFRJAXYyl
	hJRvO1hrCmMD+EWzYIO/OASUew+ePWuOLtOGdI5ljLEoue82vDOE+I4K
X-Gm-Gg: ATEYQzwGdSA/9BOxKe9Gef7YVg4lN9WY8xDBhPfuVzkE5HH88G7u2cZcTUXBfAF+fvX
	36Bc7HEeXjm0Kd/VGWSGZP9SY1Zd3ctNA20pop3NGl9Wv97BZcwCff1BifLqQ4tufrnpwm05naW
	zeiehhmrhwNswdgkJ3AzSem/d9VNESVPU07paL4uVtfa1Rmr8LlOeeqr4vP12qEETHymdWC9e1f
	3q7uh5+MKT+bHYuUiSUWTJuVUB7DyP3CGSwWptTWsXlJYSbwfMwTMxbx5oaR7fOzRkmvSblugUU
	RFDGSbRS9ZQWk4PAbbHF6p6EwFnkFj5OSWrzRXfx6l5VRz3vp9hXC2WYCYkEczXlCjfVKVavYlk
	0f5eQIFWD2ZH/wO5nod6DNkfvn9+a2mTdH1Bg+3non59bPWDr1LRoevirZ9wgn7CW5WUIJBkKBD
	dXaY+9BVFJKqqN39zZ7A==
X-Received: by 2002:a17:90b:2cc5:b0:356:35a5:4a64 with SMTP id 98e67ed59e1d1-358ae7c5003mr12522694a91.4.1771989867018;
        Tue, 24 Feb 2026 19:24:27 -0800 (PST)
Received: from dw-tp ([203.81.240.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359037afe31sm1092824a91.16.2026.02.24.19.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 19:24:26 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net, skhan@linuxfoundation.org, 
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, 
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org, 
	pmladek@suse.com, dapeng1.mi@linux.intel.com, kees@kernel.org, 
	paulmck@kernel.org, lirongqing@baidu.com, arnd@arndb.de, ardb@kernel.org, 
	leitao@debian.org, rppt@kernel.org, cfsworks@gmail.com, ryan.roberts@arm.com, 
	sourabhjain@linux.ibm.com, tangyouling@kylinos.cn, eajames@linux.ibm.com, 
	hbathini@linux.ibm.com, songshuaishuai@tinylab.org, samuel.holland@sifive.com, 
	kevin.brodsky@arm.com, vishal.moola@gmail.com, junhui.liu@pigmoral.tech, 
	coxu@redhat.com, liaoyuanhong@vivo.com, fuqiang.wang@easystack.cn, 
	jbohac@suse.cz, brgerst@gmail.com, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH v6 1/5] powerpc/crash: sort crash memory ranges before preparing elfcorehdr
In-Reply-To: <20260224085342.387996-2-ruanjinjie@huawei.com>
Date: Wed, 25 Feb 2026 08:45:56 +0530
Message-ID: <87wm01h5sj.ritesh.list@gmail.com>
References: <20260224085342.387996-1-ruanjinjie@huawei.com> <20260224085342.387996-2-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_192428_825082_EAE1E586 
X-CRM114-Status: GOOD (  14.39  )
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

Jinjie Ruan <ruanjinjie@huawei.com> writes:

> From: Sourabh Jain <sourabhjain@linux.ibm.com>
>
> During a memory hot-remove event, the elfcorehdr is rebuilt to exclude
> the removed memory. While updating the crash memory ranges for this
> operation, the crash memory ranges array can become unsorted. This
> happens because remove_mem_range() may split a memory range into two
> parts and append the higher-address part as a separate range at the end
> of the array.
>
> So far, no issues have been observed due to the unsorted crash memory
> ranges. However, this could lead to problems once crash memory range
> removal is handled by generic code, as introduced in the upcoming
> patches in this series.
>
> Currently, powerpc uses a platform-specific function,
> remove_mem_range(), to exclude hot-removed memory from the crash memory
> ranges. This function performs the same task as the generic
> crash_exclude_mem_range() in crash_core.c. The generic helper also
> ensures that the crash memory ranges remain sorted. So remove the
> redundant powerpc-specific implementation and instead call
> crash_exclude_mem_range_guarded() (which internally calls
> crash_exclude_mem_range()) to exclude the hot-removed memory ranges.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Jinjie Ruan <ruanjinjie@huawei.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>


I had gone through the generic implementation v/s the powerpc specific
remove_mem_range() implementation, when it was posted by Sourabh
separately. And it make sense to use the generic implementation in this
case, rather than keeping a duplicate powerpc specific version. So...

LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


