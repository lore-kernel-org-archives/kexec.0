Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZfIu1-0004aH-Fb
 for kexec@lists.infradead.org; Fri, 25 Sep 2015 02:38:25 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 4B7402F913E
 for <kexec@lists.infradead.org>; Fri, 25 Sep 2015 02:38:03 +0000 (UTC)
Received: from dhcp-129-149.nay.redhat.com ([10.66.129.149])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t8P2bpBK028826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Thu, 24 Sep 2015 22:38:02 -0400
Date: Fri, 25 Sep 2015 10:37:51 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] fix kexec load hang in case crash notes addr read failure
Message-ID: <20150925023728.GA11505@dhcp-129-149.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

While readng crash note, count_cpu variable will be never decreased in case
any failure to read the sysfs file.

The issue was found during I test CONFIG_KEXEC_FILE only kernel option.
crash_notes are exported to sysfs only for CONFIG_KEXEC. In latest kernel
we can configure kernel with CONFIG_KEXEC_FILE only in Kconfig. In this
case, if you run a kernel with kexec_file only but do not specify "-s"
in kexec-tools arguments, then kexec-tools will hang there.

Though "-s" is mandatory for kexec_file_load, kexec should still fail out
instead of hanging.

Fixing the problem by always decreasing count_cpu in the for loop.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
Ideally checking if kernel support kexec_load or kexec_file_load syscall
early is better, but there's no apparent way to check it, call the syscalls
with fake arguments then check return value sounds bad..

 kexec/crashdump-elf.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- kexec-tools.orig/kexec/crashdump-elf.c
+++ kexec-tools/kexec/crashdump-elf.c
@@ -141,11 +141,12 @@ int FUNC(struct kexec_info *info,
 
 	count_cpu = nr_cpus;
 	for (i = 0; count_cpu > 0; i++) {
-		if (get_note_info(i, &notes_addr, &notes_len) < 0) {
-			/* This cpu is not present. Skip it. */
-			continue;
-		}
+		int ret;
+
+		ret = get_note_info(i, &notes_addr, &notes_len);
 		count_cpu--;
+		if (ret < 0) /* This cpu is not present. Skip it. */
+			continue;
 
 		phdr = (PHDR *) bufp;
 		bufp += sizeof(PHDR);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
