Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9F3E9905B
	for <kexec@archiver.kernel.org>; Fri, 10 Apr 2026 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YFPayOsjb+5+Gcxzh+8/PY1jTqobcZZS+b7OL2QzsT0=; b=I3Xm5aZhEiYm3EO/ydvRKP13SF
	HrBEFfpwXr86j84dREGyVuk3nwaJgN8o73K1Ux3trTmsDBWkVHRfEUCIBoHfDNZZT19jcOjvuCUEd
	v68i9egLFmd6t98Jzrekwd8hgCxRa93q2BHgF62kLIgzIgkz5r5TtJFJ2Z/4bAnkXSD2EhWITeBmJ
	IMh9cw8H6BJnGuVOsaghPM27RqqhK29qc3DC45riedzuC4LZ3YtCsEpGKXzsWy+5SA16et7M2lWk9
	b29NJKbfiPYzN9RBVfpijcxZzHiw33kChKlYCKQmnWUDNXTYlkT8b94a5ch3+Ezg3OId7YF5o67zi
	tDaP594w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB7m4-0000000Bsob-03vO;
	Fri, 10 Apr 2026 09:03:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB7m2-0000000BsoV-2iOb
	for kexec@bombadil.infradead.org;
	Fri, 10 Apr 2026 09:03:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=YFPayOsjb+5+Gcxzh+8/PY1jTqobcZZS+b7OL2QzsT0=; b=froqT1HMM3Qn7nDg8IvURYA9bP
	iSlMkx3h0ORxaHdO+iOZ5RFNFDkYL84t1ZJzDkoMKwmJPjp5IOE8aE35OwWAKTTFwEoi48GGVuNb/
	s+rTLAiF+GQUmlq6XezSt9apLuysDN1wRS0DV1zYmhjpiriSO7IGWrP5JqLFm+ASpLt0YgteWL6Rb
	IZffMmxDtWtfN/5fgCpWbO3D8BI9ujdZEfHTAIQGvqunXCgDg/FW/h7JNZqJJNoZozgjbD98pVgW8
	QF1I8fhzslTSjLAYDtHGHOFiKxLiU4CEhuM24G0rA4atQ21p22C4gVXdo737VcJU1gpZPZz+h1Wby
	spzmAIrw==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB7ly-0000000D8pI-08UW
	for kexec@lists.infradead.org;
	Fri, 10 Apr 2026 09:03:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=YFPayOsjb+5+Gcxzh+8/PY1jTqobcZZS+b7OL2QzsT0=; b=gUaOeiaqFDXf+8LIJE7yyAoW6N
	xXwIVuCcbfNoujKS/rO1JbWmXERoIZ37FxvzSkstW1CES37nqEi7r0wj+GOtHVx0wWyE2Pa6LnKOi
	XIqsTPxpvNQRwzYc7GW6xr33kHhwtqj+0m1z9/sC5aaxs46PET+w1mid796X2/XlCW92gqXKmwD7w
	wf5/hZWaHFnz+LBtD/P6DXAF+nNna8qmLTt5n1SjnYgOJAXI2MQj/9hUnHwIy1Kyds3kl9s112IoS
	e3EZ2js1uw+3fD/BWb+Y2ZLAxfXDhqlKu6yug6K1j3NYH3ydWWeMd9ZjtM8IsH4ZTcAGB7Yu9gO5q
	ZD/DH/wg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wB7lp-009rsi-1U;
	Fri, 10 Apr 2026 09:03:22 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Apr 2026 02:03:03 -0700
Subject: [PATCH v2] kho: fix error handling in kho_add_subtree()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-kho_fix_send-v2-1-1b4debf7ee08@debian.org>
X-B4-Tracking: v=1; b=H4sIAMa82GkC/3XNQQqDMBCF4auEWZuSxNagq96jiBgz0WkhkcQGi
 3j3ol13+eDnexskjIQJGrZBxEyJgoeGqYLBMPV+RE4WGgZKqEpcheavKXSO1i6ht7zHsnSysvo
 mFBQM5oiO1pN7tL+d3uaJw3IYRzFRWkL8nH9ZHt0fOksuuVGy1tqhqStxt2io95cQR2j3ff8CK
 wBLibsAAAA=
X-Change-ID: 20260407-kho_fix_send-ae33f16d7502
To: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3308; i=leitao@debian.org;
 h=from:subject:message-id; bh=JQoMRroQGqF2IMGaWv58X8dTA6DCS66M2isFxCvTs8s=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp2LzWNIW/4bf1GUexjkGfxmnk43wQDHrtZRyl8
 eiiufwcuKGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCadi81gAKCRA1o5Of/Hh3
 bcOnD/9VQ5mEffCzXxXjp3D1jEz1BDnoezdxK4uOGDQ8Wq5ZIMDtwHfIFm7PPIcR5OT4g4XW14j
 9J8SRV4Qf4L+pnIj9NZjeOX1ik2GF+TUNOX5EnIAb5fghKP/BmndASTWVGJ0CeHqljcj8nvVmru
 r+KHfdpbapwtYNCzNiWMeytcziPDEo9Tgg9oL3UjmnCe+pZfGo0JLxyaza3zt75Q/sxbi5PNgae
 qcYpzECpDhROV0Ad364GmXnhWeZ+OBhhI5cSbBEzNpvPANS83/UFJXVB4FakpzBWvmfGN9mvM1q
 QzCNDKtRnnNxqfaEuURQl2gF62pO4vApZoDgfVqIViUUyLe88Db/KjsskUH4MWRaUVuQ8Oytlq9
 47u5/v4ROdHqYSc6TpdsuvJZqieJMlahf6KnepxC1/UOe68REWCoQQ10nkpj1oiYP+eVyNNdyhI
 BpW250VQeRWVQKEB28r0QLxya8Bt3dcroCH8WY8kcE02PgRn25LnyCcWlTUmLuiwjOjDrYpN0Kh
 uWxj+gMypvNea1Ia4a+236iVNb3qQk9W/t9Xa+uE/KwlFBejceHNs4a6UZFaK7GR+2d7JldZoQK
 G6wUaVrZ6wlcZ4gDICVGSkavPDu8eoJClms2x8SAskKdVV7pwXZr8TZJLxEmdW8al6Xs/HjMZhy
 3qZJnSNTZUgUubg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_100330_292950_BA9452FC 
X-CRM114-Status: GOOD (  16.06  )
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

Fix two error handling issues in kho_add_subtree(), where it doesn't
handle the error path correctly.

1. If fdt_setprop() fails after the subnode has been created, the
   subnode is not removed. This leaves an incomplete node in the FDT
   (missing "preserved-data" or "blob-size" properties).

2. The fdt_setprop() return value (an FDT error code) is stored
   directly in err and returned to the caller, which expects -errno.

Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
out_del_node label that removes the subnode on failure, and only setting
err = 0 on the success path, otherwise returning -ENOMEM (instead of
FDT_ERR_ errors that would come from fdt_setprop).

No user-visible changes. This patch fixes error handling in the KHO
(Kexec HandOver) subsystem, which is used to preserve data across kexec
reboots. The fix only affects a rare failure path during kexec
preparation — specifically when the kernel runs out of space in the
Flattened Device Tree buffer while registering preserved memory regions.

In the unlikely event that this error path was triggered, the old code
would leave a malformed node in the device tree and return an incorrect
error code to the calling subsystem, which could lead to confusing log
messages or incorrect recovery decisions. With this fix, the incomplete
node is properly cleaned up and the appropriate errno value is
propagated, this error code is not returned to the user.

Cc: stable@vger.kernel.org
Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- CC stable (akpm)
- Comment user-visible changes in the commit (akpm)
- Link to v1: https://patch.msgid.link/20260407-kho_fix_send-v1-1-b21977feb960@debian.org
---
 kernel/liveupdate/kexec_handover.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 94762de1fe5f0..18509d8082ea7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -762,19 +762,24 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
 		goto out_pack;
 	}
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
-			  &phys, sizeof(phys));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
+			      &phys, sizeof(phys));
+	if (fdt_err < 0)
+		goto out_del_node;
 
-	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
-			  &size_u64, sizeof(size_u64));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
+			      &size_u64, sizeof(size_u64));
+	if (fdt_err < 0)
+		goto out_del_node;
 
 	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
 					  size, false));
 
+	err = 0;
+	goto out_pack;
+
+out_del_node:
+	fdt_del_node(root_fdt, off);
 out_pack:
 	fdt_pack(root_fdt);
 

---
base-commit: 8f8e4b45225ec37b0c69aace920e97148b014956
change-id: 20260407-kho_fix_send-ae33f16d7502

Best regards,
--  
Breno Leitao <leitao@debian.org>


