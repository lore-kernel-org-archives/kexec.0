Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9E9C021B6
	for <kexec@archiver.kernel.org>; Tue, 25 Feb 2025 00:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kVAmyR6FHsajLdbtkqXLPF4+Gi6+fbQMI+k10rMIb+Y=; b=CEazzxcH+mRIuVzUrP6f4vwUaD
	z5yeX/ELMudqebnX27JtU8UticI8jEFhWtaWsro7Ye92aD6oXmKm9mP0vJflstHRGLlydy7hTdhvH
	EoZAl1TGTbXIAX1XX0Mb008h2ZiJhfkK63aIaaFy1w6K5jsO1+wlgIbyP3lMdbEeAFPknTUOLUHIn
	8LAbKS9+z4SwtCpdRdCv0SKiry1ZqQAHX1Hof/UNl84FNq1UeWTcHiGEuRaSCimioufs9DR5r/G4I
	LRhF9B0f4dbBVZntMFFUO6ka9SpQPksg0oqLCvBwpBB6gWxYDF/72tmskExHTUw3Euwv58rYENpXA
	WFCcdWxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmif6-0000000Fbrk-1Ok3;
	Tue, 25 Feb 2025 00:19:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmif3-0000000FbrC-1gtR
	for kexec@lists.infradead.org;
	Tue, 25 Feb 2025 00:18:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740442736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVAmyR6FHsajLdbtkqXLPF4+Gi6+fbQMI+k10rMIb+Y=;
	b=QAsVHP+UYvtygQ0NkRAaipnKjsCiydBje3cM0aSEZG5se1VghjtLeyfkMqKbnc4CW4/1Xi
	92GYdHbqYPTGZZcsMcHKi8JZzMJunQ1W0R1GkB+5MXeXc4idMZ4UukHd975zV79aqk4CFE
	sbEtSpBy6gCmEk7tqiPgR4KgsGnCyWU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-T7_wB4RKOL-n5ROr4S-uOw-1; Mon,
 24 Feb 2025 19:18:54 -0500
X-MC-Unique: T7_wB4RKOL-n5ROr4S-uOw-1
X-Mimecast-MFC-AGG-ID: T7_wB4RKOL-n5ROr4S-uOw_1740442732
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA69619373DC;
	Tue, 25 Feb 2025 00:18:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BFF71800358;
	Tue, 25 Feb 2025 00:18:48 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:18:44 +0800
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
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z70MZD+BssRG4R1H@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
 <658b52e4-a4bb-40fc-a00b-bfdb3bf15b52@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658b52e4-a4bb-40fc-a00b-bfdb3bf15b52@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_161857_518206_AF468C8B 
X-CRM114-Status: GOOD (  26.05  )
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

On 02/24/25 at 03:05pm, steven chen wrote:
> On 2/23/2025 10:14 PM, Baoquan He wrote:
> > Hi Steve, Mimi,
> > 
> > On 02/18/25 at 02:54pm, steven chen wrote:
> > > Currently, the mechanism to map and unmap segments to the kimage
> > > structure is not available to the subsystems outside of kexec.  This
> > > functionality is needed when IMA is allocating the memory segments
> > > during kexec 'load' operation.  Implement functions to map and unmap
> > > segments to kimage.
> > I am done with the whole patchset understanding. My concern is if this
> > TPM PCRs content can be carried over through newly introduced KHO. I can
> > see that these patchset doesn't introduce too much new code changes,
> > while if many conponents need do this, kexec reboot will be patched all
> > over its body and become ugly and hard to maintain.
> > 
> > Please check Mike Rapoport's v4 patchset to see if IMA can register
> > itself to KHO and do somthing during 2nd kernel init to restore those
> > TPM PCRs content to make sure all measurement logs are read correctly.
> > [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
> > 
> > Thanks
> > Baoquan
> 
> Hi Baoquan,
> 
> For IMA, it appears that there are no current issues with TPM PCRs after a
> kernel soft reboot.

I mean using KHO to hold in 1st kernel and restore the IMA log in 2nd
kernel.

> 
> This patches is used to get currently missed IMA measurements during the
> kexec process copied to new kernel after the kernel soft reboot. I think
> it's ok to leave it at current location: it will be easy to maintain for
> IMA.

Yeah, but I am saying this patchset increase unnecessary code
complexity in kexec code maintaining.

> 
> Overall, for these patches, do you see any major blockers for kexec?
> 
> If you have any specific concerns or need further details, please let me
> know.

I have no concerns for this patchset implementation itself, I saw you using
vmap to maping the possible scattered source pages smartly and taking
the mapped buffer pointers to update later duing kexec jumping. That's very
great and clever method. BUT I am concerned about the solution, if we
can make use of the existed way of KHO to implement it more simply. Could
you please do investigation?


