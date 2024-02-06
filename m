Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9DCC48297
	for <kexec@archiver.kernel.org>; Tue,  6 Feb 2024 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Cc:To:
	From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=I4UionrtBD3FCqiWqi90pwJ0cPojwsru/NA0CU0Lvrk=; b=RzbNBZq5RmrNZq
	QOYGXNtownLvtT2lk3KaspGbKRxfqAKN/GP25VmRZZUfwT4oMfuYVdBa2umIc9GWfy0cGruAv+Jh6
	VvKpCnlTkLJnOCrYXlhijKnhP5u4w70unpw62UDLlUoj5+L3wq6POpXrr0Ep3y7K7tEmBZb68Hwym
	oHx4286//SjFjB8ueOTbDp4Qx9yTTOgStFj76+aZFWfiAZVj40oyLPVBw0nbyEEUGAaj95G0Qx7Ws
	W57pepcknNpmfRQs/t9k3jXTfiuA2s+JcsYYCS1S1LY5PJVaL0unCp8sorswlQQG+M9KFxMwbLwvL
	b2t8/3PcVGcMhSzWexQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXMrT-00000007x4c-3CxN;
	Tue, 06 Feb 2024 14:55:47 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXMrS-00000007x3Y-0120
	for kexec@lists.infradead.org;
	Tue, 06 Feb 2024 14:55:47 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40ff0bb8592so3056245e9.2
        for <kexec@lists.infradead.org>; Tue, 06 Feb 2024 06:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707231344; x=1707836144; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+XZ9mIc4ZZ7nNbi2oJblEjps9kTAmyVg/UPtun3xME=;
        b=Ji8MGPxwz+BtkT7keGitXLrr9v8VI1dxJIIs4WqVX5d/mr/ahSitY7SbND/9UMFEi5
         ABXmiHzOEjoKYvxSE1xdJDldIOmth9wNqa2xYfI/kRyzX1QKgxO5r0wgOugpYy5r7rDl
         4qicxdPEf/h+u481sDSOvgAWVccpeqdNLhAoaTlo+46Myv+FOJKlra0jfu5KHVMjlBmR
         pC1V9ClouLLk0q64ryRSK6MYNEYQRfiFf1jhXk/UCXGsk1sgJZY3msFSA4durfrOSAMK
         wy0nQ2QlVrx7MtcHpRkR8aXL0FdN5bomGuGVH0WQ/jQcwefrgPlrF6Fj20TeM4gV5CqW
         zy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231344; x=1707836144;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P+XZ9mIc4ZZ7nNbi2oJblEjps9kTAmyVg/UPtun3xME=;
        b=NYEeTr6IPe9wZhPLOkTIcuUOyh7GazkjvfmfuS9ndR3tqIx+l7gRsYL7+P/frz1o3q
         iscWFTJ3k2hq2SxKRyRlOxyLAYWHL08eYfc5leXkTSkclPnP2oouSSURqda4Kud+lR7A
         0GACQVQT2rry8dnysm9rx1PuIy8yw7RQcCU998R7b3vGyRX7gGo3dBbTwv2pS8cVNTnX
         Ru11k9evxbs8G1bjFyAX7qNgc6LsndwbBKD8aXpsGdJuVJA+ii8Iv6qreMYa2BqHg4Qz
         7rs3OGB59F212euz5vI+dWOK04BPWN8vJdCefqPOkHU+BxfrMIYnhNa0RDW5b5HvfCBG
         Nmxw==
X-Gm-Message-State: AOJu0YyMv+gfq+vADv/OGgZSLEvqcDNt3ZckoIOGkMK0nJoitonAa/L/
	lhAtdQWNSLTUtEr/cIcituAWBAZP+KVNwcgEkqWm4LRBIEP+04rZ
X-Google-Smtp-Source: AGHT+IGCu12mB9a0AFI2Ba4BEGYbcnCAFKhgWjEm1Z6uIPmbfR8ErP1f3Wsb1RcCeZiIJSqC7deq0Q==
X-Received: by 2002:a05:600c:5103:b0:40f:c404:e2d1 with SMTP id o3-20020a05600c510300b0040fc404e2d1mr2172197wms.19.1707231344009;
        Tue, 06 Feb 2024 06:55:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWDK15ZzhPti6e+UKpuCLJ+9JFukOTN01W7k15JR3hJm0baSA7FuPj5PJJ3k4HijcEs5Rv0wkhg+3dhva9MPI9JBcXSvUh2zGRNkxVUjgrk0xotEExnIcaBAoYEUHedDS7Sj3CBwlQMCSasEXqn/y6c1pi15Mtxg5/H93/BGjq9uZAO+aW4rgTE7/JxqCootj4DK8Xsq0UsbUFzAh5te8GZotbsqIPtBeM4ONElJifzGw5pPzF8W1/0jxjdbI6jr1VMnqxR80uFjbYtSDRUushRf/+IX8nPWjF5oFWeSVJyMEw6Tt28Csojv1TsQSNLLbPRra+Fp0p729HNQehp/42CpldfO/HExuvqCTbk8X6f/xkCNNZqHhoGihKYVbQ9r//MK6U2gRWPS+6fWfcIo0tmPLmqBXNkW6/lD06BsD7LjSvEquthW8fQsyTBP5HNVBXLVtfmMjgGUTNhJR410OK83eQpJQObg01nURN3rFIK2qECUsVfA9RMzfNM3u++TxUi+3tZE40RwjVydmB1W8nZE8h/U5EChHJk+NKxwaG+J12i0hzjqDBrg+WCfRAH8yw09wHbFWOWvYiPtWEWTGQVKE2XADgkGoZPWJlP7H8Ii5AK55s56WLiWJ0zuuVOGQw8Jb8kgjrwo3htwsLesUC2/Y35SFyrCRLKIUmf033M1/a1CozvepAxGqjRGSUb9Xo2MO1lVmooDGgotT9fNJaL+RMINwks9cI/mihrgjCUSyg2Jv2r
Received: from ?IPv6:2a01:4b00:d307:1000:f1d3:eb5e:11f4:a7d9? ([2a01:4b00:d307:1000:f1d3:eb5e:11f4:a7d9])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b0040fd3121c4asm2243641wmb.46.2024.02.06.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:55:43 -0800 (PST)
Message-ID: <888072e30cc003dbed3f41675242b877246e2f0a.camel@gmail.com>
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
From: Luca Boccassi <luca.boccassi@gmail.com>
To: jgowans@amazon.com
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com,
 brauner@kernel.org,  dwmw@amazon.co.uk, ebiederm@xmission.com,
 graf@amazon.com, iommu@lists.linux.dev,  joro@8bytes.org,
 jschoenh@amazon.de, kexec@lists.infradead.org,  kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, madvenka@linux.microsoft.com, pbonzini@redhat.com, 
 seanjc@google.com, skinsburskii@linux.microsoft.com,
 steven.sistare@oracle.com,  usama.arif@bytedance.com,
 viro@zeniv.linux.org.uk, will@kernel.org,  yuleixzhang@tencent.com
Date: Tue, 06 Feb 2024 14:55:42 +0000
In-Reply-To: <20240205120203.60312-1-jgowans@amazon.com>
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_065546_066510_9ABCEB89 
X-CRM114-Status: UNSURE (   8.38  )
X-CRM114-Notice: Please train this message.
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


> Also, the question of a hard separation between
> persistent memory and ephemeral memory, compared to allowing
> arbitrary pages to
> be persisted. Pkernfs does it via a hard separation defined at boot
> time, other
> approaches could make the carving out of persistent pages dynamic.

Speaking from experience here - in Azure (Boost) we have been using
hard-carved out memory areas (DAX devices with ranges configured via
DTB) for persisting state across kexec for ~5 years or so. In a
nutshell: don't, it's a mistake.

It's a constant and consistence source of problems, headaches, issues
and workarounds piled upon workarounds, held together with duct tape
and prayers. It's just not flexible enough for any modern system. For
example, unless _all_ the machines are ridicolously overprovisioned in
terms of memory capacity (and guaranteed to remain so, forever), you
end up wasting enormous amounts of memory.

In Azure we are very much interested in a nice, well-abstracted, first-
class replacement for that setup that allows persisting data across
kexec, and in systemd userspace we'd very much want to use it as well,
but it really, really needs to be dynamic, and avoid the pitfall of
hard-configured carved out chunk.

-- 
Kind regards,
Luca Boccassi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
