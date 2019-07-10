Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hlIfj-0006Hc-R9
 for kexec@lists.infradead.org; Wed, 10 Jul 2019 19:54:37 +0000
Received: by mail-pg1-f196.google.com with SMTP id q4so1726700pgj.8
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2019 12:54:35 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 0/4] kexec/arm64: Add support for zlib compressed kernel
 images (Image.gz)
Date: Thu, 11 Jul 2019 01:24:25 +0530
Message-Id: <1562788469-22935-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: bhupesh.linux@gmail.com, bhsharma@redhat.com, horms@verge.net.au, takahiro.akashi@linaro.org

This patchset adds the support for zlib compressed kernel images
(Image.gz) for arm64 kexec-tools.

This was discussed a bit with the arm64 kernel maintainers (see [0]) and
after discussing the pros and cons of adding this support in
kernel-space v/s in user-space, we decided it makes more sense to add
this support to the user-space kexec-tools.

Note that this series adds support for unsigned arm64 Image.gz files
only as signing an Image.gz type file is not a easy implementation from
kexec-tools p-o-v. Also even standard signing tools like sbsign fail to
recongize the Image.gz format:

 $ sbsign --key certs/signing_key.pem  --cert certs/signing_key.pem Image.gz
   Invalid DOS header magic

... because that gzip file isn't a PE32+ that can be loaded by UEFI.
So I will work on the same in coming days and try to send a RFC
patchset for the same later on.

[0]. http://lists.infradead.org/pipermail/kexec/2019-June/023156.html

Bhupesh Sharma (4):
  kexec/kexec.c: Add the missing close() for fd used for
    kexec_file_load()
  kexec-uImage-arm64.c: Fix return value of uImage_arm64_probe()
  kexec/kexec-zlib.h: Add 'is_zlib_file()' helper function
  kexec/arm64: Add support for handling zlib compressed (Image.gz) image

 kexec/arch/arm64/Makefile             |   3 +-
 kexec/arch/arm64/kexec-arm64.c        |   1 +
 kexec/arch/arm64/kexec-arm64.h        |   7 ++
 kexec/arch/arm64/kexec-image-arm64.c  |   4 +-
 kexec/arch/arm64/kexec-uImage-arm64.c |  13 ++-
 kexec/arch/arm64/kexec-zImage-arm64.c | 199 ++++++++++++++++++++++++++++++++++
 kexec/kexec-zlib.h                    |   1 +
 kexec/kexec.c                         |  14 +++
 kexec/zlib.c                          |  32 ++++++
 9 files changed, 270 insertions(+), 4 deletions(-)
 create mode 100644 kexec/arch/arm64/kexec-zImage-arm64.c

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
