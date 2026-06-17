Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440AFCD98E2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YFc/HfY/u/L7cOD0ykigDAH9/yd+jKKdQEtzYX2vj7g=; b=Tp+NwVvV6kRp2N3xIz/bjKryQw
	QSETa5qNSV9f9b3TgE3i7Rw5UHRTWqcG4ekwZ3Y0S0JVZ2tIqG0+GjDZdXoHEaQT3zXvaTlBr45a0
	JsEL7OfIm543WKuO6NAgtDRlSd8r6dt3u6hK4Nc9W1rmeUYgaZM/5VYMN7q7ha6FBbdX8WVs1Fvkf
	vQZaTsQ+fAvQq+mflD5MIGOFki+5b7prwbDKCTlOILRSTf3XwZKoxi8Z2CTJzWyh1AQLuCmggxeyS
	B2FSr5sr43xUcud1PJd9wX1ENSNioLECEQewOhrRgd/5MJtodAV3AXjcqbUBAfSgJokFrmmmp/JHl
	tFTT4jHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvoA-00000000FSI-1KtJ;
	Wed, 17 Jun 2026 19:20:18 +0000
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZvo7-00000000FRE-3AWJ;
	Wed, 17 Jun 2026 19:20:16 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AB4131D000F7;
	Wed, 17 Jun 2026 15:20:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 15:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781724014; x=
	1781810414; bh=YFc/HfY/u/L7cOD0ykigDAH9/yd+jKKdQEtzYX2vj7g=; b=e
	irdxfePmo1oa11+SkXac2662dFfk65Hys1e/Ou95FEboP1vghiXvspnHmQ5m83FZ
	+DBixI3/3im2thBWcPqw8+TT2kH1twuZsdAmfMqWaRiqsV9uqPNrWd6H68kiG7qD
	Dm/XSrveVX3UHmacI/lPu5Ugi0z4Hht+NCnkSP+KGk7iFEWEsUJqS4SozhEWqcKh
	6yrMOL3pcvEyR2JJ5XxQWDNKfG9cfhQreP+c1TNio49MfskIVqHL5LJ4nNESOG2J
	fCt4ZgF1yeydeENOm9nHSWcDX86mV9ebQPam4XIJBNItFSpFaNvri8M+vccWzlnC
	imTeDGuRfBZHzCnSl3kQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781724014; x=1781810414; bh=Y
	Fc/HfY/u/L7cOD0ykigDAH9/yd+jKKdQEtzYX2vj7g=; b=DbJdeFl68+PaREDCX
	4dL7cDAvSQlsz0dYxKmRNIMHG7+JjBvuodCXMDzzbmsgfK1Ugo5hTfh+hv3fvFxa
	oH3WOOsCD4xM+Zp6beKYLANoqPLcKNQzC5wYCf9gThF55iuNvgJ/3DS8OrtrjDMm
	yyHDgJExqWu1wE+KndSK5azaSg3ZRhzsrmB8MplMXP/uVbbFRWjW/BcM1skJr3AG
	CNLMfYU8Sw3lPn4IUPxY7XiDmNPlKheAT+uWwt8r5+SeJgorE3J4YiBa6oDdJhRq
	Pzjd5QJSSqGoaEFQjc4jQAEo2tRgFWZgpQ2z9dX66qdRtWO51KxJCY8drJY3WfAz
	2EbYA==
X-ME-Sender: <xms:bvMyavJ3lqQh-8bvIL97VFRYKYjapWa88S0lGcbORllcjTnCFyOcdA>
    <xme:bvMyaqMUSHNbXf3fd3CiK1h00lW9v6ChnSwmL3nffUQBJbUzmk8jGrIjoA57MQfyQ
    yQ6dFp5moPypXrc6O6u5q70SFjGIElC-rf24KbWSZYSYeaSDgxdq6A>
X-ME-Received: <xmr:bvMyavZcSULJgYwd3huRga8LHvzU4yDQ8HhcOUt6l1ZbEue40ZWOnG6Ff_tRgg>
X-ME-Proxy-Cause: dmFkZTEGc1cCggI/FTMXCThQMoUsi+STagEgvDbTiaOx8lidkfShu9CsgNhNtxybperlSh
    wYaeV61DjWKAW2ZDUDqHrbShp9jqKB6/x0skOmcC8DEJ3f/o2eC9W6bOIrSc/INaK22aIk
    IbflIhJuf03G1llb3yUJ0Nxxv1o0P97QmqJfK8swgT5Kv4JfH1KHqzf5nUMZRkmudlGTXj
    +dUDb1Ng5eMd5XdZ+EIP9BjvMkuOGaArezM30dBLvwSBZlBigLMmcDp+96Lrfrt1P5uaa+
    axRUvc/FMxejiroOZbXEvIo66OfTMIX7BLDCfqbV1pUgnY23e+uL1L42S5XHrJoFp2UwGf
    0r5Z8K3reuT0OZGwBUDtOfbMtLdfGnnF8Don2uOtmg1VQzkEVKwOv/is6ED8DIiWzULJRn
    MIsodHUnJdQsoOByVlBm2H+bNs67wOzWFwnnBxTCmrzlcUvmpw5bMA60rfKLnHBlW04bnf
    y/niyLTvibBILox5QTNqfgccgVhOIt2wYfdXgprEmtO3xLCPuP5Pf0Uu9FUJ3B8siALw5a
    N03kfTXTRlqYC1/n2j5yerFV/9a4yh11ZVGVoYjIhgUPVMeAVqpt8iA2Nu3G326Mvb/LVt
    gy3hbBOW8uGuLMpfeT6hwZbQcMgRuSkgJ/en/mH9gJRWUTtKsqXdhqZ/EOKA
X-ME-Proxy: <xmx:bvMyauxMmPMqPLNvZxdl1eZv-C3C5HxqjNh2ANQjRLVShVx1jfwdcA>
    <xmx:bvMyajHWPp2tEw6oOO0azlfTIBbfa7kqYk584AfgBLiLOSH3wGkWFA>
    <xmx:bvMyahrqLvkpfZRKaLIE2Txd9C3k6a5Y86ASXTMdzui1dnBNlKsRlw>
    <xmx:bvMyapwNdDZcAWX0TjqQ_Hsg3GTSZLcOoejbAtpWCqiKAXzXOfLtWw>
    <xmx:bvMyav1S9Fe0SqRrLAnaLMIy0naimNFu-hXrbIJok8JJrxkC4HZ0bIsX>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 15:20:13 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Lecopzer Chen <lecopzer@gmail.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	kernel-team@meta.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v4 1/4] firmware: arm_sdei: add sdei_is_present()
Date: Wed, 17 Jun 2026 20:20:02 +0100
Message-ID: <b4fa56527950c27715cb603f8b35dc8652be955a.1781709543.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781709543.git.kas@kernel.org>
References: <cover.1781709543.git.kas@kernel.org> <cover.1781709543.git.kas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_122015_837085_EFB61064 
X-CRM114-Status: GOOD (  10.56  )
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

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

invoke_sdei_fn() returns -EIO when no SDEI conduit was probed, and the
core warns ("Failed to create event ...") on any registration that hits
that. An optional consumer that registers an event from an unconditional
initcall would therefore make every boot on a non-SDEI system emit that
warning for what is simply absent firmware.

Expose whether SDEI firmware is present so such a consumer can skip
registration -- and the warning -- when there is nothing to talk to.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 drivers/firmware/arm_sdei.c | 10 ++++++++++
 include/linux/arm_sdei.h    |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index f39ed7ba3a38..c161cf263547 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -339,6 +339,16 @@ static void _ipi_unmask_cpu(void *ignored)
 	sdei_unmask_local_cpu();
 }
 
+/*
+ * Was SDEI firmware probed and is it usable?  Lets optional consumers skip
+ * registering an event -- and the warning a failed registration emits -- on
+ * systems with no SDEI.
+ */
+bool sdei_is_present(void)
+{
+	return sdei_firmware_call;
+}
+
 static void _ipi_private_reset(void *ignored)
 {
 	int err;
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index f652a5028b59..b07113eeeff7 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -37,6 +37,9 @@ int sdei_event_unregister(u32 event_num);
 int sdei_event_enable(u32 event_num);
 int sdei_event_disable(u32 event_num);
 
+/* Was SDEI firmware probed and usable? */
+bool sdei_is_present(void);
+
 /* GHES register/unregister helpers */
 int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
 		       sdei_event_callback *critical_cb);
-- 
2.54.0


