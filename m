Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A11C47422
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/KGiD6s+OCYVQwkxiDTcEnohHpVVIZ1YlPylDNDB7VA=; b=K0B4wBxRZZqyhKDga3bDc0Jo3g
	tUNkNsP4PiEsRBk6wKvJCWb7sozpkcGPrQnAT/sbPTqlMbfKED6MQG2x7EoX7YXZ5VhNH7j38nP+S
	3Ow5V/LmOdgTDiHZ995xn3Dxp04bvXyxPt5wfuXCynWytX29pBxeDFOSBY3N4zUQzmkXBga86u/2f
	nmxyJht81JnIaqgosjxh8aUJ8uP6hVv69k8cTIuO6GXsqWfwAWi4qiGpfW/rjneoCuY6t+ZKwuZ/3
	FtgfLpTB2cWbSJPcausgJ2b4IsDReXZ8GyrHGK5F4dw+KNPRvFms2McIApMEm6YqSCw0ujIOWpmge
	PGgr1hBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ0c3-00EjsJ-28;
	Wed, 17 Jan 2024 07:45:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ0c0-00EjqM-1L
	for kexec@lists.infradead.org;
	Wed, 17 Jan 2024 07:45:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705477520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQKf1TFOIk3jRZgYrerpttWoKccvQIBg6Et3VqW5w6c=;
	b=Ibdjjsky8FgSI9mPougBBHnA+uVd0edA49QeEIR4WkTumsspujWJ1r8rUcHlTL3lRIneCm
	pVOLbVyBmK3QjD99dsj0CPT/0e4peNOihuR9WRNdirLN66TOfbbaFLmRmP5uruG2ACymvM
	YrJoypUzr0pEuo5D2qXrf89sJwGFzdA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-eBEaHoRgMxaE-NJl5KU2fw-1; Wed, 17 Jan 2024 02:45:19 -0500
X-MC-Unique: eBEaHoRgMxaE-NJl5KU2fw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d4931d651aso111540965ad.2
        for <kexec@lists.infradead.org>; Tue, 16 Jan 2024 23:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705477518; x=1706082318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQKf1TFOIk3jRZgYrerpttWoKccvQIBg6Et3VqW5w6c=;
        b=h2FJSw8ZwG7i9fPMEOeeIX7tviWLtfZFv+YC7xio4K3PTLJhqvaxusZfBnfp9S6/Jr
         VJpkYoiqmmeSN2f7jMc1CXr3AY6vxp2rOPN2VGyx2JyV+9HUwPGOH5yppiaJxfMp9ltX
         QdLVywlPv+w+kC6X2uJNQ2NxVOkNSA3twRiQn755a50OJBb2EkszCIsErYIp3PHQwDm1
         MRCoZbzha6P6HdOWdV7uLDi712hgX0XMG1xeBIzf+QNZ6d3rZWhzXfdwsXPAEPky48xX
         eOGeQNBVdvcB80gONCABdWm3WsgUP9k1TfSItheA7zDefnSTTebLl77WuwYM2m1TscaT
         NJnw==
X-Gm-Message-State: AOJu0YxyK3NTNIfno736xKuRPp2gAutjB9BfOH0iEArWZjkyleGFJl9c
	8loooHIQLubuQqZAUkCH6R42aRkB7fi4w2xgHZYEr9S0F83PBfSddqjcZiwi+iL4E64TO5/6s4Y
	3pQTdJ9KfHpbFhwpSFUyK33CV/3V2
X-Received: by 2002:a17:902:d489:b0:1d5:f223:a27a with SMTP id c9-20020a170902d48900b001d5f223a27amr1978810plg.39.1705477518136;
        Tue, 16 Jan 2024 23:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhEoP2YVi7iCc6R39IopraMkPNMLCAp9KZ0Dbsx8C4gLDT2Oz18uI3tNeXVMGc70+YfqFMaA==
X-Received: by 2002:a17:902:d489:b0:1d5:f223:a27a with SMTP id c9-20020a170902d48900b001d5f223a27amr1978803plg.39.1705477517899;
        Tue, 16 Jan 2024 23:45:17 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902bc4c00b001d6f5ac1ad4sm207349plz.43.2024.01.16.23.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 23:45:17 -0800 (PST)
Date: Wed, 17 Jan 2024 15:39:50 +0800
From: Coiby Xu <coxu@redhat.com>
To: Ondrej Kozina <okozina@redhat.com>
Cc: kexec@lists.infradead.org, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: Re: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
Message-ID: <isgawrvqwuyaitkxgikkcgw3g5mxt3x3tubgpsy2kqos3t4nwr@soy5s6ypm6nt>
References: <20240110071522.1308935-1-coxu@redhat.com>
 <20240110071522.1308935-3-coxu@redhat.com>
 <750d9e17-d8b8-44c0-ba47-74a686333a01@redhat.com>
MIME-Version: 1.0
In-Reply-To: <750d9e17-d8b8-44c0-ba47-74a686333a01@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_234524_527001_81712653 
X-CRM114-Status: GOOD (  16.24  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Jan 16, 2024 at 11:40:53AM +0100, Ondrej Kozina wrote:
>On 10/01/2024 08:15, Coiby Xu wrote:
>>User space is supposed to write the key description to
>>/sys/kernel/crash_dm_crypt_key so the kernel will read the key and save
>>a temporary copy for later user. User space has 2 minutes at maximum to
>>load the kdump initrd before the key gets wiped. And after kdump
>>retrieves the key, the key will be wiped immediately.
>>
>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>---
>>  include/linux/crash_core.h   |   7 +-
>>  include/linux/kexec.h        |   4 ++
>>  kernel/Makefile              |   2 +-
>>  kernel/crash_dump_dm_crypt.c | 121 +++++++++++++++++++++++++++++++++++
>>  kernel/ksysfs.c              |  23 ++++++-
>>  5 files changed, 153 insertions(+), 4 deletions(-)
>>  create mode 100644 kernel/crash_dump_dm_crypt.c
>>
>>diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>>index 5126a4fecb44..7078eda6418d 100644
>>--- a/include/linux/crash_core.h
>>+++ b/include/linux/crash_core.h
>>@@ -125,6 +125,12 @@ static inline void __init reserve_crashkernel_generic(char *cmdline,
>>  {}
>>  #endif
>>+struct kimage;
>>+
>>+int crash_sysfs_dm_crypt_key_write(const char *key_des, size_t count);
>>+int crash_pass_temp_dm_crypt_key(void **addr, unsigned long *sz);
>>+int crash_load_dm_crypt_key(struct kimage *image);
>>+
>>  /* Alignment required for elf header segment */
>>  #define ELF_CORE_HEADER_ALIGN   4096
>>@@ -140,7 +146,6 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>>  extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>>  				       void **addr, unsigned long *sz);
>>-struct kimage;
>>  struct kexec_segment;
>>  #define KEXEC_CRASH_HP_NONE			0
>>diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>index 6f4626490ebf..bf7ab1e927ef 100644
>>--- a/include/linux/kexec.h
>>+++ b/include/linux/kexec.h
>>@@ -366,6 +366,10 @@ struct kimage {
>>  	void *elf_headers;
>>  	unsigned long elf_headers_sz;
>>  	unsigned long elf_load_addr;
>>+
>>+	/* dm crypt key buffer */
>>+	unsigned long dm_crypt_key_addr;
>>+	unsigned long dm_crypt_key_sz;
>>  };
>>  /* kexec interface functions */
>>diff --git a/kernel/Makefile b/kernel/Makefile
>>index 3947122d618b..48859bf63db5 100644
>>--- a/kernel/Makefile
>>+++ b/kernel/Makefile
>>@@ -119,7 +119,7 @@ obj-$(CONFIG_PERF_EVENTS) += events/
>>  obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
>>  obj-$(CONFIG_PADATA) += padata.o
>>-obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
>>+obj-$(CONFIG_CRASH_DUMP) += crash_dump.o crash_dump_dm_crypt.o
>>  obj-$(CONFIG_JUMP_LABEL) += jump_label.o
>>  obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
>>  obj-$(CONFIG_TORTURE_TEST) += torture.o
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>new file mode 100644
>>index 000000000000..3a0b0b773598
>>--- /dev/null
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -0,0 +1,121 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+#include <keys/user-type.h>
>>+#include <linux/crash_dump.h>
>>+
>>+static u8 *dm_crypt_key;
>>+static unsigned int dm_crypt_key_size;
>>+
>>+void wipe_dm_crypt_key(void)
>>+{
>>+	if (dm_crypt_key) {
>>+		memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
>>+		kfree(dm_crypt_key);
>>+		dm_crypt_key = NULL;
>>+	}
>>+}
>>+
>>+static void _wipe_dm_crypt_key(struct work_struct *dummy)
>>+{
>>+	wipe_dm_crypt_key();
>>+}
>>+
>>+static DECLARE_DELAYED_WORK(wipe_dm_crypt_key_work, _wipe_dm_crypt_key);
>>+
>>+static unsigned __read_mostly wipe_key_delay = 120; /* 2 mins */
>>+
>>+static int crash_save_temp_dm_crypt_key(const char *key_desc, size_t count)
>>+{
>>+	const struct user_key_payload *ukp;
>>+	struct key *key;
>>+
>>+	if (dm_crypt_key) {
>>+		memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
>>+		kfree(dm_crypt_key);
>>+	}
>>+
>>+	pr_debug("Requesting key %s", key_desc);
>>+	key = request_key(&key_type_user, key_desc, NULL);
>
>If we don't read the key copy form userspace (my reply to top level 
>message) you could use key_type_logon here.

I'll use key_type_logon, thanks!

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
