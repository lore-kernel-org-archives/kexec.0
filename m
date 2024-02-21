Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB13C48BF6
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5GMGfY8Y6wgzJszELH1idaXrbYsfl6Cw2B5Kermnoo8=; b=bfGK5UDp9+gQwG
	IIgMmpiqaDm4DZ3cZH/krjL6hEZxcfgVsjziYhl1ijHokrjUvpcA039J3/9vkrHdHY/AWaHrYjhG4
	zPQruRfNRFmGmYnI9Ljd8Ekl8NvokbcBJ/kDsamyXRDN9jj23ONNwB5upSgnVWw9KRUmnYcRRBCUW
	mkkvl8YMjye2IJhfUS374RhZJhil6T2Zp1JGEVVyse8QUgBPig3tkTRrwwLtxwY2eoxbqRwJDnfFs
	GMdwa7aILOATUMu/VReX4MF/3QQYP5UqMw16BIZm1ogb7aqguquAT9UYXXSDFgokNt9RztUjMDa8B
	SJiTMW/YzJ8H1aD92fIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmtV-000000017SJ-2IJN;
	Wed, 21 Feb 2024 13:44:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmtS-000000017Qa-3A42
	for kexec@lists.infradead.org;
	Wed, 21 Feb 2024 13:44:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708523052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjg3ALQw4zFfCtoxrqU3mC8VARBMiLwWXwoSwpKkxVk=;
	b=WWA+wJgnLDUk370kmYH/LehaT5Ve7heAzmR4VSiu2MrpVJh8BmRE2z/UFKzKRiaOfZgGtD
	A/fOipeYFFzCZGG08IJSMpx57l2knMjOJF0GsqISk6o0vLD1LvuCY7T8cIa5CPRlYZkjeH
	oeEW8XEwxGs2SJZzs2Yr9i27QBSchLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-viBCBzv1MZWeE0zNlD0FTQ-1; Wed, 21 Feb 2024 08:44:09 -0500
X-MC-Unique: viBCBzv1MZWeE0zNlD0FTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1712C867943;
	Wed, 21 Feb 2024 13:44:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 21A5F2166B36;
	Wed, 21 Feb 2024 13:44:06 +0000 (UTC)
Date: Wed, 21 Feb 2024 21:44:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, piliu@redhat.com, linux-sh@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	ebiederm@xmission.com, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 00/14] Split crash out from kexec and clean up related
 config items
Message-ID: <ZdX+JMKsQWheE0B0@MiWiFi-R3L-srv>
References: <20240119145241.769622-1-bhe@redhat.com>
 <9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com>
 <Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv>
 <559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_054414_900914_62D86242 
X-CRM114-Status: GOOD (  18.99  )
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

On 02/21/24 at 11:15am, Hari Bathini wrote:
> Hi Baoquan,
> 
> On 04/02/24 8:56 am, Baoquan He wrote:
> > > > Hope Hari and Pingfan can help have a look, see if
> > > > it's doable. Now, I make it either have both kexec and crash enabled, or
> > > > disable both of them altogether.
> > > 
> > > Sure. I will take a closer look...
> > Thanks a lot. Please feel free to post patches to make that, or I can do
> > it with your support or suggestion.
> 
> Tested your changes and on top of these changes, came up with the below
> changes to get it working for powerpc:
> 
> 
> https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/
> 
> Please take a look.

I added a comment to the patch 1 consulting if the "struct crash_mem" is
appropriate to cover other cases except of kdump memory regions. I am
wondering if its name need be adjusted, or other kind of memory you
mentioned can use other structures or create a new one.

If it's has to be done like that, it's fine. 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
