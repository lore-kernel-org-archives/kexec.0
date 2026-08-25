Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C254FC61DBE
	for <kexec@archiver.kernel.org>; Tue, 25 Aug 2026 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/bO7oRLixHf3hrejlfMlGfhBMkAcUtSYSC0qo8lb9E=; b=EyNZ+Ug6dkuLplzfYT/oFTlNCf
	p+7ZlJPbtqukP6Poby8SRoB7O3JsuBlxdG0caFG9q4f2++cDRy662JjBjEUgrq35Ds4YjKo4h77Dg
	IDWH8ZjYDlGtA50IRUBxls6wH0M2/rxMMmp9Dox52ltTqVU0UbrcFviYj6JnlVFMVsx/RxJYvpehU
	KCJQfEuFcHFJTiq+68L5NNVgUeavi8mfQfMoEETs/O5BpOcchQmsjn1hlSC0FQkki0jvFequMq4wQ
	SAUSLCJW7ZfWPK3FgRoaYOIkISE+GJWFH7dugI+1EdhnBAEKT9Lm/p9AM2C5muRoZ5rUgENVJIBg1
	opq9bI6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wysbt-000000010FA-468Y;
	Tue, 25 Aug 2026 14:58:45 +0000
Received: from out-27.mta0.migadu.com ([2001:41d0:1004:224b::1b] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wysbr-000000010Ed-1JK7
	for kexec@lists.infradead.org;
	Tue, 25 Aug 2026 14:58:44 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=KnZDcMWRn7Zu+bLe9Q7f+sdXJDlECr099EG30SIifxc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787669919; v=1; x=1788274719;
 b=F4kThCqOBaNlN/UYZuYK0Se+MWi+0EkemxC+9Yomr66iwmnsmUzAClw2RzORsPWPqAlaXbWU
 AT5qe6O34aMkIDXsezO//O0cSnODIxYPLi2d0JQpO6pMcWhC/TAgXoiisyFTf7Ditz/o55JgQ9U
 3B/Il/ZBfs/eO5cV/2BMcKz4=
X-Envelope-To: kexec@lists.infradead.org
Received: from localhost (223.70.159.239)
	by smtp.migadu.com with ESMTPS id e23b80d205abac2c;
	Tue, 25 Aug 2026 14:58:39 +0000
X-Mizu-Trace-ID: e23b80d205abac2c
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org
Cc: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	shuah@kernel.org,
	ardb@kernel.org,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftests/kho: add LoongArch vmtest support
Date: Tue, 25 Aug 2026 22:58:33 +0800
Message-ID: <20260825145834.14244-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAAhV-H7XKFj93fSPcKAR9AR6Z4O28pC9va243hVccvPNOxH3qg@mail.gmail.com>
References: <CAAhV-H7XKFj93fSPcKAR9AR6Z4O28pC9va243hVccvPNOxH3qg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_075843_495742_48C99E11 
X-CRM114-Status: GOOD (  10.67  )
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

Hi Huacai,

> You nearly answered nothing.
>
> Does your employer use different kernels for host and guest in KylinOS?

No. Host and guests run the same distro kernel in KylinOS, and guests
boot with edk2 firmware, so ACPI is delivered and i8042 bails out
through the PNP path. That is the normal case and it never panics.

I have since finished the investigation, also for the firmware-less
case. The same QEMU command with two kernels gives two different
results, and the difference is the kernel configuration:

- A distro kernel (CONFIG_PCI_HOST_GENERIC=y) maps the PCI_IOBASE I/O
  window through DT PCIe host enumeration, so even without firmware the
  i8042 probe reads garbage and fails cleanly ("No controller found").
- The selftest's minimal kernel maps nothing there, so the same read
  takes a page fault in i8042_flush() and panics before userspace.

So the panic needs three conditions together: a firmware-less boot,
SERIO_I8042=y (the Kconfig default), and no registered PIO range --
which is only the selftest-style kernel. I agree the mainline fix is
not necessary. For the selftest I will enable
CONFIG_PCI_HOST_GENERIC=y in loongarch.conf instead of disabling i8042,
so the selftest kernel stays closer to a normal one; the standalone
patch will not be sent.

Thanks,
George

