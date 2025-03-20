Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14C0C28B30
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 17:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5vcA7VYkAbR6dJ4uPGsop0RCD9nTLsdEHjU7/It/kNw=; b=yeLg1ezTluJN5Dcym2yfvMkVBs
	6CL0fHaJ8NDe9lBFHNadhMgnqkjPyzZLOxXUGJq0zND56gK3kGumToonmh97uNeF057s9jq4JU5yT
	L1xGlbg28gpIUdcMEShGCgPfxtik6PDW7defUpTVKI3PV3NwpcOLBL/Sw6J+HYu7Nu7CLkx/xWJX1
	LDsMqoVQyht39F5UD27HBIqjulCuEUhQl40zldt6MeTrWI3YksjumlNNJeiQS67BQxCs38EuMacN4
	x6ptOYCWK80HWEo5ILYFx61MBl8HkQYNCwmDH/w24PGxMcdNIJhY4Fz1KROywfgQPSwEW0P6V9wOa
	qLSQ2BPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvJY0-0000000CmhH-3nc6;
	Thu, 20 Mar 2025 17:19:12 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvJUt-0000000Cm4n-279d
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 17:16:00 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-224191d9228so19671175ad.3
        for <kexec@lists.infradead.org>; Thu, 20 Mar 2025 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742490958; x=1743095758; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5vcA7VYkAbR6dJ4uPGsop0RCD9nTLsdEHjU7/It/kNw=;
        b=hpTwb5vLr9Bvq0SRrz6wAXxLHr0I+uAypgGcr6I4XOB95adEYDqp0oXGqx3T/sAMH2
         KoSpKLdHfYJLoxs/hLXQqnMxqjK3M7qu5vNvTDCpfgAD7QiPMFX/LxGoAH5y/+9tr8Ce
         3uRcoi83tryog8CPt105yrsXAaLLmexR1IMXh04zYkfr5qF0zZhs+TlloL6cC2EeYG0Z
         mhpZ4tZrRIURSsS07a4HmE0cIcDn9+90jEldJWHriUJOkoavjzAMgTilGXrPSEdq5DrD
         RlT33A2sC0vZbhisy1+X91cqoPUu1T+JuLRxKiVdzSZeanVRoMIYxv7r/YmHSq28+LUp
         1Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742490958; x=1743095758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vcA7VYkAbR6dJ4uPGsop0RCD9nTLsdEHjU7/It/kNw=;
        b=c1g3Jgw6cpXRS8EPBfQIjkPV2iFAkvApa2ReMHy8Q8ax8PHx7guFrMwvePNvAsdlue
         8L8KvwvEoT8sbZgedT39jzRuPwQ/Fo+FsIL5jQgmEVNYqoy/THUTt6EtQSOQSWoUxp8Q
         VidjULgsNua7/FOQd+dBTTzZe0CygJDqV7LR6C9Lt22WkYGWAU+iE8sGm6ou2RPYi7vQ
         /bLfp0MQyViYJCfu3wOhCp7bC8wCSShy6LU/z1GbxjNFT7/L6Z0xDi+TuzRkJZx9U7Fh
         mv8AaFRV4AHk5qx7Edc6Mf8JujG3w3YMhNOECLvQny84DzV4Uh/0IrGrll7GAmeFofw3
         5M+w==
X-Forwarded-Encrypted: i=1; AJvYcCWWfzbbXEdqT+tQ+bp2T4Ujx/U06oBZM/BM59BRfBAKLrpuL8RFFaJnsR6joCvOmDAu1z0ECg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxFXOX2ELAROv82vQ1NaNJsgBpUlJ4lFqKHY+69WOJOxXlup2Mm
	iPCWEFVAwm6WGwSGfmdeEKF0+JkTBhFa5kzQ1y276tb8sHLfmKDTrCPL0+8f+0g+DG/vS+WUIAW
	01PmgcNk8BfUcyioLvQ==
X-Google-Smtp-Source: AGHT+IFSTOZJPhF0A6p4zYu8XqyFCbfj+1u7L3mgdhQb13y/kwPpTEfBMQ3apw/ZGc9/6LxAV+vBXTVj5vs9bXs4
X-Received: from pfbkq8.prod.google.com ([2002:a05:6a00:4b08:b0:732:6425:de9a])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b55:b0:737:678d:fb66 with SMTP id d2e1a72fcca58-73905955db0mr383661b3a.5.1742490957851;
 Thu, 20 Mar 2025 10:15:57 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:15:45 -0700
In-Reply-To: <16b14662-d69b-478a-9e2f-a05c56f2c4ce@kernel.org>
Mime-Version: 1.0
References: <16b14662-d69b-478a-9e2f-a05c56f2c4ce@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320171545.2324955-1-changyuanl@google.com>
Subject: Re: [PATCH v5 02/16] mm/mm_init: rename init_reserved_page to init_deferred_page
From: Changyuan Lyu <changyuanl@google.com>
To: krzk@kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	rppt@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_101559_563094_1EFDF59A 
X-CRM114-Status: GOOD (  11.29  )
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

Hi Krzysztof,

On Thu, Mar 20, 2025 at 08:10:48 +0100, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 20/03/2025 02:55, Changyuan Lyu wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
> > function performs initialization of a struct page that would have been
> > deferred normally.
> >
> > Rename it to init_deferred_page() to better reflect what the function does.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Signed-off-by: Changyuan Lyu <changyuanl@google.com>

>
> Incorrect DCO chain.
>

Thanks for the reminder! I missed "Signed-off-by" in a few patches from
Mike and Alex where I did not make any changes. I will fix them in the
next version.

Best,
Changyuan

