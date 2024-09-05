Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F3CCD4F4E
	for <kexec@archiver.kernel.org>; Thu,  5 Sep 2024 03:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G9Dliv3UgEaUrKDsIFpn98HEMBmjWV0lPGTOBQ9HYWg=; b=GNg528JRbyaq14
	d3As36TFrzEP2i+r5a2yRI4GIu1QZ5DIDu6NefYkMBo8kYoJ5lw3ecFQDeVy7WLabjrZPcD1U5O5r
	ziUY+/g3nVKR2g4EL61UshEZmXG/WBIYE9IJpKB2tIJ06Son7daAS5ZGeHU6oWRII0pvzerQ1ZLa7
	WsG5/kDIfyFe7vweuHNzfJFFdnCZNNoNXiDpLDWk4SqZdOat/0HPiMDIZZc5CHQnqwcySAmNdwIy1
	8tXAerTTISZ70R520Qfmr+FTuRwd3TfeejBsUDQ+CAb/yuBLZvkK/Prp2oDjvKZM64O4R+DsBF7I2
	wB476VfgXo8ECttVx6QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm365-00000006nzE-32jn;
	Thu, 05 Sep 2024 03:23:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm35o-00000006ntA-39r1
	for kexec@lists.infradead.org;
	Thu, 05 Sep 2024 03:23:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725506611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTNSGL25zCLG+PtyocxhqR9poI911nBZG+X7qZt1q6o=;
	b=MJ/BKCqhoOoyNM6ZaxyW93gOQNoxtk0KPpT1iPCf/uG2ZKSDGhqoIwi7mAwZ5v/vCSGfaQ
	PBkw8I5FgoywxqYJ6w03/1IfBmOeUJELxWF+8VKPPNx32xEXVwYF9f4FmtR9FLu/luDb72
	Zl/D8se25GQy/f4RQSFtk1AEtd+9D/U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-xc-9i_YyNRWBh0VIswKbpA-1; Wed,
 04 Sep 2024 23:23:25 -0400
X-MC-Unique: xc-9i_YyNRWBh0VIswKbpA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 884571977021;
	Thu,  5 Sep 2024 03:23:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C7A41955D53;
	Thu,  5 Sep 2024 03:23:18 +0000 (UTC)
Date: Thu, 5 Sep 2024 11:23:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_202332_917165_5894C94E 
X-CRM114-Status: GOOD (  28.11  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 09/04/24 at 02:55pm, Sourabh Jain wrote:
> Hello Baoquan,
> =

> On 30/08/24 16:47, Baoquan He wrote:
> > On 08/20/24 at 12:10pm, Sourabh Jain wrote:
> > > Hello Baoquan,
> > > =

......snip... =

> > > 2. A patch to return early from the `crash_handle_hotplug_event()` fu=
nction
> > > if `kexec_in_progress` is
> > >  =A0=A0 set to True. This is essentially my original patch.
> > There's a race gap between the kexec_in_progress checking and the
> > setting it to true which Michael has mentioned.
> =

> The window where kernel is holding kexec_lock to do kexec boot
> but kexec_in_progress is yet not set to True.
> =

> If kernel needs to handle crash hotplug event, the function
> crash_handle_hotplug_event()=A0 will not get the kexec_lock and
> error out by printing error message about not able to update
> kdump image.

But you wanted to avoid the erroring out if it's being in
kernel_kexec().  Now you are seeing at least one the noising =

message, aren't you?

> =

> I think it should be fine. Given that lock is already taken for
> kexec kernel boot.
> =

> Am I missing something major?
> =

> > That's why I think
> > maybe checking kexec_in_progress after failing to retriving
> > __kexec_lock is a little better, not very sure.
> =

> Try for kexec lock before kexec_in_progress check will not solve
> the original problem this patch trying to solve.
> =

> You proposed the below changes earlier:
> =

> -	if (!kexec_trylock()) {
> +	if (!kexec_trylock() && kexec_in_progress) {
>  		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>  		crash_hotplug_unlock();

Ah, I meant as below, but wrote it mistakenly.

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6e..e7c7aa761f46 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -504,7 +504,7 @@ int crash_check_hotplug_support(void)
 =

 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
-	if (!kexec_trylock()) {
+	if (!kexec_trylock() && !kexec_in_progress) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
 		crash_hotplug_unlock();
 		return 0;


> =

> =

> Once the kexec_in_progress is set to True there is no way one can get
> kexec_lock. So kexec_trylock() before kexec_in_progress is not helpful
> for the problem I am trying to solve.

With your patch, you could still get the error message if the race gap
exist. With above change, you won't get it. Please correct me if I am
wrong.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
