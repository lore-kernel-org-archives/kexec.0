Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55298EB64D7
	for <kexec@archiver.kernel.org>; Wed, 28 Jun 2023 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=26S2v+zoj9dyatCZ5ye2qgmBsBiza9qaSSjBw0DlNCc=; b=CgR6BAG7y384xA
	KKzFXX+YsQbj0aXAw7jD8W7XfXfD55i531OPGx3NNP8JQEpD9NYXMLTA7SEaitMQwZzpmkUSYMtsh
	X5uX5DuNFcyibhR8NP0UMxh7+227+wTKRpG/clkLFUYCHpAiGFDUccV8YIu3N79PspInI6EMIvtNk
	j9CfNuoAF3T2n3vrRUFrmlP+/z9/rMsq/v9FwW4RyLWaqxt5/kY3H/5UebInj2di379nQcv2ULolO
	tW0Ij1QCQ76E8T4dzxOHHM63SUCNkboDYTudxoFibIbdQo9w1PN7ZzALGit8S+hi5NdOwpsXQdKcn
	wq/5aXG6b0pQXlnHE5nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWuZ-00FxKP-0t;
	Wed, 28 Jun 2023 15:16:51 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCBpS-00GmDs-1e
	for kexec@lists.infradead.org;
	Thu, 22 Jun 2023 04:21:57 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so4616961f8f.0
        for <kexec@lists.infradead.org>; Wed, 21 Jun 2023 21:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687407713; x=1689999713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ECnfbr1yMldiaqGJ4AwBQXH8Qu2uEGTBBXNGiQr9KY=;
        b=AzYFuuHT7s2KuQuXN3ZtpFIGzH8njq194YPbhSA7fgzrMxDVN48mrn6YXZI10Ie3t7
         O/ChLz77bCvZyrp0F/v0KnXkRivIdPkOuRFZBiYJ3gooPaO+zwoc2zKUN2knwzbL1rt6
         BhHJMCIyy9X2Q7ChZ99e8D3Dz51hGVewcXnhQge2o9btSmt2cVHJQ5xM8C5QwkHfcVtj
         dM0BQd/b4bnpoOQJ5c0hr1Nbl6yOz/Sn2BQx1C7SsrOzpf0ruDhO56PGZtk+cEr20Zdx
         mawgi29puxQBXXUx63waTPO3kWKugzjvIXu66fTOfPmaVpQ5mr/pYGe9PKk3ZdZgCuBo
         SzCA==
X-Gm-Message-State: AC+VfDwxBmnEIMzTZKHdamT2VL0Bb9wMngrzs+IPTH13cSS4cqEV3dif
	qeVQQ8zFwY/P9c28PKg4jAE=
X-Google-Smtp-Source: ACHHUZ6noBUR8iTvT8VR1EETx/SJbcA6a56KL+Jlcz/+OUxvfjHqkrQVqSA29+PLsepDYKMNhlEycQ==
X-Received: by 2002:a05:6000:10ce:b0:312:9eb6:33da with SMTP id b14-20020a05600010ce00b003129eb633damr17577wrx.20.1687407712404;
        Wed, 21 Jun 2023 21:21:52 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d604a000000b0031272fced4dsm5942680wrt.52.2023.06.21.21.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 21:21:51 -0700 (PDT)
Message-ID: <fc37eccc-b9b3-d888-6b57-78cd61986a11@kernel.org>
Date: Thu, 22 Jun 2023 06:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/11] sysctl: Add size to register_sysctl_init
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: mcgrof@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
 "Serge E. Hallyn" <serge@hallyn.com>, "H. Peter Anvin" <hpa@zytor.com>,
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
 <2023062150-outbound-quiet-2609@gregkh>
 <20230621131552.pqsordxcjmiopciq@localhost>
From: Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230621131552.pqsordxcjmiopciq@localhost>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_212154_578723_DE5AE3B4 
X-CRM114-Status: GOOD (  13.38  )
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

On 21. 06. 23, 15:15, Joel Granados wrote:
> On Wed, Jun 21, 2023 at 12:47:58PM +0200, Greg Kroah-Hartman wrote:
>> On Wed, Jun 21, 2023 at 11:09:57AM +0200, Joel Granados wrote:
>>>   static int __init random_sysctls_init(void)
>>>   {
>>> -	register_sysctl_init("kernel/random", random_table);
>>> +	register_sysctl_init("kernel/random", random_table,
>>> +			     ARRAY_SIZE(random_table));
>>
>> As mentioned before, why not just do:
>>
>> #define register_sysctl_init(string, table)	\
>> 	__register_sysctl_init(string, table, ARRAY_SIZE(table);
> Answered you in the original mail where you suggested it.

I am curious what that was, do you have a link?

-- 
js
suse labs


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
