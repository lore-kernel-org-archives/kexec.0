Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUZlW-0090mz-Vu
 for kexec@lists.infradead.org; Thu, 08 Apr 2021 18:52:33 +0000
Received: by mail-pg1-x52d.google.com with SMTP id t22so2075589pgu.0
 for <kexec@lists.infradead.org>; Thu, 08 Apr 2021 11:52:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <YG7xjbIEmrCco14F@gunter>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-3-swboyd@chromium.org> <YG7xjbIEmrCco14F@gunter>
Subject: Re: [PATCH v3 02/12] buildid: Stash away kernels build ID on init
From: Stephen Boyd <swboyd@chromium.org>
Date: Thu, 08 Apr 2021 11:52:27 -0700
Message-ID: <161790794728.3790633.1727402698174847953@swboyd.mtv.corp.google.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jessica Yu <jeyu@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Evan Green <evgreen@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org

Quoting Jessica Yu (2021-04-08 05:05:33)
> +++ Stephen Boyd [30/03/21 20:05 -0700]:
> >+/**
> >+ * init_vmlinux_build_id - Get the running kernel's build ID
> >+ *
> >+ * Return: Running kernel's build ID
> >+ */
> 
> Hm, init_vmlinux_build_id() doesn't return anything, so this comment is
> not accurate - maybe "Get the running kernel's build ID and store it in
> vmlinux_build_id"?
> 
> >+void __init init_vmlinux_build_id(void)

Thanks! I've fixed it for the next round.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
