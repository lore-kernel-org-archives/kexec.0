Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF06C0219D
	for <kexec@archiver.kernel.org>; Tue, 11 Feb 2025 00:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQ1kY4shHPqw7yZi96lRlyOcUbfb9tETUvXdj7UtOVI=; b=1Ci+42HuATgDAXEXfd5BfjPERm
	KRl0WmrwhMBJNALw9aFUYmPhBCsna/6jomHy8X0HAy1Nq2EJEW0VYdYQw5wje6jmKSSkg5ZjXDXJ1
	ix5T/J3ZBlrje6eVMG3H6SEYz4MDsg4xeLRq+ytzqSaq6Bhdz66BsEsE1uSwlTesszIppnBYpGrrs
	exRuRFYe3oFgDtssfw13N9vpLule3lP0YgeRPQ9SeiDl4td7WTV1Ds5bIjm9SAPVaxaWv3JzRCaBC
	QobectD6ajJKxHXVfQSsvumY+f8dPaBwhN3hKgFs92+zMj6KKhWoa2WeA3esLwA5dlbWyVPHXu1zb
	9wabWOyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thecu-000000023tl-1BZA;
	Tue, 11 Feb 2025 00:59:48 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thecr-000000023tT-3i0N
	for kexec@lists.infradead.org;
	Tue, 11 Feb 2025 00:59:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5FE44A40C02;
	Tue, 11 Feb 2025 00:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68860C4CED1;
	Tue, 11 Feb 2025 00:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739235584;
	bh=KclDnq0yGU1M84esdrfIpWZm2KXaxbIJOJXRdNM4TVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baX/QCOxqatyQmLiiwJbPKnXXqi17ksm24/KMF3E42PVYgHxp8UHyslMOHx/CleeI
	 +v8nfmXKDSFs5N/ZCQBxCGPe8GPQI+2dtJFBbvdN/txmjsnDEQ9v5e58ycEj+jULpA
	 tdXj9fX98XgZJpClPK3FcnfvIbruA7A8T6iv6Uqsac+/geicTGhqDS1Is3qnBTVHAs
	 gb/LHHm4EJjJ2y1osY7JMfGsufc+JLt6kaDcGFobRkKdawyQ5La6PEScQS3kdmUWfi
	 t8HRJPLYf6g0KI+jxc4cV9D+sj7EgQkzPmvzwfBDMshVoxQaK2deyXR+4TNxgWxz66
	 cOiutKCeDYFIg==
From: Kees Cook <kees@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kexec@lists.infradead.org,
	binutils@sourceware.org,
	devel@daynix.com,
	Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v5 0/6] elf: Define note name macros
Date: Mon, 10 Feb 2025 16:58:30 -0800
Message-Id: <173923550723.2947986.17868728802985188618.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
References: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_165945_986876_5323D06D 
X-CRM114-Status: UNSURE (   8.59  )
X-CRM114-Notice: Please train this message.
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

On Wed, 15 Jan 2025 14:47:57 +0900, Akihiko Odaki wrote:
> elf.h had a comment saying:
> > Notes used in ET_CORE. Architectures export some of the arch register
> > sets using the corresponding note types via the PTRACE_GETREGSET and
> > PTRACE_SETREGSET requests.
> > The note name for these types is "LINUX", except NT_PRFPREG that is
> > named "CORE".
> 
> [...]

I rebased this for changes introduced by commit
680e029fd62f ("proc/kcore: don't walk list on every read")

Applied to for-next/execve, thanks!

[1/6] elf: Define note name macros
      https://git.kernel.org/kees/c/7da8e4ad4df0
[2/6] binfmt_elf: Use note name macros
      https://git.kernel.org/kees/c/2fc4947bbd91
[3/6] powerpc: Use note name macros
      https://git.kernel.org/kees/c/609c8b309156
[4/6] crash: Use note name macros
      https://git.kernel.org/kees/c/0de47f28ec84
[5/6] s390/crash: Use note name macros
      https://git.kernel.org/kees/c/d4a760fb77fd
[6/6] crash: Remove KEXEC_CORE_NOTE_NAME
      https://git.kernel.org/kees/c/7e620b56d958

Take care,

-- 
Kees Cook


