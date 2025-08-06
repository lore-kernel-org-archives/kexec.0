Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA7CC87FD1
	for <kexec@archiver.kernel.org>; Wed,  6 Aug 2025 05:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XjJbearcpYLygH3I9UtbiSxWfVYe30GcdnmkpjPEww4=; b=eGIc/NFAZvdl6AcygJiTE2fWgq
	Zz8+vaZKc9nnCImfbwhuw1X4ePxtUa27xqVMO7Z84AY2dmF5cF00cOh/NsQ1UQDotcto90t3pYgLT
	EzNNW177bwU027oX9guzhWhTUUsoehlVnvJ2apawf2lq9JUqdmWLJWHY7KElHM+ig6CdYWi7+oHTt
	2v2ReA0ICljVk+XFuUFY9FwabaAIYOsaFVLzbLsknIeQzeTp2IzygmsSvkHjRF6fiRc4yqal5lna5
	+Q4yE2SOyAFtHJEybZ/eboQt9KontPmAQNNsgLZH7QpsWgE0g0hap3hIOJjWgWL/roBRcd2EWqwgk
	QwGXkWAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujWbp-0000000EKVd-3YVp;
	Wed, 06 Aug 2025 05:22:41 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujWbl-0000000EKTk-0dHW
	for kexec@lists.infradead.org;
	Wed, 06 Aug 2025 05:22:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8733AA568C6;
	Wed,  6 Aug 2025 05:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FD0C4CEF6;
	Wed,  6 Aug 2025 05:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754457754;
	bh=tqCPY7yIlC+Yf68lmUytU3qJt7wsROvcPOLHDh907yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=re4ea+rOiDkRPbP1dSQIxPVNijlcfv44fS+v+vp9kuFffgaFQy1vooR7imTHnG+pH
	 OO69XmtKGK/0gH6ElDfarANP5veEeoc29NGQTMo8FmHe8CAr/TA1QGx+HNHk+I5IEY
	 cc4VDQsD5E1ykLpCmNo+m9AHzxQ+5PS+kq71vF+9hhjxYE7KwlsImRLIWJLcXRxSD4
	 9axI2l1nIbj182vNhjHas1HHAdUZOSxukBjYdJHmDH6O2waO4Q1s+BZ6b4d0EyM68+
	 YKl2DGc/JYw+xMU4bZBY8YYzz8kmmUDhOqpWDI0W58SY+m0OwsDQD9wsYdkwLnyAVq
	 pvIWOtA25O0RQ==
From: SeongJae Park <sj@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH 4/4] mm/kasan: make kasan=on|off take effect for all three modes
Date: Tue,  5 Aug 2025 22:22:31 -0700
Message-Id: <20250806052231.619715-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805062333.121553-5-bhe@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_222237_256586_3FA8E032 
X-CRM114-Status: GOOD (  14.45  )
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

Hello Baoqua,

On Tue,  5 Aug 2025 14:23:33 +0800 Baoquan He <bhe@redhat.com> wrote:

> Now everything is ready, set kasan=off can disable kasan for all
> three modes.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kasan-enabled.h | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index 32f2d19f599f..b5857e15ef14 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -8,30 +8,21 @@ extern bool kasan_arg_disabled;
>  
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  
> -#ifdef CONFIG_KASAN_HW_TAGS
> -
>  static __always_inline bool kasan_enabled(void)
>  {
>  	return static_branch_likely(&kasan_flag_enabled);
>  }

I found mm-new build fails when CONFIG_KASAN is unset as below, and 'git
bisect' points this patch.

      LD      .tmp_vmlinux1
    ld: lib/stackdepot.o:(__jump_table+0x8): undefined reference to `kasan_flag_enabled'

Since kasna_flag_enabled is defined in mm/kasan/common.c, I confirmed diff like
below fixes this.  I think it may not be a correct fix though, since I didn't
read this patchset thoroughly.

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index b5857e15ef14..a53d112b1020 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -8,11 +8,22 @@ extern bool kasan_arg_disabled;
 
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
 
+#ifdef CONFIG_KASAN
+
 static __always_inline bool kasan_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_enabled);
 }
 
+#else /* CONFIG_KASAN */
+
+static inline bool kasan_enabled(void)
+{
+	return false;
+}
+
+#endif
+
 #ifdef CONFIG_KASAN_HW_TAGS
 static inline bool kasan_hw_tags_enabled(void)
 {


[...]

Thanks,
SJ

