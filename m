Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4620C624D4
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 21:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0idr2JfRYEloGcHAwnIDn5wMVIz23VU3IAPnXuADXE0=; b=0Zut5TmUTmbj7appMu5PrUaqnp
	N7vVT4o7sTx8zD2Wzuo3V2YvQX+Y6Dp96qAjSNw1XQDZqi7unLbzw8iwVTCr8FxSRHg2jsqBb5FeS
	ZRQg6k3IJ/PSY03T7rS9zgFIHt7aLg4GSyT2gDNjV6o/WPs2NvUhQxOeP8SQNfyeOzHL3nGvLgoZA
	5uuj9A705FBZQH2j7Z8dwLJOajlJjUK20gBaDptGjDmH5gY+H84PLbzAcbAdSXyaFNE8Nw+ndH5j6
	VhoYof5hmLOq1SuFVtKGCqOvZCq4/X936kXy/Ro1SOgz3S7qXMu56tKif67r5LEeY8v6Nduq59u9/
	Nm5lS+3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1sW4-0000000FwMR-46j1;
	Wed, 02 Sep 2026 21:29:08 +0000
Received: from mail.mainlining.org ([5.75.144.95])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1sW1-0000000FwLq-3SqS
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 21:29:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788384476; bh=0idr2JfRYEloGcHAwnIDn5w
	MVIz23VU3IAPnXuADXE0=; b=jJsv8Ul7OKU0x/hZ6X4zTfZ84MOslN+4lZUtD+XLA+dw1JfQr0
	d6yeDPI5VG9idy+DvGT79fIIq3QOQ8xDrz+bCX00MK4+S7rV3Q7UcvVXwCTcNOoCYUdyDuqWfJe
	Vnsy+9rIMw1Hga/3N8rWcuYqL/oXZ5dLEWYS41N+tsPeQaWl9YiIjaozfEuTRm/0N1JfmYQMQZZ
	Fb5Ccb5Ph80Af1TmarsD9BJ80OxDRqUXhOBNxqS6ycKS+Z2LktvYKJtAE4UlRxzdrB88m28+0Ex
	J/8V2uM5UnPc0QlTEttTuIEbSSSexhIJNQ9dMcPandw28V7G2aYW71knU5djFVl7rxg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788384476; bh=0idr2JfRYEloGcHAwnIDn5w
	MVIz23VU3IAPnXuADXE0=; b=tdr53U5sxswI/utko65F1O7SvAOfy0LpopgluullpTVsvw/63A
	AVtSGORs16OpdwThf1tjXFfT6bopGY+Q0hAw==;
Date: Wed, 02 Sep 2026 22:27:48 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Dave Hansen <dave.hansen@intel.com>,
 "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>, x86@kernel.org,
 kexec@lists.infradead.org
CC: tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, eric.devolder@oracle.com, hbathini@linux.ibm.com,
 sourabhjain@linux.ibm.com, ruanjinjie@huawei.com,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/2=5D_x86/crash=3A_reserve_elfcorehd?=
 =?US-ASCII?Q?r_for_CONFIG=5FNR=5FCPUS=2C_not_CONFIG=5FNR=5FCPUS=5FDEFAULT?=
In-Reply-To: <97887aeb-4454-4cb9-91ad-d0477d3ea5dd@intel.com>
References: <20260901071041.16311-1-ionut.nechita@windriver.com> <20260901071041.16311-2-ionut.nechita@windriver.com> <97887aeb-4454-4cb9-91ad-d0477d3ea5dd@intel.com>
Message-ID: <39959DB1-92BE-4200-B286-69121F4D9E3D@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_142906_007139_DED1C916 
X-CRM114-Status: UNSURE (   5.67  )
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

On 2 September 2026 22:24:16 BST, Dave Hansen <dave.hansen@intel.com>
wrote:
>On 9/1/26 00:10, Ionut Nechita (Wind River) wrote:
>> Assisted-by: LLM
>
>This seems a _bit_ opaque and imprecise. Could you take a quick look
>through:
>
>https://docs.kernel.org/process/generated-content.html
>
>and try to err a bit more on the side of transparency for the next one?


Spoiler: new rule added in the docs, you no longer need to do Provider:Modelname any longer


You only have to do

Assisted-by: LLM

Or

Assisted-by: (Let's say checkpatch --fix?)



--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

