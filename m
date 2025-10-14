Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5BDCCD18E
	for <kexec@archiver.kernel.org>; Tue, 14 Oct 2025 08:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AKUCHW/MBIZsUc3ODKKtWIaDlEQsfe7hY3IvRmB8i8o=; b=KjVJZcPrv9c1SVTlzVFZx5/Tr0
	ERsWNFankWxppYfw/TXDxck1Pls5kS6xUNHOcp99E1a/oleI8568t40pKRtZlGVzkWgi1hxj+URkW
	74/BsSytxbyBv//u0s7gO4wrTEMDeoYgGltFt0N2sYJcIp+i4nL2a+stihsIof5ztiTwTXKESfGFO
	QdmJSRkEkIB/P9VOzD8bAlqFqxBPRFIkIgGLMSte3GBZagAXoVe4GgQ+gEdqqGMnAxkWPthJSARGj
	f2bB4NcOXSbSTnPnGGO0fyU5ZeOfHhh1ZunHVM9HLEFUhHUYmDMouxINNoxFFPeYstUBEqOm1cmcR
	IccfadlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8aU4-0000000Fcqt-0chQ;
	Tue, 14 Oct 2025 08:34:16 +0000
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8aU1-0000000FcpJ-0OZz
	for kexec@lists.infradead.org;
	Tue, 14 Oct 2025 08:34:14 +0000
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso10042520a12.1
        for <kexec@lists.infradead.org>; Tue, 14 Oct 2025 01:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430851; x=1761035651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKUCHW/MBIZsUc3ODKKtWIaDlEQsfe7hY3IvRmB8i8o=;
        b=nV52RgC956UbQUW0sQLkbO39rj4qyT6Bi4HCaCFxxU77CXECi5Z8cPCAcCvHb+kTAj
         rMnm2ThUqfyz/w3o1N65NCvLke+Rs4yl6gSVgbjdU/HxP7ih7K+446UQPiNwMwwRXVAh
         P8U3CPV86yhsoaOb5xL+I7hm6U/OaNWeZxZGNASSESmVi/w1GfrKAtiiedE++gq11gCY
         wQ3eq5Vzn9X/czBgeHfxlbtv/KUjaLRaXEN8D7EGYkGq/ntoR4bWFnnhG5wMO2ajSS4q
         nSHd8NgGbTIYp2gAkIJgNEYmSrrbD+y7E2HEX0vNF28jixycD77Ug+9hDWCTKjhwAZWk
         7HDw==
X-Forwarded-Encrypted: i=1; AJvYcCU8CzG0yiMk3rxydVHdkz2v2JCAId/5IL8gMb0S0GHWDeMuvBGQkQnj/hLmWH2mjav07QyvIw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzBQ0TtgN4wPIa8ktwvkBBbpoltNG8o6rFV8E1UAZxnK2AarHLc
	XUQvPwsC6CMyKFFc7oyoKjg8TEcSJIht1S9xw1gBZqzLaJ805M59k8F+
X-Gm-Gg: ASbGncuOqIMmkc+9bnww+d/WjvFu2Pzj9KwydB2u/rUCBu4Hes2GooS0HKWx+VMutuk
	Obe9ET7FOAgyWgJabC/AOLbxKNZnbsMweMrx69GklW3FuPN7Wn7cAZz5vUqG+/djWsvyuyjcnW0
	bJiLNQS45UEEFd27JNDNfmxBkW9MqtGKvSPS9tMgqXjHdEvfSM+CKJQQThd7SOArsnk/7lsGxP6
	7MJdAIutXCOxUChix2hzAJu6yU2jdZPgxnOa/RNCeljha26ydym4BGMqnjoKkUl+nDsg7dzU60V
	RJWiteNi91nil/A/4muPGT9rMiRg4cINT4zzDJ68ENb2RcP4x+zqErgAC2sUKZRwaN9ePPE7+UI
	ccpUbxWp3aFoVdbvwqZeTXBMyVy0uXUE+pu0/
X-Google-Smtp-Source: AGHT+IH9yDBhkiPY34+r8L4QfGlETNuwKEKExxU3npIvUrJ6TVQTuSdRSJEPMfeufN3cm41sP9BTrQ==
X-Received: by 2002:a05:6402:50c6:b0:632:930c:ed60 with SMTP id 4fb4d7f45d1cf-639d5c57a9cmr20902180a12.30.1760430850785;
        Tue, 14 Oct 2025 01:34:10 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c322e91sm10304155a12.45.2025.10.14.01.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:34:10 -0700 (PDT)
Date: Tue, 14 Oct 2025 01:34:07 -0700
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, rppt@kernel.org, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, 
	hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com, 
	peterz@infradead.org, robh@kernel.org, rostedt@goodmis.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, 
	x86@kernel.org
Subject: Re: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <2ege2jfbevtunhxsnutbzde7cqwgu5qbj4bbuw2umw7ke7ogcn@5wtskk4exzsi>
References: <20250509074635.3187114-1-changyuanl@google.com>
 <20250509074635.3187114-2-changyuanl@google.com>
 <ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
 <mafs0wm4yluej.fsf@kernel.org>
 <mafs0h5w2lpqu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0h5w2lpqu.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_013413_169419_9051A32E 
X-CRM114-Status: GOOD (  21.63  )
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

Hello Pratyush,

On Mon, Oct 13, 2025 at 06:40:09PM +0200, Pratyush Yadav wrote:
> On Mon, Oct 13 2025, Pratyush Yadav wrote:
> >
> > I suppose this would be useful. I think enabling memblock debug prints
> > would also be helpful (using the "memblock=debug" commandline parameter)
> > if it doesn't impact your production environment too much.
> 
> Actually, I think "memblock=debug" is going to be the more useful thing
> since it would also show what function allocated the overlapping range
> and the flags it was allocated with.
> 
> On my qemu VM with KVM, this results in around 70 prints from memblock.
> So it adds a bit of extra prints but nothing that should be too
> disrupting I think. Plus, only at boot so the worst thing you get is
> slightly slower boot times.

Unfortunately this issue is happening on production systems, and I don't
have an easy way to reproduce it _yet_.

At the same time, "memblock=debug" has two problems:

 1) It slows the boot time as you suggested. Boot time at large
    environments is SUPER critical and time sensitive. It is a bit
    weird, but it is common for machines in production to kexec
    _thousands_ of times, and kexecing is considered downtime.

    This would be useful if I find some hosts getting this issue, and
    then I can easily enable the extra information to collect what
    I need, but, this didn't pan out because the hosts I got
    `memblock=debug` didn't collaborate.

 2) "memblock=debug" is verbose for all cases, which also not necessary
    the desired behaviour. I am more interested in only being verbose
    when there is a known problem.

That said, my suggestion is to only dump extra information when something goes
wrong, not affecting the boot time neither boot verbosity.

