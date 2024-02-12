Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF4AC4829C
	for <kexec@archiver.kernel.org>; Mon, 12 Feb 2024 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ysTlKZMjUl02Dgf0qSyQ9mXQS7eHmGMU9TLBZ7fiQsQ=; b=TZLWPlMUWI19Rob2LQfiZd0RyM
	UpRccC5pl+roJ2q7Mfqn+n/NmLO6S4CzkLcBh7E7lV1zMwzUEq9H15V4nuC8J6X/5mo5kJzTZLxLr
	me4/YaSGitbeaCphOALm1pNpEzyfDKf9Bdk7/EUXA4Zq5eqzZ6DL3fySGi5u4AV5cgsR9gjDiz5gu
	bvclBMJm1XKYooFWnBod2fZJLuNVfbRZ88bBS/J0562aZYQIhuzrOeCg6w7qqV2NKvzk9hZ+4SsmC
	IeLGNTl8jRCMvB0vlkFEWMYqyMDhs9ylb6FF6XhEqMtOrlpVw71yF954XWivaeqvGAaa7+F43SGHF
	CXK0KFAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZZTa-00000006Emd-4Az6;
	Mon, 12 Feb 2024 16:48:14 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZZTY-00000006Em1-0W1D
	for kexec@lists.infradead.org;
	Mon, 12 Feb 2024 16:48:13 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d9df9a3ef3so34388985ad.0
        for <kexec@lists.infradead.org>; Mon, 12 Feb 2024 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707756490; x=1708361290; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUtPRvYIVmTUqwi/RS8nZP0n6OBVGAfBS9HtWdoYT7c=;
        b=cM0VUsHDkoytGKbwAjgN/l0hXfE+wlFurOu6sOLHIJVW6CElOUrb9ZPKUFbno9XN13
         i+SwG74KY2jOI8K91krL96siLQg4yBe8rSmfj65zReezV87Wtkfcwhlcw+MJDBMHWWBZ
         5lZlmSio1Bjg7D48E8o1o2BPrUEOWI8VAkgfW5nFlfCDR+Dj9+NffkdOZoGcEdVECmdD
         6IkaqgjK8tKKvnwd3KWy/uvv2SzGliWRQ0kCE+J00pCZQ20niVVKAddGvLfkSCn0omRy
         J0C8sEY0AK5XkbX2Kms5W1Nr7FPUrsbHl0Kj5M4ok/rTJdUpgqf3hvN4lvbGtdg2wk2e
         AAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756490; x=1708361290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUtPRvYIVmTUqwi/RS8nZP0n6OBVGAfBS9HtWdoYT7c=;
        b=G39WPGPqmcRt6pyyQdDuy6YtWjtThiYdSulwWCiHY9bu4xsh89KKyOxz7AI4QPKI1A
         wv9rhe7jVkOmXHaFvYvIAAG4KZNxLgUldPAhkpS83Xub4uHMliUuyNEkQNVW14a/jQ1o
         pSXNnwFw6YR/eI9LKLvDnWc8CQTtvN1VuF0kN6469T+5M682iItgBSeYgVkP6ngUhcEH
         YbrOlmNpzNOqdek9m6pq8lm2sZNR/wkiqjexYJj46DwwKGc2tgD0+dyBMAEdyQjr4MHB
         /0P0AvIYcRicIYJGgm2shuMA4dGTPCwLU8XSlFW82F51jsLoctzQY5/IrH6nGzNnTiKM
         2T8A==
X-Gm-Message-State: AOJu0YyqJi6LEV5jKGzMSivgglfXTh996FD/i9eWZ8HAM5EY81Pu/1lF
	mHxNQaqAFd4W3ENEofLJJCshffmn6YTrEQcvTigeKdM2Ghl9soOHDqnT2tdb7Y61qQ==
X-Google-Smtp-Source: AGHT+IEYSGe33b1aNwrUH4ZgJdpAOKjNzhg0/+62Nd/4wOims16WFlsLyx5fXpvJNxl98RWMCIFWgPo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:191:b0:1da:16ec:a2 with SMTP id
 z17-20020a170903019100b001da16ec00a2mr156079plg.12.1707756490365; Mon, 12 Feb
 2024 08:48:10 -0800 (PST)
Date: Mon, 12 Feb 2024 08:48:08 -0800
In-Reply-To: <ZcnaW5hB8y3da3bI@krava>
Mime-Version: 1.0
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <ZcZ6myvln-v0Y98S@google.com> <ZccAyalp+NyKQoGp@MiWiFi-R3L-srv> <ZcnaW5hB8y3da3bI@krava>
Message-ID: <ZcpLyKDulwlrhGd1@google.com>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
From: Stanislav Fomichev <sdf@google.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org, 
	Kexec-ml <kexec@lists.infradead.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_084812_185965_CD1E693C 
X-CRM114-Status: GOOD (  17.95  )
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

On 02/12, Jiri Olsa wrote:
> On Sat, Feb 10, 2024 at 12:51:21PM +0800, Baoquan He wrote:
> > On 02/09/24 at 11:18am, Stanislav Fomichev wrote:
> > > On 02/09, Hari Bathini wrote:
> > > > With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> > > > to the below warning:
> > > > 
> > > >   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> > > > 
> > > > Fix it by using the appropriate #ifdef.
> > > 
> > > Same question here: how did you find this particular kconfig option
> > > (CONFIG_CRASH_DUMP) to use? Looking at the code, crash_kexec is defined
> > > in kernel/kexec_core.c and it's gated by CONFIG_KEXEC_CORE. So the
> > > existing ifdef seems correct?
> > 
> > This patch is based on the latest next tree, I have made some changes to
> > split the crash code from kexec_core.c. If you check next/master branch,
> > crash_kexec is not in kernel/keec_core.c any more.
> 
> makes sense, it should have fixes tag:
> 
> Fixes: 29fd9ae62910 ("crash: split crash dumping code out from kexec_core.c")
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

+1, would've been nice to have more details in the commit description :-)

Acked-by: Stanislav Fomichev <sdf@google.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
