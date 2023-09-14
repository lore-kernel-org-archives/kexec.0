Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043D2CA0EF3
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 04:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uZ3iA4JXLIF4nYi3L6HqLXwGbxUNucCNvWBkP2eUwDY=; b=e/pPqKVfd0u7Nw
	4+ixqiER8M5+98WRQ9Xru5x08j7xEC8++rHU5T6GfBLBnZdWs3RJhIc8L7JY6BcLOlooqEdJC8BzZ
	uGePhVhTZkl+sAXS29tFT5B4nUpvr0gzMzr3rIjzrEaIH2Q1fgnPWN6hy3cRrEKRctbUDozQQacW7
	Cmqnmqf0yQYrI7gLFUlrQTHap446x2c/brwuD0pjE39KIwmzdkKFiIh8SIwy0w1nOK59ZOaBySFXV
	v5Y90lzNxHLe37k9/9gR0f+qGW2nv1o6Cs5mDl9i5/df8SqKArHTbGnj4cQZ4wVrVCXDyQLtjnqsN
	ZeWJZ1uZdt4AgfWMVNgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgeA8-007MoN-0V;
	Thu, 14 Sep 2023 04:41:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgeA5-007Mo4-2H
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 04:41:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694666464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3bXAX87RWvBbot/wl4o5o2psWRwLqLOl+iTFzlKLtg=;
	b=IYDN3BuGReE3EbeO6Oc1Z21nLI3VxIDBTFvEnJiFUAvKcP93xzj1MWFUi8J2tqMUIz3CYx
	j39zMdg+incv3FUAGBlybYauKXs+QUUMwHpSbLQUKCoGyQZ49XWX8IBTJLsuV13sSoIzEh
	cDtSwiNDo51Elk5N0U8dpe7CHL+mTqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-LS6BjVi7O8qDXux5J0weow-1; Thu, 14 Sep 2023 00:40:58 -0400
X-MC-Unique: LS6BjVi7O8qDXux5J0weow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF40280523C;
	Thu, 14 Sep 2023 04:40:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AEFC240C6EA8;
	Thu, 14 Sep 2023 04:40:56 +0000 (UTC)
Date: Thu, 14 Sep 2023 12:40:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Kexec-ml <kexec@lists.infradead.org>,
	Dave Young <dyoung@redhat.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 1/2] vmcore: remove dependency with is_kdump_kernel()
 for exporting vmcore
Message-ID: <ZQKO1ckVu0Xj1abW@MiWiFi-R3L-srv>
References: <20230912082950.856977-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230912082950.856977-1-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_214105_841041_CAA3382C 
X-CRM114-Status: GOOD (  22.89  )
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

On 09/12/23 at 01:59pm, Hari Bathini wrote:
> Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
> While elfcorehdr_addr is set for kexec based kernel dump mechanism,
> alternate dump capturing methods like fadump [1] also set it to export
> the vmcore. Since, is_kdump_kernel() is used to restrict resources in
> crash dump capture kernel and such restrictions may not be desirable
> for fadump, allow is_kdump_kernel() to be defined differently for such
> scenarios. With this, is_kdump_kernel() could be false while vmcore is
> usable. So, remove unnecessary dependency with is_kdump_kernel(), for
> exporting vmcore.
> 
> [1] https://docs.kernel.org/powerpc/firmware-assisted-dump.html
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> Changes in v3:
> * Decoupled is_vmcore_usable() & vmcore_unusable() from is_kdump_kernel()
>   as suggested here: 
>     https://lore.kernel.org/linuxppc-dev/ZP7si3UMVpPfYV+w@MiWiFi-R3L-srv/T/#m13ae5a7e4ba6f4d8397f0f66581832292eee3a85
> 
> 
>  include/linux/crash_dump.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 0f3a656293b0..acc55626afdc 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -50,6 +50,7 @@ void vmcore_cleanup(void);
>  #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
>  #endif
>  
> +#ifndef is_kdump_kernel
>  /*
>   * is_kdump_kernel() checks whether this kernel is booting after a panic of
>   * previous kernel or not. This is determined by checking if previous kernel
> @@ -64,6 +65,7 @@ static inline bool is_kdump_kernel(void)
>  {
>  	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
>  }
> +#endif
>  
>  /* is_vmcore_usable() checks if the kernel is booting after a panic and
>   * the vmcore region is usable.
> @@ -75,7 +77,8 @@ static inline bool is_kdump_kernel(void)
>  
>  static inline int is_vmcore_usable(void)
>  {
> -	return is_kdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
> +	return elfcorehdr_addr != ELFCORE_ADDR_ERR &&
> +		elfcorehdr_addr != ELFCORE_ADDR_MAX ? 1 : 0;
>  }
>  
>  /* vmcore_unusable() marks the vmcore as unusable,
> @@ -84,8 +87,7 @@ static inline int is_vmcore_usable(void)
>  
>  static inline void vmcore_unusable(void)
>  {
> -	if (is_kdump_kernel())
> -		elfcorehdr_addr = ELFCORE_ADDR_ERR;
> +	elfcorehdr_addr = ELFCORE_ADDR_ERR;
>  }
>  
>  /**
> -- 
> 2.41.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
