From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue,  8 Feb 2022 20:51:01 +0800
Subject: [PATCH v2 0/5] Update doc and fix some issues about kdump
Message-ID: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Tiezhu Yang (5):
  docs: kdump: update description about sysfs file system support
  docs: kdump: add scp example to write out the dump file
  panic: unset panic_on_warn inside panic()
  ubsan: no need to unset panic_on_warn in ubsan_epilogue()
  kasan: no need to unset panic_on_warn in end_report()

 Documentation/admin-guide/kdump/kdump.rst | 10 +++++++---
 kernel/panic.c                            | 20 +++++++++++---------
 lib/ubsan.c                               | 10 +---------
 mm/kasan/report.c                         | 10 +---------
 4 files changed, 20 insertions(+), 30 deletions(-)

-- 
2.1.0


