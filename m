Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F1DC4167B
	for <kexec@archiver.kernel.org>; Thu,  9 Nov 2023 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TyLHInE+Ck3an/Vvj74Fdo8KOd7FZkTJjleoRi6vpR8=; b=kWJVTJrfYso0vl
	ShR/qMIYb27tpqQ8dSQdZlO99pcILcdltdSanMs23TkqYtjQasLTOci7sZTB6F4KZBIfJ2LYV9lvc
	4zwyrxOtK+r4swLVRlpYzmXl2kQxl781Z+PBZuqWIjsM4K0BoRiFUGXPiV3sLi9D1obrxWHo0xN7L
	yIgwaF+aArzEg3419KG8x9r2kNrfIHXjd8CLHD9WpFw0JpC8ymnPlsI6QvrDhMhG6aNPsOfbHcQtl
	6XqJHjmM2CI8JCOX76vrfgyXDH+91CBHHf49nDmjjaoxvx0vPRYnF4IrrEqSZ3baoT+hmWk9fPTtV
	c6PP0sfQw9doZ+by100g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r17oL-006hz6-14;
	Thu, 09 Nov 2023 16:23:17 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0fmu-003Rbc-2f
	for kexec@lists.infradead.org;
	Wed, 08 Nov 2023 10:27:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D9993CE10A2;
	Wed,  8 Nov 2023 10:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C87C433C7;
	Wed,  8 Nov 2023 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699439274;
	bh=jPTCkhBc7PI9MxQBx8eZ6M1FUClONYHAJL7rPOuMKIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ldiga5qq8VhgdAX6zRPKPVR6J7ovztl6429iDYp8512IacCZgszC+ILd6dOXkfo4v
	 t5wfjDd6YBQ5ilv5qwESULiVtvxrBQx176CSYiN6i1sPaJghieI3M1eeMMRoOefqCf
	 O+iz2Q5HsPYzw7wCoieoHfeS8i/uuey40FGqT5Ey7fkiqKOKjRh5pmaEjsK+LSN2jS
	 Parqy+HpitkBCXQIP3xBPG8ypHcAfcQTw+ngWwR4YeRpkN+yzFew1je/X4E1KyDSU7
	 YcEeIiRAgSItLvqJJ6VNflmLmL2IsTXZ/VPvh9vwMZ30c0Fipa9GWEnTB2JFYnZQ19
	 sZXk8l/GMb4gg==
Date: Wed, 8 Nov 2023 19:27:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: <j.granados@samsung.com>
Cc: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
 josh@joshtriplett.org, Kees Cook <keescook@chromium.org>, Eric Biederman
 <ebiederm@xmission.com>, Iurii Zaikin <yzaikin@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry
 <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider
 <vschneid@redhat.com>, Petr Mladek <pmladek@suse.com>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 08/10] kprobes: Remove the now superfluous sentinel
 elements from ctl_table array
Message-Id: <20231108192741.72a341b73270d3c04d6dbc51@kernel.org>
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-8-e4ce1388dfa0@samsung.com>
References: <20231107-jag-sysctl_remove_empty_elem_kernel-v1-0-e4ce1388dfa0@samsung.com>
	<20231107-jag-sysctl_remove_empty_elem_kernel-v1-8-e4ce1388dfa0@samsung.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_022757_214157_37223485 
X-CRM114-Status: GOOD (  20.85  )
X-Mailman-Approved-At: Thu, 09 Nov 2023 08:23:16 -0800
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

On Tue, 07 Nov 2023 14:45:08 +0100
Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org> wrote:

> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel element from kprobe_sysclts

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  kernel/kprobes.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 0c6185aefaef..d049b602dd41 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -968,7 +968,6 @@ static struct ctl_table kprobe_sysctls[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> -	{}
>  };
>  
>  static void __init kprobe_sysctls_init(void)
> 
> -- 
> 2.30.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
