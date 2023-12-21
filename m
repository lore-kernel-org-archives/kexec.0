Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7745C35274
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e6ZC/Q5ZyL1agOiUk/ltX6MfhtlhNp2SM5nxa7+g7E4=; b=QV3cFFJCxvLlUf
	HgSRiI1T2pMyvqKEJ9XQUkF5o+TOFHFX2lYASahyuOB8v3rknppsELA4fq0yE+CIDlliRmc/GTVrS
	SmKS5zOQcYy07VHcXXfyC8Z5b2nGp337R2QTCMGd4gqqT3Rz86WKKXrpIrW+tRzjzk1XV2D4sMYhl
	LBpXy7hF9eAu4iHpUna0ElXKJzR6TXW7MhPYmpcgiueGISZxrR1Kh8hZarK+WxBDR8X4BYD/7CxNd
	qOs/LqGOF6RqXtFt5BvrBOGDbfa8MN38zltrO/Xc1QwZVbMCs+GE13IlGdfGHvMnG+nJ6E+OKBva/
	TzkL5J/AAfrsdDdsOcew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGJpQ-0039E9-1p;
	Thu, 21 Dec 2023 14:15:12 +0000
Received: from mail-ot1-x363.google.com ([2607:f8b0:4864:20::363])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGJpM-0039Dn-1c
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 14:15:11 +0000
Received: by mail-ot1-x363.google.com with SMTP id 46e09a7af769-6da45aa5549so599862a34.0
        for <kexec@lists.infradead.org>; Thu, 21 Dec 2023 06:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703168106; x=1703772906;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSl+knmWTCSeLTh+1XO2hQUwQUQRVy6Za4rKUfujNIg=;
        b=QJ96OyPC5my/lyLVnQqBhTy27X/0kNFDRMerK/gTQb2CeMPQmJitW3ICDy/DLqCYmm
         ki2aY54gsPbSsyHFH5m04qE+UvQb/PFGiYiKf2kJJEDE5ltqJXYc3GoxpXQNXIF92aJN
         uk2AwzbvuRKxlY88vxpgfj8oLE6WlNo9dVJ0GN1Is+CpxaF9iIpEk0WKYq92iA0BO82W
         TOv5TNN/n/jJqYMRvAv+5F9KbZmG54y/vMgJbWkF/FtqGsgJkBdxHj8T8qFy00MMql8Y
         orkinR9AOQr5Tm9DDclpS59B+jvwBQKTPL49SBteIFXPNp3NsyOPDFKYgnoMhzzHgokO
         BtJw==
X-Gm-Message-State: AOJu0YyvU9cwko+b3tL31uqLl7pxIxx4yOKQ9YQQnv+O8PLC0lti9fYk
	PxsxY9zmwc3lWd+dIQy4yEUV8e5nLHLAYxGaw31V/YOYZNOmvAAX9Y94
X-Google-Smtp-Source: AGHT+IHrPEp94BVGLPXW6cSEd/B6I9izEdCCqi4YVIQKZCf8LA1dzYwKY754TiDBDf+kimlUzLUzhzBx1P6i
X-Received: by 2002:a05:6870:a119:b0:203:f1d5:2e9f with SMTP id m25-20020a056870a11900b00203f1d52e9fmr1968564oae.36.1703168105941;
        Thu, 21 Dec 2023 06:15:05 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id s28-20020a63925c000000b00584ca579bc7sm74729pgn.12.2023.12.21.06.15.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 06:15:05 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1703168105;
	bh=dSl+knmWTCSeLTh+1XO2hQUwQUQRVy6Za4rKUfujNIg=;
	h=From:To:Cc:Subject:Date:From;
	b=H5oW2lqHW2oZoSC1LdFecpSFoD589sqWKjwe/FMdknLXm7XlJhcWZaP9NzIno1inP
	 DjbhRBqydPKWFGBuiF+HhmEas5PR4EdgLNFEBw4l7V0hSI1jccII778Rqo6p5sq956
	 QQNlDXgmggFdO7vyCGSR0E4tIctUVUIGpsG05we7ig2lMmn/a7ojXT6OzfRQdojDeY
	 DLzS0ZJjRWaUsrXAiQcLO3a5GcdqltBTRU8hr/9AMilzBLPnBPcL2UEWDK84biCUT4
	 pI3Gi+t+J2BaGrDj3akZInfCeKS6BOL5tv2DXkfXaFNokkyZjeiQwIfv9RpfoDhxTH
	 dM/CDdkPxDMsA==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 3F9E14FEF00;
	Thu, 21 Dec 2023 06:15:05 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 360A1B8407DA; Thu, 21 Dec 2023 06:15:05 -0800 (PST)
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
Date: Thu, 21 Dec 2023 06:15:02 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20231221141503.21853-1-echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_061509_123520_CD91EC90 
X-CRM114-Status: GOOD (  28.94  )
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
Revision: #2 on 2023/12/21 per Kazu use NOT_FOUND_STRUCTURE for caller_id

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
index a6ec9d4..e14ed33 100644
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
+	if (OFFSET(printk_log.caller_id) != NOT_FOUND_STRUCTURE) {
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
index 61e0b26..85053b8 100644
--- a/printk.c
+++ b/printk.c
@@ -114,6 +114,33 @@ dump_record(struct prb_map *m, unsigned long id)
 
 	bufp = buf;
 	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
+
+	if (OFFSET(printk_info.caller_id) > NOT_FOUND_STRUCTURE) {
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
