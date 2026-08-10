Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E848C5AD7B
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:From:Subject
	:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGaSU+VuIRkXSJTWn32BiSoxbbOSO1fE0DsBGdD+ti8=; b=sVJJh08Smy4C9iVvtaliGoeU2e
	6uLI8PKjO/vILf3K7D06YfrveHItrjqE94/9lJSqAYxbeQ0gbtOM3qtmilhsNQX/G/izX8vkrOpXs
	tOxROlDd/tUMeTpoQ8in/NrIORmaj3qf2SmMZnviXJHqB3SKBcfcAiCc36Rl2qhcNggjsTOC+cRR3
	lqSS1IldLVBw8oOd1Tkr0UQPnPmbsXOz81HhOPulamIiN8F0vibZBx525zmYcMNK8XkYf00ZMG+Lc
	jAETEBmt8+HJkOOXKiz1PV0W89S26OshvLw3Dgf1OEAqKX3TTRbdsHzTGyU858O0pYwo27gMAPwXb
	9IBMINvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPP3-0000000Bp3E-0jIM;
	Mon, 10 Aug 2026 12:46:53 +0000
Received: from mail-ed1-x548.google.com ([2a00:1450:4864:20::548])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtPP0-0000000Bp2O-135U
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 12:46:51 +0000
Received: by mail-ed1-x548.google.com with SMTP id 4fb4d7f45d1cf-69e984607e7so1631225a12.2
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786366007; x=1786970807; darn=lists.infradead.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGaSU+VuIRkXSJTWn32BiSoxbbOSO1fE0DsBGdD+ti8=;
        b=DoJWZA999e+f3IJLpfe8LJ+e8LHKSsItlVcQzg/xTSbcEBfd/feebeH08DHKLuBCmx
         eOBFo2LicCDG/Jc6Tay7GPSMl00lGQ70eustygY3qCs7oZR/v3xjV29qgCP184JQdIFL
         bsK5mp3+o1yJKE0VDWbb+OzinaoFimuDVP69KXaFTpfk2Qrdxn0XShh3COvzsPLHfypO
         VhRLELzS7nwvdWgWKMM0AycgV14l6aS5cE4ZxrpjwTSvXM2vofGF8jJ8MLOd4Ys58QtY
         HRrfmyYvjD3uim+MM7LZMjGVy3ChTzlfVjn3v9venvy6RjT83PPoFS25WhBY+6rwdfVS
         7R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786366007; x=1786970807;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGaSU+VuIRkXSJTWn32BiSoxbbOSO1fE0DsBGdD+ti8=;
        b=UtUEkkjLQmQP57ToeB9BN+i7tYub7mIH5UI7gtBxMdnHqUFetfvmiCXpkNY+EBYMQi
         YC6t5yQI7BZDDfZ5f9b96+RlE6fdPMlu/pKqxVzmpyV1LNeZb7BOldh1CtQUvlUrxGA8
         jrVdmrEwfOVooMZvuKYH/r2BcjBOi7vcQO/SFi+3Rk311aqs5xeC1bHgGbCOUQMZPy38
         9+kvCw61bp3OJt5MkLq2wZjqewnzWuMhtVBwrfZwW5LMJRDksLS0jg7xlG1Za84uxUZT
         qyVRXekKBGpyBaIMIXBf846Dfz10nzCbgYNyfSyeosqB7z455GTEJaVQyzQ+/tvfOxk2
         qGlA==
X-Forwarded-Encrypted: i=1; AHgh+RroETOa61k19aT/wjf4asLvc6nUDWRog1TDrbdBmSEsMtZCGmX2f/f303hOxPqjenY7AE9z/w==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywnitr4GKEuPlLhJKRE320BjbArCXdXfS5eLv2SFmfwuhSEZaLQ
	l+UPLXsWAS+Xv6S6DpYkrQ/1te+QJyJa+Px1GjofJmN+lgf+SvCW0i9NelCilYueXXsSyPam49a
	H+WF0PIO5umk2sOInvA==
X-Received: from edea14.prod.google.com ([2002:a05:6402:a18e:b0:6a0:ec92:a4d7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:21d4:b0:6a1:29ca:681e with SMTP id 4fb4d7f45d1cf-6a1b4b0b051mr13103448a12.7.1786366007088;
 Mon, 10 Aug 2026 05:46:47 -0700 (PDT)
Date: Mon, 10 Aug 2026 12:46:46 +0000
In-Reply-To: <9huzh5l2taav.fsf@tarunix.c.googlers.com>
Mime-Version: 1.0
References: <9huzh5l2taav.fsf@tarunix.c.googlers.com>
Message-ID: <9huzecg6ta6h.fsf@tarunix.c.googlers.com>
Subject: Re: Qns: LUO: Should luo_core throw warning for preserved resource
 under unregistered handlers
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, skhawaja@google.com, ackerleytng@google.com, 
	seanjc@google.com, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_054650_341290_999205E1 
X-CRM114-Status: GOOD (  10.24  )
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


+ kexec list.

Tarun Sahu <tarunsahu@google.com> writes:

> Hi,
>
> I have a question. If a luo_handler is registered as part of the module
> And In new kernel, the module isn't loaded so the handler will also not
> be registered. And the resources/files preserved in older kernel will be
> leaked after luo_finish in new kernel. Right now, Luo core does not
> throw any warning. Should it throw a warning or prevent finish and let
> the user re-attempt the finish with force if they want.
>
> Guest_memfd preservation is such an example. It gets registered during
> kvm module load.
>
> I remember there was similar discussion raised by Samiullah for
> resources not retrieved but their handler was registered.
>
> ~Tarun

