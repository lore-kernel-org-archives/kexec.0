Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C5DECE582
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uIJkI5nL0w8uasG/Z5liTpPKMoKD7FnQPQc3IcmAdTc=; b=EsXGmEIlOzx0gE
	GS+j5oNDUlDlefx65oSS6iBQ1e8Y4dWZCyutVU0r2UjaCoU4Ifo8hfjA0LV4pEc7jYb+S49rl2/Q5
	8R6YO4UlbbZx7VW16hZb9yD5uPEz0lSr7AvrTbAOeMKxT1blcpQCVYr598VN9RPaPIBwRXIUNxiDF
	M8j/ZdJWRRTHakyxOrZtaWXyMKfvQWYXFTkB/8JA3D6iaA4PEs63NmQ2g0hqf/qtVuJqCtAEmI5eQ
	X/kofJnzsJ3addKIgsMTeUDzHHnSGyElKeYrhXWoglSm1P61jHVNj855mUQwctMxsDuyxnf9/CqC1
	hkiUrU4wuXJObi4qi77g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snxNB-000000053iV-2GJ0;
	Tue, 10 Sep 2024 09:41:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snxMf-000000053ZL-0GJr
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 09:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725961248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFE0gTOSvJ22bbsZXLn7Kw50Px9Uq2WJzebFyV8nzxY=;
	b=YCt+lu5ulSGTYLOcKeMitg2NvFiTA1APuo3mOb8IzbPBL9b9sTbx3qavmOCQzdSaDHieND
	V2Js+yP63CYJxfwLLFfwgVbdLn4Efpoi33w5EbL2+VBQKIXf5JIw1PsMIMzPQh83ifXbF3
	zoEkvOy8N2fXwucKMmSepp0OvfLfN9w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-srpyLGbuNGu7w9mpKxLywQ-1; Tue,
 10 Sep 2024 05:40:44 -0400
X-MC-Unique: srpyLGbuNGu7w9mpKxLywQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53FDE1954B16;
	Tue, 10 Sep 2024 09:40:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE4F1195605A;
	Tue, 10 Sep 2024 09:40:41 +0000 (UTC)
Date: Tue, 10 Sep 2024 17:40:37 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, dyoung@redhat.com,
	daniel.kiper@oracle.com, noodles@fb.com, lijiang@redhat.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 2/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <ZuAUFTgK5G2xzSya@MiWiFi-R3L-srv>
References: <20240829104016.84139-1-bhe@redhat.com>
 <20240829104016.84139-3-bhe@redhat.com>
 <43291018-098f-291a-629b-6e02ef00f8e5@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <43291018-098f-291a-629b-6e02ef00f8e5@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_024049_193178_A213DBA2 
X-CRM114-Status: GOOD (  15.20  )
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

On 09/09/24 at 09:53am, Tom Lendacky wrote:
> On 8/29/24 05:40, Baoquan He wrote:
......snip.. 
> > Here fix the code bug to make kexec/kdump kernel boot up successfully.
> > 
> > And also fix the similar buggy code in memremap_is_setup_data() which
> > are found out during code reviewing.
> 
> I think you should add something along the lines that the "len" variable
> in struct setup_data is the length of the "data" field and does not
> include the size of the struct, which is the reason for the miscalculation.

Fair enough. I will send v3 to add the reason of miscalculation.

> 
> Otherwise:
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks a lot for careful checking.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
