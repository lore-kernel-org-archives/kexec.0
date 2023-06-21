Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F31C001DB
	for <kexec@archiver.kernel.org>; Wed, 28 Jun 2023 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A7Fu29udPjrjmAvMBIkUYeKThD8/2TsVp6dnlC/XloQ=; b=SUXP0UdHiblgjF
	4zbXM+FQVUlna5dcHhXPILmImp8ZXNvNjKtu2XLe+SlfrQeLGXjMmduhGLc4ZGsWa71VRozzXtTZy
	iwGsOlchqZNEwyb+PZjH8VSrsV4ItQsyWPj0lQOjH8ZfnxWT7HoTTeGFk/qpOhH759l9MbJB2KJMH
	wmfmAdDWiqpVpalH6KLgQ+u6wsu4rklI910fjZPz1UUfGugrDXh9r6WDmOfgdWsWhZR0V833U9B7D
	BaZWxyphmh0jUocKu/1xCScMPeonc2AoHpYruKWzmTECc07xNdrNxJuj6tA578gU2FU0mNjx6j6GJ
	/e/HZ+Jz4N+osLGBwttw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWuT-00Fx5f-1W;
	Wed, 28 Jun 2023 15:16:45 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBw8t-00EPRe-13
	for kexec@lists.infradead.org;
	Wed, 21 Jun 2023 11:36:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C87691FDE8;
	Wed, 21 Jun 2023 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1687347411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FQApQPgb/S6VB9crvo39szrL+RZ0B9Iq9K2WpGCiTo=;
	b=iwyLnEK1VeUWv/tmm/Nm6Cx5NbYxgFmj0mH+P5/gDg9l9WiFHQ1aqfL3EEa87DHfpr/aUI
	PhCVJRawNs68LlACkkSmFEImXna0QGgLP5xUaED+wkuZFJn4wrg4DCWfOxgJw3/ea1pY1O
	C9tLa1Flx054EBbIvKK/ApG8ncbzfFo=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 144972C141;
	Wed, 21 Jun 2023 11:36:46 +0000 (UTC)
Date: Wed, 21 Jun 2023 13:36:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joel Granados <j.granados@samsung.com>
Cc: mcgrof@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Will Deacon <will@kernel.org>,
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
Message-ID: <ZJLgzo1GuykDV8fd@alley>
References: <20230621091000.424843-1-j.granados@samsung.com>
 <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
 <20230621091000.424843-9-j.granados@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230621091000.424843-9-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_043655_526479_942A066B 
X-CRM114-Status: GOOD (  20.34  )
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

On Wed 2023-06-21 11:09:57, Joel Granados wrote:
> In order to remove the end element from the ctl_table struct arrays, we
> explicitly define the size when registering the targes. We add a size
> argument to the register_sysctl_init call and pass an ARRAY_SIZE for all
> the callers.

This does not explain the motivatin why the end element is removed.

I agree with Jiri that saving 9k is a questionable gain. According to
the cover letter it saved 0,00%. It is because it saved 9k with allyes
config which produces huge kernel. IMHO, the 9k might be interesting
only for a tiny kernel. But I guess that it would safe much less
bytes there.

And the code with the added ARRAY_SIZE() parameter looks worse than before.

> diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
> index c228343eeb97..28f37b86414e 100644
> --- a/kernel/printk/sysctl.c
> +++ b/kernel/printk/sysctl.c
> @@ -81,5 +81,6 @@ static struct ctl_table printk_sysctls[] = {
>  
>  void __init printk_sysctl_init(void)
>  {
> -	register_sysctl_init("kernel", printk_sysctls);
> +	register_sysctl_init("kernel", printk_sysctls,
> +			     ARRAY_SIZE(printk_sysctls));
>  }

Is register_sysctl_init() still ready to handle the last empty element,
please? I am not in Cc on the related patches.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
