Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cO3OL-0000Tf-Ma
 for kexec@lists.infradead.org; Mon, 02 Jan 2017 14:15:15 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v02EDdhW122854
 for <kexec@lists.infradead.org>; Mon, 2 Jan 2017 09:14:53 -0500
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27qner5wbe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 02 Jan 2017 09:14:53 -0500
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 2 Jan 2017 19:44:49 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D72DA125805F
 for <kexec@lists.infradead.org>; Mon,  2 Jan 2017 19:46:12 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v02EEkkc39321648
 for <kexec@lists.infradead.org>; Mon, 2 Jan 2017 19:44:46 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v02EEipT020443
 for <kexec@lists.infradead.org>; Mon, 2 Jan 2017 19:44:45 +0530
Subject: [PATCH v3 5/5] powerpc/fadump: update documentation about
 crashkernel parameter reuse
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 02 Jan 2017 19:44:43 +0530
In-Reply-To: <148336637462.25358.5151364413645288219.stgit@hbathini.in.ibm.com>
References: <148336637462.25358.5151364413645288219.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <148336647935.25358.3726871546809264252.stgit@hbathini.in.ibm.com>
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
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com, Michael Ellerman <mpe@ellerman.id.au>, dyoung@redhat.com, vgoyal@redhat.com

As we are reusing crashkernel parameter instead of fadump_reserve_mem
parameter to specify the memory to reserve for fadump's crash kernel,
update the documentation accordingly.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   23 ++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 3007bc9..8394bc8 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -55,10 +55,14 @@ as follows:
          booted with restricted memory. By default, the boot memory
          size will be the larger of 5% of system RAM or 256MB.
          Alternatively, user can also specify boot memory size
-         through boot parameter 'fadump_reserve_mem=' which will
-         override the default calculated size. Use this option
-         if default boot memory size is not sufficient for second
-         kernel to boot successfully.
+         through boot parameter 'crashkernel=' which will override
+         the default calculated size. Use this option if default
+         boot memory size is not sufficient for second kernel to
+         boot successfully. For syntax of crashkernel= parameter,
+         refer to Documentation/kdump/kdump.txt. If any offset is
+         provided in crashkernel= parameter, it will be ignored
+         as fadump reserves memory at end of RAM for boot memory
+         dump preservation in case of a crash.
 
 -- After the low memory (boot memory) area has been saved, the
    firmware will reset PCI and other hardware state.  It will
@@ -158,13 +162,16 @@ How to enable firmware-assisted dump (fadump):
 
 1. Set config option CONFIG_FA_DUMP=y and build kernel.
 2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
-3. Optionally, user can also set 'fadump_reserve_mem=' kernel cmdline
+3. Optionally, user can also set 'crashkernel=' kernel cmdline
    to specify size of the memory to reserve for boot memory dump
    preservation.
 
-NOTE: If firmware-assisted dump fails to reserve memory then it will
-   fallback to existing kdump mechanism if 'crashkernel=' option
-   is set at kernel cmdline.
+NOTE: 1. 'fadump_reserve_mem=' parameter has been deprecated. Instead
+         use 'crashkernel=' to specify size of the memory to reserve
+         for boot memory dump preservation.
+      2. If firmware-assisted dump fails to reserve memory then it
+         will fallback to existing kdump mechanism if 'crashkernel='
+         option is set at kernel cmdline.
 
 Sysfs/debugfs files:
 ------------


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
