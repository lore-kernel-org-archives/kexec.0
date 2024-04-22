Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B36C41513
	for <kexec@archiver.kernel.org>; Tue, 30 Apr 2024 18:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jWQ21FZJgxO3+z0qk0/aCOBXm8n4QZgvwCZqsCyC0I0=; b=RDyHqeNTO20TiJ
	XNfMr8su15NKoDNolav9l9GxDfYtNkVCH1nD36U+xsBM2awxiSETie7pG+ulyHvIRXb6e4cjpPw0l
	P53d3Wg3GgUIWXZiiCaEkFSq8luYjxscug6RCcxcnI6pBlnZZgy3bvHkcwLLzXEkd6Q59t5vNbfV4
	cJ6wPJREJSQrAV85lWd8PeibTn8NfXP1ZA/mYD6+bSgGDremEUMM/xgZLvXvXgdfOdqAGvWdJ4bEe
	UvydZII4h7KO3Q833FqNYNuyG+xF3UceWRALCjoeNQ1Rq/cYhy0/5JQ8VClcTUdCT+/u0cKzfcimK
	Rw3GMvd/9FLP4rdEYOyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1sDA-00000007ZuR-2lF5;
	Tue, 30 Apr 2024 18:28:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryv6m-0000000E0dn-01hi
	for kexec@lists.infradead.org;
	Mon, 22 Apr 2024 14:57:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3FABC60DF3;
	Mon, 22 Apr 2024 14:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B11C113CC;
	Mon, 22 Apr 2024 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713797844;
	bh=/ys6Pzra7IEywMh4hBfA5xJtu9C9b7qcLANvkfE5cJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erWA+QCBdHASSENTMbmbCLszQVLSQvPHDCWgfW4TwFE/GVWL7ruM5SR//WtQ1W6QM
	 d12zJ3HocPCG90okjpoCMBPNiZ4C2wMBghXJf7jiZrH+0zwnbBY2X6rvcNM+wESAuT
	 kBqxDZqGDGm1bi25Y/5iM9IhfADZv/lx70kLTU88=
Date: Mon, 22 Apr 2024 10:57:23 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Joel Granados <j.granados@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org, 
	Kees Cook <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, 
	Iurii Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	tools@kernel.org
Subject: Re: [PATCH v3 00/10] sysctl: Remove sentinel elements from kernel dir
Message-ID: <20240422-sensible-sambar-of-plenty-ae8afc@lemur>
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
 <36a1ea2f-92c2-4183-a892-00c5b48c419b@linaro.org>
 <311c8b64-be13-4740-a659-3a14cf68774a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <311c8b64-be13-4740-a659-3a14cf68774a@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_075728_176174_5378E863 
X-CRM114-Status: GOOD (  22.65  )
X-Mailman-Approved-At: Tue, 30 Apr 2024 11:28:14 -0700
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

On Mon, Apr 22, 2024 at 04:49:27PM +0200, Krzysztof Kozlowski wrote:
> >> These commits remove the sentinel element (last empty element) from 
> >> the
> >> sysctl arrays of all the files under the "kernel/" directory that use a
> >> sysctl array for registration. The merging of the preparation patches
> >> [1] to mainline allows us to remove sentinel elements without changing
> >> behavior. This is safe because the sysctl registration code
> >> (register_sysctl() and friends) use the array size in addition to
> >> checking for a sentinel [2].
> > 
> > Hi,
> > 
> > looks like *this* "patch" made it to the sysctl tree [1], breaking b4
> > for everyone else (as there's a "--- b4-submit-tracking ---" magic in
> > the tree history now) on next-20240422
> > 
> > Please drop it (again, I'm only talking about this empty cover letter).
> 
> Just to clarify, in case it is not obvious:
> Please *do not merge your own trees* into kernel.org repos. Instead use
> b4 shazam to pick up entire patchset, even if it is yours. b4 allows to
> merge/apply also the cover letter, if this is your intention.
> 
> With b4 shazam you would get proper Link tags and not break everyone's
> b4 workflow on next. :/

I was expecting this to happen at some point. :/

Note, that you can still use b4 and merge your own trees, but you need 
to switch to using a different cover letter strategy:

  [b4]
  prep-cover-strategy = branch-description

-K

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
