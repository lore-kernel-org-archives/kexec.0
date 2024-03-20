Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64E2CD11BF
	for <kexec@archiver.kernel.org>; Wed, 20 Mar 2024 14:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MZjDqP583H8Z5QEO+U9TpqJdCN2gGd5Ic+Rdz1ZEwTw=; b=w832My9UkWeBzR
	MZOIOVDRqd591s8Z4mPaSdTB7toyt4sI4TUk05W3Z7pGZgDLS0wqfbL5pVopZKcj4R2o0d/DUV+lF
	kIhBYevlcxtx3ozrLG8nC+B4wYSiw9vtzvCEkxBKNsU2X0gkNK52v+NSvQuzr184O3+KyOwtiiZ/D
	dsyK7644WzVvIQ4hs0sTsXVn0ScFLKry6hSnNvg5AltxlyYb0M61e1M3Qgd/W5Zrt8MVZ4Fp4OCEI
	veTDQL5CCgBF70tdaayCC3Xe1crGJJ1e8nbBEhmT1sJQTrlTLe8mALA12yAMAh7kfoTbakZGY5ore
	elfh3BgvUlJO3fDRfikg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmwcs-0000000HNHv-1vjx;
	Wed, 20 Mar 2024 14:09:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmwcp-0000000HNFt-3jM1
	for kexec@lists.infradead.org;
	Wed, 20 Mar 2024 14:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710943743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcJPMNfkj8HLDRB0r2SHWu4MamIF95dM2IslTw3XZr0=;
	b=X758/N2U8NTNNOQE1/OpiNwwtmconJglp0I0Xob4Xd1CaGmz57GyQlPdYrv0YzlDhbL808
	gmiVqgqvLdsaVhvNkPCS1m8SyBS1VRu9+rdg/QJakrT6OtoGMd7NNaXOMG7OtLzu8t/lyK
	VMtn8UFuXHZwLMNPlpLLEymBo/Yqp40=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-SlarUKtuPt21RteC3aUyQA-1; Wed,
 20 Mar 2024 10:08:56 -0400
X-MC-Unique: SlarUKtuPt21RteC3aUyQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2517F299E76A;
	Wed, 20 Mar 2024 14:08:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5047740C6CB7;
	Wed, 20 Mar 2024 14:08:53 +0000 (UTC)
Date: Wed, 20 Mar 2024 22:08:30 +0800
From: Baoquan He <bhe@redhat.com>
To: "chenhaixiang (A)" <chenhaixiang3@huawei.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	Louhongxiang <louhongxiang@huawei.com>,
	"wangbin (A)" <wangbin224@huawei.com>,
	"Fangchuangchuang(Fcc,Euler)" <fangchuangchuang@huawei.com>,
	lihuafei <lihuafei1@huawei.com>,
	"wanghai (M)" <wanghai38@huawei.com>
Subject: Re: Question about Address Range Validation in Crash Kernel
 Allocation
Message-ID: <Zfrt3qdIWsbflBq0@MiWiFi-R3L-srv>
References: <b1c67ea9d8fe4f6f832d9272be177bec@huawei.com>
MIME-Version: 1.0
In-Reply-To: <b1c67ea9d8fe4f6f832d9272be177bec@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_070904_023957_8A3F96C5 
X-CRM114-Status: GOOD (  10.55  )
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

On 03/20/24 at 01:12pm, chenhaixiang (A) wrote:
> I tested the kernel-6.8 on my machine and found that the crashkernel memory reservation range is consistent with kernel-5.10. However, it's strange that when crashkernel=512M, the kernel still allocates two memory segments for crashkernel, as seen in the logs:
> [    0.022640] crashkernel low memory reserved: 0x49000000 - 0x59000000 (256 MB)
> [    0.022641] crashkernel reserved: 0x000000c01f000000 - 0x000000c03f000000 (512 MB)
> But only one segment is shown in /proc/iomem:
> 	c01f000000-c03effffff : Crash kernel
> Moreover, the conflicting address 53cbd000-53ccffff is still reserved by someone else:
> 	53cbd000-53ccffff : Reserved
> [    0.029843] e820: update [mem 0x53cbd000-0x53ccffff] usable ==> reserved
> It seems there is a kernel bug here.
> If you need the complete log, I can send it later.

Yeah, please attach the complete log. I will have a look.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
