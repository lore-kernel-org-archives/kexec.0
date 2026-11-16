Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37014606A88C
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sm6vHiOn;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=r5p35Vat
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=; b=sm6vHiOnxD1E9jnaNf6A/Qy6n+
	ebJDixos+AFhA9tduKqLkBk87C1Y6aDpkthwEkyhKPVqSfdF7U6Q/Unj6YnuVRcYjd50lhgrxrZge
	XyiIUsJMHtgmsDXIXVRJ64uQCZv5n54VcfRflCmpdZl4Ylz5xpT0k8XbihGthtdWHaq4S6VhMMXKX
	mWnCBypch2pGvSq/qRFZKunnszfiEPXLIxI3w2JDZRY//VyNJft7IhrO2aFNxVsAlw4w3embFcVjJ
	amZ1jPJfdTXBGieA1v4fF27x5BUbYgMrmdLYYuQrZtXz7lzn81nkzQVOB8Gi3c6ROLrcboj/ueCXx
	WLA/eOpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSoQH-000000018KW-3uyL;
	Mon, 16 Nov 2026 04:34:29 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSoQF-000000018Io-2kF1
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 04:34:28 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1b24f4b15c4so926652c88.1
        for <kexec@lists.infradead.org>; Sun, 15 Nov 2026 20:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803667; x=1795408467; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=r5p35Vat5n+//hZrG6aP3ksKFGfLA1oMipACe45Dqu/AVh9jChRLNZY9GdNPahXMmp
         nEFdtd9sVElZ995pZJJehMr+Xugnw621dXZPsBuMMj2ukzOKEYUGjPlMaL7mDOwp2wR/
         tapb03N9tfwR6j1xonIb4Hn1IpM0J8YzMMwG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803667; x=1795408467;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=AcQmH4xyTfAk+5p83xHUvyhKhpQ3Vpb2jEnKY2Dr4sqhdaFbkkNlrXUfvGc24ti3PV
         Rs/MVfvMTMuFjRABkiuIXN4ok16tKtxJr43Pi2EJVQ5smof/p1bCU4g9AanUyCuY8a65
         xTuroBaXreLHWHiA9SAvXpeTzhMZ1FffExZvFOL976FyUwX56OIZ/+bJOBsFIqX8v11w
         APkljy5bRhmj57dh5Y1q/zdnxUoA2VW7ICK0yKEgYvZZYIcB3dgasDZrPedrUfzRTYr5
         k73sS756yUZnx0tfcsQA0B3/jDDxEq3pYJZTS1LIVeuIA1PrYsNAtiGmhAbTc19K8YMu
         k+Pg==
X-Forwarded-Encrypted: i=1; AL+hErG8dIq+sSH2Zd6tOVZmSiTykCGlgJMIWBs4GdB4sJYwN9aFAgY7+tso3NT/tdRpLNw7S1bsYA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/oBKWezz13WXxC3DRBo9RqrE0PaPlL/GCAIOeL4vx6xuBp/I71
	8DKExYhYmvXtaNaOEnsuXV9J/na1I5quZo7Y8bTx4Rh+7z1s7vwfMtKBJJ07ChahYCQ=
X-Gm-Gg: AYBFou1uGHYaeY1I9A5NPF91+Zt5LgIdIBYnyBlaHwGNptUk7gldp1u+Lg9pJQRJv86
	VHxkhNbTpY5uP02AzjGB9fv6KKEFwE5CM3zQs3dGHajOJeGCYUoJbnSTUjKNK+8mjEnUzV/YQmR
	GuhJzsCCCCtU/WEidxpHKy0Wci/47ea5MsOyhjl/kntp+J4qiBU5nEjpclt2YNEPrxC1A0lO1v9
	AER7pRhg0O7HqOW197a3gHlKUe7FR1QLUUNQJsWx+6o/ebjm/8N0+UoBNgtwW+y/Zv3T//On1pS
	oLjmBNrpYAwP+ghNCR6m0zErVrTp5t3/pugrHllsV68bmzE9evvXm+xutrbChrDWR2NaqqeJOCH
	TsEUk6nnZg+kKpc9CfVrVZSJ2/2o/IiJl5ZAAuvNDafTIhAJyT+APzl39HzKXbONK5lKEsTSxpj
	ZdL+4+AEhsaZhSqXcfBvFSxq6WcdHvsJuGx6tZCEMFSJ7EFJEorMkHGblYWaqtzDOthEO8kwuX9
	sNCB5TWnQcDMJAIPtjBfdB9vwt0E1i3l5Rusza+pmzAuxNWLA/1cEJsn5N+GlMFHJtyjMCCBZpL
	kwvlLXy0Hx+ngBXAIQmpdUpsopdqzdE9PHDj5w/xxsqi8v1IWEGzrSVzwVVbV7b/37h14Ud68FV
	379NK3Un64BKBd9/1HXzy7mQh+UWL3zzpv6zQgPolZn6wNDjTTL/x8MTF1BQMRvoymZXQ+cZ4Sd
	wc9kzJD0V7e7FiMXOyMOOxhc0IfM0eX2alajcOJpdLvVNuoS6PMOFDkr88eu+t2aF4
X-Received: by 2002:a05:7022:b0c5:b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b4f5f3475fmr11110443c88.10.1794803667022;
        Sun, 15 Nov 2026 20:34:27 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm38362148c88.9.2026.11.15.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:26 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:21 -0800
From: Chris Down <chris@chrisdown.name>
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org,
	will@kernel.org, David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com,
	joro@8bytes.org, kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
	compatibility
In-Reply-To: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-6-tarunsahu@google.com>
	<DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
	<9huz5wy4tufo.fsf@tarunix.c.googlers.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261115203421.38c206b35f5b12e6@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_203427_699674_E025834F 
X-CRM114-Status: UNSURE (   7.03  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: 1.2 (+)
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

Hi Tarun,

tarunsahu@google.com writes:
>Techinically this is just for readability.
>
>WDYT?

It doesn't help readability in the generated docs, though. kernel-doc
splits the parameter list on the comma inside the macro, so
kho_preserve_vmalloc() comes out as

     int kho_preserve_vmalloc (void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc# *fhdr))

and the struct memfd_luo_ser and struct luo_session_ser definitions in the
ABI docs end up with a member like

     DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;

I'd go with Pasha's suggestion and use struct kho_ser_hdr directly. The
pointer can then say which payload follows it with a comment.

Chris

