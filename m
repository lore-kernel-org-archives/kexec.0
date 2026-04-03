Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDE9E7E376
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YH1Zm0pdIauW53+MKVBdPUDWUtbtD9Skg5FcwhJhtQ0=; b=prHWa8fAslYW7JVx5nQO9qM4C5
	728DL7Wrbv94SQNui5BDrHc1CVFnzxSf0TkMVJ8uovvM4xOlbq/S/GWZoNfd+F5+3mWOb2diWirwy
	4mXA6413y0YxoDeDZkVShnDA+l1L//J7a5L7V+P4SUD4ClGLfqFTIj4xRwmvVOpTlZ4795PRGPQAt
	M/e4pBKow4Q7RgBurH/MrP0MFLsBY6ViRdCUwo0fYTuJnn3kc68XeZMU8/dJy6k11u4Inre0JUDYM
	NG9L2Z5JfwEVKXcoYVCZE566ly0ZyIZuspYMMtCZ/ZCxNidrD1waeJF4FJq+oVhpyATViochTba5B
	JoLFGQlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ch6-00000001xPZ-2Lor;
	Fri, 03 Apr 2026 11:28:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ch4-00000001xPF-2ShR
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 11:28:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A48CE44100;
	Fri,  3 Apr 2026 11:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA9EC4CEF7;
	Fri,  3 Apr 2026 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775215682;
	bh=MabZ8ZNxlfCbCNmRDlhcdrRriNXoWOt9AGIbHCeoMZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uBvAbrlTeTRt2+30VJbA5n2wjqDEx6Y995UcLZKvOhxPUEqt9Ea/BEaDo7MYuOO/8
	 vEKvhY+w8cpNON5DPGwQsrTq9Uw0YWxNLCfXZUH+vLLwKGTpVsChEZSNF4sN4I56cC
	 ES0kSoQhuSWJt4anekYaIuTx2YLkGbKvhTRR+gQtItlkZZf4p89S1bdMdaO+/9moZB
	 vUXSW5X0CexGi0LLcIdzFf3PzgAL/zkFbJr9QyllIdBwUxg2CYoRMKrnzhU9LBQ+G6
	 6CDpwqeU9YncpUaRpYDJnG1EjWwqp185HKLkSNniPBj7PNu6Tst0FThD0l8Et1Ksse
	 Q97kGfkJHKfkg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usama.arif@linux.dev,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v9 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
In-Reply-To: <20260316-kho-v9-4-ed6dcd951988@debian.org> (Breno Leitao's
	message of "Mon, 16 Mar 2026 04:54:34 -0700")
References: <20260316-kho-v9-0-ed6dcd951988@debian.org>
	<20260316-kho-v9-4-ed6dcd951988@debian.org>
Date: Fri, 03 Apr 2026 11:27:58 +0000
Message-ID: <2vxzmrzkcmgx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_042806_641751_B593EA38 
X-CRM114-Status: UNSURE (   7.21  )
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

On Mon, Mar 16 2026, Breno Leitao wrote:

> kho_in_debugfs_init() calls fdt_totalsize() to determine blob sizes,
> which assumes all blobs are FDTs. This breaks for non-FDT blobs like
> struct kho_kexec_metadata.
>
> Fix this by reading the "blob-size" property from the FDT (persisted
> by kho_add_subtree()) instead of calling fdt_totalsize(). Also rename
> local variables from fdt_phys/sub_fdt to blob_phys/blob for
> consistency with the non-FDT-specific naming.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

