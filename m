Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30A3C27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xy8XqvhJBpADH/inn2ueL6BjCstMwFsk+ZTL4lNGFJE=; b=aLrTOoSsoZdKGy
	6yfZQxzgL5v2Fd5y13kX07IVCe+84+S7jX9o+2MZ53YuOvXk7zaHGxgSpYui8oSgcQaQ+yJu6oFA7
	fE7d009HMhjp77AEojVY06pUTJ8ZgpiRRJhGgPcLt+YatooD4eeozFpojYzT4SKEknJ1u9xUiHVb6
	CeL9JI1wGpBXmVjPyLnOJLIxKjCvAMenNTP752djyKbrCls7ThDJkbNxye6iCqe7RAndFdEYLosJj
	mWMdTXflyEM+3SGZYpnUox2Nvv0HA8altUutRdUSn6RpEzSOU1EGZ4pyAu/DSiRqjUWvjRt/z0JAs
	qCL7B38E0Lqs1cuhwMMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFWUZ-0000000DSl8-3ljk;
	Fri, 07 Jun 2024 10:06:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFWUW-0000000DSif-1yGA
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 10:06:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717754794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yfXT27/V8eVslu1sjaWJNY2m3Cho9rYaMlS4D6NlPsY=;
	b=AIgKnQuT3ugQQ0bgMd1/y/fB9S2pGRnaf8sQMx4ZUjH8PW1VgBkL6WdW8/jIQ2I6lLoQZV
	MJPRobEB2/zVCv+qASannI6Jr0JD67pPVxeDXM1f6H0qAPNVBijo02fsZMJkkxyH6bcmzP
	9EQAVRr4N4h55Ylc1X7k5QO/j06JJAw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-4sTFOuXlMYqDBJj7T7zW-w-1; Fri,
 07 Jun 2024 06:06:31 -0400
X-MC-Unique: 4sTFOuXlMYqDBJj7T7zW-w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBBD21955DB5;
	Fri,  7 Jun 2024 10:06:29 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7725919560AB;
	Fri,  7 Jun 2024 10:06:23 +0000 (UTC)
Date: Fri, 7 Jun 2024 18:06:18 +0800
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
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <ZmLbmriQYol2JHKe@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_030636_631241_3A5FEB31 
X-CRM114-Status: GOOD (  12.53  )
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

Hi Coiby,

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> LUKS is the standard for Linux disk encryption. Many users choose LUKS
> and in some use cases like Confidential VM it's mandated. With kdump
> enabled, when the 1st kernel crashes, the system could boot into the
> kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
> specified target. Currently, when dumping vmcore to a LUKS
> encrypted device, there are two problems,

I am done with this round of reviewing. The overall approach looks good
to me, while there are places to improve or fix. I have added comment on
all things I am concerned about, please check. Thanks for the effort.

By the way, do you get confirmation on the solution from encryption/keys
developer of redhat internally or upstream? With my understanding, it
looks good. It may need their confirmation or approval in some ways.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
