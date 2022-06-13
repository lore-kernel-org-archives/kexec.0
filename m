Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A35FC43334
	for <kexec@archiver.kernel.org>; Mon, 13 Jun 2022 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jb+rxE4qyycYtIuW41Opsukj3SyByzxscFt/PfFq88A=; b=yLeDB/SIoxHs+d
	9wN6u1y1ut2uLQnl6HdKGg+qJoOt1iI95tvg01RynWA4ia1w8quRGPFRs3IWFHM93OwMqFBZGixoF
	o5H96A8PQPmTxhUunm+CF6pY2Oc4TSy/xVrzb0zlEciCxou/aQ7X2MYXrb5kn39dxEd4WfFrct9dq
	nzae2WQynJ9CdfY3CdCMwaBkoRgVbvsUymie0PxHMMR4dL2syfs/BjijV7zbAY+ggMe+99JCVdIe5
	crIaaKH48/yokPUjk+i51FeKnEgSK4qEb9JMjEdX3GFqjzccSI7qOIgeSDeZW3RNS4RNp0rg0F+nK
	iwd5ynLjomcadkq/My/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0rZe-005xKE-QF; Mon, 13 Jun 2022 21:26:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0rZb-005xJZ-O3
	for kexec@lists.infradead.org; Mon, 13 Jun 2022 21:26:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 18931613E2;
	Mon, 13 Jun 2022 21:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A908C3411C;
	Mon, 13 Jun 2022 21:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1655155570;
	bh=ZiPSlVmPdSZv7W3M0Gh742ofWTqMrSKr8lBpme/zFfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZZiNsJrRHxvmqrf7NM63ryJlMGQiaqpdR10zxOX6IMMmoJAjISs0HoDA8skjf+NbA
	 nznY8vvRKzm7qH1srbvcXTZ0wcSy6sf11tALSEEAtCg1fnV7eKwGEGUepJei5mt8EU
	 l52aGRpE4AJRcrW8Wclmhq4lhokM6VjCZH3J9OH8=
Date: Mon, 13 Jun 2022 14:26:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, Nick Desaulniers <ndesaulniers@google.com>, Dave
 Young <dyoung@redhat.com>, Kees Cook <keescook@chromium.org>, Jiri Olsa
 <jolsa@kernel.org>, Stephen Boyd <swboyd@chromium.org>, Bixuan Cui
 <cuibixuan@huawei.com>, David Vernet <void@manifault.com>, Vivek Goyal
 <vgoyal@redhat.com>, Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 0/2] Expose kallsyms data in vmcoreinfo note
Message-Id: <20220613142609.3e4be0f2f45671341450232d@linux-foundation.org>
In-Reply-To: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
References: <20220517000508.777145-1-stephen.s.brennan@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_142611_883096_3454C7C2 
X-CRM114-Status: GOOD (  25.59  )
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

On Mon, 16 May 2022 17:05:06 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> The kernel can be configured to contain a lot of introspection or
> debugging information built-in, such as ORC for unwinding stack traces,
> BTF for type information, and of course kallsyms. Debuggers could use
> this information to navigate a core dump or live system, but they need
> to be able to find it.
> 
> This patch series adds the necessary symbols into vmcoreinfo, which
> would allow a debugger to find and interpret the kallsyms table. Using
> the kallsyms data, the debugger can then lookup any symbol, allowing it
> to find ORC, BTF, or any other useful data.
> 
> This would allow a live kernel, or core dump, to be debugged without
> any DWARF debuginfo. This is useful for many cases: the debuginfo may
> not have been generated, or you may not want to deploy the large files
> everywhere you need them.

Am trying to understand the value of all of this.  Can you explain
further why carrying the dwarf info is problematic?  How problematic
are these large files?

> I've demonstrated a proof of concept for this at LSF/MM+BPF during a
> lighting talk. Using a work-in-progress branch of the drgn debugger, and
> an extended set of BTF generated by a patched version of dwarves, I've
> been able to open a core dump without any DWARF info and do basic tasks
> such as enumerating slab caches, block devices, tasks, and doing
> backtraces. I hope this series can be a first step toward a new
> possibility of "DWARFless debugging".
> 
> Related discussion around the BTF side of this:
> https://lore.kernel.org/bpf/586a6288-704a-f7a7-b256-e18a675927df@oracle.com/T/#u
> 
> Some work-in-progress branches using this feature:
> https://github.com/brenns10/dwarves/tree/remove_percpu_restriction_1
> https://github.com/brenns10/drgn/tree/kallsyms_plus_btf

What's the story on using gdb with this?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
