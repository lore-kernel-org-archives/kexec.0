Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E97C5DF89
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2wH5PJaoSf+WZ0HADj6Qf/btDMSF680EsLu/bDLMdGU=; b=Lik60Bt/eT+GPATaxla2uP2vLo
	XoktJCIRZmSnd76FI+1bi/D+i2yoU3avpfhjd590DpGcOPXtAoPWRRLIYB3b8y46+lifpuRUKDnsA
	ij/rMJ4vOobeyjT4asVtcuyEphmCAYykivjyrmrNsIQXaNptuJMPPfX1XcbSeuWtpavFrMUg0knyr
	kb4On9vrnTDWHrBSvXLD+i/LImFUX2Jz4VJvJKyh40zVO/880M/WL+TDATCTQPEdPR3xUC4eK7yDq
	e+CedeRIlHEJ5ZVHIH5auYsSdMP4mnyb6pPXyOQ30hRZgjMMRQmrEJVMv2Wos2aZa743Wac7JnTvc
	sKY6qQkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQD7-0000000DYG0-0zzx;
	Fri, 21 Aug 2026 14:27:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQD0-0000000DYEF-0jFP
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 14:27:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787322421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wH5PJaoSf+WZ0HADj6Qf/btDMSF680EsLu/bDLMdGU=;
	b=KiXSUsSl3qI4xHnSwoX7ldtf3fUCU0t586hcqKIjE64LHUG9/5tUyAAS8w9uZfO5YpReYW
	4IOPGGPpzSH3UOPjiB85RAFAbTVssLfQGjzcDTkGfB22lt38YVsQWMvW3m/WFA1ExkRqkm
	MYcP2OtAZFQjaZMMM++F4/hYq/xgbn8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-wb891n9mO46S-xNiZu2-Pw-1; Fri,
 21 Aug 2026 10:25:10 -0400
X-MC-Unique: wb891n9mO46S-xNiZu2-Pw-1
X-Mimecast-MFC-AGG-ID: wb891n9mO46S-xNiZu2-Pw_1787322307
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E43718011EC;
	Fri, 21 Aug 2026 14:25:07 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93532180034F;
	Fri, 21 Aug 2026 14:25:04 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Tarun Sahu <tarunsahu@google.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	kexec@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 8/9] PCI: Enable async shutdown support
Date: Fri, 21 Aug 2026 10:24:13 -0400
Message-ID: <20260821142414.150892-9-djeffery@redhat.com>
In-Reply-To: <20260821142414.150892-1-djeffery@redhat.com>
References: <20260821142414.150892-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: SEvLhrE_hCvTdEQrOD5PGNm2SWo1Yn2VN9hEhCRuCWU_1787322307
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_072702_290590_2DACC367 
X-CRM114-Status: GOOD (  10.52  )
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

Like its async suspend support, allow PCI device shutdown to be performed
asynchronously to reduce shutdown time.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Tested-by: Laurence Oberman <loberman@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18..af2381446406 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1046,6 +1046,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	bus->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(bus->bridge);
+	dev_set_async_shutdown(bus->bridge);
 	pci_set_bus_of_node(bus);
 	pci_set_bus_msi_domain(bus);
 	if (bridge->msi_domain && !dev_get_msi_domain(&bus->dev) &&
@@ -2748,6 +2749,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	pci_reassigndev_resource_alignment(dev);
 
 	pci_init_capabilities(dev);
+	dev_set_async_shutdown(&dev->dev);
 
 	/*
 	 * Add the device to our list of discovered devices
-- 
2.55.0


