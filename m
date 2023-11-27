Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55998C4167B
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 03:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q6AC8treGShCD2SilgQrxUzQEptULCBJQocb3zdsE0I=; b=UDH71DwPi2pW8S
	mxpt65clTMB5nQ/vFuAruhTuCvOyceF3hkIFp3FBwj2ySoIIQQyIW3ovMrcwVYwbLYjc9iCC0xE1Q
	jCTGEWtpMFmdIoz1BNhjVBSLn3DCcRqxCWtnXFLj83Wc1y9gv9v9i+5DO72gEVPldcpx+rjoAK6l/
	JE9rSQzC/dtFjd5yZxknDVvgusj6f+bDN4Uo/mMDOeYCR3+f5S/tjBeLkocUUHlEM8LivxooLTS58
	DiydF7oI0KFB7DX8/VSq/nsSEex6N6b+YtrCMYhQ0a0n5EipMDxdMX2bFy7JZF4+vXr0D7G9T2Avy
	2RpTZpbUL26SOoxlu32A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7SJI-001EI9-0t;
	Mon, 27 Nov 2023 03:29:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7SJE-001EHF-31
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 03:29:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701055760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnTrWVmf8fnOo5Xt1U1MdbL+1iOZnlvT18JnDKebNVY=;
	b=YIspqSEcame0eMu3djmrCznur/QS5LM1iQvYD/A2vqW6+CkQu2u75VI2ofkY4onU8i5nH/
	TmmXAnFvtgJVuwoBt7F7oAEJFE8NNixmSB9gwKzA7F+FXS9xNq9TH7y+3ZyVlc+BNe5zCN
	urQJYAv+xs/BbFoyQoNYbh/0mUVgG4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-l4JqyT8yPdyOLUMGAlVFQg-1; Sun, 26 Nov 2023 22:29:14 -0500
X-MC-Unique: l4JqyT8yPdyOLUMGAlVFQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2977A185A780;
	Mon, 27 Nov 2023 03:29:14 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C8BD336E2;
	Mon, 27 Nov 2023 03:29:07 +0000 (UTC)
Date: Mon, 27 Nov 2023 11:29:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric_devolder@yahoo.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	akpm@linux-foundation.org, ignat@cloudflare.com
Subject: Re: [PATCH 0/3] kernel/Kconfig.kexec: drop select of KEXEC for
 CRASH_DUMP
Message-ID: <ZWQNACdS12xDXL7A@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <5ab45f48-9ec2-4611-81a2-4dc2f1854c4f@yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ab45f48-9ec2-4611-81a2-4dc2f1854c4f@yahoo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_192921_076461_D2EBF319 
X-CRM114-Status: GOOD (  25.23  )
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

On 11/25/23 at 06:07pm, Eric DeVolder wrote:
> 
> On 11/23/23 01:36, Baoquan He wrote:
> > Ignat reported a potential config regression was introduced by
> > commit 89cde455915f ("kexec: consolidate kexec and crash options
> > into kernel/Kconfig.kexec"). Please click below link for more details:
> > 
> > https://lore.kernel.org/all/CALrw=nHpRQQaQTP_jZfREgrQEMpS8jBF8JQCv4ygqXycE-StaA@mail.gmail.com/T/#u
> > 
> > The patch 1 fix the regression by removing incorrect CONFIG_KEXEC
> > ifdeffery scope adding in arm's <asm/kexec.h>, then dropping the
> > select of KEXEC for CRASH_DUMP. This is tested and passed a cross
> > comiping of arm.
> > 
> > Patch 2 is to fix a build failure when I tested patch 1 on x86_64, the
> > wrong CONFIG_KEXEC iddeffery is replaced with CONFIG_KEXEC_CORE. Test
> > passed on x86_64.
> > 
> > Patch 3 is to fix an unnecessary 'select KEXEC' in s390 ARCH. Removing
> > the select won't impact anything. Test passed on a ibm-z system.
> 
> I apologize for my delay in responding, I did not have a computer with me
> during my holiday travel.
> 
> I was able to re-run my Kconfig test script with this patch series (now that
> I'm running this on private resources, it takes half a day 8( ). The script
> only performs comparisons of the .config before (LHSB) and after (RHSB) the
> patch series; it does NOT do any building. At any rate, what that revealed
> was only differences in s390. That means that all other arches do not have
> any unintended side effects. The differences with patch3 applied look like:
> 
> FAIL: allnoconfig arch/s390/configs/kasan.config
> LHSB {'CONFIG_CRASH_CORE': 'y', 'CONFIG_KEXEC_CORE': 'y', 'CONFIG_KEXEC':
> 'y'}
> RHSB {'CONFIG_KEXEC': 'n'}
> 
> The 'allnoconfig' and 'olddefconfig' targets failed for all s390 defconfigs.
> The LHSB is the pre-patch values, and the RHSB is the post-patch values. So
> this states that CRASH_CORE and KEXEC_CORE were set previously, but now they
> are not. KEXEC obviously is being turned off intentionally.
> 
> Hope this helps some.

Thanks, Eric. Alexander has pointed out this in patch 3 reviewing
comment. I misunderstood the select KEXEC in s390 arch where they
intend to do. As I replied to Alexander, I will drop patch 3. 

> 
> 
> > Baoquan He (3):
> >    kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
> >    drivers/base/cpu: crash data showing should depends on KEXEC_CORE
> >    s390/Kconfig: drop select of KEXEC
> > 
> >   arch/arm/include/asm/kexec.h | 4 ----
> >   arch/s390/Kconfig            | 1 -
> >   drivers/base/cpu.c           | 6 +++---
> >   kernel/Kconfig.kexec         | 1 -
> >   4 files changed, 3 insertions(+), 9 deletions(-)
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
