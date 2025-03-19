Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC676C282EC
	for <kexec@archiver.kernel.org>; Wed, 19 Mar 2025 02:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pppH5gnOqQCyGbRm+GFbQIGngpP8DhwB6Ev0UDCWREA=; b=RCpAQn6jaPXb8n09tDHJ0R8Kwb
	D7BcHQ9T84equ1UF69F7QGn1h3Faa2TYsp1Z2Ee9OIIEFQFyrGTZpJIsW6MmT/7WisWbYUijwfN9t
	z/1rdLl4ydT2410sfdlrhhyZ/8ty6wuviCNZsw6ZegVu25PviX9lg1Kj9Dt6Wht8FRHi172LgnHpL
	+PkO3VG4hwYs+guqrmwHcU8DHZ/aeM/VaV5vSxdIh2GDJDL0nQPMKDdPomaLDaQSxPR7tWeS1EOJP
	Pe6J1oRsHw5RrF/5q4fhRXL9qMTtm2kIKL6v4rLZilvhlLfykHFPqVYpJjGrz81kfS2xKd5Crecp/
	OvZX0rlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tujPG-00000007om1-2STL;
	Wed, 19 Mar 2025 02:43:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tujPD-00000007olB-1DpK
	for kexec@lists.infradead.org;
	Wed, 19 Mar 2025 02:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742352221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pppH5gnOqQCyGbRm+GFbQIGngpP8DhwB6Ev0UDCWREA=;
	b=AL8cmmpUWZ9WUomc5mGA32cjb9AIaIrFAPAdEEdCPA9aSRk/D+rQz5h3AwVg1wqxVASZcb
	7oQNs6q72r962p2IPuSIdXOXwOs+vQqtqTMbC7MaMIMp6Hder2+iWJ1GGm4RasMMea3I2H
	GGdL9j6/FpBcYyy7gdmnqIxgXuzZO58=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-aJgyg-HUOCybde04zKe6yw-1; Tue,
 18 Mar 2025 22:43:38 -0400
X-MC-Unique: aJgyg-HUOCybde04zKe6yw-1
X-Mimecast-MFC-AGG-ID: aJgyg-HUOCybde04zKe6yw_1742352216
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B294218001DE;
	Wed, 19 Mar 2025 02:43:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13EA13001D0E;
	Wed, 19 Mar 2025 02:43:32 +0000 (UTC)
Date: Wed, 19 Mar 2025 10:43:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v10 1/8] ima: rename variable the ser_file "file" to
 "ima_kexec_file"
Message-ID: <Z9ovT3CnxBqN+cKI@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-2-chenste@linux.microsoft.com>
 <d85bad29-2391-41cc-868f-73119a5fffba@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d85bad29-2391-41cc-868f-73119a5fffba@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_194343_403497_A2CB0137 
X-CRM114-Status: GOOD (  23.61  )
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

On 03/18/25 at 11:10am, Stefan Berger wrote:
> 
> 
> On 3/17/25 9:04 PM, steven chen wrote:
> > The name of the local variable "file" of type seq_file defined in the
> > ima_dump_measurement_list function is too generic. To better reflect the
> > purpose of the variable, rename it to "ima_kexec_file". This change will
> > help improve code readability and maintainability by making the variable's
> > role more explicit.
> > 
> > The variable ima_kexec_file is indeed the memory allocated for copying IMA
> > measurement records. The ima_dump_measurement_list function calculates the
> > actual memory occupied by the IMA logs and compares it with the allocated
> > memory. If there is enough memory, it copies all IMA measurement records;
> > otherwise, it does not copy any records, which would result in a failure
> > of remote attestation.
> > 
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> 
> 
> > ---
> >   security/integrity/ima/ima_kexec.c | 39 ++++++++++++++++++------------
> >   1 file changed, 24 insertions(+), 15 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 9d45f4d26f73..8567619889d1 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -15,33 +15,41 @@
> >   #include "ima.h"
> >   #ifdef CONFIG_IMA_KEXEC
> > +/*
> > + * Copy the measurement list to the allocated memory
> > + * compare the size of IMA measurement list with the size of the allocated memory
> 
> Compare the size of the IMA ... memory.
> 
> 
> > + *    if the size of the allocated memory is not less than the size of IMA measurement list
> > + *        copy the measurement list to the allocated memory.
> > + *    else
> > + *        return error
> 
> If the size of the allocated memory is not less than the size of IMA
> measurement list, copy the measurement list to the allocated memory, return
> an error otherwise.

Ack the suggested change.


