Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44110CDB471
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 08:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qo4MYLhP7dlMp2m7GIjE71Z7pTs4vkTKqFa8g3CH+3k=; b=Jv/kvSWS1gbHtCBHWq8tz4lv5X
	/k562lcm1pso0kwNc1xU4z1nEoWCianO3FPY/Cd1t3xeiISD81JhFx7Vy94B35gxQyClDAnkY8+f8
	vqDr6kPTONjVZfbe3Nd0hbztQD1ugeZbaVnrDnmWeOmSBZxLquCurzPUs/Ff3IpxA2y5XvVOuwrAV
	4iN3awgMb1/caSLjyx6LLeqUaQmCBcePlt1Z7grlLP/g6eBAHnfoEJ3oE21KdIP5zUFmU5FbSLX1d
	y9nIE81bduHCPF5OojWahQeCa2qYIkHaQDtnyntBYhoZnaxbUPIe+8Dc476qf9vMf9dEMX+Txx8j5
	Bjo9hMCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbaAK-00000004gHP-1Q3q;
	Mon, 22 Jun 2026 08:38:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbaAJ-00000004gHE-0v6a
	for kexec@bombadil.infradead.org;
	Mon, 22 Jun 2026 08:37:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qo4MYLhP7dlMp2m7GIjE71Z7pTs4vkTKqFa8g3CH+3k=; b=elUPvVSZ7REnY2EeMhjVznTWiz
	wfVD0gV+gzqdp8j2sGIqN5jF0M4HEJKyfoi/vKMNKXMxwkLGYwcL4rnfra884jJeG0SnDZX/ncyAP
	a90DaiKyBBdjNSy5vgoCTwA9RXDHHfyHaf8RiCfimsYAwSnOmruYbsL4XudhYqUjsE/FuQcAHMR+u
	L+XApl6QXuhI3sKYBf/DpVvVOYqSGWZDs6ko+YrZa00zIh5xEJBGrOINABEYZT0PdgcgUFaqpWsEL
	PcQgNe/mY600p9l3VU9pUfEPK07gDlosO9VgDJUaAsfQCZHzUEpFn5IOghe0qNJIF6nRjJzTjhxpu
	dM/iYS7w==;
Received: from mgamail.intel.com ([198.175.65.17])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wbaAE-0000000HD3b-40zF
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 08:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782117475; x=1813653475;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=o0XPey02pNHXumHWa6TQBgjgCeS/R84YiOVlMcvQRTw=;
  b=ZJhIaJhK0n+LihhjPr593I/Wd/9pRDS3O0XQqZUnL+1iESdDWzr859XS
   GuN0h1tnmvloiCW+GHLByTrm5SmJjCoxnTgoA86Tf4Q4595g9RZPqlRlU
   2OXqxdB9J78KfOYcs2PZvEMkeL980p4s/YmN/AOkQzzh1qLn0e1zrmu9F
   95+B0oZDlJfkjVXbUXqdN1ZMwi91dfhMjO6/BBE+Rm6mFnKbGEily5s9V
   KQpGVfvU8F6arqk8kb4JZfBeMztOVWnzRpmiVmqtqHku+oN6MaLycvF/n
   kb6/ovxrM5GRjZWedBD2UG2Pq+NcB+n/rx6l0qk2CwF/6TCjHDwiIsJsT
   Q==;
X-CSE-ConnectionGUID: 8NtXGyEMQ7G323qKvF4wSg==
X-CSE-MsgGUID: JMXg23vZR7q2m8o/u14L3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82844711"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82844711"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 01:37:48 -0700
X-CSE-ConnectionGUID: 51x2ahlxRfadoXyoUtL0hA==
X-CSE-MsgGUID: PGIuZ8mzSP2g3MT4S82HXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="254255860"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.82])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 01:37:33 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Paul Moore <paul@paul-moore.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Howells <dhowells@redhat.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Randy Dunlap <rdunlap@infradead.org>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Philipp Stanner <phasta@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 audit@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kexec@lists.infradead.org,
 live-patching@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
 rcu@vger.kernel.org, sched-ext@lists.linux.dev, linux-mm@kvack.org,
 virtualization@lists.linux.dev, damon@lists.linux.dev,
 llvm@lists.linux.dev, chengkaitao <chengkaitao@kylinos.cn>
Subject: Re: [PATCH v3 0/7] Prepare mutable list iterators to cache cursor
 state
In-Reply-To: <20260622040533.29824-1-kaitao.cheng@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
Date: Mon, 22 Jun 2026 11:37:29 +0300
Message-ID: <88f34c7fa5a3d1700cc8005818751d6aa31f09df@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_093755_384520_20094E5D 
X-CRM114-Status: GOOD (  11.56  )
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

On Mon, 22 Jun 2026, Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
> Add *_mutable() iterator variants for list, hlist and llist.  The new
> helpers are variadic and support both forms.  In the common case, the
> caller omits the temporary cursor and the macro creates a unique internal
> cursor with typeof(pos) and __UNIQUE_ID().  If a loop really needs an
> explicit temporary cursor, the caller can still pass it and the helper
> keeps the existing *_safe() behaviour.
>
> For example, a call site may use the shorter form:
>
>   list_for_each_entry_mutable(pos, head, member)
>
> or keep the explicit temporary cursor form:
>
>   list_for_each_entry_mutable(pos, tmp, head, member)

I'm unconvinced it's a good idea to allow two forms with macro trickery,
*especially* when it's not the last argument you can omit. I think it's
a footgun.

IMO stick with the first form only, and there'll always be the _safe
variant that can be used when the temp pointer is needed.


BR,
Jani.


-- 
Jani Nikula, Intel

