Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from omzsmtpe02.verizonbusiness.com ([199.249.25.209])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeZPP-0006JA-3F
 for kexec@lists.infradead.org; Thu, 07 Nov 2013 23:54:44 +0000
From: Don Slutz <dslutz@verizon.com>
Message-ID: <527C278D.5090204@terremark.com>
Date: Thu, 7 Nov 2013 18:51:41 -0500
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 3/9] kexec: add infrastructure for handling
 kexec images
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <1383749386-11891-4-git-send-email-david.vrabel@citrix.com>
 <527BFAD4.1070709@terremark.com>
In-Reply-To: <527BFAD4.1070709@terremark.com>
Content-Type: multipart/mixed; boundary="------------010204040204000907040606"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Don Slutz <dslutz@verizon.com>, David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Jan Beulich <jbeulich@suse.com>

--------------010204040204000907040606
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Sigh, my build just stopped.

kimage.c: In function 'kimage_crash_alloc':
kimage.c:222:9: error: unused variable 'result' [-Werror=unused-variable]
cc1: all warnings being treated as errors

A late change from v9 to v10 missed the removal of this variable.

Here is what I did to fix:

 From 09587856fa36ae38a500e218979f7111cb4546f4 Mon Sep 17 00:00:00 2001
From: Don Slutz <dslutz@verizon.com>
Date: Thu, 7 Nov 2013 18:46:23 -0500
Subject: [PATCH] kexec: remove result.

kimage.c: In function 'kimage_crash_alloc':
kimage.c:222:9: error: unused variable 'result' [-Werror=unused-variable]
cc1: all warnings being treated as errors

Signed-off-by: Don Slutz <dslutz@verizon.com>
---
  xen/common/kimage.c |    1 -
  1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/xen/common/kimage.c b/xen/common/kimage.c
index 10fb785..5c3e3b3 100644
--- a/xen/common/kimage.c
+++ b/xen/common/kimage.c
@@ -219,7 +219,6 @@ static int kimage_crash_alloc(struct kexec_image **rimage, p
addr_t entry,
                                xen_kexec_segment_t *segments)
  {
      unsigned long i;
-    int result;

      /* Verify we have a valid entry point */
      if ( (entry < kexec_crash_area.start)
-- 
1.7.1

     -Don Slutz

On 11/07/13 15:40, Don Slutz wrote:
> For what it is worth.
>
> Reviewed-by: Don Slutz <dslutz@verizon.com>
>     -Don Slutz
>
> On 11/06/13 09:49, David Vrabel wrote:
>> From: David Vrabel <david.vrabel@citrix.com>
>>
>> Add the code needed to handle and load kexec images into Xen memory or
>> into the crash region.  This is needed for the new KEXEC_CMD_load and
>> KEXEC_CMD_unload hypercall sub-ops.
>>

[...]



--------------010204040204000907040606
Content-Type: text/x-patch; name="0001-kexec-remove-result.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-kexec-remove-result.patch"

From 09587856fa36ae38a500e218979f7111cb4546f4 Mon Sep 17 00:00:00 2001
From: Don Slutz <dslutz@verizon.com>
Date: Thu, 7 Nov 2013 18:46:23 -0500
Subject: [PATCH] kexec: remove result.

kimage.c: In function 'kimage_crash_alloc':
kimage.c:222:9: error: unused variable 'result' [-Werror=unused-variable]
cc1: all warnings being treated as errors

Signed-off-by: Don Slutz <dslutz@verizon.com>
---
 xen/common/kimage.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/xen/common/kimage.c b/xen/common/kimage.c
index 10fb785..5c3e3b3 100644
--- a/xen/common/kimage.c
+++ b/xen/common/kimage.c
@@ -219,7 +219,6 @@ static int kimage_crash_alloc(struct kexec_image **rimage, paddr_t entry,
                               xen_kexec_segment_t *segments)
 {
     unsigned long i;
-    int result;
 
     /* Verify we have a valid entry point */
     if ( (entry < kexec_crash_area.start)
-- 
1.7.1


--------------010204040204000907040606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------010204040204000907040606--

