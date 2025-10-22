Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3849BCCD1AB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xN1mV5QoBCeblnnwnP2HPoikUahvxsaFYWrSPo98hy0=; b=ROiILPJ//W9ShKicgpYbRx//7J
	I9nImvMefArf+3Mih2RUeOA3XWUFybuMbJVOJqUNQAo44XoFEsqoe4QzslCb0v32NgJ3Ux6Zw62Jk
	UhHHsf/Zyo+K6paPjejaKHInQrjkR0DswQNaSPpHrX7HkJREMUyR2d5Bk/h8X2cLpycJCP5imcwJQ
	NhSeCupEm5Dj8te4CSV4TVaTqLEjcsqDyaasnCfACJbnY/ZGJMGp3yEKq9VF/UVbIWEl41NOY0Zso
	xo+EaXOdWlNClQIJMGnHHqzwZX4HUuQAMeVykgYeXYbk1WprjDd2KnnvuThrpJr5d8zAAHvXLXN0p
	hZmbvV0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXGY-00000002heX-0hZB;
	Wed, 22 Oct 2025 11:44:30 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXGR-00000002hbb-3vpf
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 11:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xN1mV5QoBCeblnnwnP2HPoikUahvxsaFYWrSPo98hy0=; t=1761133464; x=1761738264; 
	b=YfZUW0kADb4j+vB+HDL865uMlYnQBJI0gaGsct0WT3gT6Y9BU7DCYCvldrmJzXrYEzzXmpE0PCK
	oozCN2DzrpRleNxnT7A+KlSa2WYNULex+zf1K8bjCIW9p/QB2iG4jYK+EB21It6qAC3TJr5Q4qRYb
	hJHgKpkkxUfpytmBUuyqeKv4j+a82gVy4AdngcvojcUk6+eXy9wX0UmhmASgxyrxFaSsDMZwhqe1q
	VZ+pmKXNURAYVlmSD3TY+P3eI+gtHjpP3vcuuptjD8fU3ftB90AE08oY6ni8FS9LYTT5oJ3Ft/H/N
	fDefGv8ybaewNVmImR/T2Dpdduk7oO++pVSw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vBXGN-00000003EiR-02O4; Wed, 22 Oct 2025 13:44:19 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vBXGM-00000002rQm-3NHn; Wed, 22 Oct 2025 13:44:18 +0200
Received: from glaubitz by z6.fritz.box with local (Exim 4.98.2)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1vBXGM-0000000019t-2490;
	Wed, 22 Oct 2025 13:44:18 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: kexec@lists.infradead.org
Cc: Khalid Aziz <khalid@gonehiking.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH 2/2] kexec-tools: powerpc: Fix pointer declarations in read_memory_region_limits()
Date: Wed, 22 Oct 2025 13:44:13 +0200
Message-ID: <20251022114413.4440-2-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
References: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.170.52
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_044425_289341_136E2F95 
X-CRM114-Status: GOOD (  10.13  )
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

Fixes the following two build errors on 32-bit PowerPC:

kexec/arch/ppc/kexec-ppc.c: In function 'read_memory_region_limits':
kexec/arch/ppc/kexec-ppc.c:106:11: error: assignment to 'long long unsigned int *' from incompatible pointer type 'long unsigned int *' [-Wincompatible-pointer-types]
  106 |         p = (unsigned long*)buf;
      |           ^

kexec/arch/ppc/kexec-ppc.c: In function 'read_memory_region_limits':
kexec/arch/ppc/kexec-ppc.c:112:19: error: assignment to 'long unsigned int *' from incompatible pointer type 'long long unsigned int *' [-Wincompatible-pointer-types]
  112 |                 p = (unsigned long long *)p + 1;
      |                   ^

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 kexec/arch/ppc/kexec-ppc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index d3dad0f..e173433 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -91,7 +91,7 @@ int read_memory_region_limits(int fd, unsigned long long *start,
 				unsigned long long *end)
 {
 	char buf[MAXBYTES];
-	unsigned long *p;
+	unsigned long long *p;
 	unsigned long nbytes = dt_address_cells + dt_size_cells;
 
 	if (lseek(fd, 0, SEEK_SET) == -1) {
@@ -103,7 +103,7 @@ int read_memory_region_limits(int fd, unsigned long long *start,
 		return -1;
 	}
 
-	p = (unsigned long*)buf;
+	p = (unsigned long long*)buf;
 	if (dt_address_cells == sizeof(unsigned long)) {
 		*start = p[0];
 		p++;
-- 
2.47.3


