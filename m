Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7958DC43602
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1wsuk7IexeTsRRUEFNapPuyiFW7RJDFzNmXxyMjzHx8=; b=PaUHsKM/O9nt2jvra2MjSTrb0n
	Y+5TNuom3bLYJFD46fVH8ny1ZAekFp9SbG7sc0XWzAZpY0w/OEJsinAspmFB4Q/vEo0nlG+2QIK0s
	iQ7f+njxgjcGiBhO31zytFwzpCIbep4ddYOgt0M2zJQkA0KkFU19mYEr4oJm0ZYh19kbS/sFkRQJ5
	H4vrIJR3NWvVCQiRbyOixw2ysp8a+kF6SkQ7rA+Ebd++hE0UeGeClSytA1deT0kUONaaH5c86rwT3
	79A/gaCOJqUfmam4WwFHY4mcz0eKl9lwUSnQ5Q7O05T/RviT4nZNTFYJTZdzzBGW4FAvYhE6uOiqk
	Vr5POf9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDa2-0000000F0yi-3BCx;
	Mon, 29 Jun 2026 15:07:26 +0000
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDa0-0000000F0xA-1zoe;
	Mon, 29 Jun 2026 15:07:25 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CC60EC0191;
	Mon, 29 Jun 2026 11:07:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 29 Jun 2026 11:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1782745643; x=
	1782832043; bh=1wsuk7IexeTsRRUEFNapPuyiFW7RJDFzNmXxyMjzHx8=; b=B
	6GWK6f3LBIHtU3J8m182ItJpg/5fvaBoGchftzQWxt2N4tZOmvjhlblQn1/QyU8O
	6sj6mLb8CT0E5i7D037GexSHV1oEqABKoQP+IrA/kSQCBAH1tbzeYMIAQpcUdKqp
	vE8/mfJkigGyFwOtfi5fwX68YocRLbE8GkVhF9RjC0df9HCHrabeWDd72I6D8pRA
	ao3HFZHwKUyiHWrY49XoVAzmPdJOg1RYPAaWfaoN2Ajv/1jwvl+hOiP/rTNs8DIY
	zXYYWzd56291NDchAmE5Wi+i2fH7IzTZK+C6WqxpV9DqqDP12NQeQ4asu+bMR+rY
	QJFxdFUKL9/HO5Cx8L4Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782745643; x=1782832043; bh=1
	wsuk7IexeTsRRUEFNapPuyiFW7RJDFzNmXxyMjzHx8=; b=BZ5w+ZaEhvxNqD5/N
	C8OZvw91LbK44U67rsQS0cNw1v8lqWvrDLxC+95OTED8Cmv43D+rGqvsU44zYu9s
	+V36VcqLQp6asAaSTxmJJsOehDiMWaDA953LiWrXer5SVNHUIReICoXt0ABCO8E/
	hSDNRW6fPguL9OdmGQnzNUfJ+B+m8FfJRabasxYvLcYLr8DLTi7mu0XmaFUWKsfP
	r5qMyrtvzs6YcPYqyEjT5nfXem2e2YzSeSEYkeFwxJxjvLTy9auFQTNVBS+KvTYh
	uWP4/bfkajgzwzJuBfIyT2gtTCLdl/A7MZsq3s5fQDnrxwe0YHZ4iSya2v8ibh2B
	il5Iw==
X-ME-Sender: <xms:K4pCaoZ3fDMM98izRH74i9sJ-V6OtT8nc-EhifFiVU1cJG7kKwJWug>
    <xme:K4pCaqfeROPlWscTd9HUVDXL4Wl2x-CDXUL1oj8euo6Qel7KaHVD2NjHK2ygYtOf2
    f9R1qo3loE-JiMX4ZLNrv7dQwUk7xHDNPKi8-nxjpwiRPuRm9gbcFw>
X-ME-Received: <xmr:K4pCaqr4GsIG-71s5V-nkEZxkKzAji119GR6jqtZbpUAJfAo6vBbJjzZKmyZuw>
X-ME-Proxy-Cause: dmFkZTGCXVRnDmX2yt9FIyjXqWdSO+WzHzjmCg41qneihPNq06PsTfzSDEMFc4yJsbzJiG
    1JcyZ2EGxD1DSakSZ9Igwkh5S6d+O3CEswHMOoFDGPNZwa08r9Dx7g6iG7XvhmXYukzgo2
    kcGW2KIn+W+Gr9l5Pl8uVi4CCf4gaVNDSsD86IdW2xTVtPl/n5pVzs7KeoP6fvX6OHSNF4
    6S/PON8aKkfxJtZ4YFF3jZDRV3ucN6At4PQdCQ97f4HFNYHWY5FnFdc4ZLsiKxMmUNHHKx
    PzO29y4ry7U+tnEwKoD9BoZ8ZZWYBE6aALLlvH1+w656D94S7wiVedubZVbml6kLDZODa9
    qdSRZ8ljHmQ0BwAQryA0aI5cBxaXpPXjf0kGZ2uRKNE2D1dkqZ8A4DU5k4+U7v6SMRBOBn
    KeLcBZTLYbb+DZA/dNgSI2REKPaiTOL4FdI9azjCvde2R56rlQq3GuKsIHGdoJasYhZXRr
    KjYNZtqDDcuPkln2P7/Owvynou1/YQvbdTLsedARs6SkyyeW/C1UqYaP/SVRUchGXnt94n
    TZavvZLO+O5qoEgITF5/6NdJPYFTyUl+MvK+9jhJ5u6GlcnguUTWr5gWSuOu5Hx6yOyF54
    tFEeWxoEkU8LpN8C+TcTwHG2cvkWdM4ixjAgzCogRtDIBYH+puqHBlO2RAoQ
X-ME-Proxy: <xmx:K4pCapBQq1MSjxpYJCaiFsOHj-8gk15xDqS9rwpHN4ZzZN1zQqbD7A>
    <xmx:K4pCagW7zC1gmtMXMvO119WFZN32lvsxzcUO4hg6vFBS-ypukF8v1A>
    <xmx:K4pCal7Qn8wEmX7QdmkBnC8srs1dRKDqWexOOZO88mNxtSqTuD_bFQ>
    <xmx:K4pCapAwF-uZMTLSXh1C0_yd1a4DcmJKrwTYiUJ26DqTIMwqB_krIw>
    <xmx:K4pCaqGXtD-5jfcLQrrve_Pgh27nasSCAFCia2pYhh-Mw4RBXg7DSrhz>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 11:07:22 -0400 (EDT)
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
Subject: [PATCH v5 1/4] firmware: arm_sdei: add sdei_is_present()
Date: Mon, 29 Jun 2026 16:07:15 +0100
Message-ID: <dcf564152da8fc599cbfbe8b8d254fe837262ed3.1782744912.git.kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782744912.git.kas@kernel.org>
References: <cover.1782744912.git.kas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_080724_584568_934F2511 
X-CRM114-Status: GOOD (  10.88  )
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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


