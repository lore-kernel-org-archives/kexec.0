Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D359FD5310
	for <kexec@archiver.kernel.org>; Fri, 27 Feb 2026 08:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P78RENVYqtBrXiPd84cUvPiHnkgGJOrq+jEIxq84kb8=; b=gQwOPg7l88R6WaLXaeZj1zGeCq
	ArGLDZYbTWmcwVjT4DBSiN6CEAL5HtVprN2SROm/zVGeb5YYiw9+LadYiWB989oBOS32dTRTszXK5
	MMNHrrsi63D0DaGImvDR2Eqr8B7L7tSWXgo+GCCp+zTnLS2Ti9/HU33rFg7Eq61/ToxptTf62X7NK
	/OyJzaevKOGdmKs2m/SdDb8orLs/VRvb86PiL8p7ThDjlU+oFk060646L/qMiy9QqoGhLvJ2iZ/jV
	jJgVSEGAxIvpSaLBnAp49TCtrFC/BCoBS+zayC+FMJ8xHE/jnVOpSAEWsOigkJ1nZ8Y/64Q/NU9t3
	PodkL5Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvtNL-000000080a1-1NYy;
	Fri, 27 Feb 2026 08:39:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqjZW-00000002tPL-2aQ7;
	Fri, 13 Feb 2026 03:10:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 71CDE44481;
	Fri, 13 Feb 2026 03:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C7CC2BC87;
	Fri, 13 Feb 2026 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770952221;
	bh=DlVfwlabE/UrECF6UV6WXsGt9/oBuJ/GsD7QC77Cks8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UqncZvbj0SmNgh6HQ/8D5uoY1GFs2E42UQc+n7sxEIeVzpQSz2IMx9zVWyz7j4P7+
	 tfOiJuyBxCrBsc2bAheTKpm+HdgmlfqnLuZA8ABBgI8BB4Lb7+u/ibAQCcDmZLMtyq
	 Dq96qaThsOFsKMLtIO2NcWVBj+w9FzkKz/VUtZt1faNqiV0NkWWQW2B8WwY9y04Gcd
	 aYQgjkp6ysc/U+JYrKXXYSXRfOItiv0ulvtW6qVQy79wnnzFOinDd0RjM46o52YLFs
	 e8YKvqJaZE43RDWwzJya1N+H3cjiEt8a6WCf6LJlnzNFusrJSTRdUBupc/JwHn7iy/
	 2DRGVckeUTNTA==
Date: Thu, 12 Feb 2026 20:10:16 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
    will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
    maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
    chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
    aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, 
    bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
    akpm@linux-foundation.org, bhe@redhat.com, vgoyal@redhat.com, 
    dyoung@redhat.com, rdunlap@infradead.org, kees@kernel.org, 
    elver@google.com, paulmck@kernel.org, arnd@arndb.de, fvdl@google.com, 
    thuth@redhat.com, ardb@kernel.org, leitao@debian.org, rppt@kernel.org, 
    osandov@fb.com, cfsworks@gmail.com, sourabhjain@linux.ibm.com, 
    ryan.roberts@arm.com, tangyouling@kylinos.cn, eajames@linux.ibm.com, 
    hbathini@linux.ibm.com, ritesh.list@gmail.com, songshuaishuai@tinylab.org, 
    bjorn@rivosinc.com, samuel.holland@sifive.com, kevin.brodsky@arm.com, 
    junhui.liu@pigmoral.tech, vishal.moola@gmail.com, dwmw@amazon.co.uk, 
    pbonzini@redhat.com, kai.huang@intel.com, ubizjak@gmail.com, 
    coxu@redhat.com, fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com, 
    brgerst@gmail.com, jbohac@suse.cz, x86@kernel.org, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
    kexec@lists.infradead.org
Subject: Re: [PATCH v5 4/4] riscv: kexec: Add support for crashkernel CMA
 reservation
In-Reply-To: <20260212101001.343158-5-ruanjinjie@huawei.com>
Message-ID: <97c57b38-2970-bdd7-2303-6de9a5c14d14@kernel.org>
References: <20260212101001.343158-1-ruanjinjie@huawei.com> <20260212101001.343158-5-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_191022_705843_C0761E91 
X-CRM114-Status: GOOD (  12.71  )
X-Mailman-Approved-At: Fri, 27 Feb 2026 00:38:19 -0800
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

On Thu, 12 Feb 2026, Jinjie Ruan wrote:

> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation. This allows the kernel to dynamically allocate
> contiguous memory for crash dumping when needed, rather than permanently
> reserving a fixed region at boot time.
> 
> So extend crashkernel CMA reservation support to riscv. The following
> changes are made to enable CMA reservation:
> 
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters.
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
> - Include the CMA-reserved ranges for kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore, which is already
>   done in the crash core.
> 
> Update kernel-parameters.txt to document CMA support for crashkernel on
> riscv architecture.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Looks reasonable.  If the plan is to have the kdump maintainers merge 
this, then:

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul

