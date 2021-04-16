Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYMU-009nE3-Et
 for kexec@lists.infradead.org; Fri, 16 Apr 2021 23:59:02 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 k23-20020a17090a5917b02901043e35ad4aso17240259pji.3
 for <kexec@lists.infradead.org>; Fri, 16 Apr 2021 16:58:57 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] fs: provide a stop gap fix for buggy resume firmware API
 calls
Date: Fri, 16 Apr 2021 23:58:48 +0000
Message-Id: <20210416235850.23690-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
To: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com
Cc: mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>

Lukas has reported an issue [0] with a media driver which causes stall on
resume. At first his suspicion was that this issue was due to a bug in
btrfs. I managed to build a custom driver to reproduce the issue and
confirmed it was not a bug in btrfs. The issue is reproducible in XFS
as well. This issue is a demonstration of how broken the filesystem
suspend / resume cycle is and how easy it can be to trigger an issue.

By only doing reads with the firmware API used incorrectly, a simple
suspend / resume cycle can stall a system. The stall happens since
the hardware never gets read request issued by the filesystem as it
was already suspended. The fs waits forever. The stall also happens
because resume calls are synchronous and if one does not complete
we'll wait forever.

My new unposted VFS series for the fs freezer / resume work fixes this,
however this series will require a bit more discussion before this lands
upstream. And so this series provides a test case for the issue and an
intermediate stop-gap patch which resolves the issue for now. We can
remove this once the VFS freeze work lands upstream.

[0] https://lkml.kernel.org/r/c79e24a5-f808-d1f0-1f09-ee6f135d9679@tuxforce.de

Luis Chamberlain (2):
  test_firmware: add suspend support to test buggy drivers
  fs/kernel_read_file: use usermodehelper_read_trylock() as a stop gap

 fs/kernel_read_file.c                         |  37 ++++-
 kernel/kexec_file.c                           |   9 +-
 kernel/module.c                               |   8 +-
 lib/test_firmware.c                           | 136 ++++++++++++++++--
 tools/testing/selftests/firmware/fw_lib.sh    |   8 +-
 .../selftests/firmware/fw_test_resume.sh      |  80 +++++++++++
 6 files changed, 261 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/firmware/fw_test_resume.sh

-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
