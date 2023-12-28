Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34B5C3DA6E
	for <kexec@archiver.kernel.org>; Thu, 28 Dec 2023 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7/OZUu+xxWoW29rghWMY7LYb+ADlv+ztrGFbuu1hooo=; b=eAaAyg/2TE85yI
	X2GGMFWIrQzGGYbcnigrdw4hVtST2diC1zErco/JVvB+DAVJ1OuXUMmSoqKtcUuH8ZHfFUfhZJqnK
	eiEUH2GFhRW6ww3z5rJtSN8A9ZiGzKlTDcDXaCE6gNEpQVZ9GCccLj553uqMQx41iiKP1wS3do7IM
	TdzOqi+evPwlCNlfs9Dd/2Mea5oBqsUdKn4KfWC3OVWlutizApg89syX02vohfh/V4f46hZ4EnN33
	bTCjRxlzo1gpAW3BDldJYcjhno4Hpap5RjbPyVUvWwop1uq3lM5NCNO4SB62Wqu4LvLDK5CKVjLD/
	HjgONHjjs1CcgVLdEyRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIx4X-00HMla-0W;
	Thu, 28 Dec 2023 20:33:41 +0000
Received: from mail-yw1-x1162.google.com ([2607:f8b0:4864:20::1162])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIx4T-00HMl0-1G
	for kexec@lists.infradead.org;
	Thu, 28 Dec 2023 20:33:39 +0000
Received: by mail-yw1-x1162.google.com with SMTP id 00721157ae682-5d05ff42db0so55012727b3.2
        for <kexec@lists.infradead.org>; Thu, 28 Dec 2023 12:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703795614; x=1704400414;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v8yyiTVQ+YYxLrsgU0UU1JCSeepIy+T23tykl3H5OA=;
        b=TScqnVYYESONRq8VqHW1wC/Z6It3E8Q5HJrbwz8ic/6j2e7G4Do1EGxOb7UaiLURPw
         QDMTYbKJbC5qCMnSre8Lzs/j/ixE+zAS5+teg/t0uZ4bnSNOawu+dqEZUkDRRQ/Y0k1y
         sFSOghcNbJPqmuCfhmrUcSLjcwUXavjsJoUWuGswZFI1e8eOWMVXScld3/UEAUkobGTV
         t4N6Qht9gliELlS8lWygXCAnUU1oJ7+cdMpGvcO2WJ4D9QjoVFfADU5pAPhgz86Q+2jD
         s90846mdxznn3nQ5ZG2zToHFHi16QtI+iXo0LgBvXTsV4HcwaaCEgKUCNfZ8DpVO+Z8H
         7OSg==
X-Gm-Message-State: AOJu0YzkJ7wv4khJrxo7p49b6t9BDFQsTtxlA6Aa6r/OifCjwEM3SxPv
	nRJ0+98s2w8hoycbiJrilTN9chUmWWnFj1/kVSF+cmYp1DMzH8ydeqQ=
X-Google-Smtp-Source: AGHT+IHaPCITzAiPM3GZNg3j4qqsd2vmfj8bs7hAVTd2H8ukYIzkEHGy/wTb0QlAoYhpBhIY8UShRDclUsxm
X-Received: by 2002:a81:aa04:0:b0:5eb:86fd:ba24 with SMTP id i4-20020a81aa04000000b005eb86fdba24mr3716615ywh.3.1703795613720;
        Thu, 28 Dec 2023 12:33:33 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id t75-20020a0dea4e000000b005df5f872fa0sm1379465ywe.18.2023.12.28.12.33.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2023 12:33:33 -0800 (PST)
X-Relaying-Domain: arista.com
X-SMTP-Authentication: Allow-List-permitted
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1703795612;
	bh=8v8yyiTVQ+YYxLrsgU0UU1JCSeepIy+T23tykl3H5OA=;
	h=From:To:Cc:Subject:Date:From;
	b=pK1t2T3fJU2sNqZlPQXTGZkciclnInvcdksWKNijmQD14PENVOXWGoiyZtC3VbRZK
	 kPhgH6fXruub9FMXpsnW15xO15zLqDALa+4zFg3FejMzp8jNK+02p85V2DPQokLt73
	 x1xTD+v4wyDW2OUTywSjGtyWilYJ6Sm36vMROgRTYUbpzL7LYfm3Qs827YWMupcgK2
	 Sd5ou7XPbsMiJ8D1cUj6DcmZscIJH2N875FnJdhrcoM+GRQpgCU0wsc+pYw013P+Dj
	 HadGrJxdYLJ3LJR55RxaUpqTOAJMkUyW5hmn/xlSzfk3rwWFQ6JiZjzgPTKddfofkw
	 2mdaGuLvW3w4A==
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: from us113.sjc.aristanetworks.com (us113.sjc.aristanetworks.com [10.242.240.8])
	by smtp.aristanetworks.com (Postfix) with ESMTP id C8586402056;
	Thu, 28 Dec 2023 12:33:32 -0800 (PST)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Received: by us113.sjc.aristanetworks.com (Postfix, from userid 10383)
	id BC5E1B840854; Thu, 28 Dec 2023 12:33:32 -0800 (PST)
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
	echron@arista.com,
	echron@gmail.com
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Subject: [PATCH] makedumpfile add dmesg PRINTK_CALLER id support
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Date: Thu, 28 Dec 2023 12:33:26 -0800
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
Message-ID: <20231228203326.9271-1-echron@arista.com>
X-SMTP-Authentication: Allow-List-permitted
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231228_123337_432440_2DD84134 
X-CRM114-Status: GOOD (  25.96  )
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
Revision: #4 on 2023/12/24 per Kazu make code consistent, drop the
                           CALLER_ID_SIZE not needed.

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
 makedumpfile.h |  6 ++++++
 printk.c       | 18 ++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index a6ec9d4..48ca11f 100644
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
+		OFFSET_INIT(printk_log.caller_id, "printk_log", "caller_id");
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
index f1619c5..cfdbf42 100644
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
diff --git a/printk.c b/printk.c
index 61e0b26..d63227c 100644
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
+	if (OFFSET(printk_info.caller_id) != NOT_FOUND_STRUCTURE) {
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
