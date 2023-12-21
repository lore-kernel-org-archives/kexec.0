Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81597C46CCD
	for <kexec@archiver.kernel.org>; Thu, 21 Dec 2023 23:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sIPO2G8NcrEbMzjLcYKtpd1IUzVJy+WP5BX5O2XTW50=; b=n0yroF+3vzjMeE
	7k5xC9e4wJBCpG91RDC7Y+stOgr3vZvpMXgya740FA/M7DR6k8viEIC6LePIESGgmM2hLA7W/3vlT
	n5vI+xA8AQ2K3eeldQMsy/d97gGt2+GpjiIOat0VwQzbSvlVUFHM40zCny8BiOWVZpstRbN9Y8Hrx
	PvBlHYgArz+kUS+Jfp4nCLT3ylKEhPLWe9d65FfEUDEzbHOI0/Faxbl7Ct/EmGzTO9oPccT5f2CUe
	1vjxDp5c3SNTw74Mq6QUtmnSm/ex8osbQZKpjwzCK/1UwQQ50dlZ01xCnZTAtghsrp/iBdM5QwKor
	1DmNCGYQ/ROVKDgw8g3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSkM-004SYl-2j;
	Thu, 21 Dec 2023 23:46:34 +0000
Received: from mail-io1-xd64.google.com ([2607:f8b0:4864:20::d64])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGSkH-004SXj-1H
	for kexec@lists.infradead.org;
	Thu, 21 Dec 2023 23:46:32 +0000
Received: by mail-io1-xd64.google.com with SMTP id ca18e2360f4ac-7b72192f7a1so59231139f.1
        for <kexec@lists.infradead.org>; Thu, 21 Dec 2023 15:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703202387; x=1703807187;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrzK1XjPkSmZ7B7ZcejFJpZeB0zdePxClb1v4dZkj+k=;
        b=TvqpHwgnhUgSHfe7T+CH6S0s/d+QMySFJ8rfub3W3qIQPlJOYWEh1WgfLCBUOCOo0g
         t8k8vFb8RHGk+VairlYVQK6FsMAobg8f54YU1tK9JRJwIV9fGpy+6TKPjvh4aB4s2SYQ
         wFrjJ3dmN8rdeeK6nB21cO61NR4cqyXS8/Rsp5XrxYPGhn2ckAlqNXM8UDElXvSrdx6A
         kO2au3y/IY8oFWMhcmTo/ExChfRMzpCJUioHeCbV2DsJSQJWhXqOK0G/ZxoGA3arJ3by
         4xygrzfXIHrs2Vlph6QiBuXgeu7wU0wSoH27Zp+BmEYuwb/pOb033Qip4C4k08i2sC33
         5Uiw==
X-Gm-Message-State: AOJu0YzwlJ7rY9OG2rp7vYtdtR9jihwEI5RaWcH/G3gUkE1WOOfOR5U7
	9nc+FXknACKlKNKD85+3TINtppNnP8kpMDe+XXzUSTb9UEfSTospsklEJRGbgG8=
X-Google-Smtp-Source: AGHT+IFhDLKIntG/+ucbo9i1q+Xz3I7KSkHJUn4dU4FK6uFQTcacBEG/adoh2Z53XkBIrLSnfQWUr0ZfhXVB
X-Received: by 2002:a05:6e02:1605:b0:35d:4463:5dd2 with SMTP id t5-20020a056e02160500b0035d44635dd2mr1171441ilu.16.1703202387244;
        Thu, 21 Dec 2023 15:46:27 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id l15-20020a02cd8f000000b004695e267a56sm126381jap.50.2023.12.21.15.46.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 15:46:27 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1703202386;
	bh=CrzK1XjPkSmZ7B7ZcejFJpZeB0zdePxClb1v4dZkj+k=;
	h=From:To:Cc:Subject:Date:From;
	b=hiRXDjkfonxFLTwimPgmfUHPSUi93DlfmVMq6iS7nnTDXKHvKntthECAVkE+mqEcN
	 x34+fwZLq/wORmjrQDr4LqEjdDsii6hu/XLHaPK3Z7kfHeib03WQ1vj2oXXzYMYYRB
	 C87PdN68C3aCxw77poikLpFxgImoZ0GMAOYBOc6Db9W+44JDNcPnnNuz7ACvpSEybn
	 Lhg7WtMwoCytzLn8fhXu2EDYmPm4qvL7rcqzNf6wECNeh+Cn4DKi2nLiwaRiByCNnM
	 E+yu4O8rvl0wn4ojvvVIXvenwgmVhz3d5bFWV3jd419fQahEfgv743DZCK7ZRi8Er7
	 /AtzeXuBgotpg==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 6DEDF400F80;
	Thu, 21 Dec 2023 15:46:26 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id 5EFAAB8407CE; Thu, 21 Dec 2023 15:46:26 -0800 (PST)
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
Date: Thu, 21 Dec 2023 15:46:23 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20231221234623.17077-1-echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_154630_800622_A6BB64EA 
X-CRM114-Status: GOOD (  30.01  )
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
Project Owner: Kazuhito Hagio <k-hagio-ab@nec.com>
Revision: #1 on 2023/12/15 per Kazu ensure spacing of dmesg output
                           matches dmesg -S and new dmesg caller_id
                           output format (space after timestamp)
Revision: #2 on 2023/12/21 per Kazu use NOT_FOUND_STRUCTURE for caller_id
Revision: #3 on 2023/12/21 streamline code for printing caller_id

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
 makedumpfile.c | 25 +++++++++++++++++++++++++
 makedumpfile.h | 22 ++++++++++++++++++++++
 printk.c       | 18 ++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index a6ec9d4..eaa8c4d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -28,6 +28,10 @@
 #include <assert.h>
 #include <zlib.h>
 
+#define PID_CHARS_MAX 16	/* Max Number of PID characters */
+#define PID_CHARS_DEFAULT 8	/* Default number of PID characters */
+
+
 struct symbol_table	symbol_table;
 struct size_table	size_table;
 struct offset_table	offset_table;
@@ -2118,6 +2122,7 @@ module_end:
 		SIZE_INIT(printk_info, "printk_info");
 		OFFSET_INIT(printk_info.ts_nsec, "printk_info", "ts_nsec");
 		OFFSET_INIT(printk_info.text_len, "printk_info", "text_len");
+		OFFSET_INIT(printk_info.caller_id, "printk_info", "caller_id");
 
 		OFFSET_INIT(atomic_long_t.counter, "atomic_long_t", "counter");
 
@@ -2133,6 +2138,7 @@ module_end:
 		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
 		OFFSET_INIT(printk_log.len, "printk_log", "len");
 		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
+		OFFSET_INIT(printk_info.caller_id, "printk_log", "caller_id");
 	} else {
 		info->flag_use_printk_ringbuffer = FALSE;
 		info->flag_use_printk_log = FALSE;
@@ -2462,6 +2468,7 @@ write_vmcoreinfo_data(void)
 
 		WRITE_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
 		WRITE_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
+		WRITE_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
 
 		WRITE_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
 
@@ -2470,6 +2477,7 @@ write_vmcoreinfo_data(void)
 		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
 		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
 		WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
+		WRITE_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
 	} else {
 		/* Compatibility with pre-3.11-rc4 */
 		WRITE_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
@@ -2921,6 +2929,7 @@ read_vmcoreinfo(void)
 		READ_STRUCTURE_SIZE("printk_info", printk_info);
 		READ_MEMBER_OFFSET("printk_info.ts_nsec", printk_info.ts_nsec);
 		READ_MEMBER_OFFSET("printk_info.text_len", printk_info.text_len);
+		READ_MEMBER_OFFSET("printk_info.caller_id", printk_info.caller_id);
 
 		READ_MEMBER_OFFSET("atomic_long_t.counter", atomic_long_t.counter);
 
@@ -2932,6 +2941,7 @@ read_vmcoreinfo(void)
 		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
 		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
 		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
+		READ_MEMBER_OFFSET("printk_log.caller_id", printk_log.caller_id);
 	} else {
 		info->flag_use_printk_ringbuffer = FALSE;
 		info->flag_use_printk_log = FALSE;
@@ -5604,6 +5614,21 @@ dump_log_entry(char *logptr, int fp, const char *file_name)
 
 	bufp = buf;
 	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
+
+	if (OFFSET(printk_log.caller_id) != NOT_FOUND_STRUCTURE) {
+		const unsigned int cpuid = 0x80000000;
+		char cidbuf[PID_CHARS_MAX];
+		unsigned int pkc;
+		char idtype;
+
+		/* Get id type, isolate id value in pkc for print */
+		pkc = UINT(logptr + OFFSET(printk_log.caller_id));
+		idtype = (pkc & cpuid) ? 'C' : 'T';
+		pkc &= ~cpuid;
+		sprintf(cidbuf, "%c%u", idtype, pkc);
+		bufp += sprintf(bufp, "[%*s] ", PID_CHARS_DEFAULT, cidbuf);
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
index 61e0b26..88ff396 100644
--- a/printk.c
+++ b/printk.c
@@ -1,6 +1,9 @@
 #include "makedumpfile.h"
 #include <ctype.h>
 
+#define PID_CHARS_MAX 16        /* Max Number of PID characters */
+#define PID_CHARS_DEFAULT 8     /* Default number of PID characters */
+
 /* convenience struct for passing many values to helper functions */
 struct prb_map {
 	char		*prb;
@@ -114,6 +117,21 @@ dump_record(struct prb_map *m, unsigned long id)
 
 	bufp = buf;
 	bufp += sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
+
+	if (OFFSET(printk_info.caller_id) > NOT_FOUND_STRUCTURE) {
+		const unsigned int cpuid = 0x80000000;
+		char cidbuf[PID_CHARS_MAX];
+		unsigned int pkc;
+		char idtype;
+
+		/* Get id type, isolate id value in pkc for print */
+		pkc = UINT(inf + OFFSET(printk_info.caller_id));
+		idtype = (pkc & cpuid) ? 'C' : 'T';
+		pkc &= ~cpuid;
+		sprintf(cidbuf, "%c%u", idtype, pkc);
+		bufp += sprintf(bufp, "[%*s] ", PID_CHARS_DEFAULT, cidbuf);
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
