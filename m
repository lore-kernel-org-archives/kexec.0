Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403A0C021B2
	for <kexec@archiver.kernel.org>; Mon, 24 Feb 2025 01:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ak1ca6nvXR4gpIUt8nNdn7G0ahaANyhsMag+O/8d/Is=; b=rPZt9J1vc10BZ2cIH9NVGr7Uyu
	3/yJCh4kbrxlOh4j29dkpeh0eQXVpCIiyyVpk9HkFI2pYz1coUfdNtMZGIFAi+CHzX0pJB3tXu7hW
	feU1GyyJH43dfAGZMcTgPmYZeMB8IFwuCWJu8SqdudwIk9n20aWxd1Ftm3JT8BIPyY0J3Oy+SpnDu
	syaWkP7BkD6fqv4WsVHYdFWqBzsF3XUQF7IxWcCpTSO42XCizxks2NkiJNmVhzkyxyzEwt20JDA/3
	ax6paYKSyqjWzuNcb4dT7Lmvl0WRv2/YyuvUcxB5ZoN4Y0T9mYu8phBqn4M+rPP6dRC+osYClNsDx
	67DqzjCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNP8-0000000C4x9-21XR;
	Mon, 24 Feb 2025 01:37:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNP6-0000000C4v0-01CH
	for kexec@lists.infradead.org;
	Mon, 24 Feb 2025 01:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740361021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ak1ca6nvXR4gpIUt8nNdn7G0ahaANyhsMag+O/8d/Is=;
	b=MFUf6dl/kHwA6Oz1rttYxwqjbFXvFUGxX0NV5WtDUVGYCqXgoYSgvT4Vl+GMxJZAgbSAHQ
	aSiHg0LbHrQWnXlQ++GLL9mqohh0Fb5kQlStQjYm4LQWdcV2SWRZsoTjdOibyHzP1ZgIpI
	psO+4wfhHl0sN3RlyuJTJhf0BMNd1Zs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-IHleUlDoO_qBwyXkEEzRBQ-1; Sun,
 23 Feb 2025 20:36:57 -0500
X-MC-Unique: IHleUlDoO_qBwyXkEEzRBQ-1
X-Mimecast-MFC-AGG-ID: IHleUlDoO_qBwyXkEEzRBQ_1740361015
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A18731800268;
	Mon, 24 Feb 2025 01:36:55 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C01D1800358;
	Mon, 24 Feb 2025 01:36:52 +0000 (UTC)
Date: Mon, 24 Feb 2025 09:36:48 +0800
From: Baoquan He <bhe@redhat.com>
To: akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v8 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <Z7vNMJPQPr4N6Dih@MiWiFi-R3L-srv>
References: <20250207080818.129165-1-coxu@redhat.com>
 <Z6sljm1lurDKPCvj@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6sljm1lurDKPCvj@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250223_173704_113725_65A16D74 
X-CRM114-Status: GOOD (  33.71  )
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

Hi Andrew,

On 02/11/25 at 06:25pm, Baoquan He wrote:
> On 02/07/25 at 04:08pm, Coiby Xu wrote:
> > LUKS is the standard for Linux disk encryption, widely adopted by users,
> > and in some cases, such as Confidential VMs, it is a requirement. With 
> > kdump enabled, when the first kernel crashes, the system can boot into
> > the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore) 
> > to a specified target. However, there are two challenges when dumping
> > vmcore to a LUKS-encrypted device:
> > 
> >  - Kdump kernel may not be able to decrypt the LUKS partition. For some
> >    machines, a system administrator may not have a chance to enter the
> >    password to decrypt the device in kdump initramfs after the 1st kernel
> >    crashes; For cloud confidential VMs, depending on the policy the
> >    kdump kernel may not be able to unseal the keys with TPM and the
> >    console virtual keyboard is untrusted.
> > 
> >  - LUKS2 by default use the memory-hard Argon2 key derivation function
> >    which is quite memory-consuming compared to the limited memory reserved
> >    for kdump. Take Fedora example, by default, only 256M is reserved for
> >    systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
> >    to be reserved for kdump. Note if the memory reserved for kdump can't
> >    be used by 1st kernel i.e. an user sees ~1300M memory missing in the
> >    1st kernel.
> > 
> > Besides users (at least for Fedora) usually expect kdump to work out of
> > the box i.e. no manual password input or custom crashkernel value is
> > needed. And it doesn't make sense to derivate the keys again in kdump
> > kernel which seems to be redundant work.
> > 
> > This patch set addresses the above issues by making the LUKS volume keys
> > persistent for kdump kernel with the help of cryptsetup's new APIs
> > (--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
> > the kdump copies of LUKS volume keys,
> > 
> >  1. After the 1st kernel loads the initramfs during boot, systemd
> >     use an user-input passphrase to de-crypt the LUKS volume keys
> >     or TPM-sealed key and then save the volume keys to specified keyring
> >     (using the --link-vk-to-keyring API) and the key will expire within
> >     specified time.
> > 
> >  2. A user space tool (kdump initramfs loader like kdump-utils) create
> >     key items inside /sys/kernel/config/crash_dm_crypt_keys to inform
> >     the 1st kernel which keys are needed.
> > 
> >  3. When the kdump initramfs is loaded by the kexec_file_load
> >     syscall, the 1st kernel will iterate created key items, save the
> >     keys to kdump reserved memory.
> > 
> >  4. When the 1st kernel crashes and the kdump initramfs is booted, the
> >     kdump initramfs asks the kdump kernel to create a user key using the
> >     key stored in kdump reserved memory by writing yes to
> >     /sys/kernel/crash_dm_crypt_keys/restore. Then the LUKS encrypted
> >     device is unlocked with libcryptsetup's --volume-key-keyring API.
> > 
> >  5. The system gets rebooted to the 1st kernel after dumping vmcore to
> >     the LUKS encrypted device is finished
> > 
> > After libcryptsetup saving the LUKS volume keys to specified keyring,
> > whoever takes this should be responsible for the safety of these copies
> > of keys. The keys will be saved in the memory area exclusively reserved
> > for kdump where even the 1st kernel has no direct access. And further
> > more, two additional protections are added,
> >  - save the copy randomly in kdump reserved memory as suggested by Jan
> >  - clear the _PAGE_PRESENT flag of the page that stores the copy as
> >    suggested by Pingfan
> > 
> > This patch set only supports x86. There will be patches to support other
> > architectures once this patch set gets merged.

Could you pick this patchset into your tree since no conern from other
reviewers?

Thanks
Baoquan

> 
> This v8 looks good to me, thanks for the great effort, Coiby.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 


