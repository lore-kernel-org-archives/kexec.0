Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD90606A31C
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DrZHYF++;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=jhLTeOdK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NrIoMTeuQSSKquJ/B8Dkq51X5h3zUX1txK3GWbjAlR8=; b=DrZHYF++bipSlb1OxE2l5wYL6N
	GnFLXMYWqFAewCSBIF1X0VHlzRphNxGRxt7Aw5fRYblu1jSv+5sVplxewpb1Xr4189NBkmp5lm5bQ
	OX7eqM3w1QovdDgzms2L9Qs9SaHzn1PXd7PLrg+0HdrD46BMIKUUcfQ4/rVltJ+HvNykiEU0+JsJ7
	fGZxHgmbZPEB5yj4k/wxcoQaglmgw7fIV8erGUdXEWRBlwIK9FT5xZT2DRJK4kCCa9y/TynPdftyI
	SHCYjGlhqaBQDM/QN/Lpg3rFdZWwuj/0RsZvnYNtlb1uswdMGpA1MQnVaqnjPzLF2ysU7auZuMXUA
	mbPtlQpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEdZ-00000000ZkW-32oI;
	Sat, 28 Nov 2026 09:22:29 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEd6-00000000ZcB-3jLX
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 09:22:07 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-8b531cd9bbaso78302507b3.2
        for <kexec@lists.infradead.org>; Sat, 28 Nov 2026 01:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795857720; x=1796462520; darn=lists.infradead.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NrIoMTeuQSSKquJ/B8Dkq51X5h3zUX1txK3GWbjAlR8=;
        b=jhLTeOdKNQUDqOO2qIl0RaSk9mQgKR4JMzjomVdlEqADSHqZ5o/dH8qHru/pkUQjWm
         3uiDQhxArmBwZmOMuaQVJNO8yISE6ET5Xm0KGbWdrKkrxKryN+MhEAmh44LQ3zhl5Xdp
         jmiBD3Au3nQumRJ7PIcu8jEjrZuuNyDuQhqoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795857720; x=1796462520;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrIoMTeuQSSKquJ/B8Dkq51X5h3zUX1txK3GWbjAlR8=;
        b=S2n6pVx0S3vQ0sAlsAOG/IBqKtMAWQQtYxeqDianaXYUDeBaWxcLf1Oid4CwwYxDo7
         rS1N/7y9OYU/hOeXGtCG5h5gmNK+R+13+jQFLz/Z7qE9TMUQvKkUVc9AoV62gXV8P4ar
         Pzi/Rai6akSns6VaXyNgLni9YK/lc+tgH9UnyV5fVo68jiJ+XaQtJCrKxhfcqjLRGUEA
         6D8zCfJwXqH1tmIEmIEG+AdhKI695u2vDxYc/NPQT5Vm3sQwseV23AO6sZnIQLjmcsW6
         kYIPI6zFRcXbiIucqMhQB9J5IDdxpS81evm49aKyrECQliKhxGlsZtQxBRLSE7imv7Xh
         kqBQ==
X-Forwarded-Encrypted: i=1; AL+hErGjgOHsj+jp7rVvRtTQFpxfAt4g4jom4uFIM0be88ND5XaLhNJFuu/MPwaqTdeNKrzS0BlRmA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/bLGGBAWb3sRqqkNX92fiCfmiWGcEnXZo25Z3K6qyWuapT9fWA
	tx54/ToOQ69RkCktleVm0Bd4pC/SMfiuJQ4LvTqsbHaUqth+hO2o1++L7DHGZH0hUG0=
X-Gm-Gg: AZFdTZfCMcl+haBx8ajsBVe5GuRhHlu/VFVv7rRfE0t2OEJp1gTb10XzNJa+ryhL1KW
	66X5UR34W5kUTUhKN28BxEscQSRYI8GKBqISo3xPSJJ7WPQ8Z5Jhj0GYrg+dJkN1mz0S8Q+xX9c
	Q3BxxM8e9Ayqokxezu4MpbJM2eWqF56cJuOFuN/cHaIOsQ/tQNYtpJztb62AqQbipk8OqA6OtHd
	l8tkhKRFd/qmm/Dkx2T1h5qQOkvGUjrnKJO8HD+gzEG//QVPVvgNXWluBt1omS0zO0HNuwWiFa7
	Q4h9jBnl2eQ3SBWD7upr9FoS4Mo5KaaxCNBeqqfvmCuB2XDNM2+IaVMLDJdI1zNr1vyfMNxOuL6
	Ssg+G9xK3yocT+BgtjzARIi8hFihc0Md96zyHQ0rWe7oVlNH+9uSIf8EFk2t424GGL7zbvxI2wr
	NW0wHkmnGp4Wtb+2I40sxV47yLt/FroqHrxpJgqzsAaQ8x9jVP6JYoLYZzIydEHjtJ1ZTsblQlo
	ZwbBo3ZEjjf3mZ1hnxptzXDl1o9yG3TjrcRtGgRJggj/z0yXK6UkAaBXK2sABTNnxBqeTkU9f+6
	ayqrHrNvg2gEmwq1F64SWUlG8dMZUkkcfzpnbVqOF6G3Tue/lr/5nlqrJuUg6SWuhuB7fnz9F19
	TDlrC4MS4aSULZrMOlCZE4EK+c69qjmgEcmG0XLmAlBvFD20KNmAPvHz37u2kEbl2QbgZMh4HrQ
	c/rCPBYUrg+zsMtZhTUd5VYE8QoiE/K/h62xkw33ylYahjboj4F3OoY05jUGAjOba7UoLZoVREd
	SZMKNKD7/9wZy6bxwET4sKg
X-Received: by 2002:a05:690c:29a:b0:8b3:361f:5d77 with SMTP id 00721157ae682-8b5204a9ea2mr142715807b3.26.1795857719761;
        Sat, 28 Nov 2026 01:21:59 -0800 (PST)
Received: from [172.20.0.3] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202fb08csm102460237b3.24.2026.11.28.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 01:21:58 -0800 (PST)
Date: Sat, 28 Nov 2026 01:21:55 -0800
From: Chris Down <chris@chrisdown.name>
To: Mike Rapoport <rppt@kernel.org>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] kho: Don't release incoming bootmem areas when kho_init()
	fails
In-Reply-To: <avGb2Trm-C3_YC-7@kernel.org>
References: <au_vQhHAcJbkryXN@chrisdown.name> <avGb2Trm-C3_YC-7@kernel.org>
Message-ID: <awqdM6WBmcGak0UV@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261128_012201_104009_E1F8D916 
X-CRM114-Status: GOOD (  13.08  )
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike,

Mike Rapoport writes:
>On Sat, Nov 07, 2026 at 07:40:50PM -0800, Chris Down wrote:
>> kho_populate() adds the incoming bootmem areas without reserving
>> them. memblock_free_all() then hands the remainder to the buddy
>> allocator.
>
>This paragraph is confusing.
>It reads like kho_populate() should have reserved bootmem areas, but it
>didn't.

Yeah, I can see how it reads that way. v2 will say who reserves the
areas on each kind of boot instead.

>> Unfortunately however, if kho_init() fails, err_free_bootmem
>> currently frees every area with free_reserved_area(). This can free
>> pages still backing early allocations or free buddy pages a second
>> time.
>
>Is this an issue you hit in practice or it was reported by a code analysis?

Just from reading the code, same as the reservation failure one.

Actually, I did find an amusingly simple way to trigger it to
demonstrate :-) With CONFIG_KEXEC_HANDOVER_DEBUGFS=y, kho_init() fails
when debugfs is disabled, so a KHO kexec into a kernel with debugfs=off
added to its command line is enough. From a quick check I did, the new
kernel then crashes in free_pcppages_bulk() under free_reserved_area()
and never gets to userspace. I'll add the trace to the v2 changelog.

kho_init() shouldn't really fail just because debugfs is off, so let me
fix that in v2 as well.

>> +	if (!fdt) {
>
>I think using !is_kho_boot() makes this clearer.

Agreed, will do in v2.

Once the reservation failure v2 lets kho_mem_retrieve() fail and drop
the handover, is_kho_boot() will be false even though the bootmem was
inherited, so both this and the bootmem setup above it will have to
check for that instead. I'll change both in that series.

Thanks!

Chris

