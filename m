Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E30C77B7E
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L5Rsx9L9sxbSJCTij30RB0hMGDNC9x76tUxnPv3klNE=; b=Ayxw7977bTOMcp
	0lojVBy+7aQbLvc/Q/SYl70gCoL3UH1jl1U6nVWtQ9E3yz6qxhbEHccQGvhmDS35EZLlbpMLmvTcA
	edIbrZpsGVAFNFELD2AyBEiDM6b6n+g0yFouUkashlUrnLOvbkZAlOqEEW6TUF9EJXLRnbYlmEtVh
	5mdGolP/o4X/YO5UZmwXLkTyoDkHxV5qNPDNZDc/hlXyxiwLEpMLFHcFc/2uRRNlOAMJFp+k5HGtC
	j1byTTzN8HVTnbBeOciIT+aN9QXZVIzEA2QuvaVEI5/b85g0t8NamLSA/SpXk0dzHLSGdxPPV7F8X
	qVS9Y3c7z1bG/exFrzzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4chj-002Lsm-35;
	Thu, 01 Jun 2023 07:26:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4chg-002LrP-12
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 07:26:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685604393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVNhkRwZAfrMBhKh//wi6Z59DrttLTByCXwnmuvQ7Sk=;
	b=SpWOqjbFkMtLXCcDYHuT1ZzYTvgNbV/W+iGUjhH3uZ9+grg4xASA/hmxRF5E/A8ASv0BSP
	J48uRovchVRg3+ckNYIoqMVSPakU/6CLNnt3vD65sUHr3+Kq4Li8i8QzU+hkddv2ZUB47h
	Z5rCiYy+vsnIDs79o3KqTe2bCxCI+og=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-QSJEGx5BO9m1HrpSOlgL3w-1; Thu, 01 Jun 2023 03:24:57 -0400
X-MC-Unique: QSJEGx5BO9m1HrpSOlgL3w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f80c977f15so5029171cf.2
        for <kexec@lists.infradead.org>; Thu, 01 Jun 2023 00:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604296; x=1688196296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVNhkRwZAfrMBhKh//wi6Z59DrttLTByCXwnmuvQ7Sk=;
        b=A2Dy+7hyZDq0w90HjVxpZLnX+gHDFt7Tb5ICeD88s1wira/0Vy9EtTyVxsiWx0ntIq
         gG/N4DL8nY0Bx8ZV5/A8o5/lEir+Mqpk5V1XWzP33tbs99re1R6W6bOXyQ10zF5cs7Zq
         Sdkbb9xa+nEzOSouInaO9HU0JubvaTPa8CHx2kT2xCrBmHmxuN8vgF53+bD5jpEhn/6o
         IAv8Upi8sHJo7SPNZ/tJDIQaok902KBJ1Y4auwodHHLvSlSfwx5OKw00A4Pm3XSCGIXn
         kK6ejiBspBRpZNrTp2TmJWNZCZSyt28tP9kgC63N3Xbty5tFid0IEIxGvVDmHah09OxS
         93kg==
X-Gm-Message-State: AC+VfDy+uDmADVQEKmedjcruJTlcvH1lJ7csrJQhOirvF0BYHkwVQvw5
	IIwmdseJkNSCsPS+mnVrxUIhyvmlwAmiMjLT4kkFHxiClqlxLkE/QyL0zVKsdA1c7y6sqarRBGO
	wfQNLjvka9jOoDDoQ6klEWkZugeMWmNe8SFzpT33G6bVtPkT4gUEtAyQNJbZac9DeXuYfadJash
	yqk/yr
X-Received: by 2002:a05:622a:3c7:b0:3f4:eb26:6d42 with SMTP id k7-20020a05622a03c700b003f4eb266d42mr7982595qtx.63.1685604295888;
        Thu, 01 Jun 2023 00:24:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6UZAxm2RuiVCtGixZ0U45XGL7fm+89xCNa6kmGqARldADNGbnk+xAiazKcrMefCa2tIl3eZQ==
X-Received: by 2002:a05:622a:3c7:b0:3f4:eb26:6d42 with SMTP id k7-20020a05622a03c700b003f4eb266d42mr7982558qtx.63.1685604295538;
        Thu, 01 Jun 2023 00:24:55 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i28-20020a63541c000000b0053efb8fae02sm2465297pgb.24.2023.06.01.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:24:55 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 2/5] crash_dump: save the LUKS volume key temporarily
Date: Thu,  1 Jun 2023 15:24:41 +0800
Message-Id: <20230601072444.2033855-3-coxu@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_002636_457651_862105D1 
X-CRM114-Status: GOOD (  20.90  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

After having the volume key, crytpsetup/systemd-cryptsetup saves the
volume key as a logon key to its thread keyring and this key is
destroyed immediately with the terminated thread. So a temporary copy of
the volume key is needed in order to later save it to kdump reserved
memory when the crash kernel is loaded later.

crytpsetup/systemd-cryptsetup will write the key description to
/sys/kernel/crash_luks_volume_key so the kernel will read the logon key
and save a temporary copy for later user. kdump has 1 hour at maximum to
get the temporary copy before the key gets wiped. And after kdump
retrieves the key, the key will be wiped immediately.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_core.h |  2 +
 kernel/Makefile            |  2 +-
 kernel/crash_dump_luks.c   | 90 ++++++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c            | 19 ++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 kernel/crash_dump_luks.c

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..596d83b8f362 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -83,5 +83,7 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
+int crash_sysfs_luks_volume_key_write(const char *key_des, size_t count);
+int crash_pass_temp_luks_volume_key(void **addr, unsigned long *sz);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index b69c95315480..8412afa4a9f0 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -118,7 +118,7 @@ obj-$(CONFIG_PERF_EVENTS) += events/
 
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
-obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
+obj-$(CONFIG_CRASH_DUMP) += crash_dump.o crash_dump_luks.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
diff --git a/kernel/crash_dump_luks.c b/kernel/crash_dump_luks.c
new file mode 100644
index 000000000000..2d88b77a93f8
--- /dev/null
+++ b/kernel/crash_dump_luks.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <keys/user-type.h>
+#include <linux/crash_dump.h>
+
+static u8 *luks_volume_key;
+static unsigned int luks_volume_key_size;
+
+void wipe_luks_volume_key(void)
+{
+	if (luks_volume_key) {
+		memset(luks_volume_key, 0, luks_volume_key_size * sizeof(u8));
+		kfree(luks_volume_key);
+		luks_volume_key = NULL;
+	}
+}
+
+static void _wipe_luks_volume_key(struct work_struct *dummy)
+{
+	wipe_luks_volume_key();
+}
+
+static DECLARE_DELAYED_WORK(wipe_luks_volume_key_work, _wipe_luks_volume_key);
+
+static unsigned __read_mostly wipe_key_delay = 3600; /* 1 hour */
+
+static int crash_save_temp_luks_volume_key(const char *key_desc, size_t count)
+{
+	const struct user_key_payload *ukp;
+	struct key *key;
+
+
+	if (luks_volume_key) {
+		memset(luks_volume_key, 0, luks_volume_key_size * sizeof(u8));
+		kfree(luks_volume_key);
+	}
+
+	pr_debug("Requesting key %s", key_desc);
+	key = request_key(&key_type_logon, key_desc, NULL);
+
+	if (IS_ERR(key)) {
+		pr_debug("No such key %s", key_desc);
+		return PTR_ERR(key);
+	}
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp)
+		return -EKEYREVOKED;
+
+	luks_volume_key = kmalloc(ukp->datalen, GFP_KERNEL);
+	if (!luks_volume_key)
+		return -ENOMEM;
+	memcpy(luks_volume_key, ukp->data, ukp->datalen);
+	luks_volume_key_size = ukp->datalen;
+	pr_debug("LUKS master key (size=%u): %8ph\n", luks_volume_key_size, luks_volume_key);
+	schedule_delayed_work(&wipe_luks_volume_key_work,
+			      round_jiffies_relative(wipe_key_delay * HZ));
+	return 0;
+}
+
+int crash_sysfs_luks_volume_key_write(const char *key_desc, size_t count)
+{
+	if (!is_kdump_kernel())
+		return crash_save_temp_luks_volume_key(key_desc, count);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(crash_sysfs_luks_volume_key_write);
+
+int crash_pass_temp_luks_volume_key(void **addr, unsigned long *sz)
+{
+	unsigned long luks_key_sz;
+	unsigned char *buf;
+	unsigned int *size_ptr;
+
+	if (!luks_volume_key)
+		return -EINVAL;
+
+	luks_key_sz = sizeof(unsigned int) + luks_volume_key_size * sizeof(u8);
+
+	buf = vzalloc(luks_key_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	size_ptr = (unsigned int *)buf;
+	memcpy(size_ptr, &luks_volume_key_size, sizeof(unsigned int));
+	memcpy(size_ptr + 1, luks_volume_key, luks_volume_key_size * sizeof(u8));
+	*addr = buf;
+	*sz = luks_key_sz;
+	wipe_luks_volume_key();
+	return 0;
+}
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index aad7a3bfd846..cc64a895c334 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -165,6 +165,24 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
+static ssize_t crash_luks_volume_key_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *buf)
+{
+	return 0;
+}
+
+static ssize_t crash_luks_volume_key_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int ret;
+
+	ret = crash_sysfs_luks_volume_key_write(buf, count);
+	return ret < 0 ? ret : count;
+}
+KERNEL_ATTR_RW(crash_luks_volume_key);
+
 #endif /* CONFIG_CRASH_CORE */
 
 /* whether file capabilities are enabled */
@@ -255,6 +273,7 @@ static struct attribute * kernel_attrs[] = {
 #endif
 #ifdef CONFIG_CRASH_CORE
 	&vmcoreinfo_attr.attr,
+	&crash_luks_volume_key_attr.attr,
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
