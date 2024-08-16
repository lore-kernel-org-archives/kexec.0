Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48C0C5473D
	for <kexec@archiver.kernel.org>; Fri, 16 Aug 2024 12:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=TCaIv0UA0Tz6MJ0Sr78+BL3CMJo/WzuJ2w9CzJhhnbo=; b=GR7YJj0+7dPPkvjnDGZL0vMeKT
	ARNNJQyvQy/fBF+1chbJnV2mQNUfblqMsYNImuqy2HTjiASRiE0xep2S3z8wDp6HvEoUAnFo4A8cE
	qmyq7yBx3e3lsVA7z1nvsp90qGNtwKRPliDjt53qepItl865PyutkjWKNG0KgKKOj4GFQ3Q8Y4ewC
	izqUUiThdG7w4I8gWb8a/n4mz8p3tZnvu0vmctzZMjcm+MXeQ74SNs3F19QxZP+2poDTE7RllcR9B
	gTZ014QLimnb/OEgM9F/2d/qnDfs8JESCpM4Z3fnt7NHm8nWt3YROk0mHI86b+Vc/drf2Agchv1DN
	5Cv6wkgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sewUg-0000000CxJZ-2AHa;
	Fri, 16 Aug 2024 12:55:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sewUe-0000000CxHj-32Fp
	for kexec@bombadil.infradead.org;
	Fri, 16 Aug 2024 12:55:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Content-Type:MIME-Version:
	Message-ID:In-Reply-To:Date:References:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SFvyHZ7VAUpKm3MAQxmbdfScDqaj2WSkqRKz6uKi3uI=; b=JhYrh5yQzBPlSRCuQVd+oJTPNX
	uZy5yLckwuvWPK0ANTkFhgLex/fBYO5YQMvg5WDgT4W8MAzVhHPa7qQAxhZjz02GZYUR8FqEkn6ry
	fmUPP02IWFOSA5pYgS+oIR2AuMFcefHEtGQDyadNu4K1PG2I+uAcPVtNGA16Hj5/b2dfrnX/tgIf0
	1mnk+PAbANvnD4Z57p+Iq5ZGAZHHhY1G89ai5Az/2MU84LTd4JPw6lePAieTeUhcuquPtivX9Mi5A
	VpWmuq0NBlcGNpQkyTt3jT0b3u5SvoHZe31/JD/8wKAwnJGU3qxLL6dYB+3EcGLUp41Hd4hkY8wah
	aNTuBlNA==;
Received: from out02.mta.xmission.com ([166.70.13.232])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sewUZ-00000008etW-2GfT
	for kexec@lists.infradead.org;
	Fri, 16 Aug 2024 12:55:47 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:33400)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sewUC-008RFg-8Z; Fri, 16 Aug 2024 06:55:20 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:48330 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sewUA-00EE99-W5; Fri, 16 Aug 2024 06:55:19 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Petr Tesarik <petr.tesarik@suse.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,  Hari Bathini
 <hbathini@linux.ibm.com>,  Baoquan He <bhe@redhat.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Eric DeVolder <eric.devolder@oracle.com>,
  kexec@lists.infradead.org (open list:KEXEC),
  linux-kernel@vger.kernel.org (open list),  Petr Tesarik
 <ptesarik@suse.com>,  stable@kernel.org
References: <20240805150750.170739-1-petr.tesarik@suse.com>
Date: Fri, 16 Aug 2024 07:54:52 -0500
In-Reply-To: <20240805150750.170739-1-petr.tesarik@suse.com> (Petr Tesarik's
	message of "Mon, 5 Aug 2024 17:07:50 +0200")
Message-ID: <871q2oy6eb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1sewUA-00EE99-W5;;;mid=<871q2oy6eb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18Vf6nPdb92wzdBhT3kwrfv72NqUKEluUY=
X-SA-Exim-Connect-IP: 68.227.165.127
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_135544_258355_3D33CA5C 
X-CRM114-Status: GOOD (  19.68  )
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

Petr Tesarik <petr.tesarik@suse.com> writes:

> From: Petr Tesarik <ptesarik@suse.com>
>
> Fix the condition to exclude the elfcorehdr segment from the SHA digest
> calculation.
>
> The j iterator is an index into the output sha_regions[] array, not into
> the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> all subsequent segments are excluded. Besides, if the purgatory segment
> precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> the calculation.

I would rather make CONFIG_CRASH_HOTPLUG depend on broken.

The hash is supposed to include everything we depend upon so when
a borken machine corrupts something we can detect that corruption
and not attempt to take a crash dump.

The elfcorehdr is definitely something that needs to be part of the
hash.

So please go back to the drawing board and find a way to include the
program header in the hash even with CONFIG_CRASH_HOTPLUG.


Eric


> Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> Cc: stable@kernel.org
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  kernel/kexec_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3d64290d24c9..3eedb8c226ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  #ifdef CONFIG_CRASH_HOTPLUG
>  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> -		if (j == image->elfcorehdr_index)
> +		if (i == image->elfcorehdr_index)
>  			continue;
>  #endif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
