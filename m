Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1450F606A324
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aFWWYYIr;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=QXvDwg+i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3IrB6l2ge+kT+1cpfqcWAfjg5pGysZEjTO7L0UKFQf8=; b=aFWWYYIrq55zEL
	Ma+m+eYOnmJufaIsxTr5TngpYoMgbgLYeVT1w5YvMH1jpBXIT0o7oHy1t7mJ6mzw1kZKBD63hAtlg
	cOGWTX+PBELvRCn8636q5Cf0tSKZz0LkGCFzB1fFWazOPKYhm+pYgpdGF46/tJWsRxsgdmIrZjMzO
	T9nSctEyvLjo4p3gyz9HZb4lVg3/f5/Unyn3oJDHKtHxZRXy3x9eXzdVmy/RY9p3um+CaU7g30w3D
	A0KOZm31hrk8o1MbCXPVQOZgXWXo8o+UuvUP7OryOvkJ/9gLboyc1mU++It/v5Q0Wk8fmk202OnDB
	w6u3YH8EE0XIqXlPDpFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFdP-00000007iSh-2Zot;
	Wed, 11 Nov 2026 21:13:35 +0000
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFdM-00000007iSL-3DeQ
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 21:13:34 +0000
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so1822913137.0
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 13:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794431611; x=1795036411; darn=lists.infradead.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3IrB6l2ge+kT+1cpfqcWAfjg5pGysZEjTO7L0UKFQf8=;
        b=QXvDwg+ijZO+swCU3mnaoSR5B8Qo640vTZylGzKCMrY30mV5WgizF05Ybb2aiA6h3a
         Kb2JDvDmEk2DcGHkZyZ/kp2b2d8lD3Hs8RVZjW8yMCaLwyNxDtg1J6ndSQiVfFdOlv8U
         ZB8jVlHSTy9LKOYajRUMZdBakierK4pcAx3KGvnMols13QR/D9fQntJL2EJpW619XISO
         ZTcUXaBLH6EIoNJAD4MHqYfuGR287GvkBwIcLcinQtRd/KMKQw6p6lGNWdrMo0NOrBk7
         kitJIAcoDSKtMtivk5FKOoavRzZkXNrD4VLOiFh1OB4+nzBVXVaki6igcmQz+KY1Q5Hf
         01ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794431611; x=1795036411;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3IrB6l2ge+kT+1cpfqcWAfjg5pGysZEjTO7L0UKFQf8=;
        b=pMnyyIPorsgE7lvUToRGKyBIH7DAEf/VpK4zvvIiPkP8vEVwnDq2q7C6TEL6fxTSNJ
         YsXlkjh5HLgfseh8K2EyjTQmO7pgrSHzjqnr+h3yOQVGcGExa/F3rf70gx1RJ828DH5f
         Q1+J6z2OQXgo1xg9xSyuU5u3YgqEB9SsFHBldHdda5dYw1oJ+44qN7Q2aYMdTNFOy9XT
         XoIa/QcQPCZqnr/wCScAuWMty8uBlNg8tgbxudUHXVPjFvJagin32iokYAS8bdhA0xiu
         NKtw54zaSmqHBRMBhEaOWM50a6bV1on6oiTfrWvusNOEHXCIZ49wAD8/e+nHzL9t7yP9
         OHfg==
X-Forwarded-Encrypted: i=1; AL+hErFFJqE3bi7YsUCnZB13LioD5vbbWMHdf4U4MnUiRj/S0PnW0TQvshztnfUTG2b5QAuXnZpl2Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z8+Alh4w6Dx1Y2cCdm129AAR7aw9vuIFi4IkAI0Xx0STdhWAnkA
	xNT2LGd086/GnUukVu7wRDwYe26OIdD/SRU09fbP9L9zpjFkQVL8XtgTwOTR3jv8mFI=
X-Gm-Gg: AYBFou1h7dwmM+cufeIKUSzJk9Dz4IVtHexTLWXXokD3fdB5F/AR+OTmfzS1XxCUIb0
	1kZbxNL0R0HYN+vCXakOWx5IVj3slVwpWeE2V/68EeLSevbt7Tc4IeqpSncBeWRB2MY0kJe+gRQ
	wB6HbXgqS2pOHHe0CatX6brw1m1Sw/M30YCwP9ADpuZG3fkW0vnDKZGXZzcSzsO7esfVkbiRhww
	Sc1EjubSl7QyUEjk/9jQMh1Ok8U3dNAfapdEEhe79hpht6OtVP7fJlatbXKDT5O/H1NsWT57Rcd
	6RW0alrgBYxOubruhV3xO+uZ4GYwhS1KPdSE4BfYpMqG1gkxhC2/Ku8mA/EuHkkGDAXAPDhn6ME
	qNFNSs/sB4wQhftzE1faI8cnbMpvltq9J+qCM3S/IMs6dB0pOha/EKfTKQ5H/eCmlCg41mE9+5s
	5XM/VHI71OEb9eoM1XToBaAAZmqnkETj8QBL1SxyEj8o1DrQ0OgJoX5n8Cho4qeVb0epFEORnPs
	HPtoVqfQsOEFWwOABXNOEEhXhL1ddn+9+0UFOt+hGAgpmPZOApDFSgunkD1khf8ivWjs+pyb9bD
	6szfFT6lP+IiAb2yP6Y+5cd50ct6vHil3F8G9VfBhpKADb8nz6F2wdm0WoLVi27gz5TA8Uq1XQ3
	wio1Ek6gBy2L3d2tO1kDgye2nzQVy
X-Received: by 2002:a05:6102:2d0e:b0:7cb:bc5e:7d9f with SMTP id ada2fe7eead31-7d4fb2577edmr1659351137.11.1794431611247;
        Wed, 11 Nov 2026 13:13:31 -0800 (PST)
Received: from localhost (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023838a9sm4907083137.7.2026.11.11.13.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 13:13:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 16:13:29 -0500
Message-Id: <DMSOX12JE1BL.33ASGRFO04NUM@soleen.com>
Subject: Re: [PATCH v5 5/6] liveupdate: Add LIVEUPDATE_SESSION_FREEZE ioctl
 to freeze sessions early
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Mike Rapoport" <rppt@kernel.org>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>
Cc: <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
 <linux-mm@kvack.org>, <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>, <vipinsh@google.com>,
 <linux-kernel@vger.kernel.org>, <corbet@lwn.net>, <dmatlack@google.com>,
 <kexec@lists.infradead.org>, <pratyush@kernel.org>,
 <rdunlap@infradead.org>, <graf@amazon.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
 <20261105050053.3063001-6-pasha.tatashin@soleen.com>
 <179439592041.425130.6098227055493441109.b4-review@b4>
In-Reply-To: <179439592041.425130.6098227055493441109.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_131332_840570_EE037E29 
X-CRM114-Status: GOOD (  11.75  )
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

On Wed Nov 11, 2026 at 6:18 AM EST, Mike Rapoport wrote:
> Hi,
>
>> Currently, LUO sessions are frozen automatically only inside the
>> reboot(LINUX_REBOOT_CMD_KEXEC) pathway, where luo_session_serialize()
>> iterates through all outgoing sessions under global write locks and
>> freezes them serially during shutdown. On hosts running multiple
>> workloads that quiesce one by one ahead of kexec, userspace needs an
>> explicit per-session freeze point so each session can capture final file
>> state under its per-session mutex as soon as its workload pauses.
>>=20
>> Introduce LIVEUPDATE_SESSION_FREEZE on session FDs to freeze an outgoing
>> session early. The ioctl runs .freeze() across all preserved files in
>> the session and serializes their metadata. Once frozen, no additional
>> files can be added to the session, and subsequent freeze calls return
>> -EBUSY. Freeze is only valid on outgoing sessions and returns -EINVAL on
>> incoming ones.
>>=20
>> By default (flags =3D=3D 0), session lifetime remains bound to the sessi=
on
>> FD: the session stays frozen while the FD remains open, and closing the
>> session FD before reboot (for example, to abort the session or on
>> process exit/crash) unfreezes it via .unfreeze(), unpreserves its files,
>> and reclaims all resources. During kexec, already-frozen sessions skip
>> the late auto-freeze and are published into the outgoing KHO subtree.
>>=20
>> With LIVEUPDATE_SESSION_FREEZE_COMMIT set in
>> struct liveupdate_session_freeze.flags, the frozen session is committed:
>> it and its FLB dependencies are immediately inserted into the outgoing
>> KHO subtree via luo_session_publish_one(), and the session survives
>> close() with full ownership retained by LUO until reboot. Once
>> committed, closing the session FD (or another session failing to freeze
>> during reboot) never unfreezes or unpreserves the session, allowing
>> processes to hand off preserved state and exit prior to kexec.
>>=20
>> Update the uAPI and core LUO documentation to describe session freeze
>> and commit semantics.
>
> Please teach your LLM to use shorter paragraphs, focus on why and don't
> list every implementation detail, but only important ones.

The first paragraph explains exactly why; however, I agree that it needs=20
to be more concise. I will address your comments in v6. Thanks!

--=20
Pasha


