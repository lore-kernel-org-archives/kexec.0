Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A257EEB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 00:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oQ9WsP+k8WIggHdZ2IoYSnFtksb6we6BTt4GWGiQ+c0=; b=AM1RF7fWcK39fj
	rvgxInLl0y7aFP4YIBfGkNV3vuw2KxArvwi+b2o+orUEQDpJ2MFTbd/RoAdK4ovCKtTEEBtH1KKJg
	sy0rnmQtGkZN3RsJ1+9fnqHrTO87VrsJMHp/eBFS3kdhSXkuSYvJm9jsbdsZpUX/d3+2Cu2sDUkSZ
	w99TxcnIYHNr/LP6egkT/yZyiKx8+tZV6+2jYD2tg46sAzITmv5XqjbZBSq5y1M0c2uH6ncmSLTWb
	AIcFIR4UIwYSamag+Uvriny5zVD348iVe5ovs4x3aS+GSIBfw5fyDHKO8wWVoPJgcitzWcA4Y+xpp
	yxogkZfiCZJX6jkgIFvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHZjg-0036gJ-1d;
	Fri, 07 Jul 2023 00:54:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHZjb-0036ez-2b
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 00:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688691243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERH9y8ye6CIkPXHBNLurA/7NLrmFEv4udLe/+CQPv00=;
	b=fuS3s7SBJFbxd2hgoTWQCl3YiU52dm5tm0uXFiY5rW2Gg8rKSLKAvVuT2fnm5MnF6wdf0O
	11HasldOTxWsZipvhAfNnr50Ftt8fGtXVeZVODTOr1t+ZrRI58oNbK4NigibLfXXbvwvt5
	Urvn4l5iisTw2Jiy2n6++XT4Th60BNQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-khqsK6SxNumoaCOB1zv-6g-1; Thu, 06 Jul 2023 20:53:59 -0400
X-MC-Unique: khqsK6SxNumoaCOB1zv-6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6F23101A528;
	Fri,  7 Jul 2023 00:53:58 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DA9A492C13;
	Fri,  7 Jul 2023 00:53:56 +0000 (UTC)
Date: Fri, 7 Jul 2023 08:53:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Chen Jiahao <chenjiahao16@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com,
	conor.dooley@microchip.com, guoren@kernel.org, heiko@sntech.de,
	bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org,
	atishp@rivosinc.com, thunder.leizhen@huawei.com, horms@kernel.org
Subject: Re: [PATCH -next v7 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Message-ID: <ZKdiIGRAQYx9zILj@MiWiFi-R3L-srv>
References: <20230704212327.1687310-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230704212327.1687310-1-chenjiahao16@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_175407_941091_FFDDCA96 
X-CRM114-Status: GOOD (  16.07  )
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

On 07/04/23 at 09:23pm, Chen Jiahao wrote:
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
> 
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Hence this patchset introduces the parameter option crashkernel=X,[high,low].
> 
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=X,high"; or reserve a memory range
> below 4G with "crashkernel=X,low". Besides, there are few rules need
> to take notice:
> 1. "crashkernel=X,[high,low]" will be ignored if "crashkernel=size"
>    is specified.
> 2. "crashkernel=X,low" is valid only when "crashkernel=X,high" is passed
>    and there is enough memory to be allocated under 4G.
> 3. When allocating crashkernel above 4G and no "crashkernel=X,low" is
>    specified, a 128M low memory will be allocated automatically for
>    swiotlb bounce buffer.
> See Documentation/admin-guide/kernel-parameters.txt for more information.
> 
> To verify loading the crashkernel, adapted kexec-tools is attached below:
> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
> 
> Following test cases have been performed as expected:
> 1) crashkernel=256M                          //low=256M
> 2) crashkernel=1G                            //low=1G
> 3) crashkernel=4G                            //high=4G, low=128M(default)
> 4) crashkernel=4G crashkernel=256M,high      //high=4G, low=128M(default), high is ignored
> 5) crashkernel=4G crashkernel=256M,low       //high=4G, low=128M(default), low is ignored
> 6) crashkernel=4G,high                       //high=4G, low=128M(default)
> 7) crashkernel=256M,low                      //low=0M, invalid
> 8) crashkernel=4G,high crashkernel=256M,low  //high=4G, low=256M
> 9) crashkernel=4G,high crashkernel=4G,low    //high=0M, low=0M, invalid
> 10) crashkernel=512M@0xd0000000              //low=512M
> 11) crashkernel=1G,high crashkernel=0M,low   //high=1G, low=0M

The series looks good to me, thanks.

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
