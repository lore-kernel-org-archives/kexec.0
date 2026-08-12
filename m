Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9F7C5AD5A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96LAzBjfGAx9nfZL8SX73XYEA1A5G1phryUkEZQ35/w=; b=nTohy8qdKk2QDTziJLs5DN/fuv
	HH/uJ39dy43eAnz2ssJLpqB/u3DTDReCehuvn06FptZjcRO8VnsRIMytV4jEuc/b2fo3V9sIJ2soU
	V9+hjGCY16P9buBcZOs4Z1nYhxLXeC7R1gYTyyEQxODplAVEGCM6cKHjwRLZ44e3ZueMFXg42y+hj
	CG9g/Y0ZyDqD+7W+LIOqqbWk8gpPwmuFBuLamonzI+E6DlXUuYq/BGPCEwZlY9ZzbKkrIkJyrYGLK
	71wo8SruZPQBvmjBGO1soptEBDSxgjDXLhyWqnGhz8/cHGVlI8/zVG7kfdEELYx8tx15UYot4T+Py
	nHLllyRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7C4-0000000G5iI-16GN;
	Wed, 12 Aug 2026 11:32:24 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7C1-0000000G5fI-1Pt3
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 11:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=96LAzBjfGAx9nfZL8SX73XYEA1A5G1phryUkEZQ35/w=; b=Bgkzq1hsvSlzCUSnGj2E/Lk8tY
	1dMyAR9AzJbQC4LpK1CNVMN3IMg2XiBBdGGpHkZxiyzZHzvIp3lUvfGekHCX5qso78dVIIz/RZzCU
	hVvG+mObEJqzW7JMq1qj9/03SAiuonCVJ7bOj/yPU94AS13q/qPSjmQLbpm0nHqqRNDSL9GTfJTki
	7cfn0GrGjen4rSZ9S7hRf+NKHoJNEtW8bP6rjSgwUqTSuMZ4Tvjn4LUfe7bBvffBhNfU4VO18ZqA4
	jZM4srYTplz+S6iuZ0U3OAwuI7bklGXi8w3NpWly3ODPPkf2aua3U5d1w/Dfozz2IlQpJhZVdTTkj
	YSjXuH3g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wu7Bo-004JJH-16;
	Wed, 12 Aug 2026 11:32:08 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Aug 2026 04:31:51 -0700
Subject: [PATCH v6 1/2] kexec_file: stop the top-down search before it
 underflows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-kexec_posioned-v6-1-e477887086f0@debian.org>
References: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
In-Reply-To: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com, 
 riel@surriel.com, kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=leitao@debian.org;
 h=from:subject:message-id; bh=FmvGEkh2rRrjTsnxxpplsZ7+GnyJWiiOZt1q+BoClXI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqfFmsyEno7+ZM8jNDTttS6/P8qtEqZPqoheexT
 8D0MQRonQuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCanxZrAAKCRA1o5Of/Hh3
 bXSJD/9jfrIbSU3oHTQv0L6n64XBO1LZMWRmaCcv4mpdb64PYKBuJ1vpA5i8Tqe5xgTSKXXA23c
 CuwqNJzcw1l3YXFoQsX3nttO24qrXYmd1hXK/jlkiBlgRxi+K3ue/Xmcz9108cNsRdieQmwVc6A
 h7veNRxUviUn1rvqU4UrdmgY5FZC5phM5rnABwFMz/hOju74BJ2YBer7UB23/KC81X5lPomJxQu
 DjRMiHU5OgXRDphVIdC1ehkv6d+D4L+kv2WGaJDqJ6qA6QsFScNowu+jY+WIbq+7nO2VY0RooHp
 IUm06Yv2t0eN2jtT05X0mve/wbxwzrHerIWupYY15hnhalruDg4iPLEv0UER95+Z28F/c7LpfXe
 8a6LbuH6JVQSr/lfxxoNSoqSatUe0YEGHWNecjZS85BdNG1pqw3mmN5N/1z9hxNC2KpPXtQXwSe
 nkAhZCovOV5Lnma3VIV4uFACGpv1O7NjkHsPX/xjEl/saVEWhnZW+Kk4/n577us+SJbLXQW+0Lm
 N1imHnRQQYBGccSPA8iyjrYOZhhJdUxEbGuISLllYItLB+g5UzJdx8wvHro047EPIzHVqffnTe8
 gofvKGUZtDyNj0/gzahda+W8EGVLlfGHHnyUE1bA3xQDQIiiTfONMjN28AA3hd0JGadH48d7q1+
 sSI7+Vo85i3O9sw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_043221_407050_5AC7B057 
X-CRM114-Status: GOOD (  12.44  )
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

locate_mem_hole_top_down() walks candidates downwards by subtracting
PAGE_SIZE whenever the window conflicts with an existing segment or with
an architecture exclude range.

Nothing stops that subtraction at zero, so a search that reaches the
bottom of the address space wraps temp_start around and continues.

The walk starts inside the range being scanned and only moves down, so
bail out once a candidate ends up above end. That covers every step in
the loop rather than the subtractions alone, and it matches
locate_mem_hole_bottom_up(), which already bounds its candidate on both
sides.

This is a better check than subtracting with check_sub_overflow(), given
that we would have 3 subtractions in this block, and this single fix
would take care of them all (instead of three check_sub_overflow()).

Fixes: cb1052581e2b ("kexec: implementation of new syscall kexec_file_load")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/kexec_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d86..01a64d98fbcd7 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -484,7 +484,9 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 		/* align down start */
 		temp_start = ALIGN_DOWN(temp_start, kbuf->buf_align);
 
-		if (temp_start < start || temp_start < kbuf->buf_min)
+		/* A candidate above the range means the walk wrapped around */
+		if (temp_start < start || temp_start < kbuf->buf_min ||
+		    temp_start > end)
 			return 0;
 
 		temp_end = temp_start + kbuf->memsz - 1;

-- 
2.53.0-Meta


