Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97438C35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Biz8sXC901evSO4XPpK/5HqP3q2ZqRxZMU/fSmJ+d5Y=; b=dTX7gvCbxTPW89
	UdX0PfINNoQ0TM3ndCw2UmA798nilcdEXi8hHz46lCF+0s72YXCQ2nyfkZyupPBFUJntMCniG79+U
	h1P8F/3gc00vJedzWywOyk0JhX85R0j5dFs1HVmiROWZn4MNdp/FVpp9xL+9pCMIdTyfe9CpVfNEp
	KgGWBuNTrc3UXHmNsBURsaawt5n/PvpWIBWgOxTDCplTlDrWM33L2xWXc2a7wDWiGBc5nlh2mz8v7
	yI0RdS6UqhNseUb2wrKpznOZhEJm/prNTX8wuVgWQeKP3Iy687CAsCTrHjsLuaVh6F//Alh/56X6U
	7xaNEc+jIlnvr/6t13Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGIhf-002sp3-39;
	Thu, 21 Dec 2023 13:03:07 +0000
Received: from mail-io1-xd64.google.com ([2607:f8b0:4864:20::d64])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGIhb-002snI-1Q
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 13:03:06 +0000
Received: by mail-io1-xd64.google.com with SMTP id ca18e2360f4ac-7b7a9f90f34so36501939f.2
        for <kexec@lists.infradead.org>; Thu, 21 Dec 2023 05:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163780; x=1703768580;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEdQpZ4m2dX6COd9Yefw2GYx/56X2W9TUsqI6/Vqvos=;
        b=HZuzPJlBBd1u4HYcGbungqUy+8HjMln313sv2JquKEj5F6XH2Sb+zga+27+Um+a0jP
         aepLgRpXJKeCU9keoWfs8XJMaijWM8Vud90/7TGSdi1nHr4IY34iB2wZfQfQECtv/MC1
         tvt8Qmc2LZxiKSZ0044lXR7mxoLTWS32YGXSPcjZbXS02+EF33cJUJFWV83lkuml34nJ
         DNh1khVbg1lBaNd32wTlgeWXGapcLHcXsF7vjYQerv6qMVvnWO/VqR+P1bGN9SYcwFqx
         70joB0JgwFsKOP43fOPPJzyiYVwN31QeO3XvTECNjB/uFHe2WVlZiWU0Naha6kADL5pM
         OPRQ==
X-Gm-Message-State: AOJu0Ywq56t/nPseK1meAk3GY9PWM2tCsKRTFjymOA8+dSWZb7DgdPdm
	9yRfHgqk618JOASYBuna2pXvXvpW4v4qh2wpHp1Idkn7tbqShIU84RaT
X-Google-Smtp-Source: AGHT+IH0pOsN/0+ZXCR/X9XJQJskdpwtjyl/HsqZlngGKRiqkpcyoRK3iLYylVBw6mp2Syk5hnlqsYcVIWGS
X-Received: by 2002:a05:6e02:1bc6:b0:35d:59a2:bb1 with SMTP id x6-20020a056e021bc600b0035d59a20bb1mr21229271ilv.71.1703163780687;
        Thu, 21 Dec 2023 05:03:00 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id q17-20020a056638239100b0046cec7d9553sm31217jat.71.2023.12.21.05.03.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 05:03:00 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1703163779;
	bh=YEdQpZ4m2dX6COd9Yefw2GYx/56X2W9TUsqI6/Vqvos=;
	h=From:To:Cc:Subject:Date:From;
	b=yEN5jkTrpm9RG7K0FELuNigJKfGAKN4W/PFLI0+AqXBYN69n7PkhxNS91ePy4vr/q
	 dvWga5T3Qzq80p2e9UauCf5e5ay9b//OrnbXDk1zAMk1mkD6qCOkSGoj0j22X8K1CL
	 gkM9K/xv6BJKRTs8FSt5khOiVyVKRplanEZeaFsEUUzkFv7hY96na1JtjWDVTGU5Fj
	 V6OoiDxR8aVvOqYoJUZ4hsoNjCMP1900uuixjQJk1YQPbkXla1kGJCC28KJ5K0/Tgc
	 vV1GMV7z5r7n8U1XCE//kc5Y2BnYnPkJrJecgUEEbhALs9FSwd3jLW10hQGJorHHhZ
	 kXF6ZjG1Z3+ow==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id DB9F9400F80;
	Thu, 21 Dec 2023 05:02:59 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id CD88BB840DDE; Thu, 21 Dec 2023 05:02:59 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Edward Chron <echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
To: kexec@lists.infradead.org
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Cc: k-hagio-ab@nec.com,
	colona@arista.com,
	echron@arista.com
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Subject: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Date: Thu, 21 Dec 2023 05:02:56 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20231221130256.21264-1-echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_050304_575921_9D47D5B6 
X-CRM114-Status: GOOD (  28.80  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Submission to Project: makedumpfile
Component: dmesg
Files: printk.c makedumpfile.c makedumpfile.h
Code level patch applied against: 1.7.4++ - latest code pulled from
    https://github.com/makedumpfile/makedumpfile
makedumpfile Issue #13
    https://github.com/makedumpfile/makedumpfile/issues/13
Revision: #1 on 2023/12/15 per Kazu ensure spacing of dmesg output
                           matches dmesg -S and new dmesg caller_id
                           output format (space after timestamp)

Add support so that dmesg entries include the optional Linux Kernel
debug CONFIG option PRINTK_CALLER which adds an optional dmesg field
that contains the Thread Id or CPU Id that is issuing the printk to
add the message to the kernel ring buffer. If enabled, this CONFIG
option makes debugging simpler as dmesg entries for a specific
thread or CPU can be recognized.

The dmesg command supports printing the PRINTK_CALLER field. The
old syslog format (dmesg -S) and recently support was added for dmesg
using /dev/kmsg interface.

The additional field provided by PRINTK_CALLER is only present
if it was configured for the Linux kernel on the running system. The
PRINTK_CALLER is a debug option and not configured by default so the
dmesg output will only change for those kernels where the option was
configured when the kernel was built. For users who went to the
trouble to configure PRINTK_CALLER and have the extra field available
for debugging, having dmesg print the field is very helpful and so
it would be very useful to add makedumpfile support for it.

Size of the PRINTK_CALLER field is determined by the maximum number
tasks that can be run on the system which is limited by the value of
/proc/sys/kernel/pid_max as pid values are from 0 to value - 1.
This value determines the number of id digits needed by the caller id.
The PRINTK_CALLER field is printed as T<id> for a Task Id or C<id>
for a CPU Id for a printk in CPU context. The values are left space
padded and enclosed in parentheses such as:
         [    T123]   or   [     C16]
For dmesg command the PRINTK_CALLER field when present is the last
field before the dmesg text so it makes sense to use the same format.

Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Edward Chron <echron@arista.com>
---
 makedumpfile.c | 33 +++++++++++++++++++++++++++++++++
 makedumpfile.h | 22 ++++++++++++++++++++++
 printk.c       | 27 +++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index a6ec9d4..a427eaf 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2118,6 +2118,7 @@ module_end:
 		SIZE_INIT(printk_info, "printk_info");
 		OFFSET_INIT(printk_info.ts_nsec, "printk_info", "ts_nsec");
 		OFFSET_INIT(printk_info.text_len, "printk_info", "text_len");
+		OFFSET_INIT(printk_info.caller_id, "printk_info", "caller_id");
 
 		OFFSET_INIT(atomic_long_t.counter, "atomic_long_t", "counter");
 
@@ -2133,6 +2134,7 @@ module_end:
 		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
 		OFFSET_INIT(printk_log.len, "printk_log", "len");
 		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
+		OFFSET_INIT(printk_info.caller_id, "printk_log", "caller_id");
 	} else {
 		info->flag_use_printk_ringbuffer = FALSE;
 		info->flag_use_printk_log = FALSE;
@@ -2462,6 +2464,7 @@ write_vmcoreinfo_data(void)
 
 		WRITE_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
 		WRITE_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
+		WRITE_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
 
 		WRITE_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
 
@@ -2470,6 +2473,7 @@ write_vmcoreinfo_data(void)
 		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
 		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
 		WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
+		WRITE_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
 	} else {
 		/* Compatibility with pre-3.11-rc4 */
 		WRITE_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
@@ -2921,6 +2925,7 @@ read_vmcoreinfo(void)
 		READ_STRUCTURE_SIZE("printk_info", printk_info);
 		READ_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
 		READ_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
+		READ_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
 
 		READ_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
 
@@ -2932,6 +2937,7 @@ read_vmcoreinfo(void)
 		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
 		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
 		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
+		READ_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
 	} else {
 		info->flag_use_printk_ringbuffer = FALSE;
 		info->flag_use_printk_log = FALSE;
@@ -5604,6 +5610,33 @@ dump_log_entry(char *logptr, int fp, const char *file_name)
 
 	bufp = buf;
 	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
+
+	if (OFFSET(printk_log.caller_id) > 0) {
+		ssize_t numspaces;
+		unsigned int pkc;
+		char idtype;
+		int digits;
+
+		/* Get id type, isolate id value in pkc for print */
+		pkc = UINT(logptr + OFFSET(printk_log.caller_id));
+		idtype = (pkc & 0x80000000) ? 'C' : 'T';
+		pkc &= ~0x80000000;
+		/* Determine size of padding space if needed */
+		digits = snprintf(NULL, 0, "%u", pkc);
+		numspaces = CALLER_ID_SIZE - digits;
+		if (numspaces > 0) {
+			char spc[16];
+
+			memset(spc, 0, sizeof(spc));
+			memset(spc, ' ', numspaces);
+			bufp += sprintf(bufp, "[%s%c%u] ", spc, idtype, pkc);
+		} else {
+			bufp += sprintf(bufp, "[%c%u] ", idtype, pkc);
+		}
+	} else {
+		bufp = stpcpy(bufp, " ");
+	}
+
 	indent_len = strlen(buf);
 
 	/* How much buffer space is needed in the worst case */
diff --git a/makedumpfile.h b/makedumpfile.h
index f1619c5..0a7acb5 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2116,10 +2116,16 @@ struct offset_table {
 		long	p_memsz;
 	} elf64_phdr;
 
+	/* The caller_id was added by the Linux-5.1 Kernel to hold
+	 * the Thread id or CPU id of the caller adding a printk
+	 * dmesg to the ring buffer. As such older versions of the
+	 * kernel can ignore this field as it won't be filled in.
+	 */
 	struct printk_log_s {
 		long ts_nsec;
 		long len;
 		long text_len;
+		long caller_id;
 	} printk_log;
 
 	/*
@@ -2671,6 +2677,22 @@ struct elf_prstatus {
 
 #endif
 
+/*
+ * Minimum size of the id portion of the PRINTK_CALLER dmesg field if it is
+ * configured in the Linux Kernel. The size is used to pad with spaces the
+ * PRINTK_CALLER field in each dmesg. For 32 bit kernels the maximum number
+ * of PIDs supported was 2^15 so pid values 0 to 32,767 while 64 bit systems
+ * support the value specified in /proc/sys/kernel/pid_max which is capped at
+ * PID_MAX_LIMIT. We can use 7 digits as that accomodates both 32 bit and
+ * current 64 bit systems as PID_MAX_LIMIT is currently 2^22 so that will
+ * fit in 7 digits and the id will add an additional byte for the id type of
+ * either thread 'T' or CPU 'C', where the Thread ids will have much larger
+ * values, so the CPU ids will easily be accomodated. When systems exceed
+ * 7 digits that won't break anything, but print statements needing more
+ * then 7 digits will not precisely align.
+ */
+#define CALLER_ID_SIZE 7
+
 /*
  * Below are options which getopt_long can recognize. From OPT_START options are
  * non-printable, just used for implementation.
diff --git a/printk.c b/printk.c
index 61e0b26..bfb3a96 100644
--- a/printk.c
+++ b/printk.c
@@ -114,6 +114,33 @@ dump_record(struct prb_map *m, unsigned long id)
 
 	bufp = buf;
 	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
+
+	if (OFFSET(printk_info.caller_id) > 0) {
+		ssize_t numspaces;
+		unsigned int pkc;
+		char idtype;
+		int digits;
+
+		/* Get id type, isolate id value in pkc for print */
+		pkc = UINT(inf + OFFSET(printk_info.caller_id));
+		idtype = (pkc & 0x80000000) ? 'C' : 'T';
+		pkc &= ~0x80000000;
+		/* Determine size of padding space if needed */
+		digits = snprintf(NULL, 0, "%u", pkc);
+		numspaces = CALLER_ID_SIZE - digits;
+		if (numspaces > 0) {
+			char spc[16];
+
+			memset(spc, 0, sizeof(spc));
+			memset(spc, ' ', numspaces);
+			bufp += sprintf(bufp, "[%s%c%u] ", spc, idtype, pkc);
+		} else {
+			bufp += sprintf(bufp, "[%c%u] ", idtype, pkc);
+		}
+	} else {
+		bufp = stpcpy(bufp, " ");
+	}
+
 	indent_len = strlen(buf);
 
 	/* How much buffer space is needed in the worst case */
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
