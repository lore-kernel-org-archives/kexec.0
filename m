Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2010EC4167D
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 00:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZM0C1N2oMD5nUpyHVZlvVPE+CBwGXMOwuyTXC1pUe6c=; b=ILSoU/RUfQRd86
	yZo8d/W0iGQhJJxQzk4mV+XNDBrpijoSU24ldlPKVuDtEurfD8S0A9wlG0hTQHiM1/Jrb8z7BpPXy
	yudgZe4jedwajcjQ0tW7Phw0XTUyJns1wiKzvkX4NFERKtTrg187P1Vqn65nWQvN8caNzpWeFrmRE
	24bPVdQj5at2UvQCb972T6KSVcocccLwtBufL3Kl2q7bqWkZSpxRW8XstO2CBmFX8mOE1BFWK/e8V
	RUDhjdnn9OZp3K8glvgr48GFQTRKLoVCDJ8ygT/npAL1T3pA2ky6HS5fXwBMMvrispvme2bnnuEod
	dSfwPgsajuuRNdtJbmOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCu8-00DA7M-0E;
	Wed, 13 Dec 2023 00:15:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCu4-00DA5z-21;
	Wed, 13 Dec 2023 00:15:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 648F761A59;
	Wed, 13 Dec 2023 00:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724A5C433C8;
	Wed, 13 Dec 2023 00:15:03 +0000 (UTC)
Date: Tue, 12 Dec 2023 19:15:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, Mark
 Rutland <mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
 <pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
 <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH 08/15] tracing: Introduce names for ring buffers
Message-ID: <20231212191546.603c0703@gandalf.local.home>
In-Reply-To: <20231213000452.88295-9-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
	<20231213000452.88295-9-graf@amazon.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_161508_728351_392B4395 
X-CRM114-Status: GOOD (  12.90  )
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

On Wed, 13 Dec 2023 00:04:45 +0000
Alexander Graf <graf@amazon.com> wrote:

> With KHO (Kexec HandOver), we want to preserve trace buffers across
> kexec. To carry over their state between kernels, the kernel needs a
> common handle for them that exists on both sides. As handle we introduce
> names for ring buffers. In a follow-up patch, the kernel can then use
> these names to recover buffer contents for specific ring buffers.
> 

Is there a way to use the trace_array name instead?

The trace_array is the structure that represents each tracing instance. And
it already has a name field. And if you can get the associated ring buffer
from that too.

struct trace_array *tr;

	tr->array_buffer.buffer

	tr->name

When you do: mkdir /sys/kernel/tracing/instance/foo

You create a new trace_array instance where tr->name = "foo" and allocates
the buffer for it as well.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
