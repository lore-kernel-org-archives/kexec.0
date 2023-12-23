Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6EDC3DA6E
	for <kexec@archiver.kernel.org>; Sat, 23 Dec 2023 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mVFNs74Pr8e83Z+MU2o4UY0ZiThhjOHCN2ruky+pANY=; b=tQpUZUyzdO/XEh
	ob+xvVZkQeA3xXtmrLuTuWjllzMI6l7IhzokdiPzaLPeKf83cyub35JbJzAv5MkWic6UsaHatYptE
	7fLv0eZdOSmkf6D6by0gwe8KsuXVJCOLSowpAc8z90I/bFVZXkd1gdu3WVlFmVSxEuTM9+Wyf/Kmk
	rDfryVs19waPuyHUdjtvJAaavF/taU3vnfjBdRzLHp4A4eCpU7qwo1xKGxNXo90/fbuaec6jI4xS6
	xeWCdrr6tfKuth5behFip5ZSfg98WJ+4FSrNaalkw1UJACIFDRnPV5jPgsDRU6dgTNceukTBH2khK
	zTDbN5e1IFcvHjVK32IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rH31x-0082Tr-0D;
	Sat, 23 Dec 2023 14:31:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rH31t-0082SV-2d;
	Sat, 23 Dec 2023 14:31:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 631A460B47;
	Sat, 23 Dec 2023 14:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBC6C433C8;
	Sat, 23 Dec 2023 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703341864;
	bh=5Yw2Br05+dFmIyBnAI8QmbQqjZjSr2mzpPb7WPvWLlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iYsg7m+95Q9TKQgUDW5gyCPibD+P4xxAtCcjZtk2OalbP+O8DDTIKjynI2Nf+xvZ4
	 R3xEVzVCGTDIpAFsyCEdHSLsldPna0cChecvFaboOiKSIUiVL+g7mEJhNXEatSnm+K
	 5MebrMXEfo88EwHdeiqzSSwHsSAE1Ui02HxNitxyC4vHX5VgkXSQPWS2TmmB7lgpP6
	 +F8Sjbo7PW1aXJYMitmq+1r/jjRsF8N2T57wzoUuHvmdglygSvz4Iyh/i26j9TTV+f
	 0ILzKwcATSdBAmm17mwsPPY+6HihbsBElDyU4Ppg/AYdNnYxfgJLhmdt/3RSCLC4OA
	 U/AeFfiKjK3qQ==
Message-ID: <39a33f9b-0290-428d-ab1f-f90856cdb31d@kernel.org>
Date: Sat, 23 Dec 2023 15:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org, x86@kernel.org,
 Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Rob Herring <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mark Rutland <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, arnd@arndb.de,
 pbonzini@redhat.com, madvenka@linux.microsoft.com,
 Anthony Yznaga <anthony.yznaga@oracle.com>,
 Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20231222195144.24532-12-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_063105_963454_FBE38DB0 
X-CRM114-Status: GOOD (  23.10  )
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

On 22/12/2023 20:51, Alexander Graf wrote:
> With ftrace in KHO, we are creating an ABI between old kernel and new
> kernel about the state that they transfer. To ensure that we document
> that state and catch any breaking change, let's add its schema to the
> common devicetree bindings. This way, we can quickly reason about the
> state that gets passed.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.

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

Missing description. Commit msg also does not tell me much. This must
stand on its own and must describe the hardware. Whatever you have in
cover letter, does not matter, especially that you did not Cc us on it.

> +maintainers:
> +  - Alexander Graf <graf@amazon.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ftrace,array-v1
> +
> +  trace_flags:

Underscores are not allowed. Does not look like generic property.


> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Bitmap of all the trace flags that were enabled in the trace array at the
> +      point of serialization.
> +
> +# Subnodes will be of type "ftrace,cpu-v1", one each per CPU

> +additionalProperties: true

No, this must be false. And it goes after required:


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

Again, no underscores.

> +          compatible = "ftrace,array-v1";
> +          trace_flags = < 0x3354601 >;
> +
> +          cpu0 {
> +            compatible = "ftrace,cpu-v1";
> +            cpu = < 0x00 >;

Drop redundant spaces.

> +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;

? Do you see any of such syntax in DTS?

Best regards,
Krzysztof


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
