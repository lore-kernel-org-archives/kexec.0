Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A74DC4829B
	for <kexec@archiver.kernel.org>; Mon, 12 Feb 2024 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T4cUOY5Z2S68YE/Dmt/ZNQKSbdkxiO4qHX5F9FjySv8=; b=KJMD4JRXXTT0c8
	WwQxtTT7TYMQUYmgFq/i1Y/g4o00VRpzkhucYm3Xasj8EKWH/5WxhZppjR51rbUWnktjeP1DHH3+y
	K2iuHWSznu6LUpNbOz2ju5Ew62nNgEk8fuauRKTzsfJX9n39V59r9wQ/LsRHJei1VkyNrBQ5LVoPv
	u6815Fp8sh+fZOxaGtlasl62ZmtKi9dBVSorK0JFKQhEXNQMA0HwgUcoQDakSpMq2/HSIpPa+icll
	thHXFb3xUYFKIV+yymGFtWbsOSaTpGjvnddjqnNAzwIsddjsNAr9waTi+ctB5r2pwOukxkdhVQeOs
	zDAQ6aoKLbWBDH1cz7Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZRvK-00000004eT9-3F4X;
	Mon, 12 Feb 2024 08:44:22 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZRvH-00000004eSR-1aXu
	for kexec@lists.infradead.org;
	Mon, 12 Feb 2024 08:44:20 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-410ca9e851bso4954555e9.3
        for <kexec@lists.infradead.org>; Mon, 12 Feb 2024 00:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707727453; x=1708332253; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LK/7MVtgjnhy5jN+N9y1+ro6J0YP7MUdBH0qcdZQKPE=;
        b=mWNfR6WWod4IptBg2KJ2cp/kasm49s6pLU0HybaNKU4Lx+qWcjPzVAklWayynV+o2T
         IJdG24F7lQDv+8Gr/9v7tVJjxkVqEcEJYj0Wq+iL0zxrVHudjeaBNWrz3HLn1tqI1+0O
         MsUdqyojX046G5y9bs9dhhgtMgD+5a9pbetM5DTWUygZrremqlqiIadKe4owveXJ7Jps
         aHwgiBNKJ9PPEbhZtL6y9NOU+clsuyyHELbr2GrrFEMl4JpPbawk/SLFsV2a57auSuxE
         5Lcr3Sjap61qWs0byykVC0K+48hD3pEWXKF5789bgwPO59rLvAqvgBxmBmIAqAzdD85A
         PSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707727453; x=1708332253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK/7MVtgjnhy5jN+N9y1+ro6J0YP7MUdBH0qcdZQKPE=;
        b=XQiJZtdmTD/NjUisyLeCv69VYLSzqRHLVxktsFex2iEZfZtYhLG6PRhum5j33kkQpd
         1dBmx2JC2eVZH/9lkC5YCRVjWqxgxYjAfjt49kCWsE1ntJ5DQ5IElSPaDcp3108sgceF
         QzMGAEB6GWLd+ytm4P1VMQX0p3hqlxYfOD0j8Z28k/iM1qaW5XwI5eNn5MQfFPWW/zNj
         gtVAMoFfRlvLJjjG3YJBPx8+bmUemvRLvYTlym7TfKydijAWfX4BekAXiw6VkZQA82nX
         0/lCuHVoct1hrPE0prKHm7sGpDSZNAZO1dnz9bM7KMxEmingBQ/lIY7V8PpMWMglt3UZ
         xZpg==
X-Gm-Message-State: AOJu0YwnOk436aBYLXW2j93zSTaN0x2aDgp0BCjWR2wxTMnm2HUXxJaR
	B/S3qrWXZlU5EbihSLjuQfBs55nCxypK5ILz34D2p0d8Rqagnve3
X-Google-Smtp-Source: AGHT+IHcgWyTIRk2/s69vNuoTEzWZ7SFLhl0GNuRLIzRhxaYQASimFCJsRDo/BgmOO4HZWOvB9e+aQ==
X-Received: by 2002:a05:600c:3555:b0:410:61ce:f5c3 with SMTP id i21-20020a05600c355500b0041061cef5c3mr4944459wmq.19.1707727453055;
        Mon, 12 Feb 2024 00:44:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNzEsaHWl853SGIKgGisI7Lu5+D0WtUkTKgMogbKNkxzYqbjtC9qXdjgDrJQHzd8wX4J3TZ09EDmFB4ljXKLNpcH1/aG7W5GENEJD6ojRgdS2Nt/vdrlQpQFmmsXJn4Fq6+1eToKyJxbw9yovaf8tFnKGE4LXvPJb6eqaln3mEzsTsJyNy18e9WSsnhi64MUSBRGWj465JE5aZcgg=
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q18-20020a7bce92000000b00410c04e5455sm3365842wmj.20.2024.02.12.00.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 00:44:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Feb 2024 09:44:11 +0100
To: Baoquan He <bhe@redhat.com>
Cc: Stanislav Fomichev <sdf@google.com>,
	Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
	Kexec-ml <kexec@lists.infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
Message-ID: <ZcnaW5hB8y3da3bI@krava>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <ZcZ6myvln-v0Y98S@google.com>
 <ZccAyalp+NyKQoGp@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZccAyalp+NyKQoGp@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_004419_439067_CB9E717E 
X-CRM114-Status: GOOD (  14.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, Feb 10, 2024 at 12:51:21PM +0800, Baoquan He wrote:
> On 02/09/24 at 11:18am, Stanislav Fomichev wrote:
> > On 02/09, Hari Bathini wrote:
> > > With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> > > to the below warning:
> > > 
> > >   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> > > 
> > > Fix it by using the appropriate #ifdef.
> > 
> > Same question here: how did you find this particular kconfig option
> > (CONFIG_CRASH_DUMP) to use? Looking at the code, crash_kexec is defined
> > in kernel/kexec_core.c and it's gated by CONFIG_KEXEC_CORE. So the
> > existing ifdef seems correct?
> 
> This patch is based on the latest next tree, I have made some changes to
> split the crash code from kexec_core.c. If you check next/master branch,
> crash_kexec is not in kernel/keec_core.c any more.

makes sense, it should have fixes tag:

Fixes: 29fd9ae62910 ("crash: split crash dumping code out from kexec_core.c")

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
