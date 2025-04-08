Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401ADC3600C
	for <kexec@archiver.kernel.org>; Tue,  8 Apr 2025 04:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e+0Q1kR0CMCFGP3tTyVdwrjZvM2FReb2Dfl3Am4J0jE=; b=ZvwTAIZzvXp/BCCg+jsJRZo63s
	uhFSMcinhykLdof/vHYm/mwrM4U5Q6JlK+XI0Xpekiv5l5lssg/J9Z5RZufHYoTsrhbzmb4LkPjBW
	B92vXhpGTKWkrORgNYmCY4CLLlgRgX3BrP4xVWfmaF2TDQ9UOOZ3EGdu0ccfpdBeREGfoogVG+N7S
	4ICdAuDw8TKeBMorDVMb7XQ8HvWkDyPiWBWYAHnwUhh4c81NED8rFFe35281orbolDrsx39ZPmpSG
	m97FAFF3kWRUCa8MXpLBzpRN2K6L8R+ppWIhuPFa6QN1BcQfh5k1kW/zPVheUj/7ar4aoqDdU+EzU
	OhRlNoIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20kP-00000002huj-1ckR;
	Tue, 08 Apr 2025 04:39:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20kM-00000002huI-28rN
	for kexec@lists.infradead.org;
	Tue, 08 Apr 2025 04:39:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744087176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e+0Q1kR0CMCFGP3tTyVdwrjZvM2FReb2Dfl3Am4J0jE=;
	b=UWYyvwKax9h9iz64Da6s5dGdmWqyr+I4XTTrqAGIUS8Ih/hnNYXPBMjSPO9HaXwmP4fJvr
	+gopDRdZrTIWoPVmDYMl4Fkn7P7V6ayqzA2ykHt2iB32uIsgk406RMP7gTZ9S7F5GQ05by
	7p65fQKf8S1x7DoKJw8Iy1RetNDE6XA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-kSFC8oDwPmOf0EdxmEQVAQ-1; Tue,
 08 Apr 2025 00:39:32 -0400
X-MC-Unique: kSFC8oDwPmOf0EdxmEQVAQ-1
X-Mimecast-MFC-AGG-ID: kSFC8oDwPmOf0EdxmEQVAQ_1744087169
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB9B41955BC9;
	Tue,  8 Apr 2025 04:39:28 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72AFA180094A;
	Tue,  8 Apr 2025 04:39:26 +0000 (UTC)
Date: Tue, 8 Apr 2025 12:39:22 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v11 2/9] ima: define and call ima_alloc_kexec_file_buf()
Message-ID: <Z/SoekIdreYI3uBZ@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-3-chenste@linux.microsoft.com>
 <a293ed27094f7fa7a36f1641a9e6b17a49e26fa0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a293ed27094f7fa7a36f1641a9e6b17a49e26fa0.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_213938_633653_0C514A20 
X-CRM114-Status: GOOD (  26.90  )
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

On 04/08/25 at 12:07am, Mimi Zohar wrote:
> On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> > In the current implementation, the ima_dump_measurement_list() API is 
> > called during the kexec "load" phase, where a buffer is allocated and 
> > the measurement records are copied. Due to this, new events added after
> > kexec load but before kexec execute are not carried over to the new kernel
> > during kexec operation
> 
> Repeating this here is unnecessary.
> > 
> > To allow the buffer allocation and population to be separated into distinct
> > steps, make the function local seq_file "ima_kexec_file" to a file variable.
> 
> This change was already made in [PATCH v11 1/9] ima: rename variable the
> set_file "file" to "ima_kexec_file".  Please remove.
> 
> > 
> > Carrying the IMA measurement list across kexec requires allocating a
> > buffer and copying the measurement records.  Separate allocating the
> > buffer and copying the measurement records into separate functions in
> > order to allocate the buffer at kexec 'load' and copy the measurements
> > at kexec 'execute'.
> > 
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > ---
> >  security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
> >  1 file changed, 35 insertions(+), 11 deletions(-)
> > 
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 650beb74346c..b12ac3619b8f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -15,26 +15,46 @@
> >  #include "ima.h"
> >  
> >  #ifdef CONFIG_IMA_KEXEC
> > +static struct seq_file ima_kexec_file;
> > +
> > +static void ima_free_kexec_file_buf(struct seq_file *sf)
> > +{
> > +	vfree(sf->buf);
> > +	sf->buf = NULL;
> > +	sf->size = 0;
> > +	sf->read_pos = 0;
> > +	sf->count = 0;
> > +}
> > +
> > +static int ima_alloc_kexec_file_buf(size_t segment_size)
> > +{
> > +	ima_free_kexec_file_buf(&ima_kexec_file);
> 
> After moving the vfree() here at this stage in the patch set, the IMA
> measurement list fails to verify when doing two consecutive "kexec -s -l"
> with/without a "kexec -s -u" in between.  Only after "ima: kexec: move IMA log
> copy from kexec load to execute" the IMA measurement list verifies properly with
> the vfree() here.

I also noticed this, patch 7 will remedy this. Put patch 7 just after
this patch or squash it into this patch?

[PATCH v11 7/9] ima: verify if the segment size has changed

> 
> > +
> > +	/* segment size can't change between kexec load and execute */
> > +	ima_kexec_file.buf = vmalloc(segment_size);
> > +	if (!ima_kexec_file.buf)
> > +		return -ENOMEM;
> > +
> > +	ima_kexec_file.size = segment_size;
> > +	ima_kexec_file.read_pos = 0;
> > +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> > +
> > +	return 0;
> > +}
> > +
> 


