Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813C8E77188
	for <kexec@archiver.kernel.org>; Thu, 26 Dec 2024 03:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3kXmqxoB2WnQIF/6kBgYMhgzGVNPo+6AgunOKSP1Vw=; b=dhRaLh8dseS+u4uis+guglibeY
	7rKf3MOhmOyAspUmewsrcDe7zfSgErkItJMCGjavK5A6LJHEzxA6e+lEHtkGMfSwh4q6eB3M23cNf
	Ifbz4fuQeBmI1YOk0F3zKVn1WfZbfRqMNQaTd1uY4+983xUzY/F99LtN8C8Y9/ad9a6O6U49UTlfa
	s+laj+iopRaMZlSJS1TWHv8clEcsWI9lU+PfJDsaPDqFEVx3g4bFgv2dFDVzax6DyW5x+qzynQXQB
	rWICrTPls5HRD0UtMHKs6b1Zi+xuWoy1Y73PZU42cpOZXq+JAqLaN7uEL/5RIV2P+yi9MeEsnxNOY
	jrldoLow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQerK-0000000F3Rn-0V2P;
	Thu, 26 Dec 2024 03:48:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQerE-0000000F3Qn-1q0E
	for kexec@lists.infradead.org;
	Thu, 26 Dec 2024 03:48:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735184897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3kXmqxoB2WnQIF/6kBgYMhgzGVNPo+6AgunOKSP1Vw=;
	b=eK3VmPrzHBAizyEjqSTFpvh9EoZ6reAFsxKqW9w1eslcbCK1fHevJ9tP8stJD6SkAM0Cw1
	arw4Zkr66AfvWQMYVj/VQegchFMkx5HMDB/LRj9Tpy1+wQcC6URKFcSBV016KEIqQtcRm7
	0TmijRNsFCHF76llogQkYkAAiJ7vcDU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-T9sa9dDGNIqCi8XeV6EZpg-1; Wed,
 25 Dec 2024 22:48:14 -0500
X-MC-Unique: T9sa9dDGNIqCi8XeV6EZpg-1
X-Mimecast-MFC-AGG-ID: T9sa9dDGNIqCi8XeV6EZpg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A76F719560B2;
	Thu, 26 Dec 2024 03:48:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.202])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DEA41956086;
	Thu, 26 Dec 2024 03:48:08 +0000 (UTC)
Date: Thu, 26 Dec 2024 11:48:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <Z2zR9ND4u9j5QMBU@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-7-coxu@redhat.com>
 <Z1mL2KBcRskFlffk@MiWiFi-R3L-srv>
 <pe6aibukdppy2p762d2qakuvxafg3ra4n7geind7w6kohaf4t6@kuzkekrbyhcn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pe6aibukdppy2p762d2qakuvxafg3ra4n7geind7w6kohaf4t6@kuzkekrbyhcn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241225_194820_560898_51650CA8 
X-CRM114-Status: GOOD (  21.53  )
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

On 12/23/24 at 09:16am, Coiby Xu wrote:
> On Wed, Dec 11, 2024 at 08:55:52PM +0800, Baoquan He wrote:
> > On 10/29/24 at 01:52pm, Coiby Xu wrote:
...... 
> > > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > > index 68530fad05f7..9c94428927bd 100644
> > > --- a/arch/x86/kernel/kexec-bzimage64.c
> > > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > > @@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
> > >  	if (image->type == KEXEC_TYPE_CRASH) {
> > >  		len = sprintf(cmdline_ptr,
> > >  			"elfcorehdr=0x%lx ", image->elf_load_addr);
> > > +
> > > +		if (image->dm_crypt_keys_addr != 0)
> > > +			len += sprintf(cmdline_ptr + len,
> > > +					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
> > >  	}
> > >  	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
> > >  	cmdline_len += len;
> > > @@ -441,6 +445,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
> > >  		ret = crash_load_segments(image);
> > >  		if (ret)
> > >  			return ERR_PTR(ret);
> > > +		ret = crash_load_dm_crypt_keys(image);
> > > +		if (ret)
> > > +			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");
> > 
> > If it's error, do we need change ti to pr_debug?
> 
> Thanks for raising the concern! I think it's OK to let
> crash_load_dm_crypt_keys fail since disk encryption may not be used for
> kdump, thus pr_debug is sufficient. Or have I misunderstood your comment?

If crash_load_dm_crypt_keys() returned error, shouldn't we handle them
separately? If disk encryption is not used, we return a specific value
to indicate that, surely no need to pr_err(). However, if disk
encryption is used for kdump but error is caused and failed
crash_load_dm_crypt_keys(), why don't we error out for the case?

Maybe below change can be made to differentiate them?

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index f72a88b7d106..327f84ea57c5 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -400,7 +400,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 
        if (key_count <= 0) {
                kexec_dprintk("No dm-crypt keys\n");
-               return -EINVAL;
+               return -ENOENT;
        }


