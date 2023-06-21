Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD31CEB64DA
	for <kexec@archiver.kernel.org>; Wed, 28 Jun 2023 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3iTUP+Byr8vGd0qWRRVSwHB/wpQYveB0+DXqtXpZ2n0=; b=qivpgOzomEd2Qq
	FWgvuTXPruBjPsAYaA9wELrbq91pimnKsjUmUZPou40kh/Ck8FoY8DT37QO7VyHPm16gbBYd5k9Ly
	yN1Adu6FXhhHU0kDunDnxwvZiDaYQ+WhW9s4rT2zNU6u1ZLDCIK+K9LjWZWCnl0AhzWaaIqoxrNCP
	Smlo58BNIDAp3QyZ+mmsF2DNPBUlsmgZiMZ9aQxa1DOT9Xj2zD+M1lYq67xxoMjPbHcZJgN+edo+b
	RkLuAhyurPrsUurSP8dtYQcSmb/Jvq6CQPvA+arJW0U1wKuQZjmbE7Ijx9Nv1rrLJVCFv4oSwLp2J
	bRT9RspG3s9lovW09m0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWuR-00Fx3G-1o;
	Wed, 28 Jun 2023 15:16:43 +0000
Received: from mail-lj1-f175.google.com ([209.85.208.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBuZN-00Dwzu-1U
	for kexec@lists.infradead.org;
	Wed, 21 Jun 2023 09:56:12 +0000
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b477e9d396so47609601fa.3
        for <kexec@lists.infradead.org>; Wed, 21 Jun 2023 02:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341367; x=1689933367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QfqFAs+LUbqWKQg3CDgDFj/Ai/EFvoPAUEVH6zEuh0=;
        b=lq2XYS4jaA7SYZUN1onMpvSRChD+TvtOIFNWYGY+pQVUU/1Lrc96DduZE7k5PnrGPV
         4EWV8E3+Oe8y2dwYkaJUA7r+FnWZI8dOoMdbhyDmzqkikfRui7ftuSaGFT1czIiJIXiD
         IJShxAl29bCG+WkFVX42RKBfOn6SXQ7J6jVlAuh3zY9Ih4W33bHwJgXRNEfbLY4tcNYY
         Axojj/cTPDFFCdHkqCIXuv/+0NG6jbXmUHYuhreEjyTn4QwCL2aEBj+cUhs0f+lij2P3
         vGrnUDO/jfbV68JweP2RVOWgDIkkem9XvKjmOeF79p/N3QrfvsJ/DPFg1NDoAHSm5Drw
         y9ig==
X-Gm-Message-State: AC+VfDwjC9PtHFIVCeEJG4po0GHwyPqssss1ejhoUzx+MOQJI0md/gHh
	p2vJgnGIcqjPTcAbLRHVF90=
X-Google-Smtp-Source: ACHHUZ4GQBsPStePkHDKNlzEaMWr+Bp+ebV1Ur4N9HjkC8j8Qd1kDy/CWY6Orh1D9sVCHniBDQ4DcQ==
X-Received: by 2002:a2e:9846:0:b0:2b4:737c:e316 with SMTP id e6-20020a2e9846000000b002b4737ce316mr7027828ljj.14.1687341366842;
        Wed, 21 Jun 2023 02:56:06 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bca54000000b003f80e81705asm4477120wml.45.2023.06.21.02.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 02:56:06 -0700 (PDT)
Message-ID: <36fae2b0-4cd2-58b5-cc12-9abdd5ce235b@kernel.org>
Date: Wed, 21 Jun 2023 11:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/11] sysctl: Add size to register_sysctl_init
To: Joel Granados <j.granados@samsung.com>, mcgrof@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Theodore Ts'o <tytso@mit.edu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Benjamin LaHaise <bcrl@kvack.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
 Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Balbir Singh <bsingharora@gmail.com>,
 Eric Biederman <ebiederm@xmission.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Amir Goldstein <amir73il@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, John Ogness <john.ogness@linutronix.de>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Mark Rutland <mark.rutland@arm.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, kexec@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20230621091000.424843-1-j.granados@samsung.com>
 <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
 <20230621091000.424843-9-j.granados@samsung.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230621091000.424843-9-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_025609_499228_D979D6DD 
X-CRM114-Status: GOOD (  12.52  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 21. 06. 23, 11:09, Joel Granados wrote:
> In order to remove the end element from the ctl_table struct arrays, we
> explicitly define the size when registering the targes. We add a size
> argument to the register_sysctl_init call and pass an ARRAY_SIZE for all
> the callers.

Hi, I am missing here (or in 00/00) _why_ you are doing that. Is it by a 
chance those saved 9k? I hope not.

thanks,
-- 
js
suse labs


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
