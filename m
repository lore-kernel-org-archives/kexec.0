Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BC0C10F1A
	for <kexec@archiver.kernel.org>; Tue,  7 May 2024 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-Id:Subject:
	References:In-Reply-To:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XdSnk7nQUCKV7cPqTVpTxuhv6DMcYXDFtsqdx8WGbkM=; b=ywNeWUy1lF0zFW
	k5lyC0olC3TQw3L65GE9jHozhk3RJ/EyVsKaUWviEvCZBovcRM3eg44Jq3UwtDiMOlWyYMvgQPp1f
	zyiB+EHtwtfCdyiWyRm5yauFbYUnSvI4pG+X1BLStrJuhg02yZBo8GKrUwOp2HUbrpVSVhBiv7bmw
	GwVyloERiBwJgKDOKcIt00fvPl38ITNZ0Iwm8MJzIxWvXydR0k5DN8zDKO2jwek8DD4TdaUimh3zA
	PJ6+/kQIrKf6pQRJzeS6++zUFZyu0FeZ8teE6QZ/j07SYybNzqel8LjVOWPpr65/ozZqk2Bt88rR5
	SaxsSDlkpOphGQOPeCLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4M10-0000000BYks-3hO0;
	Tue, 07 May 2024 14:41:58 +0000
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4M0w-0000000BYhi-3tEO
	for kexec@lists.infradead.org;
	Tue, 07 May 2024 14:41:57 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VYgvt194nz4x23;
	Wed,  8 May 2024 00:41:46 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Akhil Raj <lf32.dev@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hari Bathini <hbathini@linux.ibm.com>, Laurent Dufour <laurent.dufour@fr.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>, Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org, x86@kernel.org
In-Reply-To: <20240326055413.186534-1-sourabhjain@linux.ibm.com>
References: <20240326055413.186534-1-sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v18 0/6] powerpc/crash: Kernel handling of CPU and memory hotplug
Message-Id: <171509287314.62008.11812494124513471250.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 00:41:13 +1000
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_074155_161581_600229DB 
X-CRM114-Status: UNSURE (   9.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, 26 Mar 2024 11:24:07 +0530, Sourabh Jain wrote:
> Commit 247262756121 ("crash: add generic infrastructure for crash
> hotplug support") added a generic infrastructure that allows
> architectures to selectively update the kdump image component during CPU
> or memory add/remove events within the kernel itself.
> 
> This patch series adds crash hotplug handler for PowerPC and enable
> support to update the kdump image on CPU/Memory add/remove events.
> 
> [...]

Applied to powerpc/topic/kdump-hotplug.

[1/6] crash: forward memory_notify arg to arch crash hotplug handler
      https://git.kernel.org/powerpc/c/118005713e35a1893c6ee47ab2926cca277737de
[2/6] crash: add a new kexec flag for hotplug support
      https://git.kernel.org/powerpc/c/79365026f86948b52c3cb7bf099dded92c559b4c
[3/6] powerpc/kexec: move *_memory_ranges functions to ranges.c
      https://git.kernel.org/powerpc/c/f5f0da5a7b18fab383bac92044fd8f4f288c9d38
[4/6] PowerPC/kexec: make the update_cpus_node() function public
      https://git.kernel.org/powerpc/c/0857beff9c1ec8bb421a8b7a721da0f34cc886c0
[5/6] powerpc/crash: add crash CPU hotplug support
      https://git.kernel.org/powerpc/c/b741092d59761b98781fcb4f3f521312ed8d5006
[6/6] powerpc/crash: add crash memory hotplug support
      https://git.kernel.org/powerpc/c/849599b702ef8977fcd5b2f27c61ef773c42bb88

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
