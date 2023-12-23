Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5931C3DA6E
	for <kexec@archiver.kernel.org>; Sat, 23 Dec 2023 23:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/cLjbwklWIomfp4zyAECKTsLJt/RZGy24PyabdoKg5s=; b=ToSeZUGxV0rKbS
	4UGOfbLPKVtDfa6zkFaKG64qsT4wKvq1X834uCq7dUhWlG0DTqAZQgtrx0SYiP2QVbuw+/fb3iVcF
	KNLz4H6FICnw+oncVEHJZio5m8pWqZSH5Zkw8CgnhbWbDBDpUiRIS+yP6y7UP+dXOkm6JmQiqH5Cd
	bNLy3GJ218FVsAhmnHMZrB9XXcc9QYq+/RGif14bKFPsy14hO7H/iL8XsxHi+ZB7MZBsILtiH82D0
	z97vqCEprUMIIhgLm6WzM1cobKAEzE3PRvG6drxh4sd2YlasJi38+tBIAzCz9fGpADZk1GtmkHfyE
	5NOLdwf3ULauHVStKYog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHBIP-008aVS-0F;
	Sat, 23 Dec 2023 23:20:41 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHBIK-008aUg-2Y;
	Sat, 23 Dec 2023 23:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703373637; x=1734909637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k+KhPZsRbblVB5TlZ9Os7h40uFhyo0WJh9bKeRzhbeI=;
  b=daYNxVpbsDKUO4JQPFNtrjd/6bqATp44l0cxGLEcNTn2k/YUHdmfawA0
   YeDDCf7xsl85ijFpKXzjtI5CdPTE5p67FjCCCZhxhEC14VfxU24BW4EzO
   A1sx6HyOqfTWpmcYAYBylciWlOq1pT7Y/a/BSWan3FP4uVPHz7zM2dBS2
   w=;
X-IronPort-AV: E=Sophos;i="6.04,300,1695686400"; 
   d="scan'208";a="385480696"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 23:20:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 45BE440D5B;
	Sat, 23 Dec 2023 23:20:26 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:32696]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.220:2525] with esmtp (Farcaster)
 id 4e3d549d-4556-4d0e-b7ed-87d0eaff99ca; Sat, 23 Dec 2023 23:20:25 +0000 (UTC)
X-Farcaster-Flow-ID: 4e3d549d-4556-4d0e-b7ed-87d0eaff99ca
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 23 Dec 2023 23:20:25 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 23 Dec
 2023 23:20:19 +0000
Message-ID: <34e78a84-a29d-4b01-a860-cac3959f6cb6@amazon.com>
Date: Sun, 24 Dec 2023 00:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
 <39a33f9b-0290-428d-ab1f-f90856cdb31d@kernel.org>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <39a33f9b-0290-428d-ab1f-f90856cdb31d@kernel.org>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_152036_971900_9B725564 
X-CRM114-Status: GOOD (  34.46  )
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

Hi Krzysztof!

Thanks a lot for the fast review!

On 23.12.23 15:30, Krzysztof Kozlowski wrote:
> On 22/12/2023 20:51, Alexander Graf wrote:
>> With ftrace in KHO, we are creating an ABI between old kernel and new
>> kernel about the state that they transfer. To ensure that we document
>> that state and catch any breaking change, let's add its schema to the
>> common devicetree bindings. This way, we can quickly reason about the
>> state that gets passed.
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.


Ah, this is about directly CC'ing maintainers? I was slightly picky on 
CCs since the CC list is already a bit long for this patch set, so I 
limited the CC list to mailing lists and people that I know were 
directly interested. Happy to CC you next time.


>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.


Happy to fix up for v3 :)


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
> Missing description. Commit msg also does not tell me much. This must
> stand on its own and must describe the hardware. Whatever you have in
> cover letter, does not matter, especially that you did not Cc us on it.


Alrighty, I'll add descriptions and make the commit message stand on its 
own.

For quick reference: KHO is a new mechanism this patch set introduces 
which allows Linux to pass arbitrary memory and metadata between kernels 
on kexec. I'm reusing FDTs to implement the hand over protocol, as 
Linux-to-Linux boot communication holds very similar properties to 
firmware-to-Linux boot communication. So this binding is not about 
hardware; it's about preserving Linux subsystem state across kexec.

For more details, please refer to the KHO documentation which is part of 
patch 7 of this patch set: 
https://lore.kernel.org/lkml/20231222195144.24532-2-graf@amazon.com/


>
>> +maintainers:
>> +  - Alexander Graf <graf@amazon.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ftrace,array-v1
>> +
>> +  trace_flags:
> Underscores are not allowed. Does not look like generic property.


Let me make it "trace-flags" to not have underscores. Could you please 
elaborate on what you mean by generic property?


>
>
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Bitmap of all the trace flags that were enabled in the trace array at the
>> +      point of serialization.
>> +
>> +# Subnodes will be of type "ftrace,cpu-v1", one each per CPU
>> +additionalProperties: true
> No, this must be false. And it goes after required:


Ok, making it false and adding pattern matches instead for subnodes.


>
>
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
> Again, no underscores.


Ok :)


>
>> +          compatible = "ftrace,array-v1";
>> +          trace_flags = < 0x3354601 >;
>> +
>> +          cpu0 {
>> +            compatible = "ftrace,cpu-v1";
>> +            cpu = < 0x00 >;
> Drop redundant spaces.


I don't understand what you're referring to as redundant spaces? Double 
checking, I believe indentation is off for every line below "ftrace {". 
Is that what you're referring to? Fixing :)


>
>> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
> ? Do you see any of such syntax in DTS?


I was trying to make it easy to reason to readers about 64bit numbers - 
and then potentially extend dtc to consume that new syntax. KHO DTs are 
native/little endian, so dtc already has some difficulties interpreting 
it which I'll need to fix up with patches to it eventually :). I'll 
change it to something that looks more 32bit'y for now.


Alex




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
