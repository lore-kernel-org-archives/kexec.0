Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E89CC55173
	for <kexec@archiver.kernel.org>; Sat,  1 Aug 2026 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IqzEYyvsxUaoTo7q5N2srwBhq/x6rJ9uYS3yb+pyTCM=; b=k968DGNNV/iIiw2aGDZFlaQqgk
	BYTC3H+rwov0hQl2z4f+wAE5ROOcqkJafT91pcKCVZ+8cHFFP1DmmHAlb6+Qz9UJjP0qR9B7qQ1vb
	bk4l1QPg7vxrP1F5oQ3ndVGd93YzcFd44fdVYpJ1z4Nz3I+gm6p4LJMVAD88TR7a7j6OpxZocfNUM
	aWG/0g9XSjMQHb/z998YiroNUKgHUPxFSfpXBMLCE64O6emWWuxnzKwUUOmYHBiKjQhe+Fa1bfgPN
	+QNMJIMhGjNgHlrYLG3juMzcv9m156qIjdso6/Qm0A6t/Oz8uDCC3dKiUTcUS996NwZtJem9nr1gY
	QWPjwSqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqAJT-0000000Ehl5-14aT;
	Sat, 01 Aug 2026 14:03:43 +0000
Received: from out-177.mta1.migadu.com ([95.215.58.177])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqAJN-0000000EhkZ-2UXN
	for kexec@lists.infradead.org;
	Sat, 01 Aug 2026 14:03:39 +0000
Date: Sat, 1 Aug 2026 22:03:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785593013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqzEYyvsxUaoTo7q5N2srwBhq/x6rJ9uYS3yb+pyTCM=;
	b=cEDQsNuMU8m/3kJa8BRPGCCaVqA8r7jf5GBr9BqwksvWQ/PAlqBsrBozlWfigSsa3nLSoD
	V5tD/fjnuc0ccF7kNC9WdzxKuuDZ3jOm2kTSbc1ZkPmRPmyg36zpt6RYRwuJiEw4c7aKdY
	A2CajIn/zJtbM1ar9ehSkRM6ioD3jLk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, Coiby Xu <coxu@redhat.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, keyrings@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
Message-ID: <am38qk60mpVFuJRi@MiWiFi-R3L-srv>
References: <20260731154608.153258-1-linux@jaseg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731154608.153258-1-linux@jaseg.de>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_070338_528157_47AA181C 
X-CRM114-Status: GOOD (  23.72  )
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

On 07/31/26 at 05:46pm, Jan Sebastian Götte wrote:
> I'm using linux on an embedded target in a Hardware Security Module-like
> application. One requirement is that I want the system to be able to
> quickly erase its memory when it detects physical tampering. I'm
> approaching that by using kdump to load into a small payload that
> instead of dumping RAM, erases RAM from start to end. However, writing
> all of RAM, especially on an embedded target, is rather slow. For this
> reason, I propose the mechanism in this patch series:
> 
> Add CONFIG_CRASH_ZEROIZE (default off), which when enabled makes various
> subsystems handling secret data do a quick, targeted wipe of these
> secrets before kdump. This behavior might also be interesting in cases
> where you run a normal kdump kernel but you still want to keep things
> like fde crypto keys out of these dumps.

Please check below patchset, you both seem to have the similar
requirement. Please go there to discuss.

[RFC PATCH 0/4] panic: a pre kdump notifier list for hypervisor upcalls

Note that we usually dont' want to run a lot of work after panic and
before jumping into kdump kernel.

> 
> CONFIG_CRASH_ZEROIZE is a best effort, defense in depth solution. There
> are circumstances, such as when a panic is triggered after memory
> corruption, or when a panic interrupts some operation that mutates data
> structures under locks, when the kernel cannot safely wipe some memory
> areas. The handlers proposed in this series will just print a warning
> and skip the affected areas in this case.
> 
> This series introduces two handlers as a starting point: One for kernel
> keyrings, and one for secretmem. Future places where such handlers could
> be added would be for example drivers for crypto accelerators. 
> 
> The patch series applies on top of linux-next but should work on 7.0.0,
> too. I've tested the patches on a Arduino uno Q (Qualcomm QRB2210)
> embedded target.
> 
> Jan Sebastian Götte (4):
>   of/kexec: fix typo in comment (usable-memory-range)
>   kexec: add CRASH_ZEROIZE to wipe secrets before kdump
>   mm/secretmem: zeroize secret pages before kdump
>   security/keys: zeroize key payloads before kdump
> 
>  drivers/of/kexec.c                        |  2 +-
>  include/linux/crash_core.h                |  5 +++
>  include/linux/key-type.h                  |  9 ++++
>  kernel/Kconfig.kexec                      |  8 ++++
>  kernel/crash_core.c                       | 18 ++++++++
>  mm/secretmem.c                            | 50 +++++++++++++++++++++++
>  security/keys/big_key.c                   | 15 +++++++
>  security/keys/encrypted-keys/encrypted.c  | 12 ++++++
>  security/keys/key.c                       | 44 ++++++++++++++++++++
>  security/keys/trusted-keys/trusted_core.c | 14 +++++++
>  security/keys/user_defined.c              | 11 +++++
>  11 files changed, 187 insertions(+), 1 deletion(-)
> 
> -- 
> 2.53.0
> 

