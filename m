Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A6BC4332F
	for <kexec@archiver.kernel.org>; Tue,  8 Nov 2022 23:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8j0EcmRKKdugbQLoIJS2LGpeIuMVRDCSxISnYVYrZkw=; b=mwn/o6g4fvONlM
	Or30jdXphy3VfhlXxWw+EtmTfbTg1yZCAXYwN/MshJT/rKFQEYDctrvQaucrPc4yO7M4FHz09ucdn
	zaEiUckWd7np+dPzmWACbjV/MAlChJ1NjyQU2R1Tg0U8UkXdXA6zjgmLX5a+sQwCAy+o1FnPPrgyL
	YBCTTOL0XmGYrf1w4mHM3DRPlmkkstw7Vml910NFPSsucXrDcqwLxGMjpTdx5GLT53afHatgWlq/x
	SfSpryqp/uiqDcv6RzpHSR7le3WaQj17L9ZS+IBHNG7Byc35Sj9Syf5+4sznEmY0oSHFAgMu33yaU
	m3KZ7tRcSJa4wyqbIScA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osYKx-009MKw-My; Tue, 08 Nov 2022 23:48:59 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osYKo-009MKb-P1
	for kexec@lists.infradead.org; Tue, 08 Nov 2022 23:48:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D9B7CB81CB6;
	Tue,  8 Nov 2022 23:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F1DC433C1;
	Tue,  8 Nov 2022 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1667951327;
	bh=Fcu2qv9zwXGmJE/pBRUkdiIpewsCdUgeUAAdyR1Vl6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qLx9SpuwIqKig1y5bJ60qem3PGGvfT5r3ke/qbkfxuubLb8yLZ5Mg4OV5rvOmzpid
	 qScV+9dTVEqnW2w9hBrogWu5AiQevRlbb12NlmyP+QCVrRl8qAlEJRJ8pWeANYNbUc
	 pGl5e8pOizvJygRknyXw4GBPeZzBiy87BGTMri7U=
Date: Tue, 8 Nov 2022 15:48:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Young
 <dyoung@redhat.com>
Subject: Re: [PATCH] vmcoreinfo: Warn if we exceed vmcoreinfo data size
Message-Id: <20221108154846.11584119794413c7682280fc@linux-foundation.org>
In-Reply-To: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
References: <20221027205008.312534-1-stephen.s.brennan@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_154851_012242_D50247FB 
X-CRM114-Status: GOOD (  17.84  )
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

On Thu, 27 Oct 2022 13:50:08 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> Though vmcoreinfo is intended to be small, at just one page, useful
> information is still added to it, so we risk running out of space.
> Currently there is no runtime check to see whether the vmcoreinfo buffer
> has been exhausted. Add a warning for this case.
> 
> Currently, my static checking tool[1] indicates that a good upper bound
> for vmcoreinfo size is currently 3415 bytes, but the best time to add
> warnings is before the risk becomes too high.
> 
> ...
>
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -383,6 +383,9 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>  	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
>  
>  	vmcoreinfo_size += r;
> +
> +	WARN_ONCE(vmcoreinfo_size == VMCOREINFO_BYTES,
> +		  "vmcoreinfo data exceeds allocated size, truncating");
>  }

Seems that vmcoreinfo_append_str() will truncate (ie: corrupt) the
final entry when limiting the overall data size to VMCOREINFO_BYTES. 
And that final entry will be missing any terminating \n or \0.

Is all this desirable, or should we be checking for (and warning about)
sufficient space _before_ appending this string?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
