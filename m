Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0347C83F10
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ICDyDlyNmAwlL2Jlhe+M301ZQR7i2gWmYqE48pf4R+c=; b=5GNK3CreTlTVcB
	brBXX/Bhk5TKFXMVTY1/L4q9OlbW5d/zR2FUok8scjrx1maC/FUD8dNKK1kFxZk/87cokSPqhOj6+
	J+mH7CUQxGKRaJVct0G4iqVYnOFjpKZjb6vEnhfeRxXHdE46T/ufX2XFAMwHszYeFONbY40bkqUtM
	kfMw7hTJqd4UFoIp/ujspzN7WeeLwOB8oziaZBM5SVF4IydXP09wMe61V1kDjnlPl6DbqoyQ41c2q
	b+5z0LP5rxwsNoSK2FNCEFUWVO85jQKSJ0Ypbbjqma5kgd4mW6H+5igUYXsBP8VetxPDWg1lupFvX
	VjHAsTWONPqPKEEYb2AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qblRE-00FdRP-1A;
	Thu, 31 Aug 2023 17:26:36 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qblRB-00FdQo-05
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 17:26:34 +0000
Received: from skinsburskii. (unknown [167.220.2.160])
	by linux.microsoft.com (Postfix) with ESMTPSA id 576FD212A787;
	Thu, 31 Aug 2023 10:26:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 576FD212A787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1693502790;
	bh=nfTPUyS74OZsYR901USpAVlQVSz9pTNKt+fbqvjENVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9RJ2AkxTRu5KW6j3vuPuIkv8RGXzQueX0k4tMowfXafF6KiTLt+HqRDsZfJO8iNR
	 w3tVH/MsHxBW3JMnBMO6EPVN/0rAft0KVqSEGIYrvdhhEF/HCQxhtA88KbIydILFRS
	 5KSgCHtsY16bUrUWv5M5dGAa07Rp0Fzr09Wyyqr8=
Date: Wed, 30 Aug 2023 19:24:43 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Graf <graf@amazon.de>, "Gowans, James" <jgowans@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
	"dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"derek.kiernan@amd.com" <derek.kiernan@amd.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, iommu@lists.linux.dev,
	kvm <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH] Introduce persistent memory pool
Message-ID: <20230831022443.GA10414@skinsburskii.>
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082506-enchanted-tripping-d1d5@gregkh>
 <c26ad989dcc6737dd295e980c78ef53740098810.camel@amazon.com>
 <20230823024500.GA25462@skinsburskii.>
 <e0ed9fb9-8e7a-44ad-976a-27362f6e537a@amazon.de>
 <20230829220740.GA26605@skinsburskii.>
 <82416797-01aa-471a-a737-471297e37c4c@amazon.de>
 <1697efce-665a-43d5-b0be-7c03c0a4d850@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1697efce-665a-43d5-b0be-7c03c0a4d850@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_102633_095768_21DF2E22 
X-CRM114-Status: GOOD (  32.31  )
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

On Wed, Aug 30, 2023 at 07:39:18PM -0400, Arnd Bergmann wrote:
> On Wed, Aug 30, 2023, at 03:20, Alexander Graf wrote:
> > On 30.08.23 00:07, Stanislav Kinsburskii wrote:
> >> On Mon, Aug 28, 2023 at 10:50:19PM +0200, Alexander Graf wrote:
> 
> >> Device tree or ACPI are options indeed. However AFAIU in case of DT user
> >> space has to involved into the picture to modify and complie it, while
> >> ACPI isn't flexible or easily extendable.
> >> Also, AFAIU both these standards were designed with passing
> >> hardware-specific data in mind from bootstrap software to an OS kernel
> >> and thus were never really intended to be used for creating a persistent
> >> state accross kexec.
> >> To me, an attempt to use either of them to pass kernel-specific data looks
> >> like an abuse (or misuse) excused by the simplicity of implementation.
> >
> >
> > What I was describing above is that the Linux boot protocol already has 
> > natural ways to pass a DT (arm) or set of ACPI tables (x86) to the 
> > target kernel. Whatever we do here should either piggy back on top of 
> > those natural mechanisms (e.g. /chosen node in DT) or be on the same 
> > level (e.g. pass DT in one register, pass metadata structure in another 
> > register).
> >
> > When it comes to the actual content of the metadata, I'm personally also 
> > leaning towards DT. We already have libfdt inside the kernel. It gives 
> > is a very simple, well understood structured file format that you can 
> > extend, version, etc etc. And the kernel has mechanisms to modify fdt 
> > contents.
> 
> Agreed. This also makes a lot of sense since the fdt format was
> originally introduced for this exact purpose, to be a key-value
> store to pass data from the running kernel to the next one after
> kexec when the original source of the data (originally open
> firmware) is gone. It only turned into the generic way to
> describe embedded systems later on, but both the fdt binary
> format and the kexec infrastructure for manipulating and
> passing the blob should be easy to reuse for additional purposes
> as long as the contents are put into appropriate namespaces that
> don't clash with existing usage.
> 

I see. Using DT instead of introducing another format to pass metadata
is quite tempting.
The only problem I see here is that it enforces a user of x86 host to
use device tree.
I guess such a device tree can be fully constructred in kernel and then
added to kexec parameters by kernel itself thus keeping the such
matadata management independent from user setup.
But then how to combine this in-kernel device tree with the one,
provided by user?
Also, AFAIK user can override device tree via kexec paramaters, so I
guess placing kernel-specific data into a DT, controlled by user, isn't
very reliable.
Is there a way to pass multiple device trees over kexec?
Or should there be an implicit extention to patch user provided DT
with kernel metadata before kexec?

Thanks,
Stanislav

>        Arnd

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
