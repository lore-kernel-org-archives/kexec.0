Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A1CD13594
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 07:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JQQ6lXH4fEoIJdnWosEH2ijFYAAcUEgfMnkWSIXGAec=; b=3USA8Vt8dhhnIP
	65yEhLnkNqfOpfmH86fW0fJaLVQy9HCqSuYa0gyXITm42iW9ViKpHQBbcuVKqFUQWsT/i1BUd1evk
	2QN0ae37ThplBGP/F70h94lM8U9wOGruiB127sgpLoHxhIMe7gF9prfePyFnjj5csshU1mXtK0aLI
	XzpL4uCxaJ1ev4Dtb72Pz24Dk6fWiENdOHjFU6Cra/A95nMrfmjbzv223k6AXBomsrFk5QRFM/FMT
	nxlKbddZNzWH/UxXxgL33ZxvUcs+MSGQWfGsVuXHSxAmD5S4ewTkk6HwxE7CD4L8rI0JM/A9r9r+h
	p37k/lJBnIB0nSVrYjgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5gee-0000000DVJP-3L9i;
	Tue, 29 Oct 2024 07:28:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5gXA-0000000DU8j-1p5N
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 07:20:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730186455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IiCHGdTR4rr29W5iFVVYTtuqJGTR54mDJK7cR08LVCw=;
	b=W/Uqy0FjjfZKQkzXDnA/Zr9tMGTUF2+pzpHB0/Vw5zdoXmU01f12sg3UYuB7EmeAOZVXK8
	LiUIXQsoBZZ0y4CN/pYjZkpVmrgB0zmIQda913nzRa/spiSmXKes0pmqrousoIdspNrucI
	b7LnBX3MA5dE5GbMRvOrnZaeKeYgwSg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-6pCR-5cWNz69PllIezbVTQ-1; Tue,
 29 Oct 2024 03:20:53 -0400
X-MC-Unique: 6pCR-5cWNz69PllIezbVTQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8A3119560A5;
	Tue, 29 Oct 2024 07:20:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.66])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F59619560A3;
	Tue, 29 Oct 2024 07:20:49 +0000 (UTC)
Date: Tue, 29 Oct 2024 15:20:44 +0800
From: Baoquan He <bhe@redhat.com>
To: x86@kernel.org
Cc: dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	thomas.lendacky@amd.com, lijiang@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <ZyCMzFCSpsFxrCPh@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <ZvoUHcDGsCyX9fg+@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZvoUHcDGsCyX9fg+@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_002056_582578_B15D9DCF 
X-CRM114-Status: GOOD (  13.20  )
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

On 09/30/24 at 10:59am, Baoquan He wrote:
> Hi,
> 
> On 09/11/24 at 04:16pm, Baoquan He wrote:
> > Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
> > default. This makes kexec/kdump kernel always fail to boot up on SME
> > platform because of a code bug. By debugging, the root cause is found
> > out and bug is fixed with this patchset.
> 
> PING.
> 
> Can this be added into 6.12 so that SME system is available? Please
> tell if there's any concern or comment.

Ping again.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
