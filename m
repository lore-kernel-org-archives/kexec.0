Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1838CCF2C4
	for <kexec@archiver.kernel.org>; Sun, 18 Oct 2026 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ayMWfGshO3UNwVYFCcSN2BNh422miW8cad5xrtcnUvg=; b=CEIoPSDgIVO39TAoY96P6Sfuob
	RXY0UfHP8jNVPpFCwvN4tMEnJLROG/HZzkpa1bamF/2E1EnkZ/rR+ChTpHy7v4/buKHXfjtJqY7mt
	gxG8LaF0d0jdbJN5jm73msMJSShyiqzHoJAne599sxQHpkxXA7oykTUc8qi/HgZ0cWQEKH/kgFb10
	51HMuB2oGUCpKrJW3uCo2r2FSzsb1tCmoU2ChDKcyNEnoI7cyiweYTpl2GGvr9PQ2ZXQpMuC3uy/s
	DuO0W3KOP0hbSfPqZtD4i5XN+9BWdQ6mJrAECmKxAHHimGkeMdz30AzbqHlyd7bzv7foLX3Uj9Npk
	wg1mxPzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIRPC-00000005uod-3bAV;
	Sun, 18 Oct 2026 13:58:30 +0000
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIRPA-00000005uno-0l6A
	for kexec@lists.infradead.org;
	Sun, 18 Oct 2026 13:58:29 +0000
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-7cc0892f92cso301111137.3
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792331906; x=1792936706; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ayMWfGshO3UNwVYFCcSN2BNh422miW8cad5xrtcnUvg=;
        b=c6rv7684ICo9IwdgamfwPWWjEIoKo0YgyZA3ZwxoW8KJ4zLN63q/r7IYL69GQgZIrV
         kqCpm6GVJRTSqA567feqDacziTvBr1bFjfIpUjKbt+YebrU4PHgD2RkAl4zgqvBZJS7m
         afupJFBRs/5/XkRWYiYmT/bqYhXSMYDHv45esNE+tt471Yx8JZK2KeyhxGy4g3QrSWHG
         fjCwEj2MLlRfniTXzUloWvSaaPOCLovMsNVR8wSuZoDP2/dSokZZ12ijNhuadbGKd2Sd
         IjYfzq7Fu4XdoVEhec5JlFZU8G2h7WhtcZCwm/yqTkaSysuucGg3L3M880BYZRsj6B5U
         EFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331906; x=1792936706;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ayMWfGshO3UNwVYFCcSN2BNh422miW8cad5xrtcnUvg=;
        b=boicPAbI98p5Kt4NCVZiY7jQaD634MIMvfTqzatYJVi5WdOHnL863wppimOHNrty/G
         zu4ECEm3TS4WhjGNhX6ktGtoFyHW/JC4SeA2U36yC2txvhy4DpTl9VmygyPWJZPbVDIa
         K6wis0Bp5Yd6FZGU+ChbESpDiUE4VhBLmYTCfpurvppO+VSCPJt/oNu9G+ry76pQk7C/
         69LiIsIfaVbz2fBX13IH+QQ5lTXiMPboK9Wkigotp97AYB85WCuWn5H7W1sdkMBuyWkv
         k10jccfJiSekJJOE5aBQCsZdotWOn1IGjneQ/uhBQo2k3vec1f/iTumhsYG0Dwiyqvm8
         EkBg==
X-Forwarded-Encrypted: i=1; AKwUvBx8VXATwM+0dkXyw6yn7QR7ISSGbKPRFPCrJGrJIOQ//12comISD1Vk790YGbSPi4DTx9jWGA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ+8FO3wQaI/hFOj5UnBudorwD+tJyew4/v02IFG/u+E/F/P9BA
	IskLaTRUEEnxKk5W285rFjPncwByTZhTPb5hCgOzlot67vpEoOAcWTF2B77N/g/GEJI=
X-Gm-Gg: AYBFou0v8RteSVQVj82tjD8WLzhkAofHZ8n49l60QPzrGsnyRhvShJA24TeJ0GKbX5s
	oNtMaMZE3FJfHR7wIX48X6JSqt1Ss/kBX3Zy8KWlR0w4j2ozGsnZm926qXMjoVtvsLrFjOQ8KLH
	NFjnBuwfiAfWBqFnEHsWy1nm1kAN81122c+bq/Qxh5rdLTetZsJTLH2I2P9rBakW0QSuhKTxRq+
	P8W7i03ZDHC+QJtFchKfY1FGI+6u4spyVUKx+n059wHDl66Y4fP93pmsObN9ijHeaejXTanAUU3
	CBBxpCY+aB+867LTiBUgMXb8xID2FM125M9Yg78Vn9FLr+E3w9OP2sMhy/v4MSwiRVyvpNPZGo7
	bfBI1LPXIdUk+JOCnRYFuEC2RHB6XoxswvzwgFqFaQvOnD7RtxnDM1XgBGeoMFNDBdL5PyVFxqu
	x5CrsWnrdvPLVP+Zewe+d34jPvHRuvO8IV95xPO7+vSgIixdgvrQlPQ+HIwZj80ZVT+0YMBRppI
	JzkXy0AJlhxn0lv4iK85t0F1bDbKFx7JAUQRfCF1JRCpuR5fZVQufstTAGBPCq6ysixbn8t518=
X-Received: by 2002:a05:6102:5809:b0:7a7:19aa:f0d4 with SMTP id ada2fe7eead31-7cc36af7150mr1191922137.33.1792331906038;
        Sun, 18 Oct 2026 06:58:26 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9908366328dsm6405154241.12.2026.10.18.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:58:25 -0700 (PDT)
Date: Sun, 18 Oct 2026 09:58:24 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kees@kernel.org,
	rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com,
	tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com,
	vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev,
	cgroups@vger.kernel.org, david@kernel.org, mingo@redhat.com,
	akpm@linux-foundation.org, linux-mm@kvack.org, seanjc@google.com,
	ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com,
	mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org,
	vbabka@kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, surenb@google.com, hpa@zytor.com,
	x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com,
	kexec@lists.infradead.org, pratyush@kernel.org,
	dave.hansen@linux.intel.com, rostedt@goodmis.org,
	gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de,
	graf@amazon.com, linux-edac@vger.kernel.org, liam@infradead.org,
	ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
Subject: Re: [PATCH v1 0/8] x86, sched, mm: Speed up CPU hotplug on large
 systems
Message-ID: <atTQgM72TWSFZ0AX@google.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <atFGxagFo50iG6IS@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atFGxagFo50iG6IS@agluck-desk3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_065828_249365_37E22301 
X-CRM114-Status: GOOD (  17.46  )
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

On 10-15 14:33, Luck, Tony wrote:
> On Thu, Oct 15, 2026 at 11:33:23AM -0400, Pasha Tatashin wrote:
> >    - Patch 3 bounds cmci_rediscover() on CPU teardown. Currently,
> >      cmci_rediscover() broadcasts an IPI via on_each_cpu() to all online
> >      CPUs, serializing them on cmci_discover_lock while reading up to 32
> >      MCA MSRs. Because any disabled MCA bank is shared at most with an
> >      SMT sibling, L2 cluster peer, or die/package peer, probing a single
> >      online topology peer via smp_call_function_single() (or returning
> >      immediately when no shared banks were orphaned) reduces 479-CPU
> >      offline time on Intel from 11.42 s to 9.63 s (-15.7%) and total time
> >      from 22.50 s to 20.74 s (-7.8%).
> 
> I took this series for a spin on a timy 2-socket Icelake (36 cores, 72
> threads per socket). My test was to just offfline/online the 72 logical
> CPUs on socket 1, and I saw some good speedups:
> 
> 	offline: 4.833s -> 3.17s
> 	online: 6.157s -> 3.796s
> 
> I noticed that your cmci_rediscover() improvements mean even better
> offline performance if you work from high to low CPU numbers as the
> shared banks are assigned to the lowest numbered CPU within the sharing
> topology domain. So working from high to low avoids creating as many
> orphan banks that then need to find new owners.
> 
> 	reverse order offline: 2.984s
> 
> I haven't looked into the code yet. But the general direction seems
> good.

Thank you for the data, and your point about the ordering is spot on. 
However, once single-thread performance is adequate, my end goal is to 
parallelize the operation so the number of CPUs won't significantly 
affect the total time it takes to remove them and add them back to the 
scheduler. This is crucial for the live update work, as transferring CPUs 
to Caretaker is part of the brownout, and in some configurations, the 
blackout of the live update process.

Pasha

> 
> -Tony

