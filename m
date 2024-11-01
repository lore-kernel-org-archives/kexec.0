Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D95CE6F08A
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wvee75DUChxgjy9u8BrChWEKeQ4hBEN+nRwm38CBxoo=; b=mpWu3UJ0Rl2qxY
	cQMPPF4jVQkTMuHAq+j4nIjbds9VTDsAk1focKKyWrH+OPKui1m98cS7jX+hugaMkqvqafK4gkFrq
	sDX2+GY0cW2Pe/kkClDTODHsjUMqPlru5NOpKAmRSiUox8kDsdao4NgHCbTYGSc1pJ8WFklwDbJm5
	5JQFSktqLavtcNXTqvGlb1PovidnCQoJGLwBFq3WhbPlM0FIWfTyR/zwugljm07v0HNQRVQumCrL4
	uYImrF85iblgiFRDJwtPTmqMj8sU7wqeexp0dUwxi6eIkpmLBfVzgoOj4vSvkS4JtdyUpZueL5bci
	CMsmzoun6gMZfnU+V8CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6yN3-00000008Gg5-3wlc;
	Fri, 01 Nov 2024 20:35:49 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6yLj-00000008GLs-3IwT
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 20:34:31 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730493266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59h/4FnoLZZk0MjKW721si8AWaLkimLKPstUwXjURkM=;
	b=JeAOcNd9zrq7bXVafXOI2+VYSzyPRw9xhEyPY0SVc0xT2OTXiKahuugI6qbZlJXLpmgXdz
	S/DifpCHtGqRY77d4wpWjRyJY7j2tylDedWjt65ZEhiNjiZSeEOtRH21gcq9Hk0ZyMrP7G
	LOIMQhkAxoAsPe8PnwY42kXvpcPVqAZIYgCfLSh6SJfsTQQr/5RAqfl3q2oKQyk4Ltxa7+
	OIHZdyKZJnhBvKZQKt2IHL6yOoa9mnTcLfdL4qDvhLoRv6D8u7IaiccpXqnsEbT4G8diNJ
	n1wYxp5K/qPOc7dJvFwjgG/24Zuj2pRmN+72r0Z/SLTwxo0yreEGuOo062oJ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730493266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59h/4FnoLZZk0MjKW721si8AWaLkimLKPstUwXjURkM=;
	b=veMIp8Hu1Fbb53XXy+Sfvp5sOohtY6hRYmZZOUX8zQcskFrKrTVCheUAX3OX4Z0hp6Iatx
	V3AWbIBcUUOY/lBA==
To: Jarkko Sakkinen <jarkko@kernel.org>, Ross Philipson
 <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
In-Reply-To: <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org>
Date: Fri, 01 Nov 2024 21:34:25 +0100
Message-ID: <87a5eivgku.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_133428_001724_4B8DBA30 
X-CRM114-Status: GOOD (  18.42  )
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

On Fri, Nov 01 2024 at 12:28, Jarkko Sakkinen wrote:
> On Fri Sep 13, 2024 at 11:04 PM EEST, Ross Philipson wrote:
>> A quick note on terminology. The larger open source project itself is called
>> TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
>> the use of Dynamic Launch technology is referred to as "Secure Launch" within
>> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
>> in the code. The stub code discussed above is referred to as the SL stub.
>
> 1. I don't see any tags in most of the patches so don't get the rush. This
>    includes also patches for x86. Why I would care to review TPM patches
>    when there is over a dozen unreviewed and untested patches before it?
> 2. TPM patches have been in circulation in and out of the patch set
>    for some time now with little or no improvement.
>
> Why the sudden buzz? I have not heard much about this since last early
> summer.  Have to spend some time recalling what this is about anyway. I
> cannot trust that my tags make any sense before more reviewed/tested-by
> tags before the TPM patches.

If I intend to merge the patches then I surely have looked at them
deeply. I don't have to send a reviewed-by just to apply them
afterwards.

There was enough motion on these patches and this posting is in your
inbox for 6 weeks now without any reaction from you.

The TPM changes are very much independent from the x86 specific ones, so
why do you want x86 review tags in order to look at the ones which are
specific to your subsystem especially as some of them seem to address
real short comings there independent of trenchboot.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
