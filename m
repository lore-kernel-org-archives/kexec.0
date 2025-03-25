Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3208AC36010
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HQ1y6K6+ej3yRZwY8vjRGO04KNMR+SXa0FKK7FdZ1GE=; b=jBCbZVZqT0bAyMJ4+uJnLM5bcp
	S54OUt9ibPm7vEZ6eekZgApDNcwmyKLcQRM5IRdObeXRT4Tr3m4At4W3nHd2ueGn82eNs43BvJEwb
	wAyyOSFcf+mUIDe3mlat+FB8OKXLGETu3AN7yMPD3Pc8EZPxpjgOieBN7McZu5BNAPOrk2FiASKcK
	jp5s2YrT8pYOFsQ7Nc/diRs2WDLRWFCOXA23z+KAUC4EP/k8fYeabzLW69IonOVwE2uNXgIph0Hnn
	eijhqdYuZzDzKGnVggXodVlZ2zEnnZBB2iBQkmAu9Va5xk577u7h7yEWNot4YSqL3JMC8l1c5x7wt
	cYoohhSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTx-0000000B6A7-3FV1;
	Thu, 27 Mar 2025 13:41:17 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txCGg-000000077M1-1yt1
	for kexec@lists.infradead.org;
	Tue, 25 Mar 2025 21:57:07 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-47666573242so158851cf.0
        for <kexec@lists.infradead.org>; Tue, 25 Mar 2025 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742939825; x=1743544625; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ1y6K6+ej3yRZwY8vjRGO04KNMR+SXa0FKK7FdZ1GE=;
        b=nfQx748wXdkOcT7lFXW1HND8lg3NyNr1x+qXFkdyLaKIiFzpXMpn1J7QlRLV9kjasd
         uGlMV7cbf98wflACzm1cjJY+hpgI8g0x0KJMzhXjt4a1XWI06SGKDvuYPOaN7rIE2djU
         VSW0pgEkw7GMcafItE0Ul0/+XDFSDh9beANVVigeaMm2/LumzkaVc4QPjSWZOeM9JeNH
         Xpf8dLEh+juJ81uPkQNLEeWj7qHBfkZHZIC0VVm8QmzKrJFjmWWAfcwGE1Q1q4glxEyx
         v7DC/0CQ2D/Q38NWWdUaU0NkX4I8EdoFviLrCpopl1NPRaARz7qslR6yxwRBlMdookzV
         6RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742939825; x=1743544625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQ1y6K6+ej3yRZwY8vjRGO04KNMR+SXa0FKK7FdZ1GE=;
        b=Xu82lMxXjoRumlgrLdSRr8JUtX/ggKS3EGx2GHww8WY9ZAkqwf1DchWIPOKhJQjEhq
         ZAq7AtcX/dlPuP6pUWwrbGUhWIMnu/ult1yhiW8Q0Zk4iO/zK8BW81wVYT6StdJVqxoy
         16s3Sd+t5EO9lB6OICrn93FBPiPqiQ4Y0VkfythPCgHQX8vSUsAhMEJ9990+ui5SMRwr
         AaWO1HChraoYmo9x6OCJZqfZ1m21R4+8rjk288PQScDi0Tiky7Gr9jWhxoje+MaE4g3q
         89+ZDVnFrDSnp/b7tzzYCHbvqTS020TYBLhpL1Ffjyxp6j8Z23JsnZueFuTDmZUchTPT
         mpAA==
X-Forwarded-Encrypted: i=1; AJvYcCVrlshJcFkSoxvP2R5GsSapcb3emZzsrgsUCME9klksX95T2xrFHaAErf8bevC9WD7JCRqtdQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxvpT8FaYMoW/nKlLMlakoXluvLU9Hz2lS3TSuf8X/qBT+5u6O6
	2sLFEkANo029qL9ucCMiI8JpXjudjenptvH7jBA95CSOdDXQxJLoOCJkvEL4XwokUIr2wUsPWse
	lo2Q2EmcwhU966GG7Q539C7bzOGpPpVbbM056
X-Gm-Gg: ASbGnctvY0UTP/Pdi06gzqqCyFfd1ZFD3CkecKMZWfozFACvzBkuUR65goHYnfjZbDh
	mSlNntaGi575CbQvIq6YcABw6oZ3rW1D80Bj/jUo3vBzIp3RuHFvSxmH6jGhPLcmdYvo9rB14XT
	FNGgs6emeOGK6u3JgVesOw/E0=
X-Google-Smtp-Source: AGHT+IH/hOP5cz4/f0sHk0CeJX9EkyXr4jUNyz2/3phYBrvYUFI/aeZIqxahOHueL/ItRZ16YGhpvWcqwmSbOB39SDQ=
X-Received: by 2002:ac8:6f05:0:b0:472:61:652 with SMTP id d75a77b69052e-47762e3319amr159031cf.28.1742939824283;
 Tue, 25 Mar 2025 14:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-8-changyuanl@google.com> <CAPTztWbFXajArSN8yKu32eSoR=xsk1CHM_4V7MJ0eQxydFqPUQ@mail.gmail.com>
 <Z-MB0Cj4tM6QgOAg@kernel.org>
In-Reply-To: <Z-MB0Cj4tM6QgOAg@kernel.org>
From: Frank van der Linden <fvdl@google.com>
Date: Tue, 25 Mar 2025 14:56:52 -0700
X-Gm-Features: AQ5f1JoGOY12Onu4tBrwgKWOKiM9GvbU7kfWg3JcOKhqducXkStWehGksThe0mY
Message-ID: <CAPTztWbDtDhKZS89-aEBaZoPW2jZM2CAWW1Y_m3OnNE26=d9UQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/16] kexec: add Kexec HandOver (KHO) generation helpers
To: Mike Rapoport <rppt@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org, graf@amazon.com, 
	akpm@linux-foundation.org, luto@kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_145706_506551_39F09AE1 
X-CRM114-Status: GOOD (  27.21  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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

On Tue, Mar 25, 2025 at 12:19=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> On Mon, Mar 24, 2025 at 11:40:43AM -0700, Frank van der Linden wrote:
[...]
> > Thanks for the work on this.
> >
> > Obviously it needs to happen while memblock is still active - but why
> > as close as possible to buddy initialization?
>
> One reason is to have all memblock allocations done to autoscale the
> scratch area. Another reason is to keep memblock structures small as long
> as possible as memblock_reserve()ing the preserved memory would quite
> inflate them.
>
> And it's overall simpler if memblock only allocates from scratch rather
> than doing some of early allocations from scratch and some elsewhere and
> still making sure they avoid the preserved ranges.

Ah, thanks, I see the argument for the scratch area sizing.

>
> > Ordering is always a sticky issue when it comes to doing things during
> > boot, of course. In this case, I can see scenarios where code that
> > runs a little earlier may want to use some preserved memory. The
>
> Can you elaborate about such scenarios?

There has, for example, been some talk about making hugetlbfs
persistent. You could have hugetlb_cma active. The hugetlb CMA areas
are set up quite early, quite some time before KHO restores memory. So
that would have to be changed somehow if the location of the KHO init
call would remain as close as possible to buddy init as possible. I
suspect there may be other uses.

Although I suppose you could just look up the addresses and then
reserve them yourself, you would just need the KHO FDT to be
initialized. And you'd need to avoid the KHO bitmap deserialize trying
to redo the ranges you've already done.

>
> > current requirement in the patch set seems to be "after sparse/page
> > init", but I'm not sure why it needs to be as close as possibly to
> > buddy init.
>
> Why would you say that sparse/page init would be a requirement here?

At least in its current form, the KHO code expects vmemmap to be
initialized, as it does its restore base on page structures, as
deserialize_bitmap expects them. I think the use of the page->private
field was discussed in a separate thread, I think. If that is done
differently, it wouldn't rely on vmemmap being initialized.

A few more things I've noticed (not sure if these were discussed before):

* Should KHO depend on CONFIG_DEFERRED_STRUCT_PAGE_INIT? Essentially,
marking memblock ranges as NOINIT doesn't work without
DEFERRED_STRUCT_PAGE_INIT. Although, if the page->private use
disappears, this wouldn't be an issue anymore.
* As a future extension, it could be nice to store vmemmap init
information in the KHO FDT. Then you can use that to init ranges in an
optimized way (HVO hugetlb or DAX-style persisted ranges) straight
away.

- Frank




> > - Frank
>
> --
> Sincerely yours,
> Mike.

