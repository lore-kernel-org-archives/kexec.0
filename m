Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D718E7719C
	for <kexec@archiver.kernel.org>; Fri, 10 Jan 2025 03:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BmaeOybhmaa8oIgMIEQeZoYoCdEjinAdvqJF2JSZw/Q=; b=JsXV9ueV181LLgakLLKMmLgJgs
	ZoTiLuZa6Qg4LMDXlQqk4eUOzqTIg8pP+WaqTP3eQXAzJvwGuzX7aURt5dYwaAo/uuMm90fTs17fz
	6Ai0YEdmGLXPVjDutTr1EkrLkJrfiLFwt5sAwGBlTqgb83oPqdmsoX2dkylNoy4vURwGgWTgxGwwm
	ixmtgTCECcTWbK1Oy0C06WxCtMNS3ParWzOo8Fr/MZ8OyWVfhSOLPSeMCUaoqzenYLhjegWf4GNaV
	spE8nvR0f4gGeqMW3ZwbPkcpBNOacc4ZaujVjgaj1IaaiqUma7gBXcwiOzLAMSzJYbNOKrAKWpxW5
	Vo2iN5uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tW5H8-0000000DshW-2xYr;
	Fri, 10 Jan 2025 03:01:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tW5H5-0000000Dsgs-15aB
	for kexec@lists.infradead.org;
	Fri, 10 Jan 2025 03:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736478085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BmaeOybhmaa8oIgMIEQeZoYoCdEjinAdvqJF2JSZw/Q=;
	b=EHxqQGZcM0Mzuc6gr+Kng7DhIBDZ9TomM8PAx1YC2q0Fi0mM+Eupt684tTXTJmggZ5T7hd
	Zc2vo5R/dQJ/IT7fJicQpE76GrrPWSYBc8keGBe4oLhhJFY5nC2ij2ZHe+zIvZbOscGnsX
	wbStyYTLPOk21nyePvoH6kV8aPyMzaU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-Ahq22gvINhelBylchNMU1w-1; Thu,
 09 Jan 2025 22:01:22 -0500
X-MC-Unique: Ahq22gvINhelBylchNMU1w-1
X-Mimecast-MFC-AGG-ID: Ahq22gvINhelBylchNMU1w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0B2319560AA;
	Fri, 10 Jan 2025 03:01:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B90F51954B24;
	Fri, 10 Jan 2025 03:01:19 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com
Cc: kexec@lists.infradead.org,
	snishika@redhat.com
Subject: [PATCH] Resending patch: Improve message readability and fix typos
Date: Fri, 10 Jan 2025 12:00:46 +0900
Message-ID: <20250110030047.73538-1-snishika@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kUQNUTkVFrT2TIS8GxEqHFn-kYTsVRDXyn8F_UE_QlI_1736478082
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_190127_377038_CE0F3536 
X-CRM114-Status: UNSURE (   4.55  )
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

Resending the patch to include Masamitsu Yamazaki and Kazuhito Hagio as additional recipients. Apologies for the oversight.

The patch description remains unchanged.

Seiji Nishikawa


