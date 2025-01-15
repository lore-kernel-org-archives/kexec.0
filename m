Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFACC02185
	for <kexec@archiver.kernel.org>; Sat, 18 Jan 2025 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HoxPdbGDiDXMZjZ2YzakPSB0m74gINsG6VFgtuazYj8=; b=130T9joloGJVrduHDOkNEZE+i/
	q4ATHgTImfnf8EMBJQv38hH5BPFnz1MnRwcoQo+yIsTGij83KGUpPU3m5idGsVKttiFdRhFPjX+9s
	QdSbVshceRQ/DrWgxLMEM5kNZHBpaiGUfuuYiYR7u/Zzh7jxjG8ybiU/0DfLvJNWbS3j0ICt4hNDN
	ydeWutJH350NIf1WMh/50UBmOBrvSIoi0UQZNX8JDTF/VPQZhbwEaMREBP4AICtfmpMXTZ3W41nxi
	8Fw9zFS0pL8HyhPX3z8Ir8D48eEL3469fNKFQjJYgnrUNacxgjdHAmCzekD+SGhkfsDnAApfLcYBd
	ZRjDoAng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZ49i-000000021LE-2vsQ;
	Sat, 18 Jan 2025 08:26:10 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY7ZO-0000000Cfif-0rJg;
	Wed, 15 Jan 2025 17:52:47 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736963561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HoxPdbGDiDXMZjZ2YzakPSB0m74gINsG6VFgtuazYj8=;
	b=O59TkAiVIoh/kyWqt3sD2QUaiElCxlt4joNfsm5Vy47rl6VB5TFRsEG8yyBoGzvY2r/6mY
	lQrxl2KFOtZwXB8o2yGswqA28AwPR3ILexVj+8YMlHNoNTQyAqrecm5DQu43fEOAoeu1zB
	AUUJUV3mFLL/jKj4Q1eejS9vRnjN/1NreJFiVLN6lXCv97Xxmp1pRrzkdAR4+8k7oYySE3
	EjRlx3bwRLZ1kPZatpooq203bOQXFsUoJ5K9wvWgIoGkzYbbWPFekFpYB6FKtIibo4IGCl
	3qtrgWckX7984+Okk9ULQbx1KIxKVOK20qnnIXjJMWBsTxDlkgtJ8kE9XE9ROg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736963561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HoxPdbGDiDXMZjZ2YzakPSB0m74gINsG6VFgtuazYj8=;
	b=fzGlQJbELsuQf/TIokTn215dpIYwMgfAYRUXgXNteW1TJ/rfCFCi40yte9UtrzUzNBp68H
	ns68VXLDVpNCEbAA==
To: Joel Granados <joel.granados@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fsc?=
 =?utf-8?Q?huh?=
 <linux@weissschuh.net>, Kees Cook <kees@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-serial@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
 codalist@coda.cs.cmu.edu, linux-mm@kvack.org, linux-nfs@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 kexec@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Song Liu
 <song@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Jani Nikula <jani.nikula@intel.com>, Corey Minyard
 <cminyard@mvista.com>, Joel Granados <joel.granados@kernel.org>
Subject: Re: [PATCH v2] treewide: const qualify ctl_tables where applicable
In-Reply-To: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
References: <20250110-jag-ctl_table_const-v2-1-0000e1663144@kernel.org>
Date: Wed, 15 Jan 2025 18:52:40 +0100
Message-ID: <87jzawarrr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_095246_373037_6929B6EC 
X-CRM114-Status: UNSURE (   5.34  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sat, 18 Jan 2025 00:25:22 -0800
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

On Fri, Jan 10 2025 at 15:16, Joel Granados wrote:
> sed:
>     sed --in-place \
>       -e "s/struct ctl_table .table = &uts_kern/const struct ctl_table *table = \&uts_kern/" \
>       kernel/utsname_sysctl.c
>
> Reviewed-by: Song Liu <song@kernel.org>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org> # for kernel/trace/
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com> # SCSI
> Reviewed-by: Darrick J. Wong <djwong@kernel.org> # xfs
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

