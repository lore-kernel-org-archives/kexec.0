Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B19C36000
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 06:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2vXAyj+GHzS7wqAccTE1NbTCMIzG8yR1/7SBWPdH7m8=; b=fdd92ZlUZt6pFHuzGTO6W0/hQQ
	k0yI4PKOBWmFT5H9ZmBeukOYWAijA67YFFMW8FRq9RZqA0UqBoVVcX8z/FdI08rE9csy5oHR63+4g
	r3rKcCsfrOI2Jpn06mTPJgOPtfTgNxdB6kXmEwlEiDMWoOeQ0ktBSKwzzWOI3ErGQHtZGd0aoWOiO
	tAXdQaHu17UmPZEWBXbldvZz3Ql9H/rUXxUDBzJixWHjd6d35tA5Q9w8Abw+i9MaWA1r5XI/bL5gS
	7giRaf3Dh8GhfpyHJSBU8Udp1y447PofP0WqQOEd+QIRufy17ISFBVOCOayBO6hfjbhK1o3J53S3J
	dGYy3q8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVxC-0000000E0X9-3NKC;
	Fri, 21 Mar 2025 06:34:02 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVxA-0000000E0Vw-1NFk
	for kexec@lists.infradead.org;
	Fri, 21 Mar 2025 06:34:01 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso4549352a91.0
        for <kexec@lists.infradead.org>; Thu, 20 Mar 2025 23:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742538839; x=1743143639; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vXAyj+GHzS7wqAccTE1NbTCMIzG8yR1/7SBWPdH7m8=;
        b=v4KAD1Quf7M5xrkmqInMxzUSptGEdSPzJ7IpExAceV7l8AAGaDNIRimRtCqQTvGRlK
         ponwnHifAqQQCYWyT4puFGbgg7v7AFWGpty7LeJXPo2HuVVuD9FMsJBp1icM2WJOLZBy
         eUWkS9VF/D/fv1foO+AyAqEKgJPD6JjRN15SLeOwqpxqIs39m1aWBYfGNymUzn4fVJ87
         WLR7oetd0V7/SfsqHSuxuJK/uGJ57zT1fM1zLpRfJauICUYKUipO/efptxM9A+k6kfVf
         s909ra7oCZPDXX2tGB0UJoPXzl92P++TC3SQO4lRIo20yG7gSC+ZQnGNQUm0CqZvLYIO
         Gu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742538839; x=1743143639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vXAyj+GHzS7wqAccTE1NbTCMIzG8yR1/7SBWPdH7m8=;
        b=tF+zMaWK1kjVBYBTQdlcRSVjSpyLDwkzATnoS6iY94c4xxgx4a3SVKsTKZGXKT5NaA
         FUlsBQUnCoJKQPP9bdGLEqE+UtWZdCjzq6pHxVDCzApcNiQ2YsrsvW9j3kTPVq9bX4TR
         QeoURDlA4unMb+gFYZNmb4zZ6yIJfTMKRIkjKBEOQSjYJNIOnbKWHpImAt68ge29t2+J
         dMhGDelErCwp6s/Ki14qFDpQrioqN0hk+Z1vu10WNg8DVa1CSrHRYMDXP0OuAN7NLCyq
         z5uNxj1yOi4os9YuXp/eLrsUbNkOHVE+1RaXnRlPJWzbnkC7xTz7VUljiBvxCqQkErt1
         vNZA==
X-Forwarded-Encrypted: i=1; AJvYcCVMM/pYJFHjotAxNcGwibxxtnl/z92NSNCY7bPpqOAF4iFrikXr5ksmTXdKtOx/MTuSWc5mRQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzoiKnslT3QJkhpgE7HFaOYDCrhUUzSeKIOUY9oUuMtA0SqR8r9
	roMV2jRVmEl5W/p8YE+wmvOnGybEj/ZM8U5d5wRG1TScsjKR2R0FKKQfR3MbRDapaKfzh/h2sDA
	1tuy5W4O79J93B8xDug==
X-Google-Smtp-Source: AGHT+IHzfqXaz88vnwbh1bU3QQ0eg9cO7MjTqz+i1yp3jt6YPQs5uqsY4Klq/6OgfyRjy5OLLCoj7DrCd0HOjDbw
X-Received: from pjbsk8.prod.google.com ([2002:a17:90b:2dc8:b0:2fc:2ee0:d38a])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1848:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-3030fe9e646mr4063011a91.12.1742538838726;
 Thu, 20 Mar 2025 23:33:58 -0700 (PDT)
Date: Thu, 20 Mar 2025 23:33:56 -0700
In-Reply-To: <87wmcj69sg.fsf@trenco.lwn.net>
Mime-Version: 1.0
References: <87wmcj69sg.fsf@trenco.lwn.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321063356.381646-1-changyuanl@google.com>
Subject: Re: [PATCH v5 16/16] Documentation: add documentation for KHO
From: Changyuan Lyu <changyuanl@google.com>
To: corbet@lwn.net
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, 
	rppt@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_233400_381691_37614553 
X-CRM114-Status: GOOD (  16.50  )
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

Hi Jonathan,

On Thu, Mar 20, 2025 at 08:45:03 -0600, Jonathan Corbet <corbet@lwn.net> wrote:
> Changyuan Lyu <changyuanl@google.com> writes:
>
> > From: Alexander Graf <graf@amazon.com>
> >
> > With KHO in place, let's add documentation that describes what it is and
> > how to use it.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  25 ++++
> >  Documentation/kho/concepts.rst                |  70 +++++++++++
> >  Documentation/kho/fdt.rst                     |  62 +++++++++
> >  Documentation/kho/index.rst                   |  14 +++
> >  Documentation/kho/usage.rst                   | 118 ++++++++++++++++++
> >  Documentation/subsystem-apis.rst              |   1 +
> >  MAINTAINERS                                   |   1 +
> >  7 files changed, 291 insertions(+)
> >  create mode 100644 Documentation/kho/concepts.rst
> >  create mode 100644 Documentation/kho/fdt.rst
> >  create mode 100644 Documentation/kho/index.rst
> >  create mode 100644 Documentation/kho/usage.rst
>
> I will ask again: please let's not create another top-level docs
> directory for this...?  It looks like it belongs in the admin guide to
> me.

Thanks for review the patch! Sure I will move usage.rst to
Documentation/admin-guide in the next version.

However, I think concepts.rst and fdt.rst are not not end-user oriented,
but for kernel developers of other subsystems to use KHO API (I also plan
to include the kernel-doc generated from kernel/kexec_handover.c and
include/linux/kexec_handover.h here in the next version).
Should Documentation/core-api be a better choice?

Best,
Changyuan

