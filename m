Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8026C48BF6
	for <kexec@archiver.kernel.org>; Thu, 29 Feb 2024 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dbmoXqEcsiK2YLykwi3depUASnmB9UgrKvIYf7r+9EA=; b=vRhVtxBsJPuS/+
	OmV8+j7lOsbPCsuyQ5TbuzDv2oEJNwfjNazzesV00eWuFttipH+XmVu8zn3G7QA2kkRp1R09U1LHl
	SI7/g8bCOuNwu17+pGKyKsxRXe3EuHrmrxIPOEQM+HLNHmEVhLyHvytrlIURVmmmz2vZGT/fjDujA
	c1o9Z8f0xxWt/9eOolw2qm2xwUcx5omRmxVPNk0bD9SrdgzTd9UUe26ueu0unzIk9wVaZrf+TTHIP
	56CDUa1xTOcTXwpKukWrMXSutT0Acxe2kyH60J7GR0FIpe8I3xColwr6Jk0Q5Z+yFJWp3sYqObuYL
	HJyMBRu9F/VPg2Q3h5hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfgM1-0000000DdpI-1Dmm;
	Thu, 29 Feb 2024 13:21:41 +0000
Received: from bee.tesarici.cz ([77.93.223.253])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfgLw-0000000DdkV-45im
	for kexec@lists.infradead.org;
	Thu, 29 Feb 2024 13:21:39 +0000
Received: from meshulam.tesarici.cz (unknown [213.235.133.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id BB8D61BE01B;
	Thu, 29 Feb 2024 14:21:20 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709212883; bh=W9Ca6WxMe0ePjruOa7Varz1kJvqdyOtBeHSeSBDdvbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=baTH7RbDrd+4pxVinm5/lbkVaJq4HpMzmQVQ1p9APQxqOZ+z+7uv8abHk6UjrQRax
	 8/mmdTKMYaXuLXj7T5Vwojf0bSAuIzcHKnLEPoCdLQr/3ulJQjzhCu8zFYwYoN7un0
	 NbeiHC2/dToUjGC4szPaWISBhrxRgljOHizVcRfIxELrbSdvgDUYLHIwV86Rc3em9j
	 n7kB8l+il5gGqc7+eZVarDVi/J11G+CoPV1M8JXa8hUSWXhuZL56z1aNvYSGKnp+hg
	 iuz69GOGI1YnM+Q3wm/b40Gc1YZ6e7YCzEymQgbhfkOnkhKwcUxU9yAVitntpiuvOR
	 zhF/xj5WWPe3Q==
Date: Thu, 29 Feb 2024 14:21:16 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, stefanb@linux.ibm.com, ebiederm@xmission.com,
 noodles@fb.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, code@tyhicks.com, nramas@linux.microsoft.com,
 paul@paul-moore.com
Subject: Re: [PATCH v5 6/8] ima: suspend measurements during buffer copy at
 kexec execute
Message-ID: <20240229142116.5f16061b@meshulam.tesarici.cz>
In-Reply-To: <20b13e7bab048b3afb94a8878299aa7d61016364.camel@linux.ibm.com>
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
	<20240214153827.1087657-7-tusharsu@linux.microsoft.com>
	<cba09611c2e069be49faca2f137d99c772635831.camel@linux.ibm.com>
	<20b13e7bab048b3afb94a8878299aa7d61016364.camel@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_052137_485772_077D3D2A 
X-CRM114-Status: GOOD (  20.69  )
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

On Thu, 22 Feb 2024 11:38:23 -0500
Mimi Zohar <zohar@linux.ibm.com> wrote:

> > > @@ -176,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry
> > > *entry, int violation,
> > >  		}
> > >  	}
> > >  
> > > +	/*
> > > +	 * suspend_ima_measurements will be set if the system is
> > > +	 * undergoing kexec soft boot to a new kernel.
> > > +	 * suspending measurements in this short window ensures the
> > > +	 * consistency of the IMA measurement list during copying
> > > +	 * of the kexec buffer.
> > > +	 */  
> > 
> > Either remove the 2nd sentence "suspending measurements in this short window
> > ..." or explain what is meant by "short window".
> > 
> >   
> > > +	if (atomic_read(&suspend_ima_measurements)) {
> > > +		audit_cause = "measurements_suspended";
> > > +		audit_info = 0;
> > > +		goto out;  
> 
> After the suggested changes, understanding how many measurements are not being
> added to the measurement list and not being extended into the TPM would be
> really interesting.

First, I'm sorry for chiming in when v5 is already around, but I have
just found this patch series now.

It indeed sounds conceptually wrong to suspend and resume measurements.
At some point during the handover, other CPUs are taken offline (look
for migrate_to_reboot_cpu() in kernel/kexec_core.c) and even the reboot
CPU will be sufficiently shut down as not to be able to add any more
measurements.

IMO it would make more sense to copy the measurement list at this late
stage, even if it means adding a new notifier list (or a new action).

It may be a bit challenging if you want to make 100% sure that a new
measurement cannot be made from hard interrupt context, but is that even
a supported scenario?

Just my two (euro)cents,
Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
