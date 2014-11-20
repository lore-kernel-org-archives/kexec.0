Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1416526275.23886.120.camel@smoke>
Subject: Re: [PATCH 0/8] arm64 kexec kernel patches V6
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 20 Nov 2014 15:31:15 -0800
In-Reply-To: <1416524243.23886.118.camel@smoke>
References: <D2393EB95A9993478029A6FE6A290A9F8129D1FE@szxeml510-mbx.china.huawei.com>
 <546AE4BE.1020909@huawei.com> <1416524243.23886.118.camel@smoke>
Mime-Version: 1.0
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
To: Anurup M <anurup.m@huawei.com>
Cc: sanil.kumar@hisilicon.com, kexec@lists.infradead.org

> On Tue, 2014-11-18 at 11:48 +0530, Anurup M wrote:
> > 	I get a relocation error  when I try to load using latest kexec-tools from https://git.linaro.org/people/geoff.levand/kexec-tools.git.

Please build with the patch below and let me know the
result.

-Geoff

diff --git a/purgatory/purgatory.c b/purgatory/purgatory.c
index 3bbcc09..faee277 100644
--- a/purgatory/purgatory.c
+++ b/purgatory/purgatory.c
@@ -6,8 +6,9 @@
 #include <string.h>
 #include "../kexec/kexec-sha256.h"
 
-struct sha256_region sha256_regions[SHA256_REGIONS] = {};
-sha256_digest_t sha256_digest = { };
+struct sha256_region __attribute__ ((section (".data")))
+	sha256_regions[SHA256_REGIONS] = {};
+sha256_digest_t __attribute__ ((section (".data"))) sha256_digest = {};
 
 int verify_sha256_digest(void)
 {



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
