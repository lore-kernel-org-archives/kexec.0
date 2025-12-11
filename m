Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044EFD3E788
	for <kexec@archiver.kernel.org>; Thu, 11 Dec 2025 02:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54bOQMjE86a3OvBo4Z5xX+IGN2GAizUFzbeuDsoGB3k=; b=ULCM/tZFzB/Zl5A8ekiz0xq+pf
	wJY3Mudm8YvuXenGaxHgkAGAGzjxOkaOfi63W3iBaK4TG2kSBM+v54u8DYWq8kAitJ4tgUdZ8xtxy
	3fJ52IcRimWIPHPdlX8/fG57nq61f8HETr5+pO6eSwvRUW1A6/VtFZ94umuQL0Gm9fHg1y74rUwvh
	WE2rMyD7Z9mpbD1bgeRjagX22NJHHVNgdOlz4IeopOualNHUkMrV7wTxuxTsbEeOhKct8DdmlkYIw
	iFnzzqpuLDSnTVRE/KW3kxpfYuyuqrJGQxtllxpjyQzQudRE2QB5cwoxUL2NbU5fSGyhRuDuYggOM
	/j4uHhBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTWo1-0000000G8Tl-2Not;
	Thu, 11 Dec 2025 02:53:25 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTWny-0000000G8TN-3Lw3;
	Thu, 11 Dec 2025 02:53:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765421603; x=1796957603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nCP4Qrkpz8bVZqCHE4sJmyUXXrSPtXg/5yZwtOzX+cg=;
  b=J08opOngke1umBZevExKoS8Q+VvpR/LnN3aELgMmGqYPtpvZ4a10x9JD
   1/Rn6r98ozf7YZO/q6VPvpHBC4W4GDTnqyHBtXr45V3E6V6/dio0IVWUA
   GBUNMR1LGy47QxNZs3DvTZW+wEgNEXqhUCPUjfpeN0y+65C7IKBcaPqcz
   9fcN75jBTxHu9Z8ANXu3hWa2h8F0hy0Ji1mwqorVhK5gPzExY2XJoRoqW
   dNWx2R76Qb1r1EJpWF2bAUMGTOdjMNDHQOzqm9M1mLCb+Ha3+muJDU9CQ
   vY2geRZ3O05OljZxkV+EjvpfLnCVlOle7sVto3RzoU9voT6YOHnsv/Kfd
   A==;
X-CSE-ConnectionGUID: j9TeoBg0SsyOyewDu/PgGQ==
X-CSE-MsgGUID: 6bBdp/I2Roi5wx9j74+CFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="78765560"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="78765560"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 18:53:20 -0800
X-CSE-ConnectionGUID: Zev6oIoBRpaOqU2xDpbw4g==
X-CSE-MsgGUID: oROrgDILQmSBZQ6XsbXTuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="196738003"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 18:53:20 -0800
Date: Wed, 10 Dec 2025 19:00:06 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Changyuan Lyu <changyuanl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	corbet@lwn.net, dave.hansen@linux.intel.com,
	devicetree@vger.kernel.org, dwmw2@infradead.org,
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com,
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
	mingo@redhat.com, pasha.tatashin@soleen.com, pbonzini@redhat.com,
	peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org,
	rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com,
	skinsburskii@linux.microsoft.com, tglx@linutronix.de,
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 17/17] Documentation: KHO: Add memblock bindings
Message-ID: <20251211030006.GA9333@ranerica-svr.sc.intel.com>
References: <20250509074635.3187114-1-changyuanl@google.com>
 <20250509074635.3187114-18-changyuanl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509074635.3187114-18-changyuanl@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_185322_884934_CCDF1F96 
X-CRM114-Status: GOOD (  28.71  )
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

On Fri, May 09, 2025 at 12:46:35AM -0700, Changyuan Lyu wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> We introduced KHO into Linux: A framework that allows Linux to pass
> metadata and memory across kexec from Linux to Linux. KHO reuses fdt
> as file format and shares a lot of the same properties of firmware-to-
> Linux boot formats: It needs a stable, documented ABI that allows for
> forward and backward compatibility as well as versioning.
> 
> As first user of KHO, we introduced memblock which can now preserve
> memory ranges reserved with reserve_mem command line options contents
> across kexec, so you can use the post-kexec kernel to read traces from
> the pre-kexec kernel.
> 
> This patch adds memblock schemas similar to "device" device tree ones to
> a new kho bindings directory. This allows us to force contributors to
> document the data that moves across KHO kexecs and catch breaking change
> during review.
> 
> Co-developed-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  .../kho/bindings/memblock/memblock.yaml       | 39 ++++++++++++++++++
>  .../kho/bindings/memblock/reserve-mem.yaml    | 40 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 80 insertions(+)
>  create mode 100644 Documentation/core-api/kho/bindings/memblock/memblock.yaml
>  create mode 100644 Documentation/core-api/kho/bindings/memblock/reserve-mem.yaml
> 
> diff --git a/Documentation/core-api/kho/bindings/memblock/memblock.yaml b/Documentation/core-api/kho/bindings/memblock/memblock.yaml
> new file mode 100644
> index 0000000000000..d388c28eb91d1
> --- /dev/null
> +++ b/Documentation/core-api/kho/bindings/memblock/memblock.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +title: Memblock reserved memory
> +
> +maintainers:
> +  - Mike Rapoport <rppt@kernel.org>
> +
> +description: |
> +  Memblock can serialize its current memory reservations created with
> +  reserve_mem command line option across kexec through KHO.
> +  The post-KHO kernel can then consume these reservations and they are
> +  guaranteed to have the same physical address.

Hi Changyuan, Mike,

I am sorry I am late to this patchset. I am working on a patchset to use
KHO to pass reserved memory regions to a driver after kexec and I have a
few questions.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - reserve-mem-v1

Shouldn't this be "memblock-v1". IIUC, the compatible "reserve-mem-v1" is
to be used for the memblock reserved memory regions, not the memblock node.


> +
> +patternProperties:
> +  "$[0-9a-f_]+^":

Shouldn't this be "^[0-9a-f_]+$": ^ at the start of the pattern and $ at
the end of it? Or is this a KHO-specific rule?

Also, IIUC, this means that names of the nodes are hexadecimal numbers
whereas the example below has a "membloc" name. I assume this does not
refer to the subnode named "n1" as this does not follow the pattern
either Moreover, it should have been documented in the reserve-mem binding.

> +    $ref: reserve-mem.yaml#
> +    description: reserved memory regions
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    memblock {
> +      compatible = "memblock-v1";
> +      n1 {
> +        compatible = "reserve-mem-v1";
> +        start = <0xc06b 0x4000000>;
> +        size = <0x04 0x00>;
> +      };
> +    };

Thanks and BR,
Ricardo

