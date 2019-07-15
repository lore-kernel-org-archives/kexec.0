Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hmu4o-0005qD-Nl
 for kexec@lists.infradead.org; Mon, 15 Jul 2019 06:03:08 +0000
Received: by mail-pl1-f194.google.com with SMTP id a93so7724077pla.7
 for <kexec@lists.infradead.org>; Sun, 14 Jul 2019 23:03:04 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 0/4] kexec/arm64: Add support for zlib compressed kernel
 images (Image.gz)
Date: Mon, 15 Jul 2019 11:32:52 +0530
Message-Id: <1563170576-13134-1-git-send-email-bhsharma@redhat.com>
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
Cc: takahiro.akashi@linaro.org, bhsharma@redhat.com, bhupesh.linux@gmail.com, horms@verge.net.au

Changes since v1:
----------------
(v1 can be viewed here: http://lists.infradead.org/pipermail/kexec/2019-July/023288.html)
 - Fixed the potential file descriptor leakage code legs pointed out by
   Simon.
 - Ran Valgrind to make sure no potential memory leakage issues are
   introduced by this patchset.

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
 kexec/arch/arm64/kexec-uImage-arm64.c |  13 +-
 kexec/arch/arm64/kexec-zImage-arm64.c | 226 ++++++++++++++++++++++++++++++++++
 kexec/kexec-zlib.h                    |   1 +
 kexec/kexec.c                         |  14 +++
 kexec/zlib.c                          |  38 ++++++
 9 files changed, 303 insertions(+), 4 deletions(-)
 create mode 100644 kexec/arch/arm64/kexec-zImage-arm64.c

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
