Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3DFCF6499
	for <kexec@archiver.kernel.org>; Mon, 30 Sep 2024 03:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j4mxUj8Ej4W0bhgs67inIE8cRlHonoclAMbFmVpESLU=; b=aqGR2K9VWR1nxM
	X4VfxpPZnjI4o0/NiH8/Ki9/UfIvLZ7syQWtYCiSltKMizxmV/xBzbpRTll8GCJ9+ZbVbZNg3ACl+
	EV70rwTrV5QjyWzIQex0ZXKgitEwNmx9w/xvmJKwJLRgydWlKNHmLb2PUXWvizlcrU9jlqFHpGBf/
	uD7tMaavHS/mny4I+hcaMMo1gwWLDMSiOZ5hgKBrSMiUczFekCNY6kujjXThzoot9juFmlYsyEw9o
	y3zLWR8GDiJ06/mZ9LyDD4AN/S9XuJpuZgfGKT1qRV2pdVl+nQMw9wj2S70F8XMIEOTAT9MsYBEAA
	/bTem9mD6xbCzSmU4YLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sv6di-0000000Fm6A-44BB;
	Mon, 30 Sep 2024 02:59:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sv6dd-0000000Fm5S-3hY4
	for kexec@lists.infradead.org;
	Mon, 30 Sep 2024 02:59:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727665191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=52ETwP6isu6QbD683EQIu95q3mYeXtz+F2oyo0mvDPI=;
	b=B3ltAcBESSpHidyfG9puA3JmRcFk5Ar4XYlCfRJCSBRCM9ZqDN0FLUBRJnWkloEcXnm69E
	+RLNXODsazLYPf1UcOr9XdE5adQT6APz51YX1hVUOP6bmRNUClQTWbSZqNK1Wu2Bd5BNhH
	eCsw1kpNPFdiNUJc7j4Tx6NRy2vsBLc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-uu9o7dTyMtSU1GJ1JgjymA-1; Sun,
 29 Sep 2024 22:59:49 -0400
X-MC-Unique: uu9o7dTyMtSU1GJ1JgjymA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95FB7196C42F;
	Mon, 30 Sep 2024 02:59:48 +0000 (UTC)
Received: from localhost (unknown [10.72.112.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 623FC3003E40;
	Mon, 30 Sep 2024 02:59:45 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:59:41 +0800
From: Baoquan He <bhe@redhat.com>
To: x86@kernel.org, thomas.lendacky@amd.com
Cc: dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <ZvoUHcDGsCyX9fg+@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240911081615.262202-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240929_195954_012776_84D90D6F 
X-CRM114-Status: UNSURE (   9.64  )
X-CRM114-Notice: Please train this message.
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

Hi,

On 09/11/24 at 04:16pm, Baoquan He wrote:
> Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
> default. This makes kexec/kdump kernel always fail to boot up on SME
> platform because of a code bug. By debugging, the root cause is found
> out and bug is fixed with this patchset.

PING.

Can this be added into 6.12 so that SME system is available? Please
tell if there's any concern or comment.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
