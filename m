Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA514C4706F
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-Id:References:
	In-Reply-To:Cc:To:From:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t1bb18j8eK9xRux+4b1Y7xCHDDX482AuXKLvib8vOnE=; b=brlAdA14WaEAoX
	htMJ1zXL2mMCZ/o8XqsImEZ2Pmy9PoofTqox7JV+1jYbB91mAilk1AgGY4PyqRrHD3+/Zp0+VGiex
	iBagPrDbVI91K/UO3pBjomr1jUN/BvTrfovApGW0xaAgmF2ea+LlByd7zs9BUws/k6qQXVCspgCfP
	DpCa/3UyvQhzfJceNm1gUhWmPGLcaKLFV4v0GHTyyWxD3DcHPzVbSTq64oop9/AY3Y2YC6f9QNwQe
	Glte/uuQyTDWECSGVH6sMmZvXl0cMwxZpuZNe0CHKgOMtGxnm9cvbav7BldpnG2gj9FQ9bQ3BMPYh
	ax977bqsO4ZFNQPqS+3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGmw3-006rZq-2a;
	Fri, 22 Dec 2023 21:19:59 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGmw0-006rVr-1l;
	Fri, 22 Dec 2023 21:19:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 25F55B80BA0;
	Fri, 22 Dec 2023 21:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8469C433C8;
	Fri, 22 Dec 2023 21:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703279983;
	bh=85pem+bV3h4CTSEJsl8gxNpUqeC+ByEZF8tHZajdLdo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XutJyryH1C0yuKZA/mta5BFslea1nPHuuMEMIqTexQjedrgggkrdf3eqN2kD6EkgU
	 3jCx87FzTjHItInuySR3YJOOZmFV211W9WBPfOQXj+lHVaF9uXE6yR6kBTdYnjJhdQ
	 s70fgyCI5FDyEx/7pzbczFpZNRK/qYjTXh+G6TNTSIAAXIHxfpWMzIAO4LYqjrX9U5
	 wAjkBSNhgkiJ/W8etslilyY1mQKWxdEWarTXXTaBT+uPKmD129ajAHNB4wLfI2NAKS
	 isigYPWU3YdtSbDmSciHfVtXZ1A1wrIOZH52LLSxoazUgCso3tswSPt13z5HfEGnjQ
	 qfE7JAi8wYz6Q==
Received: (nullmailer pid 2942328 invoked by uid 1000);
	Fri, 22 Dec 2023 21:19:39 -0000
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>, Usama Arif <usama.arif@bytedance.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw@amazon.co.uk>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com, Ashish Kalra <ashish.kalra@amd.com>, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, pbonzini@redhat.com, Anthony Yznaga <anthony.yznaga@oracle.com>, arnd@arndb.de, linux-doc@vger.kernel.org, linux-mm@kvack.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-trace-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Rob Herring <robh+dt@kernel.org>, Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, James Gowans <jgowans@amazon.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231222195144.24532-12-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
Message-Id: <170327997978.2942294.14458926896132199704.robh@kernel.org>
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Date: Fri, 22 Dec 2023 15:19:39 -0600
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231222_131956_878138_BA8B34F8 
X-CRM114-Status: GOOD (  15.57  )
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


On Fri, 22 Dec 2023 19:51:44 +0000, Alexander Graf wrote:
> With ftrace in KHO, we are creating an ABI between old kernel and new
> kernel about the state that they transfer. To ensure that we document
> that state and catch any breaking change, let's add its schema to the
> common devicetree bindings. This way, we can quickly reason about the
> state that gets passed.
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml:43:111: [warning] line too long (117 > 110 characters) (line-length)
./Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml:53:111: [warning] line too long (117 > 110 characters) (line-length)
./Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml:45:111: [warning] line too long (117 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-array.example.dts:29.25-39: Value 0x0000000101000000 truncated to 0x01000000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-array.example.dts:29.48-62: Value 0x0000000101000100 truncated to 0x01000100
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-array.example.dts:29.73-87: Value 0x0000000101000038 truncated to 0x01000038
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-array.example.dts:29.96-110: Value 0x0000000101002000 truncated to 0x01002000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.example.dts:29.25-39: Value 0x0000000101000000 truncated to 0x01000000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.example.dts:29.48-62: Value 0x0000000101000100 truncated to 0x01000100
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.example.dts:29.73-87: Value 0x0000000101000038 truncated to 0x01000038
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.example.dts:29.96-110: Value 0x0000000101002000 truncated to 0x01002000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace.example.dts:29.25-39: Value 0x0000000101000000 truncated to 0x01000000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace.example.dts:29.48-62: Value 0x0000000101000100 truncated to 0x01000100
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace.example.dts:29.73-87: Value 0x0000000101000038 truncated to 0x01000038
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace.example.dts:29.96-110: Value 0x0000000101002000 truncated to 0x01002000

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231222195144.24532-12-graf@amazon.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
