Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D513C5AD4E
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q7bDX99X8heKfUMDjEOLpp44Kc2HBY4XoCrDNhJpdWw=; b=qElmkJfnihC+0E0SuzGvAyXTgp
	w4gmy2p2Bj1V5J4PxT7jtGapNGsql9bEBqWvuR0D45s40iJ6qlaWVQjqaaBRRUiDoYcYw/4T+7dVS
	gqvofKc3p6t19i6xCx97pfEU/czs0gkwxtZE7f8h556G2J0JyEko6kFr6n6byEZy4n0131wMcS74/
	4z0VTStjpuf6s3VG50wtsyyCLJaCb2+W0YRWpy4K+n1OpNj6SCtjTV5ryQ5XBA4a64SrzSDmZCKhG
	1TTeRAnlfm/zrARIYg5Cke4kdz7gXSOmV8D5Dp+3AjLgaZQ637ndM3lqx7y9T9NejB7tjkEGX/ezC
	useysbQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtN1N-0000000BTuM-0bJC;
	Mon, 10 Aug 2026 10:14:17 +0000
Received: from mail-ed1-x547.google.com ([2a00:1450:4864:20::547])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtN1J-0000000BTtz-3pzn
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 10:14:15 +0000
Received: by mail-ed1-x547.google.com with SMTP id 4fb4d7f45d1cf-69cd6606b19so1410674a12.1
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786356851; x=1786961651; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q7bDX99X8heKfUMDjEOLpp44Kc2HBY4XoCrDNhJpdWw=;
        b=Zq5PSXXyS0vOO2u/hZGuXF8qHv/b20mvVEx25HGmNRe+u/4ts9sWGqbuU3HztmHfbE
         lWfOLk3ubaYWSedLPDSCRVuKaX6PqSurWf5gq56zwEE5eUyzvRxD1UyrJpCiZ8xHrYtw
         PD5f7wpmHqPYNutFzDAwC4Cb3r7eLQqXZEYx39BabX+nRZCDv7sREAHsJVlOCekU/S+v
         P8BEgoyuUZeKVXn+g/XJmvUSbwjL+MWA6h9pjKzTKIFdt5E5ZnxqCIVSxnJ3o2h4vDWA
         iFY6MCE/SbEwLkLfelz4mj34+d3xDzEDKEJJwwIkrPELQWqUEbp+pri0H+sJbdJgueZA
         Wt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786356851; x=1786961651;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q7bDX99X8heKfUMDjEOLpp44Kc2HBY4XoCrDNhJpdWw=;
        b=W1AG6uYB/1l+3h+TlAqxNxHFwdJZ6I9OY7rfE+g/94lv2nhL3+B2rVdlPwUk4NOBF8
         KTpXafTf2VFwJBRzplj8H91pHNpana3gNQTwk1KJlcQNnVSCt3FIfnFAyZuLMgE9UMeJ
         q1BA/qa1VCih0yUjSixF6ISbd3olceBSMn6BYn6wFLBfUDHpAAn8THlLhbL544zeDZYB
         a53uLAwMV5q07wz6OJHPHuqLMiCcwlGEtQUZFdmfWaTVVmcFiJako8+qnMVBnJd38USM
         Jjv/CsXNbqUZsNkXd64uW7vfD8KaffuwfnxHQYtEsiGWkCcFB46UnzumvPIWbUsuaZZt
         kpKA==
X-Forwarded-Encrypted: i=1; AHgh+RowQOZPmnbDvWBw+kcX47deKAjxSfOyCc2nrHZ8BQbPyBQXtkqu6T/7hHzmWBHguKjC6TD2Kw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxgeH4E+h2S3jUjcpnjthqxvsRujbSuLaT4bISa+sgPKteDGxt5
	bxqFScA9pR/wbfjddBdNY95OF+w9lftiHGHTMu/qlvyW3E0hqPpwmWdMJjZZTmi7UaDAoS7L8C5
	VnEbllh5MXleOwNs/tg==
X-Received: from edtp18.prod.google.com ([2002:aa7:cc92:0:b0:69a:bfa3:e91d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a00e:b0:6a1:fb92:b3c3 with SMTP id 4fb4d7f45d1cf-6a355e19d23mr437843a12.12.1786356851307;
 Mon, 10 Aug 2026 03:14:11 -0700 (PDT)
Date: Mon, 10 Aug 2026 10:14:10 +0000
In-Reply-To: <CAEvNRgGazT2D-G7sEem4RD5nUEj7dmcg8vx2=3bpatS_o5uE+g@mail.gmail.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-3-tarunsahu@google.com> <CAEvNRgGazT2D-G7sEem4RD5nUEj7dmcg8vx2=3bpatS_o5uE+g@mail.gmail.com>
Message-ID: <9huzh5l28eq5.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 02/11] KVM: Introduce kvm_create_vm_file() helper
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_031413_990771_01B0D88D 
X-CRM114-Status: UNSURE (   7.78  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
>> - Introduce kvm_create_vm_file() to wrap kvm_create_vm() and
>>   anon_inode_getfile(), providing a unified VM file creation API.
>>
>
> I think these should be 2 separate patches.

Okay, I will split them. Thanks
>
>>
>> [...snip...]
>>

