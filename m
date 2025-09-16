Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF0ECAC597
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=svR4ILe5q+v2LmQEWerxsYkZzfptiZWl4WfYXwVp2vg=; b=JudeT5nIEoW28mIL0ZdaaWL/DH
	EhndasqH0BxtxBHbx3DSbil7owRSBomWWOfbdeClEeXlUms20Ja4drGVIuWXkxSWHaLJwdB3SVyoG
	+8mHtsw/DCnDvKXxzjZxdKOB4kDHI4GMJAp9DE+okmu+tEAjaK7B501l1Zv5/tEdQGxwegHRPkBdZ
	51NeB8XTGKePhjuOAjat/viSpomowzUw3Rin/LSM7WM4I0lulKLX63RowuenQKkhbQ3D33g3jvEyY
	IATfjFDiejGGZ2XRP67aQQ3U2rUotWEIRGhyiDfjAan7RJq6Z9AiPvx/1YZmB2FHDSemnWl3uy57Z
	LMtPJ2Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKt1-00000006CbL-1T46;
	Tue, 16 Sep 2025 01:53:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsz-00000006Ca7-3Sac
	for kexec@bombadil.infradead.org;
	Tue, 16 Sep 2025 01:53:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=svR4ILe5q+v2LmQEWerxsYkZzfptiZWl4WfYXwVp2vg=; b=M6dvdvMrTDnNct68lxfiaekqBT
	ppy+XiUxFadwyIumQkSpT+h1VgTLh1lvzZDFpY10QY+EtV/sqn92kFRqVb7ssrwu8liuJl+H3ogFK
	ENPDQimaWa3PLnLhxced+KMnxsi3hZFBK+hxrHuxqOWzuK/RFZYNPKmwAgjyzHtHkSZoRC7K4KZ3I
	VQ2lQ0610bl4oHeHaH9NbrbdQOHcKrG7nVL2oe8hnisCYpqKNfEfLgZcZahXk3M9jXDgOmAed2WTI
	5x7bozyv98wdIgbcVihnWJnsrTRMr7H0KkU3Oo4MyWlXalP2zQTVdTi5HnxGhkXj5LT9si7+UBCix
	3Jub4e7A==;
Received: from out-183.mta0.migadu.com ([2001:41d0:1004:224b::b7])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKsw-000000077l4-1cBi
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 01:53:36 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757987309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svR4ILe5q+v2LmQEWerxsYkZzfptiZWl4WfYXwVp2vg=;
	b=lhe1DcOWUZvCHEJm3wCIzMnDQiO47SWWpuUSqAZWMWsP0ieq0MsI5W3O+o0hX2GDv0mSah
	et5CWn3Fr2xulg7FlOBDNKG7faoRVotPPaGmXj1FDdjyMCWjr6AC/DYPBcPy1uOpxMf6d4
	PVdxu/MBYzEmj6wSrC0dpPt0nLObPYA=
From: Youling Tang <youling.tang@linux.dev>
To: Simon Horman <horms@verge.net.au>
Cc: Simon Horman <horms@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	kexec@lists.infradead.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 10/10] LoongArch: Remove 'kexec_file' cmdline parameters when using --reuse-cmdline option
Date: Tue, 16 Sep 2025 09:46:55 +0800
Message-Id: <20250916014655.841632-11-youling.tang@linux.dev>
In-Reply-To: <20250916014655.841632-1-youling.tang@linux.dev>
References: <20250916014655.841632-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025334_818334_192D4805 
X-CRM114-Status: UNSURE (   8.46  )
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

From: Youling Tang <tangyouling@kylinos.cn>

On the LoongArch architecture, when loading the kernel via kexec_file,
the 'kexec_file'prefix is automatically appended to the command line.
Consequently, if the '--reuse-cmdline' option is used to inherit the
current command line, this prefix must be detected and removed.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 kexec/arch/loongarch/kexec-loongarch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index eb60ef0..240202f 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -260,6 +260,7 @@ int arch_process_options(int argc, char **argv)
 		case OPT_REUSE_CMDLINE:
 			cmdline = get_command_line();
 			remove_parameter(cmdline, "kexec");
+			remove_parameter(cmdline, "kexec_file");
 			remove_parameter(cmdline, "initrd");
 			break;
 		case OPT_INITRD:
-- 
2.34.1


