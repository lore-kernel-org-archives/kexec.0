Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F556EB64DC
	for <kexec@archiver.kernel.org>; Wed, 28 Jun 2023 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1I+cBUX0uBxETIVbw69fbKdfYSXMD9reEO3JmPD3YFQ=; b=3HSHDdPl9V+IJ3
	ySK22MFQheejiJ4pxsYoVIS2wZQ5TWGHyr52Ap8zfd6Orq7YDH0chOCerH7PzmEsQ0wVCz9oJ6ktQ
	OlJ2JHixXaFnY/i9a7aLABxxnSQtw0vINazAhYUSjx+a8UTNkmvSjFwINo9gHwlIUDR0MwBuREMEJ
	8wvC7o+bOTX+8fE+qxC3C/v2UNpT707HiKu4Xb2YSf2YyAyRnZ6Wc2UKjWuatlmPLXZvG+3pZm/DH
	KGDePaVFreq9gYVVIYf4Faj+OKQmsm9bovf5dLcENyPNfRq3UJq27HWKAzSirQ6FDxXxZ6XAGM0Qr
	4ij5EyV8IbiG0acqXx9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWua-00FxLg-1o;
	Wed, 28 Jun 2023 15:16:52 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCBsn-00Gmgq-1s
	for kexec@lists.infradead.org;
	Thu, 22 Jun 2023 04:25:22 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so9225398e87.2
        for <kexec@lists.infradead.org>; Wed, 21 Jun 2023 21:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687407919; x=1689999919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5vC2aRsA2WDjAiqv/C0BR7ctU6hTo76uwUZaC8vGUs=;
        b=PScI4sTPdQCIv0tU01sYyjGpfzxJTy5KJSlMclRN0k/zRnxqgSRhZXjP5oBKghLoZq
         6uChsyYjeNRd9f2ByvqYZRhT/qvXAOFoxaGMroKoK4Zb54+HDOpkbuYS5xrSpgK/kS3h
         H33pMc1jSw37SGEP4YjdlgGxvQVGJapYYonreUUKlydomBscwLjiHjDdFqqjI5TDJ/xF
         LUwecjxkgny6eGieuZgfgc4CfJxvT74gXbNBacOqqoiqbYrNeASj+f+tWTXjKfPdYB1w
         sUDAbxPWO3ZFCxANyFOvGTSzg7zegNK3CDNm7tZUUCEP+Q5U0qJrKh+Ydjuv568PkfpA
         4YiA==
X-Gm-Message-State: AC+VfDyn+Navbr9l5GnnJQPwH3EYRj+iVYn5WkQQtJvsQnbdiBk8Lcq9
	vqd1EtUGdDNxcsAckUpXwFM=
X-Google-Smtp-Source: ACHHUZ6mLLpZ2jzgBbisqW8BsQ34AJIZtXtyRLGlK/Pv18m3vLOsDnG3vORq9yee5CR+W4060ihrFA==
X-Received: by 2002:a05:6512:313c:b0:4f9:566f:1aab with SMTP id p28-20020a056512313c00b004f9566f1aabmr3597524lfd.29.1687407919067;
        Wed, 21 Jun 2023 21:25:19 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id y7-20020a1c4b07000000b003f17848673fsm6553494wma.27.2023.06.21.21.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 21:25:18 -0700 (PDT)
Message-ID: <68038b83-3221-e351-909c-7f2722b612df@kernel.org>
Date: Thu, 22 Jun 2023 06:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/11] sysctl: Add size to register_sysctl_init
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>
Cc: mcgrof@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
 <36fae2b0-4cd2-58b5-cc12-9abdd5ce235b@kernel.org>
 <20230621131147.c3jegl4hgjplcrpu@localhost>
From: Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230621131147.c3jegl4hgjplcrpu@localhost>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_212521_641080_37ECCC6C 
X-CRM114-Status: GOOD (  18.18  )
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

On 21. 06. 23, 15:11, Joel Granados wrote:
> On Wed, Jun 21, 2023 at 11:56:03AM +0200, Jiri Slaby wrote:
>> On 21. 06. 23, 11:09, Joel Granados wrote:
>>> In order to remove the end element from the ctl_table struct arrays, we
>>> explicitly define the size when registering the targes. We add a size
>>> argument to the register_sysctl_init call and pass an ARRAY_SIZE for all
>>> the callers.
>>
>> Hi, I am missing here (or in 00/00) _why_ you are doing that. Is it by a
> Not sure what happened. I used the kernels get_maintainers.pl script
> together with git-send-email. These are my settings:
> 
> "
> tocmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --m --nol --nor"
> cccmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --l --r --nom"
> "
> 
> Could it be that there is an error in MAINTAINERS?

Sorry, I don't see what you are asking about. I was asking about 
motivation behind the series. That is a must in commit logs.

thanks,
-- 
js
suse labs


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
