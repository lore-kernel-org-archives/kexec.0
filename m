Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98B606A337
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=32hUUnEz;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=XOP3Ihig
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IG2RtveLbr6LLHiOkKFy7cZt2dAAYGYqRZMKbSVVxF4=; b=32hUUnEzimn4Nz
	fVifF3BoSXKvzElgfiGs7MoBCtySIMAgcibxwFoMmxG5Hu/9ZMjD3R4lzeKKbWJZTd60xGktQtSrG
	g7TIdGgCN4UaRmwH8QPQdLPlzTQ/DbE0ZbOwcKC7X7RdAIp67k4ng6r6mxK8qLR8Uem1A+TXbjLzR
	4QYsqYMmvQKBtBC8gFrXNUpU5KeJFZY7FRaMNSjskLhq1qeUjq2jyCmByHz+4nlDnRSnrdrc/PT3g
	uoLdiw60yGkB/+wvP8uRFG0VnmydvW1fnec7Es2UUMztoy3MdsmcQ0h91dVlPPdd7iLUpAxG4yRMM
	rHPvhcm3uQ6XioqnqTyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTLgu-00000006O0O-2FJJ;
	Tue, 17 Nov 2026 16:05:52 +0000
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTLgs-00000006Nzr-2LUW
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 16:05:51 +0000
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-745497ac8fcso1509481137.0
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 08:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794931549; x=1795536349; darn=lists.infradead.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IG2RtveLbr6LLHiOkKFy7cZt2dAAYGYqRZMKbSVVxF4=;
        b=XOP3IhigZolwm6+eV/6YJobC3NlevW1cCBVUmGYEFvH5e0qiOao1gch4I0X9Al7NAx
         R+DecD03fYT2koPDn4Bp84bmfZkH2ahc8U2E5oBpbLYHpIEVlJtJ3ckEH9oZMwWq0Ekl
         JyLJlmKBdma35fxXL8UbSD5xoRM1iIXd4wuuGW3ow6VnPMl/qef3NKmclJKDpE0TiQJN
         tpX8qx1HJtDaMnpKF0HIi7S9ZRWT30U4kWlvihzcWaGM2BN7L/P5Fdc/6WzUmQv8obUF
         d0mAqml1JnVC/6+ZMD4wi7eRSYaCLJGV3ROPbGaTiy+Ztrh0Pzzax8++MQtirkGreRdj
         bwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931549; x=1795536349;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IG2RtveLbr6LLHiOkKFy7cZt2dAAYGYqRZMKbSVVxF4=;
        b=h5xWLT+7S7lJsGLQqwPe0oQYzE36Pk3G9czfo3tUVqokKwIK+UG8p6xAwWsiwX+UJS
         NMc5hpceegnkkqxA7CLj6FVC9BBAbAFMq21O0iUmcJIL6+FW+3SPbNcEfsXEoYiPars4
         daK2UKz0nMVo5Cdwm2bHVLVw3hK5w1Seb6U6Je9GBTDUrtEH4tw7Bj30UsGjfsBOPDnA
         OGq1CWxHLJ/zkT8yKvi8ZOuJmh3fQuLLSVFL16VGrFw4tC9NtKd8+xORUg/pkeSL8xFq
         khOgWnBM3SSiBtan27RCXfnxC7MbQTGlFLAK3K5UWFNHJPclzRTJMf9coBOmYQ+/p8Bz
         R9zw==
X-Forwarded-Encrypted: i=1; AL+hErFtZWhX3VTEDBnOzX3nbPsJmssalX57vlCL7Tv+k0BUSLq51CfDrYFoJS9qIr2MNHXIiUCiPQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/laXQrYDm7pR1FQ3df3jIM+vImWZHofD0crAXqRBfzm4eQdrtz
	9tLgRBQG13p/meFK3Qjg36KZtsOphu+02N/AlC9yphEPaazTyGry0iQ1rQpkYnFR9KU=
X-Gm-Gg: AYBFou2LmKX3IV+D4kJfvdfcjVrDk0oQPRSeKbg18W1UhUX2r+G6WMhVXXmNDcu8aW3
	aViAoGOIyEse+yDydE68cXegU3ZtRoSI4lk1QiByjUzTgJvaopCXf3A9V9ZP1xsj3yVw8NkTrYQ
	h6iZMs0J75HTVP+pNY39ZkYEk9MlCD+zn6PGE2/NodCOYu10FL6vZG7J2LysVWWdb155X/LZhXx
	UhQJTFrVt3oe26MvHpGXmq0oV9iYrktYwSmy36AP09ofVdTETvcFTYBm87eqgwRpDtBRazXsMnp
	qMe65sK16xo2oIS78oX8wM/x7JcSJKM1Fcvz6b2EteJKhuAFvK/mQRfkNMBYM/I6duupQOkWr1j
	F62v+RZCoEhuIWtdfbD3joKxwxa79vup4Yuj1ygUret3VSLXJVkmgaVvMEgIeZIRn7TZNu9Ju00
	tTsNpIzBJbu9RLI7gcll40QHup01L/IQt9UDtifWh+cdi1R0I5u73Yw7VdEKv0GkxgfJ7iHFhEB
	DmhJuVLDIxG59w3BwtPL438HALnH9Nj016d5vgNSJLq8Gp+uPAHRq3ZWNJbWhTm114jZ/vdz6vo
	CRYGAlGQH6TplIii2eD9cnT8UkGT9ysuKvAlg0WXu09ZR8DwtK1yWjErI3Nbv9EZ594rnJ6fKC0
	KAJ+Xtyzp0C29ExnCYaIlHwOqqTzSu70=
X-Received: by 2002:a05:6102:4457:b0:7c1:8aa5:36d6 with SMTP id ada2fe7eead31-7d64d6d4a85mr3228252137.11.1794931548510;
        Tue, 17 Nov 2026 08:05:48 -0800 (PST)
Received: from localhost (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d69e023608sm2832234137.7.2026.11.17.08.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:05:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 11:05:46 -0500
Message-Id: <DMXM4P4NQ6DH.15QJ2AU95YJRT@soleen.com>
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport"
 <rppt@kernel.org>, "Alexander Graf" <graf@amazon.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Tarun Sahu" <tarunsahu@google.com>, "David Matlack" <dmatlack@google.com>,
 "Samiullah Khawaja" <skhawaja@google.com>, <kexec@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] KHO map
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261116134013.1636689-1-pratyush@kernel.org>
 <179486913878.127049.11178890384802388709.b4-review@b4>
 <2vxzwlqbfxtf.fsf@kernel.org> <2vxzpkw3fp2y.fsf@kernel.org>
In-Reply-To: <2vxzpkw3fp2y.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_080550_606820_B23BBAAC 
X-CRM114-Status: GOOD (  18.66  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 17, 2026 at 10:35 AM EST, Pratyush Yadav wrote:
> On Tue, Nov 17 2026, Pratyush Yadav wrote:
>
>> On Mon, Nov 16 2026, Pasha Tatashin wrote:
> [...]
>>> Instead of caller-chosen depth, the tree should grow (and shrink?)
>>> dynamically bottom-up based on the widest key.
>>>
>>> Plus, with bit 0 tagging leaf values, 2M entries can be stored directly=
=20
>>> at L1 and 1G at L2 (on 4K pages). Even for huge memfds, the pgoff space=
=20
>>> is much smaller than 64 bits, so in practice the tree stays tiny in=20
>>> depth.
>>
>> I think it is a good idea to allow dynamic depth in the ABI, but I am
>> not sure if we should deal with the automatic resizing just yet. How
>> about we start with making callers specify the depth (max index/pgoff)
>> up-front for now? The ABI stays the same, so we can add support for
>> dynamic resizing later if needed.
>>
>> The reason for this is to keep things simpler to begin with. That said,
>> I don't have a _strong_ opinion about this, so if you insist, I can add
>> dynamic resizing from the get go.
>
> I take this back. I went and looked at how xarray does it, and it is
> pretty elegant. I thought some sort of rebalancing would be needed, but
> all that is needed is to add a level above the root tree, and demote it
> to a subtree. Similarly, for pruning, the subtree at index 0 can be
> promoted if all other slots of the root are free.
>
> So I'll add dynamic sizing and reparenting logic in v2.

I agree; let's implement this properly from the start. Growing from the=20
bottom up is the right approach. I am not sure whether support for=20
shrinking is needed, so that can be added later.

--=20
Pasha


