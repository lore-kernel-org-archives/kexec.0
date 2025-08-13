Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8151C87FCF
	for <kexec@archiver.kernel.org>; Wed, 13 Aug 2025 03:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ldor2CsT8B6HWfUu/hwR1kEDuR0LOGQwR1IQ7tbgj10=; b=DU4yPU5+KFbi4xxCKu2gOGxE3P
	QvRor8dMDhFVhY5LAniOHCQy+KN+aluEFKscLKb/QFkZdbJs1Vn9NHFQu4WiztOGAK7QQFYfJzEuy
	3s6aUImRJtDJ0O9/NNBo+LoVEAm2eMUUKOUgbDL/US2BH0AVH+uDifgmoHBxKANGiWxDlc15dc/ut
	UF0acVfSUFIMh1g19d21g8nIX53UF+44kLsR2Wsh1MKxj2CCS3XuwowMB8m07oJVLmHu/uTUPUSrx
	M9YVKE51xky2n65Ap32veUDQnI2hOyb7AC4mlqpUqgBqGPZg8t7ylLioOwc55FUEauEevJas7RZi3
	IKwYjiOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2Z2-0000000CXeo-213u;
	Wed, 13 Aug 2025 03:54:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um2Yz-0000000CXdr-2kIw
	for kexec@lists.infradead.org;
	Wed, 13 Aug 2025 03:54:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755057247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldor2CsT8B6HWfUu/hwR1kEDuR0LOGQwR1IQ7tbgj10=;
	b=Q88//AJnoZtpwXolzlyXSnIUWECoaTTmqKH1MvHCgo6lEsbv7OP+ulouRZhcz9pkPsfX7B
	Jv+Z/Crkw9to+j+AK6DztJOd2PVHxf59nNZ0Tv2tKazYilZdaWrOciTKkJ7Fgg8BvskHRe
	vq7Y8S8uWHdHsvlT6CQznvk6ruTeoO4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-1xDdHYkhNKi6pz80MtGFpg-1; Tue, 12 Aug 2025 23:54:06 -0400
X-MC-Unique: 1xDdHYkhNKi6pz80MtGFpg-1
X-Mimecast-MFC-AGG-ID: 1xDdHYkhNKi6pz80MtGFpg_1755057243
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-33272ab5ed4so26894841fa.3
        for <kexec@lists.infradead.org>; Tue, 12 Aug 2025 20:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755057243; x=1755662043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldor2CsT8B6HWfUu/hwR1kEDuR0LOGQwR1IQ7tbgj10=;
        b=AQbe2tvr9whkiNHZmvoK+r8VRntuPSX+AJFa155YfQavaIc7LqwmcJ3iR7O//Q4wGd
         hgKg8ZoQPWGr3j6+t1sGCCf2iU/3+mSuWoIfbbK6+asDFEXTu2UwauFLolty2vU0X7RR
         5oUAswPII283VkT0DX6chJ8+63uyeyQUo5FSQb1eC88cLjqFyTZfJoXfVPqUoQEECZZh
         vNFdfgIybkdDT2PLkNNypIdKEfDtg7+TpCVi9ZhmWc5x4dAMWTE64NOohRCdZYsaGGj3
         LE9XB+S91JK5964HY4uV3cwPloezvrdmp2Z4XXrCp/4ukJlXZ2dH6I7dalYShGDbBl6t
         14oQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5YHyHK0DjbU8vRH/i00RqpKX9XC6m0uHQkvhItBNmrR4joXrmfTxwy6Z5z5MOmGvuNKPLgw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxnrs4y577lXUelbnPSnZTn8vQVdn1+8hSCz8tU4ZT815/sk9U0
	H69A4fEtVYkQHaP1NFtzi3g//om4IspkbxCKOeUpuMFdaq/qIxOFf4ovMu2NkOSaWXVn4Q7rfwa
	EW/5ciqpmYWUcNzg0qMIp5Y8Ze5lAu6+kVj7STMdvpy+zoG1RVOvME2ubm/u0PnOvVTUV5wBxel
	9/Ih6gRqTZX3GEMAPU/2XVHeaiMEauyrcLaJuBRKHeTSES
X-Gm-Gg: ASbGnctm6hAgdagP3F2ukFbALJoj6/6IhUjDq5znSQ9lufZXjg3Fh0IkRrPyclYIdJs
	U/xR9mQI5p7NMd3vqdCi/RB+eGQ5xKB8QJ9jj0ad2n4a3+GkLivuFwMsQBrVFrKqDR+lmXWWAmr
	XNWC1Jew5VRwEDVeN6LBxiGg==
X-Received: by 2002:a05:6512:aca:b0:55b:8277:22a2 with SMTP id 2adb3069b0e04-55ce0345860mr417143e87.21.1755057242533;
        Tue, 12 Aug 2025 20:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZexknp+rla3L40FUKhJV5/CkF/Q1buN23b5+UivngVCIbFHMBHBYv82Z303ckdVGtLcpYInGr0FEz6ewgXYw=
X-Received: by 2002:a05:6512:aca:b0:55b:8277:22a2 with SMTP id
 2adb3069b0e04-55ce0345860mr417134e87.21.1755057242110; Tue, 12 Aug 2025
 20:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250805211527.122367-1-makb@juniper.net> <9B71EC74-D1F4-4F7D-837A-A43E53CEBB89@juniper.net>
In-Reply-To: <9B71EC74-D1F4-4F7D-837A-A43E53CEBB89@juniper.net>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 13 Aug 2025 11:54:43 +0800
X-Gm-Features: Ac12FXyxBbd3MqroyWxKC83iyko_mLksVDwNvBYetOdQP2oCw_iEtH2TUcVrO6s
Message-ID: <CALu+AoQnXfYtuKQxVKK32sC4D98Y+Yn30TjTr2xmXhZcHe0x=A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: Carry forward the boot DTB on kexec
To: Brian Mak <makb@juniper.net>
Cc: Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PTsgYL8ppiunBRzpKlKokNEVjdFZxba2o2tfErkQhRI_1755057243
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_205409_765991_2B703F33 
X-CRM114-Status: GOOD (  26.12  )
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

On Wed, 13 Aug 2025 at 02:01, Brian Mak <makb@juniper.net> wrote:
>
> On Aug 5, 2025, at 2:15 PM, Brian Mak <makb@juniper.net> wrote:
>
> > Hi all,
> >
> > Here is v2 with the comments from v1 addressed. I also added a patch to
> > the series to add KEXEC_FILE_NO_CMA as a legal flag. I noticed that this
> > was missing when I went to add my KEXEC_FILE_FORCE_DTB flag.
> >
> > Thanks,
> > Brian
> >
> > Changes in v2:
> > - Added a patch to add KEXEC_FILE_NO_CMA as a legal flag
> > - Added a KEXEC_FILE_FORCE_DTB flag to enable carrying over the current
> >  boot's DTB on x86.
> > - Modified the commit message to include more reasoning for the change.
> > - Changed a pr_info print to a pr_debug print.
> >
> > Brian Mak (2):
> >  kexec: Add KEXEC_FILE_NO_CMA as a legal flag
> >  x86/kexec: Carry forward the boot DTB on kexec
> >
> > arch/x86/kernel/kexec-bzimage64.c | 47 +++++++++++++++++++++++++++++--
> > include/linux/kexec.h             |  6 +++-
> > include/uapi/linux/kexec.h        |  4 +++
> > kernel/kexec_file.c               |  1 +
> > 4 files changed, 54 insertions(+), 4 deletions(-)
> >
> >
> > base-commit: 35a813e010b99894bb4706c56c16a580bf7959c2
> > --
> > 2.25.1
>
> I see Andrew has sent these patches to linux-next. Thanks for that,
> Andrew!
>
> Dave and Baoquan, have you two had a chance to peek at the updated patch
> set yet?

Hi, The #ifdef CONFIG_* which can be replaced by #if defined(), but I
do not have a strong opinion.  other than that do you have kexec-tools
patch ready? It would be better to provide a link so that people can
try and test it.

Thanks
Dave


