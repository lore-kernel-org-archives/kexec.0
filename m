Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6ABC021B3
	for <kexec@archiver.kernel.org>; Mon, 24 Feb 2025 06:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gJAE5VQtKOJvPeRIxHRRWordcbnsd54QiHO4iNapbAU=; b=tAB9l38TqJAdqrehVhUOU8PmKD
	3nVIbnssbhBahysLT5pk/xRI1IUQ+ssmbj05ByXaQHIQ/hX1AOqgh3Sgwj0AUMXp4un11Yg0ByxJ6
	HMn/9HwJWj2UAEGRAwUMlw20yT9hqAjtmuW7p7vnZsHT6PBcD23hKOA9oaOKd4W9DjEAfhLrDJGHq
	wtn1MOh0o06nHoHWpH66zmyNsWGZM8m8XGcYSZX9CGE6TDEG4keT9BKD7FgZrFMMrX7MzWCyi4Lf5
	ypeU+rfOd9JtraIgYRZBQOxv+VP/PVEfOm04/6v86vWR2v0G8NrUKMAKqIqQYrRRZ+FF9Q9yzXHyX
	UlWUpIyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmRl7-0000000CQhn-1O7K;
	Mon, 24 Feb 2025 06:16:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmRjl-0000000CQW5-3Ges
	for kexec@lists.infradead.org;
	Mon, 24 Feb 2025 06:14:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740377679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJAE5VQtKOJvPeRIxHRRWordcbnsd54QiHO4iNapbAU=;
	b=c63FEhUJ8fsCOApN6DqzAsnAiSWru4NYHZVhq0wNJv6qtLB+DHIVR0BA45CI6xZhQKnkJu
	vCTIyYKe3L9t2jSveBsTyRNlhG3Xooadm4+qkugE2SH9YG4OIU8gvsIlhDT6A0jcBWg1zd
	4oXTKPTzHp69JhfAR13FD1aIX6ijMN8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-mIj5mZ4mOF6cCPhbbVyElQ-1; Mon,
 24 Feb 2025 01:14:33 -0500
X-MC-Unique: mIj5mZ4mOF6cCPhbbVyElQ-1
X-Mimecast-MFC-AGG-ID: mIj5mZ4mOF6cCPhbbVyElQ_1740377671
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 276581979057;
	Mon, 24 Feb 2025 06:14:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9565519560AA;
	Mon, 24 Feb 2025 06:14:27 +0000 (UTC)
Date: Mon, 24 Feb 2025 14:14:22 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218225502.747963-3-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_221441_887602_E9AF8803 
X-CRM114-Status: UNSURE (   8.25  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Steve, Mimi,

On 02/18/25 at 02:54pm, steven chen wrote:
> Currently, the mechanism to map and unmap segments to the kimage
> structure is not available to the subsystems outside of kexec.  This
> functionality is needed when IMA is allocating the memory segments
> during kexec 'load' operation.  Implement functions to map and unmap
> segments to kimage.

I am done with the whole patchset understanding. My concern is if this
TPM PCRs content can be carried over through newly introduced KHO. I can
see that these patchset doesn't introduce too much new code changes,
while if many conponents need do this, kexec reboot will be patched all
over its body and become ugly and hard to maintain.

Please check Mike Rapoport's v4 patchset to see if IMA can register
itself to KHO and do somthing during 2nd kernel init to restore those
TPM PCRs content to make sure all measurement logs are read correctly.
[PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)

Thanks
Baoquan


