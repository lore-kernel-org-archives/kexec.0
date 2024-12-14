Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99572E7717F
	for <kexec@archiver.kernel.org>; Sat, 14 Dec 2024 02:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1dpSCmmqK/j/7n07sNfCg5XminxI/aT3vgOaLdpOTw=; b=kNmCvQuGf1dQ1+2ReuPpau/tM8
	JFqKSzwslF1pgdooyCzRoesLpM1YldVTGceKMEdi1BcFY5MIVJAyu8/QUJbmcy+HO+ygWCKnB9Kh0
	pOrEcE2jreiqb+SzPn3J51xYXEyz25Hn2CAYl89CVY+3gskw70AAUBO/kGZuVSlPznholpzvgZkSq
	Puuzq6ZCpChKIJasdzUiOALy/p7mrb1d8KU8FmXNLPwXGYLd4J4RyYWfzsRD1mhpCWzM8Mv+w4Riw
	Ot2UPQd7wsXwENGtAM5r1caOrT2Zl3B1x5iypTE3y9wycRthrgWldxBemgwGO3U7uLJG4KS7BucfH
	zhaEU60g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMHpl-00000005YiS-0FBS;
	Sat, 14 Dec 2024 02:24:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMHph-00000005Yhj-2j6s
	for kexec@lists.infradead.org;
	Sat, 14 Dec 2024 02:24:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734143078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1dpSCmmqK/j/7n07sNfCg5XminxI/aT3vgOaLdpOTw=;
	b=V73S8Yj2KVQmvwE20f9dhXB8FOmhpJkMKQlIOLj457q33g7iC1zZG/s7FywLIa7QnFmgPJ
	r7kdjkeH9tpXC0sIPud71wjkiFn8+I6W7sw5blipCdUSibsEYW6GnCibIQ/8z51QiFTAOx
	03QYVGjdrJOXXvldB+/D/GlMlDzCjsk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-8OlSKUhYPvy85pFRhSU7hg-1; Fri,
 13 Dec 2024 21:24:35 -0500
X-MC-Unique: 8OlSKUhYPvy85pFRhSU7hg-1
X-Mimecast-MFC-AGG-ID: 8OlSKUhYPvy85pFRhSU7hg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46A7019560A2;
	Sat, 14 Dec 2024 02:24:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.69])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40893195605A;
	Sat, 14 Dec 2024 02:24:30 +0000 (UTC)
Date: Sat, 14 Dec 2024 10:24:26 +0800
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
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <Z1zsWoRhVaqXkVbb@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_182441_762520_D58B592D 
X-CRM114-Status: GOOD (  11.37  )
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

Hi Coiby,

On 10/29/24 at 01:52pm, Coiby Xu wrote:
> LUKS is the standard for Linux disk encryption, widely adopted by users,
> and in some cases, such as Confidential VMs, it is a requirement. With 
> kdump enabled, when the first kernel crashes, the system can boot into
> the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore) 
> to a specified target. However, there are two challenges when dumping
> vmcore to a LUKS-encrypted device:

Other than those small concerns, and the lkp reported issue, the overral
series looks good to me. Thanks for the effort.

Thanks
Baoquan


