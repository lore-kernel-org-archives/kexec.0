Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E59C64ED8
	for <kexec@archiver.kernel.org>; Mon, 27 Feb 2023 15:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MWSbRQ+IkEWlW7ky7e9SS7Ffo6VoftdjVYROA8ZyxN8=; b=b0/unPHriKt7Ld
	R87reJa6Qfo/xtQ1D+hUXjmbRVN2N/9kFiS1ciJUqfAIaLxjL2pNUGrUvF6LrtSNH+yWiklwLbKlz
	NB+JCVmLHlxTDBXNFcAdsS0mbnxpCukJY5m0WlDwClFpVxoPjXH1C+euNLB9OTut61qS1hB5YUzxZ
	+80Wf804/YvDFaVsbIoCP6LkbDQdOauQwX2urHiRm7Ej2X9gc/eLpGUHLg010SHs8RQuvF9ayPC3S
	CBDt4zHD1YjIUO5LRSiJC5ao9rb3rIDbATVg1Ofq/JPifwKmEjlkQrdJSZyjUZK0r+DY07n4JsmoZ
	5VgVKdv3ZTJh8OH2k8ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWfHn-00ABK2-Jm; Mon, 27 Feb 2023 15:19:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWfHk-00ABHp-Rh
	for kexec@lists.infradead.org; Mon, 27 Feb 2023 15:19:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677511166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6jnskS/bIC0dPKtaxTBrzQLQ3WB9NMd7/sWBP44Yh0=;
	b=KA/8jRAgvMucb8p6TUvsycMG7WFkNa/zau5NdY2OCgNc/yoOlbmaXz7xLDid3ObxqIGKC0
	3l5ueCy0VGf7pQQix5yz0tpo1+WOBzMkBmQDKnYm3dtRkTq7/qdYYXSEQ0YyaaPvq9YBOW
	VYlG39LaddRoCA5s60QTMZZY2JJvzBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519--C0CBLUEMoOsa7rWHKM2kw-1; Mon, 27 Feb 2023 10:19:22 -0500
X-MC-Unique: -C0CBLUEMoOsa7rWHKM2kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A3F6101B450;
	Mon, 27 Feb 2023 15:19:22 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.58])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A3EE9404BEC5;
	Mon, 27 Feb 2023 15:19:21 +0000 (UTC)
Date: Mon, 27 Feb 2023 16:19:19 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Youling Tang <tangyouling@loongson.cn>
Cc: Simon Horman <horms@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] kexec: Default __NR_kexec_file_load is set to
 undefined
Message-ID: <20230227161919.7c4884cd@rotkaeppchen>
In-Reply-To: <1677232268-2451-1-git-send-email-tangyouling@loongson.cn>
References: <1677232268-2451-1-git-send-email-tangyouling@loongson.cn>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_071929_016608_9A767770 
X-CRM114-Status: GOOD (  21.06  )
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

On Fri, 24 Feb 2023 17:51:07 +0800
Youling Tang <tangyouling@loongson.cn> wrote:

> The initial reason is that after the merger of 29fe5067ed07
> ("kexec: make -a the default"), kexec cannot be used on LoongArch,
> MIPS .etc architectures. We need to add "-c" for normal use. The
> current kexec_file_load system call is not implemented in
> architectures such as LoongArch, so it needs to pass kexec_load.
> So we need to set __NR_kexec_file_load to undefined in unsupported
> architectures. This will return EFALLBACK via is_kexec_file_load_implemented,
> and then via kexec_load.
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
>  kexec/kexec-syscall.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index be6ccd5..ea77936 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -59,9 +59,7 @@
>  #endif
>  #endif /*ifndef __NR_kexec_load*/
>  
> -#ifdef __arm__
>  #undef __NR_kexec_file_load
> -#endif
>  
>  #ifndef __NR_kexec_file_load

I don't think this will work as intended. 

On the top of the file sys/syscall.h gets included. In there
architectures that support kexec_file_load define __NR_kexec_file_load.
This also means that if an architecture doesn't support kexec_file_load
__NR_kexec_file_load shouldn't be defined in the first place. Thus I
suggest that you find out why sys/syscall.h defines
__NR_kexec_file_load for LoongArch even when the system call is not
supported and fix it there.

Thanks
Philipp 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
