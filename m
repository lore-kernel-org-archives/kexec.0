Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED50CD98F2
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlTP4v2bni27T+dN93Gnu5TExfReIwH1JsMfVrv7mfM=; b=LwtA1y0Q+HNECR6Jompieyj12/
	V6oym6DbD0M9GHGx7V2RWpLlHp9FDHC9LZt6wmVGnmfJvb5Qi/n4B4S2o35nN5T2Txpu3GUz3yAMv
	6qFh+WdF+qzbIhYqwNJXTveoImpgNUlRmyU9Dm/H/+BI2OQgAxUfjHu7NwheR75V2+xIQTf0+uRUP
	As1EZL/Zyi7iqLqnKYqXv9eFLch3+v8Puk1LzP4jcNjYAOHYEjxM68crPh2MdTYFF4iWQTMutvkYE
	HR8QPF8CPlj3dsvP82c1BXj4lZBw9TzzRq94AnKVncip1HAYnXPAqpkU+j/Cu7YayDaM5wSmK8lN2
	0CL3NNoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZqPK-0000000HQ6y-03gk;
	Wed, 17 Jun 2026 13:34:18 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZqPH-0000000HQ4D-0Gr2
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 13:34:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=SlTP4v2bni27T+dN93Gnu5TExfReIwH1JsMfVrv7mfM=; b=kl+w8DmBKc4wQhjE7PZ3ca0tgu
	J/sxm4NzcJ8Bm6zSz2NFpOXIsaydQ32wMDMTDYbmgSASLUX40RMK0J/ZtXFQbv/NbAHiZr8o2ScnK
	3WJo5Hkl+ZqmShN1lQwI//Yfl9xgdV9mX8Ui7TJhg5kAJvganCx7yr0OHvbcIIpqexpJyyVXXGh1t
	/EjKsyMmiGuRaffcFC63apK4Eb7AxHGPrKKuGlX9L+wDmmcuMKgTfODyIXsDvMUEH7qB4TtICXgm0
	ooyhUuaCO869KfHnETOi0Xy6DfKnGoc8w5GuEc7EtXPyFff9kFk2uYR3KeJX3813am+7di5+ODDcu
	iN/olMMA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZqOk-00EeVE-1T;
	Wed, 17 Jun 2026 13:33:42 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Jun 2026 06:32:48 -0700
Subject: [PATCH 2/2] vmcore_info: track fatal hardware errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-hwerr-v1-2-ff131cd6203c@debian.org>
References: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
In-Reply-To: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 riel@surriel.com, caggio@meta.com, kexec@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=leitao@debian.org;
 h=from:subject:message-id; bh=DCcwS/Af0/gCwvOSwGbr70DNuzjaSOMbXeG1pza3/9A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMqIkHd3YyPVlkIneRAlRDF0MNSBVdeDObpXEj
 5pGdayCaROJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajKiJAAKCRA1o5Of/Hh3
 bZQoD/474ejbOPMswWEZKvzjO5yiWKb7EtubDsMelEZDSF2C+kjeJQdIQhd1xwvjtuI3tPVVvSk
 jOKouxMf7XcYmbcXXLzmyP6lyYiOh9sQM7zSpwP/OLksDhsDZA4btJivk4yVqfbSf/2qCmR/wUz
 vfcp9kDDzYunhKjcdRF9lvV2BBWdeC0kHA5jtczl4fzE4ZFkQqq0t5Lkj+iCCxEpT+GyH4447zS
 4GLmqCmyJQS8EAqOuaUQe0ZXANh0QniWjuj/v8RBnwlCXKE7oFbC3+OAP3PfulU0Qo+VAcAXW5y
 vHOkicdeRGVFqhmZQS+i0x4P0yryhPe55IPzQ4542vPNNv+mpIynY/n+2pgFsMiWu/Y/sJWBpwr
 RnHFSISfFR7Go7jjfkODBFQEC7+eAjBl9r17drmAIQlUrmOD5E0U+uKuTSYd93XvonH+1pY8E6T
 oYzoQaiCJVU9O0xTN4GWhm7CBlfgITd9jBKWojCUlphPOwUIewnyLeTdcvHkPEpxks9L5GvzI/n
 td4Qn31FS+qC0QNmak9d6jOkVVyZcPtMKpfaYd20FW/Te/bIIcbsyQxNhsdi5jKrCX4+QiVEtwT
 T4dJJjTovGiEHQMfYwUWfWR4JHS8V+cKF3rYwu+gshXGk4wLIXnmx9m+cO17mUXF3bu6BQhOZDq
 ru8b7DMx1P8Gsfg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_063415_108710_48927205 
X-CRM114-Status: UNSURE (   9.89  )
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

Fatal (panic-severity) hardware errors reported through APEI/GHES are
the ones most likely to have caused a crash, but hwerr_data did not
record them.  Add a HWERR_FATAL bucket and bump it from
ghes_log_hwerr() when a GHES_SEV_PANIC error is seen, so crash tooling
can tell from the vmcore that a fatal hardware error preceded the
crash.

Tools reading hwerr_data gain one entry (HWERR_FATAL).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/apei/ghes.c    | 5 +++++
 include/uapi/linux/vmcore.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0f9f1529e7aa..5a9e16bdca2b6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -877,6 +877,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
 
 static void ghes_log_hwerr(int sev, guid_t *sec_type)
 {
+	if (sev == GHES_SEV_PANIC) {
+		hwerr_log_error_type(HWERR_FATAL);
+		return;
+	}
+
 	if (sev != GHES_SEV_RECOVERABLE)
 		return;
 
diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
index 2ba89fafa518a..c774b037603e2 100644
--- a/include/uapi/linux/vmcore.h
+++ b/include/uapi/linux/vmcore.h
@@ -21,6 +21,7 @@ enum hwerr_error_type {
 	HWERR_RECOV_PCI,
 	HWERR_RECOV_CXL,
 	HWERR_RECOV_OTHERS,
+	HWERR_FATAL,		/* fatal hardware errors */
 	HWERR_RECOV_MAX,
 };
 

-- 
2.53.0-Meta


