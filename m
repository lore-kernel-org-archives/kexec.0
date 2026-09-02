Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEEBC624D4
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 21:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rp9bm9bTm2PViQoUzBgxPxizOnj4XY3x0SF/Mb+IbGo=; b=qeMIVbVLq55hVebIyr3jUwDQiz
	xDY+SU33QlccqsIrvuaXyUIznijssSchgsnqdOvcLebCOthj0eq7EjwgFt2HqXxQr/2i7+lwmtoiN
	hqArfWJb1ROtIlAuKwnS+4IFDbg68sKDo4ui9kEVPKNu7PRyCS69WPQPnh3YyKj1MLRyKN+QB4eG2
	XhZNVIStwQx3hwJCVIR6r37jswiwNLgjvNbm3udAaRsTFBMJ4CBhUAqvegGP1btTgu5EZUAGDHCww
	GkAbDOXCr8hNAqr7GZNrOPVSu8Vx8/BsiuPmz6MZfPr+Gwyf6QNZFZer1kpZcnGQuQwP2Wq5zGg8R
	Fn6zC0sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1sfd-0000000FxIu-3x1f;
	Wed, 02 Sep 2026 21:39:01 +0000
Received: from mail.mainlining.org ([5.75.144.95])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1sfb-0000000FxIA-25Nt
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 21:39:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788385124; bh=Rp9bm9bTm2PViQoUzBgxPxi
	zOnj4XY3x0SF/Mb+IbGo=; b=nkykdCGDgJqoXlnwYE8z9ksDRqNjKJ6y/H3ykFjEzAIGIupZEq
	G4PYfcG/DJrf7NszYhnsMxGk/uNRu9+XH1B75ZAUU2gcrPesAUadK2f5mFzsRD/sJDSQH1vVIAh
	a5n9cn+sMvdgkdVCFkBemSsAy8LVHgAGD44tMMzcQ7hWc1pDYR0rRhuAKQp8pfpLmwlB29szVZC
	F46YVAPNTfX5DdSCyngZj4BMGupBrizq3VBEBqXLUUzE57Q78o2EtmSNR3SNtkcz5z1WvIrU9YG
	OrtdnXj73Bc3Bn/HJLZXJpoV+5AJ9JsTFKhPXnFOSBrRO6YLvMv2TraDM77LU0WDLTg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788385124; bh=Rp9bm9bTm2PViQoUzBgxPxi
	zOnj4XY3x0SF/Mb+IbGo=; b=JqQAFXYkWQKqBv7wGPIdLNNhEU82uK/BSl3fWQmPdQmpkCJm+r
	uJw3KwpkS1vz3ViPumVCQG1Z8CAqoLK6PZCw==;
Date: Wed, 02 Sep 2026 22:38:41 +0100
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
In-Reply-To: <e11aebd1-4952-46ce-849f-3a5d1ed65b85@intel.com>
References: <20260901071041.16311-1-ionut.nechita@windriver.com> <20260901071041.16311-2-ionut.nechita@windriver.com> <97887aeb-4454-4cb9-91ad-d0477d3ea5dd@intel.com> <39959DB1-92BE-4200-B286-69121F4D9E3D@mainlining.org> <e11aebd1-4952-46ce-849f-3a5d1ed65b85@intel.com>
Message-ID: <799F44D8-AFCA-4F59-9B5C-6C898D4DAB59@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_143859_683159_1CFBD971 
X-CRM114-Status: UNSURE (   9.78  )
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

On 2 September 2026 22:34:09 BST, Dave Hansen <dave.hansen@intel.com>
wrote:
>On 9/2/26 14:27, Bradley Morgan wrote:
>> On 2 September 2026 22:24:16 BST, Dave Hansen <dave.hansen@intel.com>
>> wrote:
>>> On 9/1/26 00:10, Ionut Nechita (Wind River) wrote:
>>>> Assisted-by: LLM
>>> This seems a _bit_ opaque and imprecise. Could you take a quick look
>>> through:
>>>
>>> https://docs.kernel.org/process/generated-content.html
>>>
>>> and try to err a bit more on the side of transparency for the next one?
>> 
>> Spoiler: new rule added in the docs, you no longer need to do
>Provider:Modelname any longer
>
>I'm just saying, for me, "Assisted-by: LLM" is almost worthless. I'm not
>going to go tilting at any windmills to get that doc changed, but it
>seems a borderline waste of bytes.
>

True, people argued that nobody cared what extras you used, all they needed
to
know is what the base you used is. E.g: LLM

>Please just say how you used the tools. At least for things you want me
>to merge.

Maybe a --- line note could be good?

E.g:

(Patch)
---
I used a LLM (Claude code?) to (discover, build, etc?) the patch.

 Yes, I owe an Documentation/process/maintainer-tip.rst update
>for this.


Want me to do it? Or could you cc me

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/

