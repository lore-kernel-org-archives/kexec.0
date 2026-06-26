Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1831CDE008
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKarf3WojTEtDL02vWetL6uYebMXxJkO3bOvu7zoQng=; b=1OIs1qvcHv88Eplbjw78R9XVte
	gF9MC1ND7Qp3tkH+9ZOqy292U63/+zadJedQUtoPYw8IE11h9oqI5da0vrqWa5nTzeWVqBifWgOXx
	U+w5YX/yaRCADGWhvX93IKb1m6WTHf0QW5uvGw1WRdw9pJgoSKmhBJWMc3Ps4F3eZ+BvsoimVa+xG
	xMBiTHTlqYpIqEFvmPpwfTDQgRP6zBbyduPJtESln9qB7piUeRCbeLKxP5fKLc55UgxEQ3ziwMNGL
	XQcDsrNM2x9nunzEC3O6Un4Mc8tU9QI2rX/xSqeykH9CbLwDcMoxBOYMe1DZ1gTLxlxpUjsIIkiy6
	cmW8ZOhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd3C1-0000000B1tu-2ysl;
	Fri, 26 Jun 2026 09:49:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd3C0-0000000B1th-3Lj4
	for kexec@lists.infradead.org;
	Fri, 26 Jun 2026 09:49:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8BFF743F8D;
	Fri, 26 Jun 2026 09:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA251F00A3A;
	Fri, 26 Jun 2026 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782467387;
	bh=sKarf3WojTEtDL02vWetL6uYebMXxJkO3bOvu7zoQng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YUr0Kerrbh2QuIIdyOHOVDcepjBbndMwnzTudYfheGuqV4Fntr0vAgbDXKC9LaqhX
	 ce0z/D+401e4kYwm1/ggRKKaEEWtgdzTFwyWsGSAzUT78379WgPjrVyCVMIzBhIyXM
	 OVRzdocqk2OGmDOBHFIM9wQ5DLXfkWjuH7WNLQaxwM7+hNMQdF0IUPVXXSdlT4vaSU
	 ZOFIftIDH91HbkI8zWjL5TORYM7YTeFGAewf9WhX3V6Bq/EllIS2ZN/HHNntdDjeeW
	 56wuMvW7i7cvBzV+s1+vCDVfI+KJGxdOuTf18N1wcHKSbeTkgrM5y9NVee9DOW6wy3
	 uw/3A00dBkIDA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Jordan Richards <jordanrichards@google.com>,
  Shuah Khan <shuah@kernel.org>,  Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>,
  Willy Tarreau <w@1wt.eu>,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  kexec@lists.infradead.org
Subject: Re: [PATCH v4] selftests/liveupdate: add end to end test
 infrastructure and scripts
In-Reply-To: <20260626-luo-vmtest-v0-v4-1-e7d3111cd5b3@kernel.org> (Mike
	Rapoport's message of "Fri, 26 Jun 2026 12:15:36 +0300")
References: <20260626-luo-vmtest-v0-v4-1-e7d3111cd5b3@kernel.org>
Date: Fri, 26 Jun 2026 11:49:44 +0200
Message-ID: <2vxz7bnlljgn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Jun 26 2026, Mike Rapoport wrote:

> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Add the end to end testing infrastructure required to verify the
> liveupdate feature. This includes a custom init process, a test
> orchestration script, and a batch runner.
>
> The framework consists of:
>
> init.c:
> A lightweight init process that manages the kexec lifecycle.
> It mounts necessary filesystems, determines the current execution
> stage (1 or 2) via the kernel command line, and handles the
> kexec_file_load() sequence to transition between kernels.
>
> vmtest.sh:
> The primary KTAP-compliant test driver. It handles:
> - Kernel configuration merging and building.
> - Cross-compilation detection for x86_64 and arm64.
> - Generation of the initrd containing the test binary and init.
> - QEMU execution with automatic accelerator detection (KVM, HVF,
>  or TCG).
>
> run-vmtests.sh:
> A wrapper that runs vmtest.sh for each LUO test across supported
> architectures, providing a summary of pass/fail/skip results.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Co-developed-by: Jordan Richards <jordanrichards@google.com>
> Signed-off-by: Jordan Richards <jordanrichards@google.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

