Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9F8CD98D2
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LrNLo7Ew0vkv5/2r20/RtbigqwQYa7RBbYfUHsMbkTE=; b=M6LdUFDhZvhXntgGGbGt45GxeR
	PGDO1au+3ip9XsWE1ZKBj7L26C5boiMgqSpb9K4CicD4WQ+Qo1mU0ZlSS4qckoyVscS6I/5cf+lcD
	fNXj6ZbcgfalLfXzNGC/LfhJdytDBTsxp5pMVw131Aqgw7mgUAm0WOIKUwsM9AOkH9hf1v7KBjwyc
	VWtMVEBu17FhHiVLJXiiMmEPjrPevXT78Esrxcv62FGKYsP9KpIAuwBo5GWYPRFgukAsAdKrRxB38
	GryOY6byZWn7RtveRApllplfS8kehdTcFmQY+eKZosINSNk3498VysfHv7/y8qxtCZHdFd4LCLrIo
	EylQ8NSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY6mD-0000000BPlv-0ODZ;
	Fri, 12 Jun 2026 18:38:45 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY6mA-0000000BPla-0AgP
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 18:38:43 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8ccf6a63a45so16650786d6.3
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 11:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781289520; x=1781894320; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LrNLo7Ew0vkv5/2r20/RtbigqwQYa7RBbYfUHsMbkTE=;
        b=KBQfJzGbbO4VDYh+ND++0+M4leu1lj2RlZOY0sRCFx+RMfQs/GZpvFUU+X22JMwY0O
         dEorCtavsLk8Kew46tKWyJERu7uUm5g+GzIEJs/Lyeya8TmFWrgzfJKr1Pl83BIVc9mc
         Fun0my4w3cQhlyo8aYv43vPNF9zwOsRYbfLHILmfw+EkT5uIW1mhWMRXflt90wN7gV7t
         tfPm/M8jj5GTwyLsE+wBH1SdKEBHhWBEWnW6ZmwNNDEnw0eY3JNK5pIN64Rs45x6x3lt
         Y67Qp1+kgcM4IG5soPgsEYpx0fYR1onE9UQuBKmFfyEaUeldqpcDuPJTLCJhTqz9QxCm
         CN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289520; x=1781894320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrNLo7Ew0vkv5/2r20/RtbigqwQYa7RBbYfUHsMbkTE=;
        b=Pi8X/axt6hV1WhZGLmrq+ZYIy+981a3AuAFsrMy4UyyskgWRM7/INBnSSbEblXhJP0
         lFgDcO5oVGtVQf26ZqGYAgBDvoCVIKxv8eckYgRMBzBv3OKDZcPqSDEm0Ofl1TMclPYu
         dpTasVuWQ80TRJs3tcZ5drIj6lp2z/OPhJSFSa/7tDr41zxReA12KJ+TIB1uinifKksp
         OyzKUhvSfo+OFjyNi1VL91mI/ar8QGNdaKWuiBd8npX8/+VOJKd5M1BoDBQU+TztUA95
         UjjtsapWUyHovkhOyQzvu819t3zXxVy0AWxQoPYSoXz3M+Zyr0cglT2WDqodiVL4D5tl
         KiOA==
X-Forwarded-Encrypted: i=1; AFNElJ/DYMjBKQFyzZcCnQIpUw5v6FFt4BnDrWMZ8Tbqv/lapE407zcGopI6WMozYrNWoomy2Kpd1w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0bZ7kmI2JQmX1uVzzrX9VjxsquPObwmMUoMGTGBmKwJ3Vr4s3
	hPwibgyYL2cP72zW85J2cAn6n9YqqdVX56jpakYou2M9qUfdBXNbxRbs9BE6Jaymlcg=
X-Gm-Gg: Acq92OH2AIHtfj/VXDqQKJlu9P3v7iEOU0hHBf7IBgLBYzjImjKDsQFpDnqwzvdW1eE
	VGKKPYy24mahtEJgRaDANT6axxr0SyFhCvdL/7pTRYxClnb5i8On9o621TwZeRYfOtpkL5zMqIf
	lFL8ksJyGUkPco7CU+suE1cHaY04ToDJKqwed6Set5eGQPZ2scbGwWrHQn5oFq4hYoS3ImUGXPG
	HcojlggIH48iD68cPtQMgUEJgNtIiNH4sGqajVSIAQMF5jt2HwJskvmJTxRqaoQJuwIPQgs/QSt
	vAr6lVGpee5LUwEA8xCk6yw9ZAvb70nRs5TdrqgAw06OI1VBWePa0U145qxkLgsjhQ0dT3IhpJt
	IMf24njy6iLYumd2+7KLMu5VakqbQB5mIV4qbuwXOiPBQWEr621JTMOA9hV8gjeKh70GGKoNbdD
	rqdFbhmF5/gnXxiAN1z6Yo0Gg8Pwsnbsf/TcEpqJFxbLlZJf4Cwj0=
X-Received: by 2002:a05:620a:3703:b0:914:c82c:79fe with SMTP id af79cd13be357-9161bd3547cmr582475285a.27.1781289520113;
        Fri, 12 Jun 2026 11:38:40 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a03d6fcsm272063885a.35.2026.06.12.11.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:38:39 -0700 (PDT)
Date: Fri, 12 Jun 2026 18:38:38 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Subject: Re: [PATCH v2] pstore: add a KHO backend
Message-ID: <aixSCR1P2zVHDo3e@plex>
References: <20260605121040.1177072-1-mclapinski@google.com>
 <aiwa4jIWEMsvfnVg@kernel.org>
 <aiwbUfeaF9RdCGR-@plex>
 <CAAi7L5cnRt6enZnrrbbhsVwtxUDBXrxj16zsg8TtRFvP70ocoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5cnRt6enZnrrbbhsVwtxUDBXrxj16zsg8TtRFvP70ocoQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_113842_100026_2F0A2306 
X-CRM114-Status: GOOD (  25.92  )
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Kees Cook <kees@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 06-12 19:57, Michał Cłapiński wrote:
> On Fri, Jun 12, 2026 at 7:21 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On 06-12 17:42, Mike Rapoport wrote:
> > > Hi,
> > >
> > > On Fri, Jun 05, 2026 at 02:10:40PM +0200, Michal Clapinski wrote:
> > > > Up to this point to preserve late shutdown logs in memory, users had to
> > > > predefine a memory region using ramoops. This commit changes this by
> > > > preserving a buffer using kexec-handover.
> > > >
> > > > pstore_kho supports preserving only 1 dmesg buffer.
> > > > It gets replaced with the new buffer on every kexec, so the user has to
> > > > copy the file out of pstore after every kexec.
> > > > There is no erase() support.
> > >
> > > Sorry I didn't jump at v1.
> > >
> > > pstore does not really need a KHO backend. It can use ram backend with
> > > reserve_mem and reserve_mem can be preserved with KHO already.
> >
> > I just tested it, and it works well, I think it would be fine for
> > Google's requirements:
> >
> > CONFIG_PSTORE=y
> > CONFIG_PSTORE_RAM=y
> > CONFIG_PSTORE_CONSOLE=y
> 
> Is it common to write to this console? I think what I typically see in
> the console are error logs that are also in dmesg, so if I preserve
> console logs and dmesg I just have 2 files where one is a subset of
> lines from the other.

We need either your KHO backend, or the following patch:
https://lore.kernel.org/all/20260612172623.1218280-1-pasha.tatashin@soleen.com/

We need all dmesg messages.

Pasha

> 
> > With the following parameters:
> > 'reserve_mem=2M:2M:dmesg_buffer ramoops.mem_name=dmesg_buffer ramoops.max_reason=5 ramoops.console_size=2097152 ramoops.record_size=0 ramoops.ftrace_size=0 ramoops.pmsg_size=0'
> >
> > KHO preserves pstore properly. However, we need one patch that would
> > allow for ramoops console to capture the output even when quiet is
> > provided.
> >
> > Pasha

