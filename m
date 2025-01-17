Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D436C02183
	for <kexec@archiver.kernel.org>; Fri, 17 Jan 2025 03:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JicVrS6630U6GLKgttTEGLfxPYMVZnTHvkxIjdKwIR8=; b=T/dtMUEucXbYBubgs2DK44ijhH
	3QcroLDReO0r5RLs3xqg+Ho1XP5uyg2Sz/sCbpJqo/1aSyYtkMX0SfMJ02UKg2LUuIsM2+0zmoQgw
	9B3xK4oI13oCq+ez8QVtjqHQflH/cI0LGrAsjIJn3VdFBB+DFT4JfLV7rIX6+TeMgbvj5pRPY2cc9
	cW3T6EFLr5kpDoEDD0dWx2JzVAPxnRPAAN8r0n5F8tzam+VdPgHT+ScuYseo9Qdmkh6qF7N0O5fR8
	JgHP9M86ZwGjzogQMEfBTO7Axp8XJL4x+MlrW2WJIIshnNq9wYqM2q16A45g92iv2OFCWDxSiOzlz
	FdPFeQnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYdEi-0000000Gw2w-0lQ6;
	Fri, 17 Jan 2025 03:41:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYdEf-0000000Gw2T-04wq
	for kexec@lists.infradead.org;
	Fri, 17 Jan 2025 03:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737085287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JicVrS6630U6GLKgttTEGLfxPYMVZnTHvkxIjdKwIR8=;
	b=ePLS2SBJdeo0UNtQ34ed2TF+dPsa2a6ki5xMNRUbe1cnxdbdNWuACmFXD0bKiundsmInXL
	9WKe0bRLHArqo5PTmotwlMT7KHi+yJRZC0j/bdaIiQeXqSAog3S/R1yTTnyCmVjYV17Ah1
	U1DgH6TAPZXs+SB9+z19WqWKe90Qe40=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-9Nugs1zqOY6ARK2pr1smzg-1; Thu,
 16 Jan 2025 22:41:23 -0500
X-MC-Unique: 9Nugs1zqOY6ARK2pr1smzg-1
X-Mimecast-MFC-AGG-ID: 9Nugs1zqOY6ARK2pr1smzg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A4D619560B7;
	Fri, 17 Jan 2025 03:41:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B113E30001BE;
	Fri, 17 Jan 2025 03:41:19 +0000 (UTC)
Date: Fri, 17 Jan 2025 11:41:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Roberto Ricci <io@r-ricci.it>
Cc: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4nRWnysvuxLWU32@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4Zjmva-pLbLjtQv@desktop0a>
 <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
 <Z4ejbdJr87V3IwV8@desktop0a>
 <Z4jy-NoLxpwaLfyD@desktop0a>
 <Z4m4q8yfIjfMRgZ+@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4m4q8yfIjfMRgZ+@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_194129_139562_C4751107 
X-CRM114-Status: GOOD (  10.19  )
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

On 01/17/25 at 09:55am, Baoquan He wrote:
> On 01/16/25 at 12:52pm, Roberto Ricci wrote:
> > On 2025-01-15 Wed 13:00:52 +0100, Roberto Ricci wrote:
> > > On 2025-01-15 Wed 12:04:10 +0800, Baoquan He wrote:
> > > > On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> > > > > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> ...snip...
> > Also, I can't reproduce with the default config (make defconfig),
> > therefore something in my config (I already sent it) may play a role.
> 
> What I tried is defconfig on 6.13-rc7, let me try your config again.

I tried your config on the latest kernel, reboot will fail during the
new kernel bootup after newly built kernel was installed.

I haven't compared your config with the defconfig to see their
difference. Wondering where your config comes from.


