Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71159C02183
	for <kexec@archiver.kernel.org>; Fri, 17 Jan 2025 01:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FBe3eeTEFS2c2V0/g2HvswYNSDDgWbxsTGLzAw3EfuQ=; b=N9KganDMJc+NNwSxhJqdQ4Pj9q
	2izicnIdg1L7SmYQM+o8Qg5jbS+w/zutDxKDq9bjGY3kiz+QYGU57zPE3e79Tvmo6QStaMBAjfmQr
	F/3IboKEFo7TEXHRGMLv0vg6QrFXhNfDZzhqi1hUqR9cyK64gDSBMgak3LeZCYrYgq5i+wkVkpY0t
	uDXvGOiZX7s80ESEYdsN8G5PSv0a8/A4bIHUr9LNe7DvEFc9dbtI5FTKYLvor4Vq5itaNF1Bw4E/p
	C43z9YuduS5u8/Wu9dmnpGLGN6MZlqVGZrcGxjYDJUfV7JQz+rXzBlcwTtwplrp09ER6Pg61BImJP
	GuKaFYfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYbao-0000000Gom2-1nEj;
	Fri, 17 Jan 2025 01:56:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYbal-0000000GolE-3PDx
	for kexec@lists.infradead.org;
	Fri, 17 Jan 2025 01:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737078969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBe3eeTEFS2c2V0/g2HvswYNSDDgWbxsTGLzAw3EfuQ=;
	b=K3Nlto25IFZ1z8IsnrtJca/98quEVYKUFH86XQmumcX5bOmaPY2uhTh2FzukHP+dP1kofU
	aYIBCBAnT/HqVKtXH7p6yNow/cZpIY8DUTI4jNMgU6XoNesK/JCfDDogombCQIwhx2wfu7
	SNGQbrIwUyZjS6XauX4cnj+AGsBVCsc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-84aStPJhPwWpmp7hpABuyA-1; Thu,
 16 Jan 2025 20:56:05 -0500
X-MC-Unique: 84aStPJhPwWpmp7hpABuyA-1
X-Mimecast-MFC-AGG-ID: 84aStPJhPwWpmp7hpABuyA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDDBA19560AB;
	Fri, 17 Jan 2025 01:56:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C485195608A;
	Fri, 17 Jan 2025 01:56:00 +0000 (UTC)
Date: Fri, 17 Jan 2025 09:55:55 +0800
From: Baoquan He <bhe@redhat.com>
To: Roberto Ricci <io@r-ricci.it>
Cc: Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4m4q8yfIjfMRgZ+@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4Zjmva-pLbLjtQv@desktop0a>
 <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
 <Z4ejbdJr87V3IwV8@desktop0a>
 <Z4jy-NoLxpwaLfyD@desktop0a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4jy-NoLxpwaLfyD@desktop0a>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_175611_928033_F4C2F415 
X-CRM114-Status: UNSURE (   8.10  )
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

On 01/16/25 at 12:52pm, Roberto Ricci wrote:
> On 2025-01-15 Wed 13:00:52 +0100, Roberto Ricci wrote:
> > On 2025-01-15 Wed 12:04:10 +0800, Baoquan He wrote:
> > > On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> > > > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
...snip...
> Also, I can't reproduce with the default config (make defconfig),
> therefore something in my config (I already sent it) may play a role.

What I tried is defconfig on 6.13-rc7, let me try your config again.


