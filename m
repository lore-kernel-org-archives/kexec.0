Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82A5C64EC4
	for <kexec@archiver.kernel.org>; Fri,  3 Mar 2023 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/LZ+zUtFkxGyzWwrJ1kjKCu/SaHasNuVmi4C3EFJEPs=; b=gYOJXL8JVPEJWW
	CUpXfQ+/52Dm6gLdeuwXN/+JgFuSyayHaJLhfCcKMEz8Ne46i533Dmhe7TDbDV/0q4oAi/yZa2EzD
	7CDLO0VZ0ELwd92/Oe5gQ78VqIczgrbaaYVTqd4IMdn+WIzP9yEoP0EaafQgZC+kSESdIopc4EixE
	6bGhwc9BS46oZtLJClDGPcrh7liWmwyQ1v6TqZebvZf55RlhoKNqVtztrZXWHBuMkuapADM5EuDzX
	cOnvf6RIaQVCBGsfCWa0Ebhh5eJx2R1RnbnlM3ZMxB2c6WsrrePOwKrYbHzhETCpVZbsDs1WBVmjD
	Rof4Q0Tl8jyhM14Os8eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY33y-0064vB-3R; Fri, 03 Mar 2023 10:54:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY33v-0064uD-16
	for kexec@lists.infradead.org; Fri, 03 Mar 2023 10:54:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677840892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRqjZpzidEB/3wqhOjC3fxQExYiR50pUnNXEP8PJWuQ=;
	b=NEaJoeIZNuzqkkAliCtp4pNf+StE1DS4nA8znLBRqEs/vzFz8nKlKPluTK3ElD4IUB/8rT
	eMXFsHQloNUXr7HcEKyakVgQSgeMQ1x5UOlhCiATklB0vqvnvXukN+89+BfQaVPL2J9UzY
	HyT7Gj2gPIMHA7YAGq7wakckZU4wjBw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-nHejzCj8N9e2iglClnLKpg-1; Fri, 03 Mar 2023 05:54:43 -0500
X-MC-Unique: nHejzCj8N9e2iglClnLKpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F281B3C10EC4;
	Fri,  3 Mar 2023 10:54:42 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.195.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A4FB40C6EC4;
	Fri,  3 Mar 2023 10:54:42 +0000 (UTC)
Date: Fri, 3 Mar 2023 11:54:34 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Youling Tang <tangyouling@loongson.cn>
Cc: Simon Horman <horms@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] kexec: Default __NR_kexec_file_load is set to
 undefined
Message-ID: <20230303115434.46b3ad94@rotkaeppchen>
In-Reply-To: <eb34b2b5-3965-27f1-2fe5-bb4fda4ef16b@loongson.cn>
References: <1677232268-2451-1-git-send-email-tangyouling@loongson.cn>
	<20230227161919.7c4884cd@rotkaeppchen>
	<eb34b2b5-3965-27f1-2fe5-bb4fda4ef16b@loongson.cn>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_025455_202953_F7DC05C3 
X-CRM114-Status: GOOD (  34.22  )
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

Hi Youling,

On Tue, 28 Feb 2023 10:02:16 +0800
Youling Tang <tangyouling@loongson.cn> wrote:

> Hi, Philipp
> 
> On 02/27/2023 11:19 PM, Philipp Rudo wrote:
> > Hi Youling,
> >
> > On Fri, 24 Feb 2023 17:51:07 +0800
> > Youling Tang <tangyouling@loongson.cn> wrote:
> >  
> >> The initial reason is that after the merger of 29fe5067ed07
> >> ("kexec: make -a the default"), kexec cannot be used on LoongArch,
> >> MIPS .etc architectures. We need to add "-c" for normal use. The
> >> current kexec_file_load system call is not implemented in
> >> architectures such as LoongArch, so it needs to pass kexec_load.
> >> So we need to set __NR_kexec_file_load to undefined in unsupported
> >> architectures. This will return EFALLBACK via is_kexec_file_load_implemented,
> >> and then via kexec_load.
> >>
> >> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> >> ---
> >>  kexec/kexec-syscall.h | 2 --
> >>  1 file changed, 2 deletions(-)
> >>
> >> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> >> index be6ccd5..ea77936 100644
> >> --- a/kexec/kexec-syscall.h
> >> +++ b/kexec/kexec-syscall.h
> >> @@ -59,9 +59,7 @@
> >>  #endif
> >>  #endif /*ifndef __NR_kexec_load*/
> >>
> >> -#ifdef __arm__
> >>  #undef __NR_kexec_file_load
> >> -#endif
> >>
> >>  #ifndef __NR_kexec_file_load  
> >
> > I don't think this will work as intended.  
> 
> Works fine in LoongArch after applying this patch.

I believe you. The problem is that it changes the behavior on other
architectures.

> >
> > On the top of the file sys/syscall.h gets included. In there
> > architectures that support kexec_file_load define __NR_kexec_file_load.
> > This also means that if an architecture doesn't support kexec_file_load
> > __NR_kexec_file_load shouldn't be defined in the first place. Thus I
> > suggest that you find out why sys/syscall.h defines
> > __NR_kexec_file_load for LoongArch even when the system call is not
> > supported and fix it there.  
> Yes, in the kernel, LoongArch uses the generic syscall number (in
> include/uapi/asm-generic/unistd.h), so __NR_kexec_file_load is
> defined as 294.

Ok, I see. I have expected that it is wrapped in some ifdef
CONFIG_KEXEC_FILE. But apparently that is not the case. Thanks for the
clarification.

> I think the simpler way is to modify it in kexec-tools as follows,
> #ifdef __loongarch__
> #undef __NR_kexec_file_load
> #endif

Yeah, looks like this is the best solution. Only thing you could do is
to merge it with the arm special handling. I.e. so it reads

#if defined(__arm__) || defined(__longarch__)
#undef __NR_kexec_file_load
#endif

But that is more a matter of taste. So you and Simon need to agree what
you like more.

Thanks
Philipp


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
