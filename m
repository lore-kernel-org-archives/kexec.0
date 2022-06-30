Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE41C433EF
	for <kexec@archiver.kernel.org>; Thu, 30 Jun 2022 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/cMb3GVYkahqbmqWz8nJOsPpRj0BoUUYeH0lFHz5fN4=; b=wvMF1fQu9TI1+J
	JjwqBdLyJBveQjoWtichZCOSMkdXcA/xfVdVColsAQVUtRbVQ28lHHUDFHZR4Ak5g0j0ODvzEyMfO
	xaHSa02PC2ZUvgmhPuXycNIkN9dGzw9693Wv8g44LVIsulMCeaXzCFFArMcX6hugY1ZmZJ+Snt0UV
	NOUO4JhHoVRAdbUmABTnEVqCSaMYUU9unFkpd8J2LYiNRbGpzgNoYOEdhAsbm3VI6LDxmSpXaI9Uj
	kbPizqWRW+P4dswh5smKihyEWl6IjU1iyOROaiTVwX2uGuu/Ockl9RWfeELRa2kQBEJ07DIeCW5QN
	AXrsJjDvRJ5dnCJcpUMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6xr1-000nX6-F7; Thu, 30 Jun 2022 17:21:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6xqy-000nVK-RG
	for kexec@lists.infradead.org; Thu, 30 Jun 2022 17:21:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656609675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A5OgPBniuWt/Ivj7mlDLsvU3Ai/7R90RcZ3oxlYDH8I=;
	b=OR+3aouh+PeVbh05rIlVNZg1y3l4fclqZut2nEepTnumOODJbvVEskPqhBr3bkk+bIHJy4
	LbSArv3PSoH4+flhPaxJ97XEEVx//p7NGHUtaCQWPhbYOtVhDhMfASDWDMk+3n8T3qvG9b
	E7TvSecX69uuhWu3DSstM41vwXx7RGs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-uedA1p-DOB-fSdfuI0f8cg-1; Thu, 30 Jun 2022 13:21:14 -0400
X-MC-Unique: uedA1p-DOB-fSdfuI0f8cg-1
Received: by mail-wm1-f69.google.com with SMTP id h125-20020a1c2183000000b003a0374f1eb8so1678484wmh.8
        for <kexec@lists.infradead.org>; Thu, 30 Jun 2022 10:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A5OgPBniuWt/Ivj7mlDLsvU3Ai/7R90RcZ3oxlYDH8I=;
        b=HJp69kfIbUN2n2DviMWQV9XKW56rYYMOsIQ9Mh+g85Rn8mkK948x97QQMJZ/81tcg9
         /JWBGknYx+ITUM7VClNwLeJJ6yvnRGM4aTHX+hhZNwJ/i5CE4Gm88TaNWp4KIobanOvg
         kKk+i9OXMd4OCdQzpGAtDxmkl4+/TuLrxibjbGKHPSpwIbyDiUffho5SotuA42Csy2IP
         N7Onuw8I/wQqHy728rd7nNktiBdIZE4Xoym2EDBsnvE/6W10KMRo2g4cS2rh1BaFS1LC
         nyTgwckgV+jgO24gG2vOCy+Q2rA4cGi+viOYeVXAD8j1lNrlj1BQd79J9aJ/OjpmFwWS
         5eWQ==
X-Gm-Message-State: AJIora+3psbD9AbJKzHntyiPr0Gxu3vWjTJqQYp/KwIrJpMsi/V7cYB1
	C2K2n58hAiDeLYEiljNp50ORFFahrV6xuzhYwpvTRf1wArCKk/BK0RvqMLXXCImCyJSswzpCHMO
	IAQZOHaEj3zaaQZ7kSWRq1q5M+IwEp6mIZ2CDAmMh8PoheXIY48jy+dtCygHOqsavUN4FNtlM
X-Received: by 2002:a5d:448e:0:b0:21b:887f:23f with SMTP id j14-20020a5d448e000000b0021b887f023fmr9598771wrq.240.1656609673122;
        Thu, 30 Jun 2022 10:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tLSw0n9SwkwRiHg02raa2UNgWCjcHEkLR9YfRZg33No2Yv3dNxwDSETN5lNlfJhNYkN9rmTg==
X-Received: by 2002:a5d:448e:0:b0:21b:887f:23f with SMTP id j14-20020a5d448e000000b0021b887f023fmr9598740wrq.240.1656609672838;
        Thu, 30 Jun 2022 10:21:12 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0039c41686421sm4065122wmg.17.2022.06.30.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 10:21:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: kexec@lists.infradead.org,
	linux-rt-users@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Petr Mladek <pmladek@suse.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v3 0/2] kexec, panic: Making crash_kexec() NMI safe
Date: Thu, 30 Jun 2022 18:20:39 +0100
Message-Id: <20220630172041.4100123-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_102120_998364_687936CA 
X-CRM114-Status: UNSURE (   9.39  )
X-CRM114-Notice: Please train this message.
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

Hi folks,

Here's v3 where we now completely get rid of kexec_mutex.

o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
  having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
  here. If that can't be done then I think we're better off with the combined
  mutex+atomic var approach.
o Patch 2 does the mutex -> atomic var switch.

Revisions
=========

v2 -> v3
++++++++

o Dropped kexec_mutex entirely and made the atomic variable the one true lock
  for kexec (Eric)

v1 -> v2
++++++++

o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
  (Petr)
o Slightly reworded changelog
o Added Fixes: tag. Technically should be up to since kexec can happen
  in an NMI, but that isn't such a clear target

Cheers,
Valentin

Valentin Schneider (2):
  kexec: Turn all kexec_mutex acquisitions into trylocks
  panic, kexec: Make __crash_kexec() NMI safe

 include/linux/kexec.h   |  2 +-
 kernel/kexec.c          | 11 ++++-------
 kernel/kexec_core.c     | 28 ++++++++++++++++------------
 kernel/kexec_file.c     |  4 ++--
 kernel/kexec_internal.h | 15 ++++++++++++++-
 kernel/ksysfs.c         |  7 ++++++-
 6 files changed, 43 insertions(+), 24 deletions(-)

--
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
