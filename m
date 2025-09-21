Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DAACAC5A7
	for <kexec@archiver.kernel.org>; Sun, 21 Sep 2025 05:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQOMjv/XWFU6ZeX6ZY4a3Y6cru0sQECLaJUnw5UqKBI=; b=ueKM1w1vNVO8dUnKAYQLtyhRky
	bmmBPJnprTCtDqCFgfomIAXPkGohy5N9xKesvoAUeLMHg4Bu+Gu8KaJw3dZ9DEh4crNeQlkANJyWa
	Pxl01N6JBSMH1ndFuTcWFTzf0MijE7reuPc5VpvsuiM8SEHS7AB8gGXtdMXpJDAxD6dHdbALoJcxZ
	IR0jlEH4YUGjfdnW9RMNnN1dUwVsKu4NYg4wGM++Xi9gNBWoJIRI1c/O6etBND44WUUUYykORedu4
	9KtxJ/0JNXQHWttncTSg6dYzZAeR/NV7D75Voowk3uTM5Oe+q3QzSdkyXxM3UngaqUByNQtqwqwdB
	/jR8yfzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0D23-00000006jAP-0Nmj;
	Sun, 21 Sep 2025 05:54:43 +0000
Received: from a3.inai.de ([2a01:4f8:202:600a::a3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0D1z-00000006j6g-37JI
	for kexec@lists.infradead.org;
	Sun, 21 Sep 2025 05:54:41 +0000
Received: by a3.inai.de (Postfix, from userid 25121)
	id AF8151003C5102; Sun, 21 Sep 2025 07:54:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id ADE391100A8ED8;
	Sun, 21 Sep 2025 07:54:31 +0200 (CEST)
Date: Sun, 21 Sep 2025 07:54:31 +0200 (CEST)
From: Jan Engelhardt <ej@inai.de>
To: Cong Wang <xiyou.wangcong@gmail.com>
cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
    Cong Wang <cwang@multikernel.io>, 
    Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
    Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
    Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, 
    linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
Message-ID: <3ns36rp5-rp37-1nns-9q43-op05or6s26nq@vanv.qr>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250920_225440_000861_6DDCA66C 
X-CRM114-Status: UNSURE (   7.27  )
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


On Friday 2025-09-19 00:25, Cong Wang wrote:

>This patch series introduces multikernel architecture support, enabling
>multiple independent kernel instances to coexist and communicate on a
>single physical machine.
>
>Each kernel instance can run on dedicated CPU
>cores while sharing the underlying hardware resources.

I initially read it in such a way that that kernels run without
supervisor, and thus necessarily cooperatively, on a system.

But then I looked at
<https://multikernel.io/assets/images/comparison-architecture-diagrams.svg>,
saw that there is a kernel on top of a kernel, to which my reactive
thought was: "well, that has been done before", e.g. User Mode Linux.
While UML does not technically talk to hardware directly, continuing
the thought "what's stopping a willing developer from giving /dev/mem
to the subordinate kernel".

On second thought, a hypervisor is just some kind of "miniature
kernel" too (if generalizing very hard).

