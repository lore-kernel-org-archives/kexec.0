Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E8DC47074
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=phHSsY/9prIpcKpC2XtWeNswELZABZvmAo4nl7daLYY=; b=BtHGU2+P6jHnjM
	/n1UwRR8nz/BsdQ5GbzhUVXBZHFUQRx1vhTR1FbeR752GV2AcO7JK8KFyG9jrLacLDWUI3p6G8LPR
	zlWpgG4KDkkyfbijaOJ2u1s5U2jDphY+8JT+9M+HNOrGNJ8WOmQyTwp4csTTQ5XEVwQWrHa/phsjW
	CI1tc/zpAH5oEfPzyx1fXDVB62xsIFoAa+9QmFzeh6rMwoW/C1u4ONwxp5G1WZfbTqqUeurS/SESM
	eMHJKT4FDqZRWe2ouqfAMJgPCaAfVxLylverY8dVKpd/0VyZSvxuDBLVECOcxkp1mSlc/B8JwBY3S
	FrRN4ppc7VxDGoFjSfKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgZD-008Md0-2K;
	Tue, 02 Jan 2024 15:20:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgZA-008Mb5-02;
	Tue, 02 Jan 2024 15:20:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1AEF061170;
	Tue,  2 Jan 2024 15:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335A1C433C8;
	Tue,  2 Jan 2024 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704208826;
	bh=28yPedgGByxBs/XllHPUgTPObBuags0avxhjHUIO2lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqEPk9zNaSyGDVA+YezzLsKj3ZNQGZ0SC4yCM9VyBETW2lskULwf3YW1bzCtNQIfP
	 6uXhHnR+VyjNxAdfsAuGy3PHqdk6b8MxmTW8LYv8wBb4ItzWZw49ksPEkR06n89PFp
	 2SHwc5dxr4TpgSfLoEJwYJVg/H6eXbQixr64Xmfg+I5UB0X4IH3NAAjmjbwdHFlysM
	 UpyPsK4q/fnx9eBausPSz+cLglyeXqhW6ZWKNvjm1TKrQumi+l1lHl2hw3OUh/RrfO
	 moE9dADO9rGte6dRtTv4Lf6g34Xmghec8dAzDY6uXDe6/E/fPOAc7PHu2mFtiS2u5m
	 S8IIs3i6VEKvg==
Received: (nullmailer pid 2861879 invoked by uid 1000);
	Tue, 02 Jan 2024 15:20:23 -0000
Date: Tue, 2 Jan 2024 08:20:23 -0700
From: Rob Herring <robh@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com, Anthony Yznaga <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Message-ID: <20240102152023.GA2821956-robh@kernel.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231222195144.24532-12-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_072028_141252_BA13131F 
X-CRM114-Status: GOOD (  30.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Dec 22, 2023 at 07:51:44PM +0000, Alexander Graf wrote:
> With ftrace in KHO, we are creating an ABI between old kernel and new
> kernel about the state that they transfer. To ensure that we document
> that state and catch any breaking change, let's add its schema to the
> common devicetree bindings. This way, we can quickly reason about the
> state that gets passed.

Why so much data in DT rather than putting all this information into 
memory in your own data structure and DT just has a single property 
pointing to that? That's what is done with every other blob of data 
passed by kexec.

> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  .../bindings/kho/ftrace/ftrace-array.yaml     | 46 +++++++++++++++
>  .../bindings/kho/ftrace/ftrace-cpu.yaml       | 56 +++++++++++++++++++
>  .../bindings/kho/ftrace/ftrace.yaml           | 48 ++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
>  create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
> 
> diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
> new file mode 100644
> index 000000000000..9960fefc292d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/kho/ftrace/ftrace-array.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ftrace trace array
> +
> +maintainers:
> +  - Alexander Graf <graf@amazon.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ftrace,array-v1
> +
> +  trace_flags:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Bitmap of all the trace flags that were enabled in the trace array at the
> +      point of serialization.
> +
> +# Subnodes will be of type "ftrace,cpu-v1", one each per CPU

This can be expressed as a schema.

> +additionalProperties: true
> +
> +required:
> +  - compatible
> +  - trace_flags
> +
> +examples:
> +  - |
> +    ftrace {
> +        compatible = "ftrace-v1";
> +        events = <1 1 2 2 3 3>;
> +
> +        global_trace {
> +          compatible = "ftrace,array-v1";
> +          trace_flags = < 0x3354601 >;
> +
> +          cpu0 {
> +            compatible = "ftrace,cpu-v1";
> +            cpu = < 0x00 >;
> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
> +          };
> +        };
> +      };
> diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
> new file mode 100644
> index 000000000000..58c715e93f37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/kho/ftrace/ftrace-cpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ftrace per-CPU ring buffer contents
> +
> +maintainers:
> +  - Alexander Graf <graf@amazon.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ftrace,cpu-v1
> +
> +  cpu:
> +    $ref: /schemas/types.yaml#/definitions/uint32

'cpu' is already a defined property of type 'phandle'. While we can have 
multiple types for a given property name, best practice is to avoid 
that. The normal way to refer to a CPU would be a phandle to the CPU 
node, but I can see that might not make sense here.

"CPU numbers" on arm64 are 64-bit values as well as they are the 
CPU's MPIDR value. 

> +    description:
> +      CPU number of the CPU that this ring buffer belonged to when it was
> +      serialized.
> +
> +  mem:

Too vague. Make the property name indicate what's in the memory.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Array of { u64 phys_addr, u64 len } elements that describe a list of ring
> +      buffer pages. Each page consists of two elements. The first element
> +      describes the location of the struct buffer_page that contains metadata
> +      for a given ring buffer page, such as the ring's head indicator. The
> +      second element points to the ring buffer data page which contains the raw
> +      trace data.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - cpu
> +  - mem
> +
> +examples:
> +  - |
> +    ftrace {
> +        compatible = "ftrace-v1";
> +        events = <1 1 2 2 3 3>;
> +
> +        global_trace {
> +          compatible = "ftrace,array-v1";
> +          trace_flags = < 0x3354601 >;
> +
> +          cpu0 {
> +            compatible = "ftrace,cpu-v1";
> +            cpu = < 0x00 >;
> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
> +          };
> +        };
> +      };
> diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
> new file mode 100644
> index 000000000000..b87a64843af3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/kho/ftrace/ftrace.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ftrace core data
> +
> +maintainers:
> +  - Alexander Graf <graf@amazon.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ftrace-v1
> +
> +  events:

Again, too vague.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Array of { u32 crc, u32 type } elements. Each element contains a unique
> +      identifier for an event, followed by the identifier that this event had
> +      in the previous kernel's trace buffers.
> +
> +# Other child nodes will be of type "ftrace,array-v1". Each of which describe
> +# a trace buffer
> +additionalProperties: true
> +
> +required:
> +  - compatible
> +  - events
> +
> +examples:
> +  - |
> +    ftrace {

This should go under /chosen. Show that here. Start the example with 
'/{' to do that and not add the usual boilerplate we add when extracting 
the examples.

Also, we don't need 3 examples. Just do 1 complete example here.


> +        compatible = "ftrace-v1";
> +        events = <1 1 2 2 3 3>;
> +
> +        global_trace {
> +          compatible = "ftrace,array-v1";
> +          trace_flags = < 0x3354601 >;
> +
> +          cpu0 {
> +            compatible = "ftrace,cpu-v1";
> +            cpu = < 0x00 >;
> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
> +          };
> +        };
> +      };
> -- 
> 2.40.1
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
