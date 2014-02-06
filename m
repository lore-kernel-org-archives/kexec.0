Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBITa-0004xj-By
 for kexec@lists.infradead.org; Thu, 06 Feb 2014 06:30:20 +0000
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH 0/2] kernel probe function fixes
Date: Thu,  6 Feb 2014 14:30:42 +0800
Message-Id: <1391668244-13631-1-git-send-email-dyoung@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

During my testing for arm zImage, in 2nd kernel the atags pointer and the
machine_id are not valid, I did a lot of debugging in kernel, finally I found
this is caused by a kexec tools bug instead.

It is a regression since bf06cf2095. It changes uImage probe return values as
below:
 *  0		- valid uImage type
 * -1           - If the image is corrupted.
 *  1           - If the image is not a uImage.

Because uImage will be probed before zImage, but the uImage probe return 1 for
a zImage thus kexec will mistakenly think it is ok to use as uImage.

IMHO, return -1 in case it's not an uImage is better instead of 1 like before
It's not really necessary to introduce a new return value. It might be better
for a new patch to return either 0 or -1 for uImage probe.

But I did not fix the uImage return value yet. In this patchset I did below:
 - ppc64 zImage: return 0 instead of 1 in case of success
 - strictly checking if probe return 0 in kexec.c

Tested arm zImage with use_atags only.

Dave Young (2):
  zImage_ppc64_probe: return 0 instead of 1 in case of success
  kernel image probe function return value checking fix

 kexec/arch/ppc64/kexec-zImage-ppc64.c | 5 ++++-
 kexec/kexec.c                         | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
