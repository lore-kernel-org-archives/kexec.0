Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE97CFD2F6
	for <kexec@archiver.kernel.org>; Thu, 27 Nov 2025 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iUYE5Nv9stWS9k53Pjb2GiHfm7cAAwaViRSFXAZ3/B0=; b=g5WzKM3+eBMY3zqcBpcVSZGuNV
	jmVdmk1SKlZiZ/ipQV0lPTxDacidiJ5F+SiLLf9ggnkW+CsZtPf8lLyKozOucy0t9ZlkZtcGE1crY
	QnFKKvJ5jkke6Oj1gai1dcW64Mtf0aFg+wLolN8C1rLjTzEyeCioOKoK8FpipOLQlvi7FtcOibJ8y
	4hewNNMD+62k+8numyIDFx6MFI8bd7qVPcwlpnid77FpKYvuEHnA2Nr8yvyq6CNzK2vBYXJMxPol4
	h4WPyMcylezpnI458qSW5bg0+0ME3LZtfW4w1+oX0kOKU27NwpYKlIvKT/kFdqd/QSbHsT9NtuFdZ
	3T4j1jUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdxS-0000000GqYb-07Hx;
	Thu, 27 Nov 2025 15:30:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdxN-0000000GqXX-2Xpq
	for kexec@lists.infradead.org;
	Thu, 27 Nov 2025 15:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764257452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iUYE5Nv9stWS9k53Pjb2GiHfm7cAAwaViRSFXAZ3/B0=;
	b=Jj3TRQ+Bbk68NkXRdh6DZSPTUW7/F6jcncdOMuNlMr5Fas5tapLFFLH1Vm9EaJbP7iaSc7
	gIukqn4+1houGSPQ7Vz4DaMrcvJyOPHj8WsKghQovDhE04Bi7Pjp+szWfysVLauKToteoF
	Vc4B+K/5WJO8gkOu8Yey3AAeNBmdRRM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-pxvj3IHcPoSYz_Fi9Nw39g-1; Thu,
 27 Nov 2025 10:30:45 -0500
X-MC-Unique: pxvj3IHcPoSYz_Fi9Nw39g-1
X-Mimecast-MFC-AGG-ID: pxvj3IHcPoSYz_Fi9Nw39g_1764257444
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA918195606F;
	Thu, 27 Nov 2025 15:30:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E965230001A4;
	Thu, 27 Nov 2025 15:30:40 +0000 (UTC)
Date: Thu, 27 Nov 2025 23:30:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, akpm@linux-foundation.org
Cc: Qiang Ma <maqianga@uniontech.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shivang upadhyay <shivangu@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required
 for kexec_load
Message-ID: <aShunGBgVbEZmCxO@MiWiFi-R3L-srv>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
 <7aadda55-d2a4-40f9-95ef-d284ec358646@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aadda55-d2a4-40f9-95ef-d284ec358646@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_073053_713748_3981560E 
X-CRM114-Status: GOOD (  10.60  )
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

On 11/27/25 at 05:31pm, Sourabh Jain wrote:
> Hello All,
> 
> Do we have plan to support KEXEC_DEBUG flag?
> 
> Because upstream kexec-tools already added support for KEXEC_DEBUG flag
> and that breaks the kexec_load with -d option.
> 
> - kexec: add kexec flag to support debug printing
>   https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=71d6fd99af7e

I think we should revert that kexec-tools commit. This whole patchset is
non-sense. Because of my carelessness, that userspace patch was merged.

Hi Sourabh,

Could you go through this patchset and help check if they are really
needed? I can't find anything to convince myself. Thanks.


