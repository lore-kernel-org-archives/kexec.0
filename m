Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3288DC021A0
	for <kexec@archiver.kernel.org>; Sun,  9 Feb 2025 00:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=moq4SnbaCAx8eYUk71pHxNOu7coQOxVd2ccab0EZm5I=; b=n+yRxUwJs//uwN9qOSASdr2ciK
	jthW5Atn3CqqQB/rcLZbRXPkXuHExQ3Tuii4r2qmoF9WZgIT1xqTAeIkyZmbCxdxgYE8EUO/g0xfi
	483QHDoliU3elBRSIcjldHRXa+AMQbp2TQopcC98MuwZU8tdPrmEb5Fdp6ZqLPZeHEwpJpZEVthr3
	+S1gYfW802/A1sVajLwba/BIE34wX9s3fmDgVDB+fzn39B0Fl2rvJevZ2LHbbY0mpF8WH7YjBgTeX
	crQ6Q0A68w4Q4my0vaasoV5aSCncY8f6AesZLSU59JisYXSFzocqx77MMOeqPMc0a7u0+4iA5hHNe
	5FUPXaLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgvYF-0000000Do4W-3ozp;
	Sun, 09 Feb 2025 00:51:59 +0000
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgvYD-0000000Do3o-3VXT;
	Sun, 09 Feb 2025 00:51:59 +0000
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4bbb56bbbd4so581681137.1;
        Sat, 08 Feb 2025 16:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739062316; x=1739667116; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moq4SnbaCAx8eYUk71pHxNOu7coQOxVd2ccab0EZm5I=;
        b=nI1y7ffaN/Ks1gVklwmAcOZ0ZkIr48bp6bOvfv7rM66DDUfLMQJVhJt0IQ80JlOr1P
         MS1fHsVYHj4Lx5oRHckIVERQzyn9fm909FSdV/7C8ZS4i19q41r2BsbeI/DB5kbTwYzV
         PGJUvm68sFT1divvo0sjTj9hZ4y2gUOCEuuwWhfEbqKkU7ExIZbu3REhYJBL0dHD0KcS
         +LBC1wu+/NZvMZgtjxhBvNZg+Q2jXspBlppKmNpz4mOeCKR/pa02MbpseWkvch6QXmja
         S6zFyo+jzY5OklMYBG2N71sO0xyl3ISidV/eXhI2FwbZZEPcsBDIZSVajCoU3AuWmx0d
         Lxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739062316; x=1739667116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moq4SnbaCAx8eYUk71pHxNOu7coQOxVd2ccab0EZm5I=;
        b=G35USNCT1dXYJ1XXqmAe4nmZY3N4zoNVa4kLQ9taa9zWAjojYDKkWgj4aENZCDBP9v
         J/Dq+FsT7VLzCfMJWl3dAZsPGbatkVCFckSTwyycVqieNaII2yiLO2I3q4H/hfQ8OnsU
         vJ51qMiDoH8Sji1S/LjsT06mpSyPkeXd/XDZdU6ESR4TXvcVh8CPHgPjlPEiK3xd5MK1
         pS3jSYsr9btfv8Tixp4FeoDOxOwAY82NhjfXkOuLcs1RkH0RC/ql+vIx2P6LBKbW6+ol
         exyvzOAtbkxboHhgRw4QCj6/csk8ytoAyULvKEvGS75beP5uDPvfjBb3zXy1o3RiPn5Q
         TvzA==
X-Forwarded-Encrypted: i=1; AJvYcCU2xQmod3sSIRaKFSRqTs1/dg459u1ki8C1/dWXgNHnHHoGe8bOHyy7zx95oYb9gmJ6DKPFn8Hqv79oRDXcMqmnkQ==@lists.infradead.org, AJvYcCUbWD0fJUtLYahHnQQYB53StoRXixng2xR+iY1mXgvmeulmnIkdVA9rwtNpAyo9l2Si+k6s2w==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywxb28YGArx3rnSUEbulc+9IPQvJFh+lv7Qdk7BUcEZyfRwrR+4
	/9Y3FA4wOTfgdx8SNL+++qf7YkfAl/UwpmBz6K2QCH4mJ8PZZKa0GTcbNSQIbR96GfsLGuIrct9
	iPiI/tpE+IftUCmV2fi8oSAsn5+Q=
X-Gm-Gg: ASbGncvqrntojfkK+O3XiMcChTNqjIXC/NbPbSwkdbi5CseGysFw72faLwrAMvY174d
	YmaK5VxH5U56GNF3Io5KsEjr2j73rdmZuSyzxLEWoQqezf1CZHzVuqQTUqJyjBKvit8UTNz5SbO
	s0OjDxp8OhgG2JS3gdtZI7hYPZG2FZMQ==
X-Google-Smtp-Source: AGHT+IHbvBsh6V0fXstr8+BOoSkHjjWgUMnEaXVoAFyg/1U+OLW9gAoZ0JTlsqAOxqlsdld7G6QKRI/njRDoksoZ/U0=
X-Received: by 2002:a05:6102:8086:b0:4af:ef82:ce8d with SMTP id
 ada2fe7eead31-4ba86dc8dc9mr5995609137.0.1739062316419; Sat, 08 Feb 2025
 16:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20250206132754.2596694-1-rppt@kernel.org>
In-Reply-To: <20250206132754.2596694-1-rppt@kernel.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 8 Feb 2025 16:51:44 -0800
X-Gm-Features: AWEUYZlTa-fKw29GejPO9DLzpee4iJIj63nbPkF2TO1t-8jFRDudad4UpWMOvAI
Message-ID: <CAM_iQpW+K-Q7qCZ_EH+BsF64aevK0tE3_kO=hma7sWa4TcWDSw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ashish Kalra <ashish.kalra@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@redhat.com>, 
	James Gowans <jgowans@amazon.com>, Jonathan Corbet <corbet@lwn.net>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Usama Arif <usama.arif@bytedance.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250208_165157_875020_410F0764 
X-CRM114-Status: GOOD (  16.67  )
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

Hi Mike,

On Thu, Feb 6, 2025 at 5:28=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
> We introduce a metadata file that the kernels pass between each other. Ho=
w
> they pass it is architecture specific. The file's format is a Flattened
> Device Tree (fdt) which has a generator and parser already included in
> Linux. When the root user enables KHO through /sys/kernel/kho/active, the
> kernel invokes callbacks to every driver that supports KHO to serialize
> its state. When the actual kexec happens, the fdt is part of the image
> set that we boot into. In addition, we keep a "scratch regions" available
> for kexec: A physically contiguous memory regions that is guaranteed to
> not have any memory that KHO would preserve.  The new kernel bootstraps
> itself using the scratch regions and sets all handed over memory as in us=
e.
> When drivers initialize that support KHO, they introspect the fdt and
> recover their state from it. This includes memory reservations, where the
> driver can either discard or claim reservations.

I have gone through your entire patchset, if you could provide an example
of a specific driver that supports KHO it would help a lot for people to
understand and more importantly help driver developers to adopt.
Even with a simulated driver, e.g. netdevsim, it would be greatly helpful.

Thanks.

