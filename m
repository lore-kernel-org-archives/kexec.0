Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E472606A321
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Fv8tcKQu;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=SIUmczEH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r4Hzxb3NGCSSYFn+Gm/a38nZ3OBSGBwiKOcgfEfvzmI=; b=Fv8tcKQuB/WO+fkl8Kf2kyMhFJ
	SI761EnVCFuZVvl5cj3fsOkYLVISw7pS91PlO9JNEe2rN21/J1wrafxXrOGKzGiK/uNqCLtIVv+RZ
	3mUIeMFTT/FSRh+XKZj+0XpmXF9lbXILXp3oEcO41W7KBfdQAXk8eli9vNPDZDa0gPA6wmhZ7ekH0
	IcTzBwNXwHpzsVC5JkrIk2aC0rm7t1WGw8YAbvEKtaC7fGlpceAo1+sshN8esLEx7bkKZDKzhfTmV
	liJqxjOjyVpKPsVxa0nUt6gcWWRm9E6S9iTMfFbNBICXoCV0SO7193t/L3vA/f1C/+25MHbQoarqY
	iLIlJKWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xX6nR-00000000FWI-0UVi;
	Sat, 28 Nov 2026 01:00:09 +0000
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xX6nM-00000000FVn-2HPz
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 01:00:05 +0000
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-8b5981c4834so8369897b3.2
        for <kexec@lists.infradead.org>; Fri, 27 Nov 2026 17:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795827601; x=1796432401; darn=lists.infradead.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r4Hzxb3NGCSSYFn+Gm/a38nZ3OBSGBwiKOcgfEfvzmI=;
        b=SIUmczEHanfi8K6txRiJoeDW2Il1mIAj7QEkbYSEvQKjdblyi/AkrSjMOMD3fOZU6u
         yMNa8v4CKEuAlFs7zhIhjL5MO7iHzoM+tt2lejJwO9TyWweG6VXYV3QLcjlHeIRnsgZH
         /jVJEFJa07YpdoXIPk0ls2OLezxm2wdsW8Rqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795827601; x=1796432401;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4Hzxb3NGCSSYFn+Gm/a38nZ3OBSGBwiKOcgfEfvzmI=;
        b=XmsDQk/W/ORsqifashe4SE74FGnBx51TwJSM0F8JBte1aJSu3/RAShIAVM225WHoek
         zWVCYN+eMMWy87Y6Gz1rmFVqGw2S9CPmTW3YwapMmq8Abi3yjKjG8xt/BIQbMoGrIQ9v
         309muSXhny3aQ0vO4mbnvoVutgq3JgfHb+zF3SdH7noqnSpfB0lG/J9hoS7M2CmvpsTe
         NkMAEb8TCjLZRAzZDp506xgwFdXeNo5sOAK8uLhHp7Y4Qel/7ar1DD7ZAOFPEQgJFzN4
         UVRn0ze6QWXdvSRyI7/+INrW55J5GyCL/cmtbwnF7rumv+vVadLNSA9Tkd8mzwMhLLCi
         R36A==
X-Forwarded-Encrypted: i=1; AL+hErGDGMYhbk3axnbaMgHK/dV7bKpS8dyXqGL1bb3KOsMWsBmD7utL934XMFgvbVLkIjOPlhG0dw==@lists.infradead.org
X-Gm-Message-State: APuU4Z/Hjms47a9RxYx850YOQXsU/Q+1IVPdjnWOrOJ5B3mUktkY/tYy
	Cj9Pm10ZhuLIpzpP5/Xf0did4iPC57u9VLGRiNWKsV2V3DYWxV6EOuMq2hvG9e1PfsY=
X-Gm-Gg: AZFdTZcKu4ZA18WI8c9Q+zg0DFthEgEOwhRxPCXNce5Pw+Um0QnpE1b6N9t9VUYkDSR
	DWdoXyv50O2GyqCCUfLJhmtqqYK79Dpg/9xXiLPfrn7H1wnnaNMqX6cZTsFrp0hWkDYyOkvN/vM
	vgqTNcp+5tc0FL9b3vPz4VTdPbskkvXio0OxaShRX0nI6IJu4HZgoEOqN+sSREXpdt/eLRCiUXi
	aZF0EfrPdrczm9QNBVWiX8IwTxJURIaE7a26OG5t8Pl+Gxg2PA/+ZbWnE8Rt6j60ogTKIs7z2pD
	DHxXH/YA798/TFsKOdHGZSYL38hCMIE/PM0kc+jncLB0YjdONuzYisepIZNlePPUxq2LS4+8TLm
	94oEOD+U4Za1pAeT+9LWR+zB2e5ibjKUNEmGbmayKOaAmvwACcUTchTQjHnqzU41ZT/Ve/frR3K
	mX4z6WcoQ9gqhE2mQU0Rf+4m8A+8kOQhYwNkiZSHHiDEHyEakNwRUVJMBdvJWsKjLGcylV+jdwS
	ohwXnA3hDX2JkiqHGkULG0wyh2A6HNcoFWUCwtNOwLFNzP9YbqQkAafrmXL1+qdc66CeLrTgPMH
	eEwKQr7ebjsXN8s9Q5cpaWfgfoxP8uadAdFJupJtgFsksSFzWrgx5YfScSlQui1oh36ntKpM5uh
	acUrL6yNS4OGMXUzRaulKeP/rUZ+Xx0T93RRBQ0iWITTpDiTmX0dnPkfebAV660Vigrb9CXbqit
	2OBs8kLgYggHHHzwLkLZ9ACSk4qlG1YmyNYNv4vcjCY0ybdGXkfFNRjSp7p8IAtevfgT2P/C+gN
	g+e1eBwV1AUO+8h46JGQEw=
X-Received: by 2002:a05:690c:b86:b0:8b3:4911:2dc1 with SMTP id 00721157ae682-8b5204ae0e7mr116512127b3.39.1795827601141;
        Fri, 27 Nov 2026 17:00:01 -0800 (PST)
Received: from [172.20.0.2] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202bf474sm101002207b3.21.2026.11.27.16.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:00:00 -0800 (PST)
Date: Fri, 27 Nov 2026 16:59:58 -0800
From: Chris Down <chris@chrisdown.name>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, David Matlack <dmatlack@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/6] kho: don't reference subtree blobs as FDTs
In-Reply-To: <20261127122536.3708770-7-pratyush@kernel.org>
References: <20261127122536.3708770-1-pratyush@kernel.org>
	<20261127122536.3708770-7-pratyush@kernel.org>
Message-ID: <awonjgkHO4wSeAGO@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_170004_621376_B642250A 
X-CRM114-Status: UNSURE (   5.93  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pratyush Yadav writes:
>The only functional change is the rename of the debugfs subdirectory
>from "sub_fdts" to "sub_blobs". Everything else is a pure rename.

It looks like two places still refer to the old directory name:

    Documentation/admin-guide/mm/kho.rst:110:``/sys/kernel/debug/kho/out/sub_fdts/``
    kernel/liveupdate/kho_core.c:1099:``/sys/kernel/debug/kho/out/sub_fdts/@name`` when kernel is configured with

