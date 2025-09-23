Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCA8CAC5AC
	for <kexec@archiver.kernel.org>; Tue, 23 Sep 2025 02:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2avbd4LjS8nrMV3+bJmt9fqA5He5939YGUafn95iA/s=; b=WRAOxFzvO7FFpVCUGUPwWAN6K2
	AQBU2UcKTUTwdC6eZykn4R3a6ChTHzZoMOOrd/xMcKhwG99YD1YllwhlZX392nmOJOQbjpY1RQ5NJ
	XMy8LdLTyUarFZW9xsQACQ2SNXUDE5nojp5J8qiuLuM3f6Cq4FZkvjiFWB+0RaDAi55zloSdKYYAy
	2qkiVDk4YKAyPgqnv7pgDtOjkhDIL8Da0kKVPZpD02D6G6P29yHkhKPpZ3ZqyW31MF9yHeY/R/8BA
	yvFl7m2MtmsWp3dwkM42qy7hYlWLKE4BKX2Tsbcn0tfxo+H+dcyCWktL3fCMVPKuuTNJ2k7J2LCih
	TZNn3axg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0sZ7-0000000C7ij-3KKL;
	Tue, 23 Sep 2025 02:15:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0sZ4-0000000C7hf-3g8q
	for kexec@lists.infradead.org;
	Tue, 23 Sep 2025 02:15:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758593732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2avbd4LjS8nrMV3+bJmt9fqA5He5939YGUafn95iA/s=;
	b=a1izDE43D1UnwoVodReJMizvKg4/b4zYdtzSNZF+9JbMinXiD99wbSLqlAb5aZmixisRJS
	94WsRHf9PaZSeTh2p6/JhiEpPm/UoM4G2s+2erDwWrfBOpfXODN9oeViZKXFqFW3BA8pCS
	3i//yey3vx+t5TsH8ngVkob1QtaMc2M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-CbxdawZnMAa5DwVrSs_sfw-1; Mon,
 22 Sep 2025 22:15:28 -0400
X-MC-Unique: CbxdawZnMAa5DwVrSs_sfw-1
X-Mimecast-MFC-AGG-ID: CbxdawZnMAa5DwVrSs_sfw_1758593726
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62A3319560B6;
	Tue, 23 Sep 2025 02:15:26 +0000 (UTC)
Received: from localhost (unknown [10.72.112.183])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C35F18004D8;
	Tue, 23 Sep 2025 02:15:22 +0000 (UTC)
Date: Tue, 23 Sep 2025 10:15:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Simon Horman <horms@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
	kexec <kexec@lists.infradead.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
Message-ID: <aNICt3e3Fg0iwxvv@MiWiFi-R3L-srv>
References: <20250819213014.908757-1-safinaskar@zohomail.com>
 <19972b2566e.1115458b7339833.495097856732093802@zohomail.com>
MIME-Version: 1.0
In-Reply-To: <19972b2566e.1115458b7339833.495097856732093802@zohomail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zMDXWwn3QyzMbaw0N7kaiFh6ECUOJ7JvHHK4M9H7t74_1758593726
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_191534_985702_E207F841 
X-CRM114-Status: UNSURE (   7.70  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 09/22/25 at 10:31pm, Askar Safin wrote:
> Simon Horman, so what? This patchset is still not merged.

Not sure if Simon minds the patch log, especially in patch 1. I saw the
'TL;DR' first time in a patch log.

For a problem solving patch, we better provide information like

-what is the problem;
-why it's caused;
-how you fix it;

Don't tell too long story out of the space. Refering to other already
merged commit's log is also a good way to learn that.

The fix is absolutely a great one.

Thanks
Baoquan


