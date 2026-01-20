Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002F6CA5FA8
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/9bvytCEld5G8KAmP/gN8sR/WGKE3Vrlr77tW8T8mGo=; b=I2UCKa/prXDl3IaV3qR9u5H53f
	kzQ1MCuSpQB6DEPP+5O5Ip9KDUmpms0V9zYRzupd2oy3ogYUSdXDeSaNQ3e52jABL9QayPfy3aevA
	2E7zUEmLTwuclFxPN71PwvbVdFpuArKxaENXk6IWE7GQL6zR7SxZTxa1uZYOXEnS/oZxWIqgDjNzS
	txJXGYbTYH3gKLhaxfYGL8Iykt1sb29ATz0LDIqD06cbmRBXsIMM/1rHxt1JV/ARattiYJjV4ZKPi
	fS6J5zczhD3TAJUqf9CR4aQuDHmD+6G7ZZzjkctIZIrOAaGwqiO3DcP7D9Ci1tNYKGD9ns42zJGPN
	PsQD1niw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEdX-00000004Aes-0SQF;
	Tue, 20 Jan 2026 16:31:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEdQ-00000004Adi-1w4k
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 16:31:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DAEDE40D88;
	Tue, 20 Jan 2026 16:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E42C16AAE;
	Tue, 20 Jan 2026 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768926675;
	bh=b+DEzrhzQLEZaXZekFtcaQ+EoJRPMgcm+b7GQK00jzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lllm8gJKsKXKIIbGa/8Mhv3Frwq887BG2Yh/JTKwz3Cs30xtnoRwE075kz3xMtERX
	 8VbtdWkRd8wwxP5YPBII0c5+/TxFnfnoWO5J0VWK2z1LEJcN+/JVeQpb3DHWY6LEET
	 OzS+5sAmZKniDDSXOJKC5RHqITIbB9bFf6b9yt5/FRwBrGabs4g0INX0mMVFG/gkfr
	 FFDWmgC9EXOvhj3znC5tjScmOclMBI2vArmTbFQ+2FX3nYuWFV+z6PgZoSZJYvHrPZ
	 Uw6nq+uPcpUyOkMuiF0eD8lwHjnxJqFJMQXhWOb0cZYZrk0xbG37uYBtMWZMFQR01U
	 heAP9PWzXct7w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Jason Miu <jasonmiu@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 6/6] kho/abi: add memblock ABI header
In-Reply-To: <20260105165839.285270-7-rppt@kernel.org> (Mike Rapoport's
	message of "Mon, 5 Jan 2026 18:58:39 +0200")
References: <20260105165839.285270-1-rppt@kernel.org>
	<20260105165839.285270-7-rppt@kernel.org>
Date: Tue, 20 Jan 2026 16:31:12 +0000
Message-ID: <2vxzqzrkckkv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_083120_499849_6F222ABF 
X-CRM114-Status: GOOD (  13.07  )
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

On Mon, Jan 05 2026, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Introduce KHO ABI header describing preservation ABI for memblock's
> reserve_mem regions and link the relevant documentation to KHO docs.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
[...]
> + *	/ {
> + *		compatible = "memblock-v1";
> + *
> + *		n1 {
> + *			compatible = "reserve-mem-v1";
> + *			start = <0xc06b 0x4000000>;
> + *			size = <0x04 0x00>;
> + *		};
> + *	};
> + *
> + * Main memblock node (/):
> + *
> + *   - compatible: "memblock-v1"
> +
> + *     Identifies the overall memblock ABI version.
> + *
> + * reserved_mem node:
> + *   These nodes describe all reserve_mem regions.
> + *
> + *   - compatible: "reserve-mem-v1"
> + *
> + *     Identifies the ABI version of reserve_mem descriptions
> + *
> + *   - start: u64
> + *
> + *     Physical address of the reserved memory region.
> + *
> + *   - size: u64
> + *
> + *     size in bytes of the reserved memory region.

I think you should also mention that the name of the node is the name of
the map.

Other than this,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> + */
> +
> +/* Top level memblock FDT node name. */
> +#define MEMBLOCK_KHO_FDT "memblock"
> +
> +/* The compatible string for the memblock FDT root node. */
> +#define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
> +
> +/* The compatible string for the reserve_mem FDT nodes. */
> +#define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
> +
> +#endif /* _LINUX_KHO_ABI_MEMBLOCK_H */
[...]

-- 
Regards,
Pratyush Yadav

