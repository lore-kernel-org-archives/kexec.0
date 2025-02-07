Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87626C02194
	for <kexec@archiver.kernel.org>; Fri,  7 Feb 2025 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/B6rKXoRP9BkkuR2mn1tTK5oITIELKG2LYs8WqA/Z0=; b=ujCzqWPNkhZ6AuXXOx+3Ifu1rt
	pNtPG/zWkUp7YER3+2DdhXdXku64Gc64NHlfHRjPrD3+hHpcKoRY0dZFduE1xE13tqYx0iRVwmHdE
	pIph0ahZD57uror+KISPA36xpN10gQEMKvbY3+YtnxYzVCgiBR+DPc+pA34r6WozUisXFwjJa3jWP
	StdBJZ/3WqDS1FQkfbbMJeAPGfeZDsW4+0EBUn7z1GBM/ssgUk52Ohr1PXoPfpmopwMiDPQNwIK4Q
	cIsGkrcbhjL7asjvukShhkEZ5wU57a4AtoX/MA6wmjOvcCzN96xR2tXasrvICteSCuXDFwcfOazbL
	BpePx1uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgDCO-00000007xFJ-1TtB;
	Fri, 07 Feb 2025 01:30:28 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgDAy-00000007wwk-2dVa
	for kexec@lists.infradead.org;
	Fri, 07 Feb 2025 01:29:02 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-46788c32a69so20946471cf.2
        for <kexec@lists.infradead.org>; Thu, 06 Feb 2025 17:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1738891739; x=1739496539; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/B6rKXoRP9BkkuR2mn1tTK5oITIELKG2LYs8WqA/Z0=;
        b=CLOZLCvdtEvWZ4hJXVffHN7qAfsCKg1FPRFFEkYFCPDG2dVY6YYp7nGXPRrMH/9EVT
         0dSM6fLZGjfH5h6qzxWT2NN7hgH29hrLCIBw6IGQN+R6jxXQiDnkvmt/wrEaAqmXk4My
         aJ7BstcSIUOFgFodoPVpukpc7arA4OB1ZBSnVNUcLaYV79mdEEOtuPDgkA4ayVU8HCbF
         eRIP3QUZAOQejlWtb++8CL251MgW5KkITBkogFZM186TZ0ksshI9qLdn0FwPfvnyZGxw
         YXmX5i9Ro10i4+brevB1q/YUYPBJCe+iLtSwFtC14QBt4l6YC4yxksQlUdzpy1SDfGul
         mbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738891739; x=1739496539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/B6rKXoRP9BkkuR2mn1tTK5oITIELKG2LYs8WqA/Z0=;
        b=gE1tPbhZuf4dwHo3BImOQ2N1m6Rr0EeX/J44dyKzEZ3bj9d3mtki3Vx+1wCda5xPFx
         M9YKsFUAPIZykR/TgZ9PVXuZJ1pdkfEa+FH+wOTQ6yYsvUptIbgEm6PpsYQbFBcTgLyo
         QnhUkJU/tBqB+20BmQAXG0su/lObabvUd4KMczZ2WdKYgFE7kr+ac8ue6K9JVpKfAd5I
         VyUeWVEF2XY+t2yat12lB6dqqOpZG9ZGDlz0gloVbUHGohYY508tU5GPOpLWWohcxrI2
         1+alSFuR2lUuzZPcEigSpBeSGcbIWOXINsKUIJI0nqL7Lty+xmYhhE7PeVyn9BLFqw84
         C4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWLlRtmvYyXHv/sdExW7LEB5GPjlhiBjw7qMD3QnV/eVwryY3LRcaI+eydtK4khgwu9YJ4G8Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxzZ8BgrqMzAhmRAm4gKyEbac2DP7Xia4Qnul9gKJWOnEnP3wMF
	9NV/t9mh3xnCPlC1LPZRzvRgP9Unx4hLtOw5kiVfHcPbzft6M/xHQudw2LyuU7jiAS74xNp317q
	xEpXXbBOykHqR+2hJkeAEHL1n9f0yER5WxWA7VA==
X-Gm-Gg: ASbGncs7i8u7UsytRxqH0JEou5c8UQNUUXimgFSvylpXvjAoMzyy2bI8L8SbRxqicvk
	fMXbE5wYE7QXUb1AitVmaPkqiY1I+Zh/QHVQCOabK7WDmv7RqkSveRHjfqqkOl9JRPC71xQ==
X-Google-Smtp-Source: AGHT+IG/qU+DQGRbIVpasPJX4dEgRbGI1bwsgyRQgH7sLyexv6ztYzz7dd87jk6gdrjtGjTpHMmepc+RecJuVSIbOWM=
X-Received: by 2002:a05:622a:30f:b0:46e:24b1:dcd1 with SMTP id
 d75a77b69052e-47167ae2a56mr22008491cf.32.1738891738868; Thu, 06 Feb 2025
 17:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org> <20250206162939.a1f86fb835f1eeb7ed73ff1c@linux-foundation.org>
In-Reply-To: <20250206162939.a1f86fb835f1eeb7ed73ff1c@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 6 Feb 2025 20:28:21 -0500
X-Gm-Features: AWEUYZl6iTKJpq_CKya0Z3uq2I-kaX8PhW2bxqIFxSemVzQfHVc82dvbk7pP-8Y
Message-ID: <CA+CK2bD6204AKWGOgzLMiMsnVZ=tk+DGc+VWgi3RVt2byaLJJA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	Alexander Graf <graf@amazon.com>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	changyuanl@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_172900_859307_29FC8E08 
X-CRM114-Status: GOOD (  19.61  )
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

On Thu, Feb 6, 2025 at 7:29=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu,  6 Feb 2025 15:27:40 +0200 Mike Rapoport <rppt@kernel.org> wrote:
>
> > This a next version of Alex's "kexec: Allow preservation of ftrace buff=
ers"
> > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.co=
m),
> > just to make things simpler instead of ftrace we decided to preserve
> > "reserve_mem" regions.
> >
> > The patches are also available in git:
> > https://git.kernel.org/rppt/h/kho/v4
> >
> >
> > Kexec today considers itself purely a boot loader: When we enter the ne=
w
> > kernel, any state the previous kernel left behind is irrelevant and the
> > new kernel reinitializes the system.
>
> I tossed this into mm.git for some testing and exposure.
>
> What merge path are you anticipating?
>
> Review activity seems pretty thin thus far?

KHO is going to be discussed at the upcoming lsfmm, we are also
planning to send v5 of this patch series (discussed with Mike
Rapoport) in a couple of weeks. It will include enhancements needed
for the hypervisor live update scenario:

1. Allow nodes to be added to the KHO tree at any time
2. Remove "activate" (I will also send a live update framework that
provides the activate functionality).
3. Allow serialization during shutdown.
4. Decouple KHO from kexec_file_load(), as kexec_file_load() should
not be used during live update blackout time.
5. Enable multithreaded serialization by using hash-table as an
intermediate step before conversion to FDT.

Pasha

