Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00361C44512
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ldlKJTt83OroR2A75ml0k59gQsXf+w2G0f8AwORm5GQ=; b=XKJ8PLJOu2ZG6S52/T3A59Acz9
	sh0/tQR0WuH5GN1ChunctTT/NtDSru3BtMekCe0tDf0KKtqZRLL4y3IxKx3y3lGSlNSrUhNU33fXG
	t00td8X0hzkXRm+4QtBh1H5j2P6S3xStyY0Zgo+wKP40ORyLDqGdqJIcsSH1L9+UliIBNA+m4a4u+
	xivEkDYKddyxoiR7lGiEbpJe34vOKM8ro2ppaY1G5LlJecjZFQbAnVhvDjETXNNHeFDwyNTVvrcMo
	4HjBcvfaPmy47YwUIZBObaJZ/3Wuj/F4ksOzRO/QRoZhqoa4Run6LUK9FqS2hFgxB1YjlsgcOuMFe
	9mx2MkEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNV1-0000000HYJh-3N3Z;
	Thu, 16 Jul 2026 14:55:43 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNUz-0000000HYJ3-0oQ7
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 14:55:42 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-81e69a2db34so8299957b3.0
        for <kexec@lists.infradead.org>; Thu, 16 Jul 2026 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784213740; x=1784818540; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ldlKJTt83OroR2A75ml0k59gQsXf+w2G0f8AwORm5GQ=;
        b=SCLRHXRfMKOnplcM/FbDUfi7x4YQmzP1YpevQIoeHjMMB6g7feQBWrEgO51v4Fqakm
         Ne3dY9SZ0rBQ8e1vHP/hrUW9d800YdH8Q9a/mV14HvTNH0bT6yyJH01qHqSx8iOjefNP
         WZTQuzRf3Z2pNIP2TUROnxF3dekA/fuZMatocUb0MVf6yFpsBgvhFh5HIt3PKeHp+YTi
         te1l7YZ1KMKfmLoi0tbj3dsziiGP+leZ9ywBsOzTxEc095GiNE4FFVmbMSKOoAWlGj9e
         ua2hpHt2+RSHPr8O1SBd8+ajPGm+nkO6CWj0YZ990KtHN3DA9tw3MU1sgpMjBvPeBqld
         1b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213740; x=1784818540;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ldlKJTt83OroR2A75ml0k59gQsXf+w2G0f8AwORm5GQ=;
        b=cZ4NydnSjQyUiGl4bA2abWIEr5JuBJ9wIDX4KEWvAdvEogQxh+s2aEMIaWuiOJk7R6
         y3n9BD9goCrC4mGaiHW4LLanebO3Q5GXtq0qXTvv8dAG25M/jFYrH5e7SP9XbsYv+OFa
         mwMr7lSyzkZAUa8VauErSmVt2Sy75fzt84hoUb3Cvktl3KsooqQErPLZNAvkC+GILN82
         /gdM+/RMVipNBQ9v3/ZcJWJPt0j6285LyrG69Wwx0Sj4cgTr3d5CWFgqWoZeUdxHk0od
         eQHy68jXDlp06qtxesOHho7amW+KkIteItj52L9m5OLZKPEFI1UmD8gS8TCuSVqbdCZx
         lNYg==
X-Forwarded-Encrypted: i=1; AHgh+RpePQhLRJ8o+kBRXOfjy5mQOmC7LH2rtJH3prXQc+X5PdC+vFMHImlwsDOZQUN5n3FuPbdvOA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxW63c4KXSdB9H+nz0gSXrvWJqUyAzmBsuDumFodWLSuy1URYuI
	kw0mIsg8W4IzYIJoeIDAE2PG5i7F08OB7FDcJHopA2hu72vdKJjU53k9Jys2xGNfm8Q=
X-Gm-Gg: AfdE7ckCzU/wtfkguNDhyyBpHErtnocdFsYNc29MQKsHW/SenizVEleIu0UDWdqGTNU
	HbYZmcr7ZteBXbS7pFo4uZkL/2//TIbYQkmHPsQ3zM1klxpMWRJrEhtwn8Q5vQw44EdkbyYzldE
	2M+NGbmepKs73WgKoq1JPPWnh1CWbiq0+Ien6Kodhb+oxM+7LLP2917QlsvKjazLE09QKTR6DLd
	Z8oVh7SM9o+d5P7oPpe0EQ6L4qNH608Nfr+DAOWqQJKlLi+Lrmw0W3G2zdwFeuufN6EB1Ncb1FH
	ypGiVSIjhK5Poavd9yDxt2EVzWhINZjrVDE32Bx9R6U6C5bM91q3pWETJc2mUQVqwU/F+TnTk/h
	QV+34LJ6z4M2OSPszo18HdoSOkE4yhA6xrgToSGsfW6o5n0/imyXwCZBkvKtYCJCAeaoqSHjjfJ
	TpkyccFxiwnQ9Ase2wOqvSi2YiXBaPr/hhN0fpdQlM4JkR3ZObHvzcVR+wmUuJKDpms9pjuAgqN
	hXNNgJp2a8D
X-Received: by 2002:a05:690c:688e:b0:81d:ff0a:2cfe with SMTP id 00721157ae682-81ecf776a35mr56530767b3.8.1784213739802;
        Thu, 16 Jul 2026 07:55:39 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ed77e8ca7sm35824487b3.1.2026.07.16.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:55:39 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:55:38 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Sagi Shahar <sagis@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	"Andersen, Tycho" <Tycho.Andersen@amd.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Matlack <dmatlack@google.com>,
	"Heyne, Maximillian" <mheyne@amazon.de>,
	James Gowans <jgowans@amazon.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Praveen Kumar <kpraveen.lkml@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	Chenghao Duan <duanchenghao@kylinos.cn>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Sean Christopherson <seanjc@google.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, linux-mm@kvack.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Preserving TDX module during kexec with live update
Message-ID: <aljw6vDaeEdhzZdy@google.com>
References: <CAAhR5DGpL6_ViMwQ0nKzTgOoziE_oq8JofpO-VtHBXK37uO-FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhR5DGpL6_ViMwQ0nKzTgOoziE_oq8JofpO-VtHBXK37uO-FA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_075541_245761_7E823AB3 
X-CRM114-Status: GOOD (  28.63  )
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

On 07-15 18:28, Sagi Shahar wrote:
> Hi,
> 
> I started looking into preserving the TDX module across live updates
> and I'm not sure what the best approach is. I tried looking into using
> flb as David M suggested but I don't think this approach works for the
> TDX module.
> 
> Right now the way that TDX supports kexec is by disabling the TDX
> module on kexec and then reinitilizing it on the next boot [1]. This
> approach clears the TDX module state so any TDX VM from the source
> kernel won't be able to resume running on the destination kernel.
> 
> In order to support live update while keeping the VMs alive we need to
> skip the TDH_SYS_DISABLE call and instead preserve pages used by the
> TDX module such as the TDMR pages from the source kernel.

Agreed.

> 
> From what I understand, using flb will tie the TDX module save/restore
> to the lifecycle of the VMs depending on it. This means the module
> will be restored too late during kernel boot, after the VMs are
> restored using the live update IOCTLs.

That is not correct. FLBs specifically can be restored very early in 
boot. We do that for HugeTLB preservation, for example.

liveupdate_flb_get_incoming() does not require userspace to resume or 
restore VMs. You can call it super early in boot to see if there is FLB 
data present and, if so, change the way the module is initialized during 
boot.

> 
> I'm thinking we should preserve the TDX module during the shutdown
> stage of the source kernel. Perhaps we can preserve the pages used by
> the TDX module as we allocate them on the source kernel and pass
> pointers and additional metadata during KHO. Then on the destination
> we need to pipe this information to where the TDX module gets
> initialized during the KVM module initialization.

Please don't invent another state machine; instead, use the existing 
one.

Pasha

> 
> I haven't found a device that acts in a similar way so I'm not sure
> how complicated this will be or if there's a better approach.
> 
> I would love to hear your thoughts and if you have any pointers on
> where this code can be implemented.
> 
> Thanks,
> Sagi
> 
> [1] https://lore.kernel.org/all/20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com/

