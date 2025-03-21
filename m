Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C2FC36000
	for <kexec@archiver.kernel.org>; Fri, 21 Mar 2025 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2bzQ39oJ6FKRT59C+Uimbt2z4p+cGnCUiJQU6Ut1RkE=; b=KBegGfy6BS3PG6XuVxL7e9W8L+
	pVFIpjZ/uiGBP3CIt4M81F359iHU0x67UEJZuMS7x/GiegGTolOVozseU10RcUuTtft/oODDp6zm4
	g3r3CexZprzgN/Y8ni8z+tVUS8MIAY+UHsMIbJ6t4xgsbPTLP+83ml87w+YQlcO6128fX6HtHCNvl
	qWO5ql2bJZktni9DC5dPW/6H0qTpqF8MnhCODsqRdyxNwFavZp0Ow2iVQUak2C2aSCziUf912rrSV
	wbDmsNTT6jUhRj5+e7ty8HPacqRAAZaBb7I761RvmpgzRcPT0VMOt7uoRpHzANfFwQrIYc5/cTaLB
	QPuNl10A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvcjb-0000000EyQx-1ja2;
	Fri, 21 Mar 2025 13:48:27 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvciA-0000000Ey81-1xIA;
	Fri, 21 Mar 2025 13:46:59 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AFB0541061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742564812; bh=2bzQ39oJ6FKRT59C+Uimbt2z4p+cGnCUiJQU6Ut1RkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JEshP6ni6yTLpiaYeOas9Jrjng77WDd/fjCMr/gyDDWDqacAJ+YuUA8xDXXFER0bT
	 skcsq4eOugcFKMrAOhAi5bJelZY5jeMWSuiex8mG+kjmeigm/4eb4IX4uDvZ3rhzjb
	 uTPpLNk55qCifj+0RtgKCO8lr13t4OjPqyVdNXdKWcdpjLB8vdRS7mmYjWkYli1QVF
	 T6JGg6nJ5dp6Iys4YrQyveK3B7Qdrjs1qbajVQPpCSuKoxwQMgI28OvBtX2zxUm4cl
	 YmbNWfFdDGyr3sOosFT031TE7EXwH8N3uAYsRNSTCevKWhC1dLLjJq+wYgtYrWpFIA
	 t+cnjbyGdB9jA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AFB0541061;
	Fri, 21 Mar 2025 13:46:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Changyuan Lyu <changyuanl@google.com>
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de,
 ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
 catalin.marinas@arm.com, changyuanl@google.com,
 dave.hansen@linux.intel.com, devicetree@vger.kernel.org,
 dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com,
 hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org,
 krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
 mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com,
 peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org,
 robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org,
 saravanak@google.com, skinsburskii@linux.microsoft.com,
 tglx@linutronix.de, thomas.lendacky@amd.com, will@kernel.org,
 x86@kernel.org
Subject: Re: [PATCH v5 16/16] Documentation: add documentation for KHO
In-Reply-To: <20250321063356.381646-1-changyuanl@google.com>
References: <87wmcj69sg.fsf@trenco.lwn.net>
 <20250321063356.381646-1-changyuanl@google.com>
Date: Fri, 21 Mar 2025 07:46:51 -0600
Message-ID: <87frj6o5ro.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_064658_497428_1765F231 
X-CRM114-Status: UNSURE (   7.85  )
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

Changyuan Lyu <changyuanl@google.com> writes:

> However, I think concepts.rst and fdt.rst are not not end-user oriented,
> but for kernel developers of other subsystems to use KHO API (I also plan
> to include the kernel-doc generated from kernel/kexec_handover.c and
> include/linux/kexec_handover.h here in the next version).
> Should Documentation/core-api be a better choice?

Yes, I think it would be.

Thanks,

jon

