Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA117106ACD6
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 16:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aCV6AtrZqJOTKDcJoDwJvJmch/wh+FICVhihLLbm0gc=; b=ZmdqL5XcHANJ9GiszHsGaK7kg7
	eCr8mCJuyDu4+Qi9ZwkxCNswk5rFHa/U9TdrZ/dxEySP9Lp2zPblbIvhb/ZBGaC470+Q1ZbaYZ50g
	pMVMMAwE5JwlHKooI18H2LAcUx52MsHcj2+Nip/sPA7z3AeYG//OsrhdJdC7MGUDMCOORaj6c9iuS
	FPyH7kiSwuPfE6814BnyBxLZD3EzGTR7uAaGwg3+ivdW7kyVE2Q0Os0qEegZq/Ftapir5YT73ec37
	uAznCyK7NWyUoMpp6Nkf46ZFRwb1kyIWWdtaqHs+G5unt7sIsU5JJebtwqHx//3M7unLkIrq3nGyH
	jN6+4NWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0jAU-0000000EcBF-3j3K;
	Thu, 12 Mar 2026 16:45:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzmay-00000008Yki-0T8T
	for kexec@lists.infradead.org;
	Tue, 10 Mar 2026 02:13:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773108793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCV6AtrZqJOTKDcJoDwJvJmch/wh+FICVhihLLbm0gc=;
	b=Q9eTEjCJGTSIR0My6f7xooqePX+H8yKQJyD5pdHcxG5uhW2ivc2YpDBI2SBKcNBshPl83h
	YhaIRIT6ThlcFyLSP3yYbWlIYswr6swq3sbC301fIB2UWQsKrxN0HpZXZxH4ETZ1lAOjyM
	jUbZJ0DAmocdFYa9OQ4uQ28oQJNysbc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-0W-wL2VWPKuFFCHVPIHhug-1; Mon,
 09 Mar 2026 22:13:09 -0400
X-MC-Unique: 0W-wL2VWPKuFFCHVPIHhug-1
X-Mimecast-MFC-AGG-ID: 0W-wL2VWPKuFFCHVPIHhug_1773108784
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 810F31956050;
	Tue, 10 Mar 2026 02:13:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C06ED1800761;
	Tue, 10 Mar 2026 02:12:54 +0000 (UTC)
Date: Tue, 10 Mar 2026 10:12:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	rdunlap@infradead.org, pmladek@suse.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, paulmck@kernel.org, lirongqing@baidu.com,
	fvdl@google.com, rppt@kernel.org, ardb@kernel.org,
	leitao@debian.org, sourabhjain@linux.ibm.com, jbohac@suse.cz,
	cfsworks@gmail.com, osandov@fb.com, tangyouling@kylinos.cn,
	ritesh.list@gmail.com, hbathini@linux.ibm.com,
	eajames@linux.ibm.com, songshuaishuai@tinylab.org,
	kevin.brodsky@arm.com, samuel.holland@sifive.com,
	vishal.moola@gmail.com, junhui.liu@pigmoral.tech, coxu@redhat.com,
	liaoyuanhong@vivo.com, fuqiang.wang@easystack.cn, brgerst@gmail.com,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <aa9-HYdKT8MhAjhi@MiWiFi-R3L-srv>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20260302035315.3892241-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N-PdyisCVFS46gPh7YSqooEe-aDptxWawA6-baPeKsQ_1773108784
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_191316_442375_BDF9E4B4 
X-CRM114-Status: GOOD (  10.91  )
X-Mailman-Approved-At: Thu, 12 Mar 2026 09:45:47 -0700
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

On 03/02/26 at 11:53am, Jinjie Ruan wrote:
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> Rebased on v7.0-rc1.
> 
> Basic second kernel boot test were performed on QEMU platforms for x86,
> ARM64, and RISC-V architectures with the following parameters:
> 
> 	"cma=256M crashkernel=256M crashkernel=64M,cma"

The whole series looks good to me, thanks.

Acked-by: Baoquan He <bhe@redhat.com>


