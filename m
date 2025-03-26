Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C3C36005
	for <kexec@archiver.kernel.org>; Wed, 26 Mar 2025 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hpwLopG/y4QsEDTE7uR/BjKfEYIxvRxD91VY/RN0u38=; b=ztpZisCujRCog8/VgvACu45FSW
	56JOSH5KFIi60l2Ag0T1FEz9sYhpaYiQoIe2Z2VLKoi/75PHwx5IzrL7inq7JJZvbJECpVnYlX+s2
	L4tG64Xn+eON+lWZbVSIt8CgyyfvkCNLMLJdYHPwIozImRVhEdKK7R4pUGLEeURFkTSRIDouqETFi
	YmCqXAsYjRd3ppzJkovwW1JRC0iXLAclvMJjOMS1mH0u64wZOsWkcs1MC83XaQgsKo6JytuDUf0cr
	eY3WKptQX4c70cNd37uNONJlTG0LaN83l2Cx61IlMhe+Ixrei2KHxICYV+CnbrcLIgS10lwfjbsMX
	DmLeg4eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txGWq-00000007Q3W-2jkT;
	Wed, 26 Mar 2025 02:30:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txGVB-00000007Pu4-1azl
	for kexec@lists.infradead.org;
	Wed, 26 Mar 2025 02:28:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742956098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpwLopG/y4QsEDTE7uR/BjKfEYIxvRxD91VY/RN0u38=;
	b=OwhJObWWMz9zcxaqIZRfGD7XhN19tTh976YnuGH5KSoQqH/9362ytV32ybti74pAqjwOyQ
	KJ+dl1ke9FQ17+mR/B8A8NrgmfyDwZbPeXv+2Q0geIzQ/ATW0mzJ8g+UK/g3YJWvpy1kuR
	ScNwIONMgEyWqYqRXxfHgRhAOFTwTuM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-BU-CW3qUPCm4PVw89ZN9DA-1; Tue,
 25 Mar 2025 22:28:14 -0400
X-MC-Unique: BU-CW3qUPCm4PVw89ZN9DA-1
X-Mimecast-MFC-AGG-ID: BU-CW3qUPCm4PVw89ZN9DA_1742956092
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3628196D2CC;
	Wed, 26 Mar 2025 02:28:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.203])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13EF21801A69;
	Wed, 26 Mar 2025 02:28:07 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:27:58 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
Message-ID: <Z+NmLtn0vojVYJ3H@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
 <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
 <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
 <6583378c-55ee-4192-a95f-ebaf3f708bbb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6583378c-55ee-4192-a95f-ebaf3f708bbb@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_192821_493703_8B1051B5 
X-CRM114-Status: GOOD (  23.92  )
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

On 03/25/25 at 03:27pm, steven chen wrote:
> On 3/24/2025 4:00 AM, Baoquan He wrote:
> > On 03/21/25 at 09:23am, steven chen wrote:
> > > On 3/19/2025 7:06 PM, Baoquan He wrote:
> > > > On 03/17/25 at 06:04pm, steven chen wrote:
> > > > ...snip...
> > > > > ---
> > > > >    kernel/kexec_file.c                | 10 ++++++
> > > > >    security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
> > > > >    2 files changed, 40 insertions(+), 21 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > index 606132253c79..ab449b43aaee 100644
> > > > > --- a/kernel/kexec_file.c
> > > > > +++ b/kernel/kexec_file.c
> > > > > @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
> > > > >    }
> > > > >    #endif
> > > > > +static void kimage_file_post_load(struct kimage *image)
> > > > > +{
> > > > > +#ifdef CONFIG_IMA_KEXEC
> > > > > +	ima_kexec_post_load(image);
> > > > > +#endif
> > > > > +}
> > > > > +
> > > > >    /*
> > > > >     * In file mode list of segments is prepared by kernel. Copy relevant
> > > > >     * data from user space, do error checking, prepare segment list
> > > > > @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > > > >    	kimage_terminate(image);
> > > > > +	if (!(flags & KEXEC_FILE_ON_CRASH))
> > > > > +		kimage_file_post_load(image);
> > > > machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
> > > > we should use it to do things post load, but not introducing another
> > > > kimage_file_post_load().
> > > Hi Baoquan,
> > > 
> > > Could you give me more detail about this?
> > I mean machine_kexec_post_load() is the place where post load operations
> > are done, including kexec_load and kexec_file_load. There's no need to
> > specifically introduce a kimage_file_post_load() to do post load
> > operaton for kexec_file_load.
> 
> Hi Baoquan,
> 
> Updating the machine_kexec_post_load() API to carry flags would indeed
> require changes to multiple files. This approach involves the condition
> check if (!(flags & KEXEC_FILE_ON_CRASH)) and ensuring that the flags are
> properly passed and handled across the relevant file
> 
> if just adding a API kimage_file_post_load() here, it is much easy and
> clean, right?

Hmm, it's easier, while maybe not good. We should not repeatedly
introduce similar things into codes. Here, it's similar as
what kexec_apply_relocations() and arch_kexec_apply_relocations() are
doing. 

int machine_kexec_post_load(struct kimage *image) 
{
#ifdef CONFIG_IMA_KEXEC
        ima_kexec_post_load(image);
#endif
	return arch_machine_kexec_post_load();
}

Then a generic arch_machine_kexec_post_load(struct kimage *image)
{return 0;} version, and a arm64 specific version. 

Is it OK to you?


