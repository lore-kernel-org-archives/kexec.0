Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7748FE668B1
	for <kexec@archiver.kernel.org>; Sat, 20 Dec 2025 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NirtzK3cSKP6Dn8RC3SUqGY+8QtbdDa8PCdCAnfz/Ds=; b=RGKox/o62Pe5cyiV9NpIB7SBMW
	IIi5dVkCcxKNN4s9NX1mfWKDIQ9kDq6bojDlmWeETga7J2g8H+Ck6yl8gysXtoxVzFXiSF4HyFsQa
	gtBbhoC9lYc7JPkPIRe45vOSY3ecUrwn0Q3qrdHNxrjPGvTW8HII6m1DfwCFQnKqangsqyOs8vyz4
	OxHr7UQBuEFAhAzZ7zRXTE5Z3l1vwbVag5ZZXa2yoFLkcLnBzWADQMJCovGL+ENj6d/rWwCfWLD9e
	zvb5LI97NoB2LJkOeftgPlnW/yc4u/VC0ChAxuwAnelMr7lMpy7pRZ46hIiklA1J4Ond1RvQtElNN
	giDs2cVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWycx-0000000BgJI-1sqd;
	Sat, 20 Dec 2025 15:12:15 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWycu-0000000BgIi-22av
	for kexec@lists.infradead.org;
	Sat, 20 Dec 2025 15:12:13 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so3561545a12.0
        for <kexec@lists.infradead.org>; Sat, 20 Dec 2025 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766243530; x=1766848330; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NirtzK3cSKP6Dn8RC3SUqGY+8QtbdDa8PCdCAnfz/Ds=;
        b=CJE2dmwZmSYH/nTFEM8kV+AbqoNv2IVA8hymEF3nlOI+S8eCHppov2eFpN4xvoOs96
         rXRvnaudAOpYJVl0DgxSu+GPRID5odztB36M12nYPqpU3hI0aZ2He8M6HAVH4b/V9PDv
         rKnIadZINtPHjqq+CmXisSrQDOW1Sf/qLumuZ9BEhbj6712VWG/lERc46hEPxKUtZbiW
         4MG2idOhDUEHOBprxnbzVisG2FlDMqQCPCXK9A6VVJCGFoWv/3uQizXU6cFm+0hl1g55
         ZXjLO2zlRQfJvAH+ECXQ/8OI8thBB6Mtd81U+iRN3lfg84oXaBPDX6zbpFqvtntjb7sM
         0r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766243530; x=1766848330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NirtzK3cSKP6Dn8RC3SUqGY+8QtbdDa8PCdCAnfz/Ds=;
        b=A3OnVu40/9HzbhbdxPSTk9I7qVE42lW0N83LHmF/s8DbCI7+1rF9fjOntZUihR5/F9
         8bSqltIAcLfceG1gevNs/38stA4NYCkmyZKeJMNBpzn9xTUrKF/QLbXpa3jumynrVbW5
         R13JctK143Gxw5j4MwX7gtQK8IcRsrnZmLlRY23mCjDWD4YLbgvTd9p5NVT7gh7heWLB
         vJ2aC2/AB4dCFdk6DhMi6yARSW9Z+QgYbZW8Cx8U9a5SBvxHMTAs93VddGwBSsiyL/+S
         YVuV+dzKncTtd74MwR2qYpvy+BQREkaN/ArhUYJU2/ZD8qmIaSgj+PqadgZ9I2fMFeip
         wHXw==
X-Forwarded-Encrypted: i=1; AJvYcCURvr6y51nojoxaBR2UMJgvwXPEKGVw1d4koOGTqLyp2zYfqhF0VmYnCdEXrCYBrfCbUSekfg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy52fX4rRzr9bp85Mv+TRxlqk67z5QQ6qYYtaGe02gWmGEpUtdL
	fsM2aVQ22gm30SB4/F5W6d+FfkKkDsPO5+hjnuO51Ylju2pElklqyquerWxIyFif5/olu4zXC/f
	zqKJKx4uNb8IP1n8YLCT6Leqc0l47tU4F1YM//a9TOA==
X-Gm-Gg: AY/fxX4xeYhDHaDlUhV3jwLkwo1GfSZRleJE59fHn80oGOyEjzGMxYl9X8wwld1apr5
	TqmJ7n4pN78OwC4IfuV1DakPWl3YUzYA4H9Pahez9rjLxgPG++iL8YAaJLSBZ6TW7Ijt0kNZTrM
	HT/e2T0MtuOAdQ17D9KOI0pGhTKZmvUKJ5f0FflaEInx6AqpmY5pWQD4w2+9ZqC8R/krtUNHwc9
	GS1y2JY4EI2C4wRPKE6dOTvJJzHPMyY76d3ucOXt2HjaoFhhvWUTTSZD0toIZCiqyHpciMP3mWJ
	qL3aqIch3ilFvuWkuphRdjFSWIxINJVX6ODGTOFPMaDIHm1I4m2Hmn7Ghywtxw==
X-Google-Smtp-Source: AGHT+IG2H0JMzpZ4Rw9d+GSeTdHtlvEwfcgulZM7WmjLKT/BwHOEpNubFax4Xm7riytdiegSHPUBkYePz2N2H5EqPpE=
X-Received: by 2002:a05:6402:34c5:b0:649:230e:ec52 with SMTP id
 4fb4d7f45d1cf-64b8e935a65mr4687631a12.1.1766243530490; Sat, 20 Dec 2025
 07:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20251206230222.853493-1-pratyush@kernel.org> <20251206230222.853493-5-pratyush@kernel.org>
 <CA+CK2bAV1y_LySjyj-wcn1cdSuVBdC+r+zQL7AQTY64nk3OxuQ@mail.gmail.com> <86wm2hj0ky.fsf@kernel.org>
In-Reply-To: <86wm2hj0ky.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 20 Dec 2025 10:11:34 -0500
X-Gm-Features: AQt7F2rkD8DzKJtnBrRBVjSiNOllvUXl1o05w5fOraa6mNPG1z2m3wrrR9PJQmQ
Message-ID: <CA+CK2bDWF6pbNQRkJFa+WcD1pwUOr3yQdrRUs-mgLWu5ght+7A@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] liveupdate: flb: allow getting FLB data in
 early boot
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251220_071212_549268_82DD57F9 
X-CRM114-Status: GOOD (  20.55  )
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

> > [Follow-up from LPC discussion]
> >
> > This patch is not needed, you can use liveupdate_flb_get_incoming()
> > directly in early boot. The main concern is that we take mutex in that
> > function, but that I think is safe. The might_sleep() has the proper
> > handling to be called early in boot, it has "system_state ==
> > SYSTEM_BOOTING" check to silence warning during boot.
>
> Right. I will give it a try. For hugetlb, this works fine since it
> doesn't really need to do much in FLB retrieve anyway, it just needs to
> parse some data structures.
>
> If other subsystems end up needing a two-part retrieve, one in early
> boot and one later, then I think it would be a good idea to model that
> properly instead of leaving it up to the subsystem to manage it.
>
> Anyway, that isn't a real problem today so let's look at it when it does
> show up.

FLB has exactly one .retrieve() lifecycle event. Once called, the data
is considered fully available and cached in private->incoming.obj.

If a subsystem has a requirement where it needs a specific state
available very early and other state available much later, the clean
solution is simply to register two separate FLBs.

Pasha

