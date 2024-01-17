Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB9EC47DA2
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0gylESk/ie0eZmBJnra0YRGE60NGx/y3RNgFMBrEP3Y=; b=gTDnzbDBdyaM0+
	uauYHUB8oh5azQ2r2KZtRREneE7xJODBfyES2OGkV6bCaunhBK3JyJlNBOMBanGpktqMZzHRW7Stc
	tGtG11aSBoFC358EZaepXXpSSAoKBHop3HesdYlEo/TKhY8P+BXuc4wMrgSZ/GJ3YI/WE69qMjCv4
	608MRuzbNie+Azx5fa6GBuRGzKSEzAT+EF4Q/m//ZP5WVaiBsQH6xf2vBRNe3xcR31uAuQf6K2kOn
	Q+RSQ+tTUAvCKouHCcRpE/SODXX3RawejBDp3udnlDlgSsnDbcS6qXw1xTXr+3wzvzsLy+oAQav+P
	Euo47DcsBZLHGPiiNDhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6Q1-00Gmmo-2G;
	Wed, 17 Jan 2024 13:57:25 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ6Pu-00Gmg8-26;
	Wed, 17 Jan 2024 13:57:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705499838; x=1737035838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sCbAsogEL9M6bXyV8ZRDEEuZUfshks5aG+BxCQOa/NY=;
  b=GlAwotCO7W5yqmNNZDUj4ifYZdgNipwYUMBF7bsZD2wdZ4FEFgjIU1j1
   H4BQ2S3d5UiyuUg+g88MNImKWAIIiyCrydo2ESIwYieLl+y8akFMcF1KZ
   GV6AweS2HHP4n191jdCB6YURV+bRQDRhUL6QVLPy9RBq6TXaw2EEYn7I1
   8=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="58966275"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 13:57:09 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id 8F1104A462;
	Wed, 17 Jan 2024 13:57:01 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:22279]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.164:2525] with esmtp (Farcaster)
 id 7447900b-b2ad-45a7-833b-230f16a2e7a7; Wed, 17 Jan 2024 13:57:00 +0000 (UTC)
X-Farcaster-Flow-ID: 7447900b-b2ad-45a7-833b-230f16a2e7a7
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 13:57:00 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 13:56:54 +0000
Message-ID: <48241e64-953d-4aeb-b4cf-f7eb0e1bffbe@amazon.com>
Date: Wed, 17 Jan 2024 14:56:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
 <20240102152023.GA2821956-robh@kernel.org>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240102152023.GA2821956-robh@kernel.org>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_055718_763035_EDEE90BA 
X-CRM114-Status: GOOD (  36.21  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hey Rob,

Thanks a lot for taking the time to review!

On 02.01.24 16:20, Rob Herring wrote:
> On Fri, Dec 22, 2023 at 07:51:44PM +0000, Alexander Graf wrote:
>> With ftrace in KHO, we are creating an ABI between old kernel and new
>> kernel about the state that they transfer. To ensure that we document
>> that state and catch any breaking change, let's add its schema to the
>> common devicetree bindings. This way, we can quickly reason about the
>> state that gets passed.
> Why so much data in DT rather than putting all this information into
> memory in your own data structure and DT just has a single property
> pointing to that? That's what is done with every other blob of data
> passed by kexec.


This is our own data structure for KHO that just happens to again 
contain a DT structure. The reason is simple: I want a unified, 
versioned, introspectable data format that is cross platform so you 
don't need to touch every architecture specific boot passing logic every 
time you want to add a tiny piece of data.


>
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> ---
>>   .../bindings/kho/ftrace/ftrace-array.yaml     | 46 +++++++++++++++
>>   .../bindings/kho/ftrace/ftrace-cpu.yaml       | 56 +++++++++++++++++++
>>   .../bindings/kho/ftrace/ftrace.yaml           | 48 ++++++++++++++++
>>   3 files changed, 150 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
>>   create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
>>   create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
>> new file mode 100644
>> index 000000000000..9960fefc292d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/kho/ftrace/ftrace-array.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ftrace trace array
>> +
>> +maintainers:
>> +  - Alexander Graf <graf@amazon.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ftrace,array-v1
>> +
>> +  trace_flags:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Bitmap of all the trace flags that were enabled in the trace array at the
>> +      point of serialization.
>> +
>> +# Subnodes will be of type "ftrace,cpu-v1", one each per CPU
> This can be expressed as a schema.


Could you please give me a few more hints here? I'm not sure I understand how :)


>
>> +additionalProperties: true
>> +
>> +required:
>> +  - compatible
>> +  - trace_flags
>> +
>> +examples:
>> +  - |
>> +    ftrace {
>> +        compatible = "ftrace-v1";
>> +        events = <1 1 2 2 3 3>;
>> +
>> +        global_trace {
>> +          compatible = "ftrace,array-v1";
>> +          trace_flags = < 0x3354601 >;
>> +
>> +          cpu0 {
>> +            compatible = "ftrace,cpu-v1";
>> +            cpu = < 0x00 >;
>> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
>> +          };
>> +        };
>> +      };
>> diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
>> new file mode 100644
>> index 000000000000..58c715e93f37
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/kho/ftrace/ftrace-cpu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ftrace per-CPU ring buffer contents
>> +
>> +maintainers:
>> +  - Alexander Graf <graf@amazon.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ftrace,cpu-v1
>> +
>> +  cpu:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 'cpu' is already a defined property of type 'phandle'. While we can have
> multiple types for a given property name, best practice is to avoid
> that. The normal way to refer to a CPU would be a phandle to the CPU
> node, but I can see that might not make sense here.
>
> "CPU numbers" on arm64 are 64-bit values as well as they are the
> CPU's MPIDR value.


Here we're looking at the Linux internal CPU numbering which I believe 
does not have to use the MIDR value?


>
>> +    description:
>> +      CPU number of the CPU that this ring buffer belonged to when it was
>> +      serialized.
>> +
>> +  mem:
> Too vague. Make the property name indicate what's in the memory.


"mem" is a generic property for every node in the KHO DT that contains a 
<u64 phys_start, u64 size> array that describes memory to pass over. I 
use it in generic code so that we don't need to do memory reservations 
individually per node. That means I can't change the name here.


>
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      Array of { u64 phys_addr, u64 len } elements that describe a list of ring
>> +      buffer pages. Each page consists of two elements. The first element
>> +      describes the location of the struct buffer_page that contains metadata
>> +      for a given ring buffer page, such as the ring's head indicator. The
>> +      second element points to the ring buffer data page which contains the raw
>> +      trace data.
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - cpu
>> +  - mem
>> +
>> +examples:
>> +  - |
>> +    ftrace {
>> +        compatible = "ftrace-v1";
>> +        events = <1 1 2 2 3 3>;
>> +
>> +        global_trace {
>> +          compatible = "ftrace,array-v1";
>> +          trace_flags = < 0x3354601 >;
>> +
>> +          cpu0 {
>> +            compatible = "ftrace,cpu-v1";
>> +            cpu = < 0x00 >;
>> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
>> +          };
>> +        };
>> +      };
>> diff --git a/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
>> new file mode 100644
>> index 000000000000..b87a64843af3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/kho/ftrace/ftrace.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ftrace core data
>> +
>> +maintainers:
>> +  - Alexander Graf <graf@amazon.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ftrace-v1
>> +
>> +  events:
> Again, too vague.
>
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      Array of { u32 crc, u32 type } elements. Each element contains a unique
>> +      identifier for an event, followed by the identifier that this event had
>> +      in the previous kernel's trace buffers.
>> +
>> +# Other child nodes will be of type "ftrace,array-v1". Each of which describe
>> +# a trace buffer
>> +additionalProperties: true
>> +
>> +required:
>> +  - compatible
>> +  - events
>> +
>> +examples:
>> +  - |
>> +    ftrace {
> This should go under /chosen. Show that here. Start the example with


It can't go under /chosen because x86 doesn't have /chosen :). This is 
not a device DT, it's a KHO DT.


> '/{' to do that and not add the usual boilerplate we add when extracting
> the examples.


What exact difference does /{ and ftrace { make?


>
> Also, we don't need 3 examples. Just do 1 complete example here.


Great idea :)


>
>
>> +        compatible = "ftrace-v1";
>> +        events = <1 1 2 2 3 3>;
>> +
>> +        global_trace {
>> +          compatible = "ftrace,array-v1";
>> +          trace_flags = < 0x3354601 >;
>> +
>> +          cpu0 {
>> +            compatible = "ftrace,cpu-v1";
>> +            cpu = < 0x00 >;
>> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
>> +          };
>> +        };
>> +      };
>> --
>> 2.40.1
>>




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
