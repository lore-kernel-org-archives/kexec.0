Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07ACAC4725D
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5fuFjFyBBrhZJUL+GbGlSziU5SFazVbd5qRREQS45vg=; b=1LZalwgfJT+4La
	lWXJyWihF/tklDiJcL2w5nJW3EKsDCmk8lasmQjaH/wt9stRCKKZ+8Z3ZZ2fw1qe1T0CT1XOLVQaC
	Dyaj7GecZBiIRKzu9AXRxt6dMkpyXSGlqHV9OOwEJXO3bbj9tBdxilMo0WTOE7m16368qSG9NSGuW
	sDn7sXInzos7wXPn4ycqxlGg0jl94FRTw/lQTmTz7Rd2URPFe9fiTaMh0LFqICOA1b9K4a2vkFZ49
	oowuQAjdRN8QH0sYLpiOqwwS6py5HGXmS4e4QYzjbOo0L+O/NWPluVVscncISzgSVfeUknrxHyKTD
	fhNdwj4fWLYHVxPdzbiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJw1-003EHu-04;
	Fri, 12 Jan 2024 15:59:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLPI7-00ERJz-1j
	for kexec@bombadil.infradead.org;
	Thu, 04 Jan 2024 15:05:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QMeOCEySrVsJoINeQ9TxSNj3pbxXUobg3IWm+PNZCv8=; b=BbarvAFemfLPswJMTN35yeEzOb
	K6xgTNviB5Dwxae0K+reW+ZN5MgVdA04t8uexoUgGx5kFGIdzCdvNYA5UE1fP0TXWypf16c2HBc+R
	3wnOimyOgkYFowOhnfotZSe3dPpzf8Lcm+iaVsOyp5C8dk6KlHm9G+TYOSXVZT8W8PfoZ2dwqmEMq
	Bw1TT24kk9MMU+ZxMRg5ntUIsQXwRRxTcrT2dSoQMzvVlR8Ci1H7uNXSREVmdYSS/+kfgMj75D/uM
	QsBYUD+0HXvBr61b3drn5iep3H62o86+q6W9ZHM829QpThRI0h/kfng/Nq50HLB23Y43oTaviwJiR
	wALd4NhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLPHy-00FNU5-CW; Thu, 04 Jan 2024 15:05:42 +0000
Date: Thu, 4 Jan 2024 15:05:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org,
	Kees Cook <keescook@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Balbir Singh <bsingharora@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 00/10] sysctl: Remove sentinel elements from kernel dir
Message-ID: <ZZbJRiN8ENV/FoTV@casper.infradead.org>
References: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-0-836cc04e00ec@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240104-jag-sysctl_remove_empty_elem_kernel-v2-0-836cc04e00ec@samsung.com>
X-Mailman-Approved-At: Fri, 12 Jan 2024 07:58:48 -0800
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

On Thu, Jan 04, 2024 at 04:02:21PM +0100, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> What?

The reason I wanted you to do the sentinel removal before the split was
so that there weren't two rounds of patches.  Ironically, because you
refused to do it that way, not only are there two rounds of patches, but
I'm being cc'd on all of them, so I get all the $%*^ emails twice.

Please at least stop cc'ing me.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
