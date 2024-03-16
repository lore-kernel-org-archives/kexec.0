Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BFDCD1283
	for <kexec@archiver.kernel.org>; Wed, 27 Mar 2024 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YximCmTfkZePKjEy9ddMvKSHIlwqknCDx/Y7O0b+Y9Q=; b=ztx08QNOgLfaiz
	zb0DHSzSiSgSUmnJK6oJGpgmaappPpfz5pGlPkgF3Zr7vTQCojKeOoKndguZcHwTtCYvKdNL68wx8
	OHPpBWRLW4QURaLPgkTsUJKHcLhjgNikjLoIe6J/iGUnSnBlw/frmoWv55il5DWOdueCR5l4NSoSo
	Rp3cLyrLdglmx0NI2iAfoEYdcLnWCgyvYJyDsE0yocsd4EVpd+3aba+9v+L9q3JAWFPGLrFZh29sx
	RpanpCYm/0yG0jxL9PFbk1JfmdsnG4nHdW3SGmb8DB4Rei9Xb/NCGWVcPssdUnHVCDjy11FLg/xkz
	bZ/urUzv84UQZfeOX2nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpYYb-0000000Ahhj-0ZrP;
	Wed, 27 Mar 2024 19:03:29 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlKAK-000000029WG-3I7j
	for kexec@lists.infradead.org;
	Sat, 16 Mar 2024 02:52:58 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1def59b537cso8483605ad.2
        for <kexec@lists.infradead.org>; Fri, 15 Mar 2024 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1710557573; x=1711162373; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBoX08MQ+GnGsn3Ys1XDLWs0vSpU6QZ104y6JQ1iJRA=;
        b=NV8GubJHDTOWZdk3e2sMzrDyKx/yM5PBLpBDeTHJC1VZEmAptjdBR+WJo7oWR/GZWm
         /oQf2NimPVQ0Pq94NXbO+vOBqf0ppulXtJBQNyWFDCPxLy4Msg+z1d6Ddzi3WgWsD5Io
         7GeYwZikhQOXKBWu4gbH6DnEPxX42teh5GT/32HmWFnmd3bMW4hbQtTXVhKugIBgOeFS
         eeBivFAw5G3N1rq+Z73T9mG9DyxOJ1f4XHrR7Hokga3VAv868aACvPbCI0qClmKrR4vF
         Ykg47Uq1zNqlYypSrat/V2QLyaYkmJ5J7omUe9rA0lxI8yZwL9PKrjiLwaIxaFLNK3WY
         5P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710557573; x=1711162373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBoX08MQ+GnGsn3Ys1XDLWs0vSpU6QZ104y6JQ1iJRA=;
        b=ZXrmLEJ5MKgJWDNCrfxsSQXihBD6S70ZmqQkm2LoMgUHQB6gE2SgRWk1OlBflQCUGI
         A7Gj9xmsEYTNjWWQqR8d21OLZYlCQUfc68AC8rQ6AyYvzGjiJUE2NkafX1iHx38YkiX2
         DHurtu4NhcdjWepzJE51qYkzocK1YsQpkLUO0SX1Cfob+eCswi+bcK6vpXH3UZ0oH1Uy
         fiJL3POur/c+mhuj/ZWEgA+uZICtEHXV7uK53tYtTfFpXJ1XBdIDY662q4MU0mkrxqZ4
         nkRJSgACARGeo110i3gW+yxDkElz0bBt2rvk69QLfboehyLIeQbP30htWJavBCilGk9c
         hjuw==
X-Forwarded-Encrypted: i=1; AJvYcCX9C9cwbDncs3s3/pTEZiGmBIQnc6ObdmhQjPva+7f8etqTKGzYM7gZxS4FWVdqvXaVRYA+o7Y11tSseGO6a+RdiDhF/4UXCWyT
X-Gm-Message-State: AOJu0Yw4l9ZiYfoOoEj9/qlNIYRRa+rwxSK707oaiqZ+nwp1oKVUGg6J
	9FGlUYfZuAJtl31GBeBQrUPqM+hEOZUUze5Z1OMEqaenuOnnCLgxuXMlV3ge2f8=
X-Google-Smtp-Source: AGHT+IF+mhHYlAObRzpfXYn3IGnPDczeVjZaH7QVUqvtIq9UdyOULCBCqzY79zAwu/GemLxZ182Fng==
X-Received: by 2002:a17:903:2446:b0:1dd:9cb3:8f96 with SMTP id l6-20020a170903244600b001dd9cb38f96mr6055795pls.42.1710557572964;
        Fri, 15 Mar 2024 19:52:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-185-123.pa.nsw.optusnet.com.au. [49.180.185.123])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b001dddbb58d5esm4736209pln.109.2024.03.15.19.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 19:52:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rlKAC-002Wnj-2F;
	Sat, 16 Mar 2024 13:52:48 +1100
Date: Sat, 16 Mar 2024 13:52:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Luis Chamberlain <mcgrof@kernel.org>, Joel Granados <j.granados@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Phillip Potter <phil@philpotter.co.uk>, Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Balbir Singh <bsingharora@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Alexander Popov <alex.popov@linux.com>, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kexec@lists.infradead.org, bridge@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 11/11] sysctl: treewide: constify the ctl_table argument
 of handlers
Message-ID: <ZfUJgML8tk6RWqOC@dread.disaster.area>
References: <20240315-sysctl-const-handler-v1-0-1322ac7cb03d@weissschuh.net>
 <20240315-sysctl-const-handler-v1-11-1322ac7cb03d@weissschuh.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240315-sysctl-const-handler-v1-11-1322ac7cb03d@weissschuh.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240315_195257_158601_5EF6E3AC 
X-CRM114-Status: GOOD (  28.74  )
X-Mailman-Approved-At: Wed, 27 Mar 2024 11:01:40 -0700
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Mar 15, 2024 at 09:48:09PM +0100, Thomas Wei=DFschuh wrote:
> Adapt the proc_hander function signature to make it clear that handlers
> are not supposed to modify their ctl_table argument.
> =

> This is a prerequisite to moving the static ctl_table structs into
> .rodata.
> By migrating all handlers at once a lengthy transition can be avoided.
> =

> The patch was mostly generated by coccinelle with the following script:
> =

>     @@
>     identifier func, ctl, write, buffer, lenp, ppos;
>     @@
> =

>     int func(
>     - struct ctl_table *ctl,
>     + const struct ctl_table *ctl,
>       int write, void *buffer, size_t *lenp, loff_t *ppos)
>     { ... }

Which seems to have screwed up the formatting of the XFS code...

> diff --git a/fs/xfs/xfs_sysctl.c b/fs/xfs/xfs_sysctl.c
> index a191f6560f98..a3ca192eca79 100644
> --- a/fs/xfs/xfs_sysctl.c
> +++ b/fs/xfs/xfs_sysctl.c
> @@ -10,12 +10,11 @@ static struct ctl_table_header *xfs_table_header;
>  =

>  #ifdef CONFIG_PROC_FS
>  STATIC int
> -xfs_stats_clear_proc_handler(
> -	struct ctl_table	*ctl,
> -	int			write,
> -	void			*buffer,
> -	size_t			*lenp,
> -	loff_t			*ppos)
> +xfs_stats_clear_proc_handler(const struct ctl_table *ctl,
> +			     int			write,
> +			     void			*buffer,
> +			     size_t			*lenp,
> +			     loff_t			*ppos)

... because this doesn't match any format I've ever seen in the
kernel. The diff for this change shold be just:

@@ -10,7 +10,7 @@ static struct ctl_table_header *xfs_table_header;
 #ifdef CONFIG_PROC_FS
 STATIC int
 xfs_stats_clear_proc_handler(
-	struct ctl_table	*ctl,
+	const struct ctl_table	*ctl,
 	int			write,
 	void			*buffer,
 	size_t			*lenp,

>  {
>  	int		ret, *valp =3D ctl->data;
>  =

> @@ -30,12 +29,11 @@ xfs_stats_clear_proc_handler(
>  }
>  =

>  STATIC int
> -xfs_panic_mask_proc_handler(
> -	struct ctl_table	*ctl,
> -	int			write,
> -	void			*buffer,
> -	size_t			*lenp,
> -	loff_t			*ppos)
> +xfs_panic_mask_proc_handler(const struct ctl_table *ctl,
> +			    int			write,
> +			    void			*buffer,
> +			    size_t			*lenp,
> +			    loff_t			*ppos)
>  {
>  	int		ret, *valp =3D ctl->data;
>  =

> @@ -51,12 +49,11 @@ xfs_panic_mask_proc_handler(
>  #endif /* CONFIG_PROC_FS */
>  =

>  STATIC int
> -xfs_deprecated_dointvec_minmax(
> -	struct ctl_table	*ctl,
> -	int			write,
> -	void			*buffer,
> -	size_t			*lenp,
> -	loff_t			*ppos)
> +xfs_deprecated_dointvec_minmax(const struct ctl_table *ctl,
> +			       int			write,
> +			       void			*buffer,
> +			       size_t			*lenp,
> +			       loff_t			*ppos)
>  {
>  	if (write) {
>  		printk_ratelimited(KERN_WARNING

And these need fixing as well.

A further quick glance at the patch reveals that there are other
similar screwed up conversions as well.

> diff --git a/kernel/delayacct.c b/kernel/delayacct.c
> index 6f0c358e73d8..513791ef573d 100644
> --- a/kernel/delayacct.c
> +++ b/kernel/delayacct.c
> @@ -44,8 +44,9 @@ void delayacct_init(void)
>  }
>  =

>  #ifdef CONFIG_PROC_SYSCTL
> -static int sysctl_delayacct(struct ctl_table *table, int write, void *bu=
ffer,
> -		     size_t *lenp, loff_t *ppos)
> +static int sysctl_delayacct(const struct ctl_table *table, int write,
> +			    void *buffer,
> +			    size_t *lenp, loff_t *ppos)
>  {
>  	int state =3D delayacct_on;
>  	struct ctl_table t;

Like this.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 724e6d7e128f..e2955e0d9f44 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -450,7 +450,8 @@ static void update_perf_cpu_limits(void)
>  =

>  static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
>  =

> -int perf_event_max_sample_rate_handler(struct ctl_table *table, int writ=
e,
> +int perf_event_max_sample_rate_handler(const struct ctl_table *table,
> +				       int write,
>  				       void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int ret;

And this.

> @@ -474,8 +475,10 @@ int perf_event_max_sample_rate_handler(struct ctl_ta=
ble *table, int write,
>  =

>  int sysctl_perf_cpu_time_max_percent __read_mostly =3D DEFAULT_CPU_TIME_=
MAX_PERCENT;
>  =

> -int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
> -		void *buffer, size_t *lenp, loff_t *ppos)
> +int perf_cpu_time_max_percent_handler(const struct ctl_table *table,
> +				      int write,
> +				      void *buffer, size_t *lenp,
> +				      loff_t *ppos)
>  {
>  	int ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  =


And this.

> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index b2fc2727d654..003f0f5cb111 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -239,9 +239,10 @@ static long hung_timeout_jiffies(unsigned long last_=
checked,
>  /*
>   * Process updating of timeout sysctl
>   */
> -static int proc_dohung_task_timeout_secs(struct ctl_table *table, int wr=
ite,
> -				  void *buffer,
> -				  size_t *lenp, loff_t *ppos)
> +static int proc_dohung_task_timeout_secs(const struct ctl_table *table,
> +					 int write,
> +					 void *buffer,
> +					 size_t *lenp, loff_t *ppos)
>  {
>  	int ret;
>  =


And this.

> diff --git a/kernel/latencytop.c b/kernel/latencytop.c
> index 781249098cb6..0a5c22b19821 100644
> --- a/kernel/latencytop.c
> +++ b/kernel/latencytop.c
> @@ -65,8 +65,9 @@ static struct latency_record latency_record[MAXLR];
>  int latencytop_enabled;
>  =

>  #ifdef CONFIG_SYSCTL
> -static int sysctl_latencytop(struct ctl_table *table, int write, void *b=
uffer,
> -		size_t *lenp, loff_t *ppos)
> +static int sysctl_latencytop(const struct ctl_table *table, int write,
> +			     void *buffer,
> +			     size_t *lenp, loff_t *ppos)
>  {
>  	int err;
>  =


And this.

I could go on, but there are so many examples of this in the patch
that I think that it needs to be toosed away and regenerated in a
way that doesn't trash the existing function parameter formatting.

-Dave.
-- =

Dave Chinner
david@fromorbit.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
