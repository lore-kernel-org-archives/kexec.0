Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49BDC5DF70
	for <kexec@archiver.kernel.org>; Sat, 15 Aug 2026 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=; b=ZKZrogQgun45yZ24b4WEFM4Txs
	k2Wx3ObYLm+hGgWrdXctps5PP4x8tZ3aEARr9epM9/cizyaKqb8/pX2g8r24+Di0wgFtoZhtLst9v
	eO68K4H1ijGFyY/z6ZR97ugZJPAVFSql0UFigLXAfVhvCmXxYYW8NmAbfPZu8YFF7nLX50ncbf4BQ
	qKy2lnCRW17dUUQWseQWX4TixD2bqzlK6WZZK0EVezRO21pDKzOViZ3Hbvzbo/6O0ZnzL+dHGEh40
	Ky58svbe0PmfFVMoemwqSdzLjpUmrwuljFZa3kDHvVHikRu3NHwHdGPghAup3twd9LQaXmhns0ArN
	Fx9ICwxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wv95L-00000003cx1-03eG;
	Sat, 15 Aug 2026 07:45:43 +0000
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjw2-00000005Kaw-2Hic
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 19:03:56 +0000
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-30c0a352e33so197593eec.0
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782155033; x=1782759833; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
        b=roGqLQ38+0vokF++ejoAP8imt3LFmG0M1nL/FvWjOq9slLcRp0siiAcrhqs4z0w5u2
         aicajmjW3oEjgY+NlDaCprG+030ZXPboDwaWz70hOJEdc0frzxRT18mnGWaXiGr8QpmO
         lHNasG22h4uMw98RObLIF4cmJ0Gl/qKIrF8l5WQ9oauYy3IMqX3Ohasul95z0DmqdMsp
         sw4YQJfkqme21beZy89GMLbh6NHfT1pAtCRiCK4t8QUdhZHk2C8ONopyk2bnwZogvohf
         w4WdobCtJuTeeU3LzZWlL+5kt4o7jBXayq0Sma3ig4jlWCnbnMuG9rGJzdFNcJkZcYV3
         cSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155033; x=1782759833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
        b=l6lbXV6wvEAIbmb5Bg4UHQvo3tE3Feanf2nlwx8KOTBwTPWeNBFnzcIYqdAnWwaBA7
         DtOm8ZsCjCXKE3Rfu7c+7B7EnbE/NhTcRIUhmHrahTqHexpK90UUaWxcadV8yqkPt3ok
         4x7OOZzbHm432bYStTRMGIw6qCPtLsxKOM9SxN5I6JpEDONJyr2as5UsMTijEUbUKZ8f
         3jQdC2ydnIY6sBi2NqjStmWBp05DIbCl6l1vI2NPRCOMDlvVQm8AacKLz9ZhjHs7s4yP
         C6bCtA1/IAgkb5KlVOceqE82tK4QX26r91O+TUVL4mlsBUj7ZS21jXvjcte+1qrYn+AH
         XCAA==
X-Forwarded-Encrypted: i=1; AHgh+RrX6aeqHhjRT0ac2a920Sqlit2KNwfBvRseBuDJTnidCYbDk9EMMYwGzk7Z8DZd/vqSw/ORpA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxRIhefwgP6526KNze/Sae/uG9IRgPqKbT2ZtavwGRS8Gbm/4W+
	gMI76LaxPkJoEBYHCPr45T/v2yWa3NbT8/DO5/oNgZ7t1JHjmWpfRNVU
X-Gm-Gg: AfdE7cnkuPfk/ela3m6gsvOUDigF9/JsZbLlkDRcHLoTZj0UKOsO4O+M6Cz8NrZTaB5
	HMEv46oct5JXlUIo4EXGxj3pahkcvoj0Pd+alShWZ6oP/OUVfg84v7BZc2+wevICW6RoRCQej5x
	UZR9/mNaAChFZkwYkIl1Px6NajW16rFQU4j5Z1JkBBLBkHjxYnwmZnUWh27S2uG4MLlIMtrub0T
	BBPeiRzgIS+vx887R7dRlAXyE1kaPrzCpXKOiLEQ8/vKjbC2YnJjkcdJFnO6RLRkBmirpb4mTZK
	rUVa8CbEdXE43+B/xT6pczlYIM+pxoAOLOQv0nqM5Vxycq70b5Hqc7c5jvYRbTDHNdAYcXmeGS2
	QrUoP4kOTGVQoS/GU9MKhlL60FINlYTWcyRFYknQ+2ke8l4sVUgJ5Zd9Rhqv5pRKYl+mllnOILS
	I2a3ZpVimr5Hjqxv0AW/6DYbt2m0mvhV0/U4b2TEbVWZHxxL0wVmPZ3BTBjz4f+AYZx8g=
X-Received: by 2002:a05:693c:2887:b0:30b:cc4e:6396 with SMTP id 5a478bee46e88-30c5553b105mr382073eec.7.1782155033135;
        Mon, 22 Jun 2026 12:03:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6e2:c699:67c:63fe? ([2620:10d:c090:500::1:5387])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm10549199eec.26.2026.06.22.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 12:03:52 -0700 (PDT)
Message-ID: <1979fc81ae7bdaabda8616cd9698a40ef8bbfaee.camel@gmail.com>
Subject: Re: [PATCH v3 5/7] kernel: Use mutable list iterators
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Paul Moore <paul@paul-moore.com>,
  Eric Paris <eparis@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski	 <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend	
 <john.fastabend@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner	
 <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 
 Maarten Lankhorst	 <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock	 <natalie.vock@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar	 <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim	 <namhyung@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov	 <oleg@redhat.com>, Peter
 Oberparleiter <oberpar@linux.ibm.com>, Andrew Morton	
 <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport	 <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav	 <pratyush@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Josh Poimboeuf	 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes	 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Will
 Deacon <will@kernel.org>,  Boqun Feng <boqun@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,  Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Steffen
 Klassert	 <steffen.klassert@secunet.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"	
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes	 <joelagnelf@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Juri Lelli	 <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Kees Cook <kees@kernel.org>,
 Balbir Singh <bsingharora@gmail.com>, Anna-Maria Behnsen	
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, John Stultz	
 <jstultz@google.com>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski	
 <mattbobrowski@google.com>, Nathan Chancellor <nathan@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, David Vernet	 <void@manifault.com>, Steven
 Rostedt <rostedt@goodmis.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	netdev@vger.kernel.org, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	kexec@lists.infradead.org,
 live-patching@vger.kernel.org, 	linux-modules@vger.kernel.org,
 linux-crypto@vger.kernel.org, 	linux-pm@vger.kernel.org,
 rcu@vger.kernel.org, sched-ext@lists.linux.dev, 	llvm@lists.linux.dev,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Date: Mon, 22 Jun 2026 12:03:46 -0700
In-Reply-To: <20260622042811.31684-1-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
	 <20260622042811.31684-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_120354_590925_341C86D2 
X-CRM114-Status: GOOD (  16.42  )
X-Mailman-Approved-At: Sat, 15 Aug 2026 00:45:40 -0700
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

On Mon, 2026-06-22 at 12:28 +0800, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> The safe list iteration helpers require callers to provide a temporary
> cursor even when the cursor is only used internally by the loop. This
> leaves many functions with otherwise unused variables whose only purpose
> is to satisfy the old iterator interface.
>=20
> Use the mutable list iteration helpers for those cases. The mutable
> helpers keep the same removal-safe traversal semantics, while allowing
> the temporary cursor to be internal to the macro when the caller does
> not need to observe it.
>=20
> Convert list, hlist and llist users under kernel/ where the temporary
> cursor is not used outside the iteration. Keep the explicit cursor form
> where the next entry is still needed by the surrounding code.
>=20
> No functional change intended.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Beside the fact that this does not apply,
I don't see a reason why is this needed for BPF sub-tree.

[...]

