Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6577EC369B1
	for <kexec@archiver.kernel.org>; Wed, 16 Apr 2025 03:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DSUrpdlFst4zUoEQ0PmRqqZ4BUa3aoPhJxPxerV9mYM=; b=rzDTL/RAVlBx+MnV0h6dN3JGp2
	MP/D7ixwEEtVPnd2o68JQKB3A6k3T6fJWAe7J/HZawZhtqBmu0Pyils4hvIwCxBhLBrayETKlmFU6
	/+l3C5WCrcw+tnBcL6G9yZeCSkyGxLjtIqbSu0QSpvU3+W6iDYq6gHi1gujU1nLtZYUElSDMWxsuf
	eoMnsGDv6gl1L6+W/0ZU9+lWDbF1Nj06PGJpJ9BhW3mEJxlm/CYvWL/xmS99kiO+SakbYINKyZw0e
	7IaHutZSB2SXEROnr0cqvplTwxBKo1BkcegJiSrZ64Sn6c0bhqbANVtLNXpKVNiYuTaSAY8m9CkJo
	nw2Lkr2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4tNX-000000082cz-3RdZ;
	Wed, 16 Apr 2025 03:23:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4tMe-000000082ZC-1Idf
	for kexec@lists.infradead.org;
	Wed, 16 Apr 2025 03:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744773783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DSUrpdlFst4zUoEQ0PmRqqZ4BUa3aoPhJxPxerV9mYM=;
	b=cGbuyvVkaYyZ26dt1gpY8Xkz9kekf4jGIL0Xo3xhXGJsPLp+EyvhOOKgjwAjQeNPbCpr6L
	gIH7tRRhurpje4+1gAvvBuBXb3hC751QvzjyGQqG5jATvAOIxFJO9g/4ZmM5aVK87indgr
	DPJtpa9Qa4CLlM0vFMQ8882OMQ9vVZU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-jZrM28liOaqoT1eK1lmHhg-1; Tue,
 15 Apr 2025 23:22:59 -0400
X-MC-Unique: jZrM28liOaqoT1eK1lmHhg-1
X-Mimecast-MFC-AGG-ID: jZrM28liOaqoT1eK1lmHhg_1744773778
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 73A2E180035E;
	Wed, 16 Apr 2025 03:22:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 084C4180176A;
	Wed, 16 Apr 2025 03:22:56 +0000 (UTC)
Date: Wed, 16 Apr 2025 11:22:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Coiby Xu <coxu@redhat.com>
Cc: chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
References: <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_202304_425975_138498A1 
X-CRM114-Status: GOOD (  20.20  )
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

On 04/09/25 at 11:40am, Mimi Zohar wrote:
> On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
......snip.. 
> > Thanks for confirming. I will consider how to fix it accordingly. Maybe
> > after Steven's patches are merged. That would be great if the buffer
> > allocating and storing can be skiped for kdump in Steven's patch. While
> > I am worried that could disrupt the progress of Steven's patches.
> 
> Agreed, let's get Steven's patch set upstreamed and then make the kdump
> exceptions.
> 
> - "ima: kexec: move IMA log copy from kexec load to execute" looks like it isn't
> copying the IMA measurement list records (kexec_post_load), but the memory for
> the IMA measurement list is being allocated (ima_alloc_kexec_file_buf).
> 
> - Do you really want to totally disable IMA for kdump or would disabling IMA-
> measurement be sufficient?  Remember there's already an option to disable IMA-
> appraisal.  Disabling just IMA-measurement would allow IMA-appraisal to continue
> to work.  Meaning based on policy the integrity of files - executables, kernel
> image, etc - could still be verified.
> 
> Without IMA-measurement:
> - No adding records to the IMA measurement list
> - No IMA measurement list pseudo securityfs files
> - No extending the TPM
> 
> With IMA-appraisal:
> - Integrity verification of files based on keys, keyrings
> - Loading keys

Currently, Kdump has no demand to do integrity verification based on
keys, keyrings, except of Coiby's LUKS support in kdump:

[PATCH v8 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
https://lore.kernel.org/all/20250207080818.129165-1-coxu@redhat.com/T/#u

I have talked to Coiby, he will do some investigations to see if loading
keys related to IMA or IMA-appraisal functionality is related to LUKS
support in kdump because the LUKS support in kdump also needs
store/restore keys/keyrings between normal kernel and kdump kernel.

> 
> Obviously my preference would be to add support to disable IMA-measurement in a
> kdump environment.
> 
> thanks,
> 
> Mimi
> 


