Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8A3C00140
	for <kexec@archiver.kernel.org>; Thu, 11 Aug 2022 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o5XzHJR7GBtc5kP3Qd/a1N4pVhKft1oSxOCcl70lO7g=; b=N6BT52S0XCUuqU
	IcNqx44yr+8d4V6zLnLn+peWfsypWqxJG6+LDqC8c48aVt1tIaf+plsNpdxyPobZhN5JKA/L1I9vH
	AfnAAtMjPS9CYiCsSgS7BF2xm3I+lxnZYe4we0fMb6UzHaljRWO6QurYbyUJKoHp7lJ3rPptb4s88
	UWYEqyhhutx0zyOk3OMcMeZbl1iBX17fQvslfvsM1657eLWFBVe2ALAuUa67jA+53ApidmXC5QCAa
	8oDnx4HbA2O0BBrv0j9WhnZoWh7UXlTnm5OAq/QxW0T1WpiXMaOEyWxXLgQKBf74jKI8jD1GKEovb
	aDzJ+nK1SWMx0yqvb1/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLwKt-000gtr-Ft; Thu, 11 Aug 2022 00:46:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLwKq-000gdT-Bw
	for kexec@lists.infradead.org; Thu, 11 Aug 2022 00:46:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1660178759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mb6LvVDNkIGuE2f7Qq0kKvwOfpEUqHsNTOyvM74HAMA=;
	b=W4h2YZjUJDfKWIGWUVHpzwV1PMJh7HAdupHd85BzxZ/DN4tN2lsyYnVZF6aMHneyeAPglM
	w+avF1j9iWOdQWoUQuHjrDMaJ9rOCXC+F3Lel/YoAc79nkbyVFjiMoIE6PQAnUSjarbmnM
	s4O+3kJ/ZA88wdwKZZlIA+zmWNMGTJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-DZFnXh6RPGyR82J4DCjfhw-1; Wed, 10 Aug 2022 20:45:58 -0400
X-MC-Unique: DZFnXh6RPGyR82J4DCjfhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60BF185A596;
	Thu, 11 Aug 2022 00:45:58 +0000 (UTC)
Received: from localhost (ovpn-12-110.pek2.redhat.com [10.72.12.110])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AA4901121319;
	Thu, 11 Aug 2022 00:45:57 +0000 (UTC)
Date: Thu, 11 Aug 2022 08:45:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Donny Xia <donnyxia@google.com>
Cc: dyoung@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org
Subject: Re: Question about the size of VMCOREINFO
Message-ID: <20220811004554.GE373960@MiWiFi-R3L-srv>
References: <CAKE-ki_vO=2SXGsX8cjX+89MP09Tku4KyNANPTiEPKUx7y-LpA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKE-ki_vO=2SXGsX8cjX+89MP09Tku4KyNANPTiEPKUx7y-LpA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_174604_550880_98E443D7 
X-CRM114-Status: GOOD (  14.90  )
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

Hi,

On 08/10/22 at 03:39pm, Donny Xia wrote:
> Hello Kdump Maintainers,
> 
> We utilize the kexec and kdump feature heavily to collect the crash dump
> file when the kernel crashes. We write some customized values into
> VMCOREINFO and we find that eventually the size of the data we write
> exceeds the size of VMCOREINFO. I find that the size of VMCOREINFO is one
> page, which I believe is 4k. I am wondering is there any specific reason to
> choose this size? Is it possible to use a bigger number? Any suggestions
> about it would be appreciated.

No specific reason. Just our current usage of vmcoreinfo_data is enough to
cover our need. I don't see why you can't enlarge it to, e.g 2 pages or
more. Have you tried? E.g allocate more pages and change
VMCOREINFO_BYTES to the corresponding value.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
