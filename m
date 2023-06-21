Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21EAEB64DD
	for <kexec@archiver.kernel.org>; Wed, 28 Jun 2023 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xd2ztqKJQkDNKh1MfqnrAGshNxeJqn8lMBtVVuL3xL0=; b=0KNSGf7PnTIOof
	3VatT/lZMRciEieV6b+mOCue+lD8OUsFKaNIU7h+kNbsHcQYiO8Wbsr9EmDER8O7YJ1lLm+UGXW1L
	B3CMzFgUjBpH++J4KWIcubsBKuD1pQhz3lF7leAkK2T5YnJ2xEHCn2Tq9iz/G3BE8FMdWCN+3KW5r
	iY+rbIDzqSR/Wjvr7pv1GpeDsmvCVC83QicY52WDn8/9fNZLAI3kCk9gZ7IsGvQMp5kuCeQ2Z+xGB
	LpHLxr0grqwjC3VX/TqmsiVmfwuq1eYVJW5KYmQltDrspOLMCAMy56Ox1NwKQEniXl+eA/bdDqQ9h
	x4ac2Ug58K//6v/KxweA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWuS-00Fx3d-0V;
	Wed, 28 Jun 2023 15:16:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBvNe-00EDGo-1t
	for kexec@lists.infradead.org;
	Wed, 21 Jun 2023 10:48:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DADB161501;
	Wed, 21 Jun 2023 10:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D79BC433C8;
	Wed, 21 Jun 2023 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1687344485;
	bh=vQW8SpknqhfYsLd//ycoQUF1XEoKmVOh7WQXK7qiNdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3axtBl09Uj+gGhVy84WdPlv59/aPeu632cEchdYe8a/k5iJl0+IXsbF+vopEWDYq
	 NwenFITRTKDLMCVF8CzPXY6p9Hti1Q2TT7eK4GXO8pT0fRmZYBTPxe1ckDw7AxLZe2
	 wT9Wmou6gxTC0sVGsza4KPz7hQ7x6JjyXWzC0NK4=
Date: Wed, 21 Jun 2023 12:47:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joel Granados <j.granados@samsung.com>
Cc: mcgrof@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Iurii Zaikin <yzaikin@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Amir Goldstein <amir73il@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, kexec@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/11] sysctl: Add size to register_sysctl_init
Message-ID: <2023062150-outbound-quiet-2609@gregkh>
References: <20230621091000.424843-1-j.granados@samsung.com>
 <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
 <20230621091000.424843-9-j.granados@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230621091000.424843-9-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_034806_745005_2BE0A3A4 
X-CRM114-Status: GOOD (  13.18  )
X-Mailman-Approved-At: Wed, 28 Jun 2023 08:16:38 -0700
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

On Wed, Jun 21, 2023 at 11:09:57AM +0200, Joel Granados wrote:
>  static int __init random_sysctls_init(void)
>  {
> -	register_sysctl_init("kernel/random", random_table);
> +	register_sysctl_init("kernel/random", random_table,
> +			     ARRAY_SIZE(random_table));

As mentioned before, why not just do:

#define register_sysctl_init(string, table)	\
	__register_sysctl_init(string, table, ARRAY_SIZE(table);

or something like that?

That way no callers need to change AND you prevent the size from ever
being incorrect?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
