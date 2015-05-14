Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ysm7v-0003PM-5B
 for kexec@lists.infradead.org; Thu, 14 May 2015 05:56:13 +0000
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH V2 00/11] ARM64 Binary Image Support
Date: Thu, 14 May 2015 11:25:36 +0530
Message-Id: <cover.1431582203.git.panand@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: geoff@infradead.org
Cc: Pratyush Anand <panand@redhat.com>, takahiro.akashi@linaro.org, kexec@lists.infradead.org

These patches are discreet and for Geoff to apply on his tree, so that
they can further be sent to upstream with other ARM64 patches.

Patch 1 will apply on top of [1].
Patch (2-9): I am not sending as they are from AKASHI Takahiro's tree
[2].
Patch (10-11) will apply after pulling Takahiro's kdump patches[2].

Changes since V1:
 --  --page-offset  helper moved to image_arm64_usage
 -- debug values are getting printed if user page offset did not match
with text page offset

Pratyush Anand (3):
  arm64: Kexec: Add support for binary image
  arm64: kdump: Add support for binary image
  arm64: wait for transmit completion before next character transmission


[1] git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git
: master (2f5f0e06823c)
[2] git://git.linaro.org/people/takahiro.akashi/kexec-tools.git
:kdump/v0.12 (fcaad9577789..913c2ec2d045)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
