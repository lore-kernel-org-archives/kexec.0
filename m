Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7C0C77B7C
	for <kexec@archiver.kernel.org>; Thu,  3 Jul 2025 06:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cJ7q0V9kF6LpjhO3dWBRMm1GDYk0h/5qsRyzs/9AW0o=; b=Xux/qJrJcz1xQ7GrzJ2UCR1IO9
	WsA6DP7Ya7OWe90zehqmMlq6suSGXiWAs39UGKp7+1+BBHCtZEHQN7m5zjA2xsa4WomMQTgKhP41f
	3AsClT2uwTJXVSGDhjPz5oZbnbYOvAdSKn2TcLGvPaukvVcRXFdMC1QArN9J/3AYGAh2AGEBjWqJ7
	qVL3z/1bp8IYKvNq2IaDjG2If5hwe7kVmA8m5wAe91wKyG7hNuh7sjhGx3Jf1lXKQaKd+A/DW/qGq
	qXhiS2EbQ6OvI0J5CeolEnYgBIfKkdMCrhnt3IvYHcgFu/qbBAwh0g7DzXZDD39UkrTKK04SS6Wm9
	y2B30dlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXDo7-0000000AQp5-2RAG;
	Thu, 03 Jul 2025 06:52:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXDgd-0000000APme-3ORo
	for kexec@lists.infradead.org;
	Thu, 03 Jul 2025 06:44:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751525085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJ7q0V9kF6LpjhO3dWBRMm1GDYk0h/5qsRyzs/9AW0o=;
	b=LTp+o+aDJUWU06H2i2mS9TlFGT3kglT8fwo69nUO8/lJvrpvIEciGV3j2TSkUVlUvraDTl
	nRBZ4U1XTjsPO7sg0OpVLzVqOMnNUdKzmjZjwsSu6dFPAdYiLbKC3k3wjtO4kKlkXVwBYY
	Qei9uv7LUb05rghPsH3OTYKjC31Bzmw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-yQrqLG9AO-ujHHCjFsafNg-1; Thu,
 03 Jul 2025 02:44:44 -0400
X-MC-Unique: yQrqLG9AO-ujHHCjFsafNg-1
X-Mimecast-MFC-AGG-ID: yQrqLG9AO-ujHHCjFsafNg_1751525082
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 584E919560A6;
	Thu,  3 Jul 2025 06:44:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.67])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA45419560AB;
	Thu,  3 Jul 2025 06:44:40 +0000 (UTC)
Date: Thu, 3 Jul 2025 14:44:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Cc: khan@linuxfoundation.org, kexec@lists.infradead.org, dwmw@amazon.co.uk,
	mingo@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] selftests/kexec: fix test_kexec_jump build
Message-ID: <aGYm1BARlztCoCLT@MiWiFi-R3L-srv>
References: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_234447_918172_03FA182C 
X-CRM114-Status: GOOD (  17.33  )
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

On 07/02/25 at 10:17am, Moon Hee Lee wrote:
> The test_kexec_jump program builds correctly when invoked from the top-level
> selftests/Makefile, which explicitly sets the OUTPUT variable. However,
> building directly in tools/testing/selftests/kexec fails with:
> 
>   make: *** No rule to make target '/test_kexec_jump', needed by 'test_kexec_jump.sh'.  Stop.

I can reproduce this, and this patch fixes it. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> This failure occurs because the Makefile rule relies on $(OUTPUT), which is
> undefined in direct builds.
> 
> Fix this by listing test_kexec_jump in TEST_GEN_PROGS, the standard way to
> declare generated test binaries in the kselftest framework. This ensures the
> binary is built regardless of invocation context and properly removed by
> make clean.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
> ---
> Changes in v2:
> - Dropped the .gitignore addition, as it is already handled in [1]
> 
> [1] https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com
> 
> 
>  tools/testing/selftests/kexec/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
> index e3000ccb9a5d..874cfdd3b75b 100644
> --- a/tools/testing/selftests/kexec/Makefile
> +++ b/tools/testing/selftests/kexec/Makefile
> @@ -12,7 +12,7 @@ include ../../../scripts/Makefile.arch
>  
>  ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
>  TEST_PROGS += test_kexec_jump.sh
> -test_kexec_jump.sh: $(OUTPUT)/test_kexec_jump
> +TEST_GEN_PROGS := test_kexec_jump
>  endif
>  
>  include ../lib.mk
> -- 
> 2.43.0
> 
> 


